USE [dbTreinamento]
GO
/****** Object:  StoredProcedure [dbo].[stp_Sys_Autorizacao_Upd]    Script Date: 24/08/2021 16:29:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[stp_Sys_Autorizacao_Upd]
	@IdOperador INT = NULL,
	@Acoes VARCHAR(MAX) = NULL
AS
BEGIN
	BEGIN TRY
		DECLARE @MsgErro VARCHAR(255)
		
		IF @IdOperador IS NULL
			BEGIN
				RAISERROR('INFORME O OPERADOR', 16, 1)
			END

		IF @Acoes IS NULL
		BEGIN
			RAISERROR('INFORME ALGUMA AÇÃO', 16, 1)
		END

		IF NOT EXISTS(
			SELECT 1
			FROM Sys_Operador
			WHERE idOperador = @IdOperador
		)
		BEGIN
			RAISERROR('O OPERADOR NÃO EXISTE', 16, 1)
		END

		DECLARE @T TABLE (
			idAcao INT
		)

		INSERT INTO @T (idAcao)
		SELECT value
		FROM string_split(@Acoes, ',') 

		-- Inserir em autorizacao,
		--as acoes do operador que foram informadas na tela
		-- mas o opoerador ainda nao tem sys_Atuorizacao
		
		--INSERT INTO Sys_Autorizacao (idAcao, idOperador)
		--SELECT t.idAcao, @IdOperador
		--FROM @T t
		--LEFT JOIN Sys_Autorizacao a ON a.idAcao = t.idAcao AND idOperador = @IdOperador
		--WHERE a.idAutorizacao IS NULL

		INSERT INTO Sys_Autorizacao (idAcao, idOperador)
		SELECT t.idAcao, @IdOperador
		FROM @T T
		WHERE NOT EXISTS(
			SELECT 1
			FROM Sys_Autorizacao A
			WHERE idOperador = @IdOperador AND A.idAcao = T.idAcao
		)


		-- Remover de sys_autorizacao as acoes do operador que foram desmarcadas na tela
		-- São as acoes que estão atualmente em sys_Autorizacao, e não estão em @T
		DELETE A
		FROM Sys_Autorizacao A
		WHERE idOperador = @IdOperador
			AND NOT EXISTS(
				SELECT 1
				FROM @T T
				WHERE A.idAcao = T.idAcao
			)  



		RETURN 0

	END TRY
	BEGIN CATCH
		SET @MsgErro = ERROR_MESSAGE()
		RAISERROR(@MsgErro, 16, 1)
		RETURN 1
	END CATCH

END
