USE [dbTreinamento]
GO
/****** Object:  StoredProcedure [dbo].[stp_Sys_Autorizacao_Sel]    Script Date: 24/08/2021 16:29:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[stp_Sys_Autorizacao_Sel]
	@IdOperador INT = NULL,
	@TipoConsulta INT = NULL
AS
BEGIN
	BEGIN TRY
		DECLARE @MsgErro VARCHAR(255)

		IF @TipoConsulta IS NULL
		BEGIN
			IF @idOperador IS NULL
			BEGIN
				RAISERROR('Informe o Operador', 16, 1)
			END

			SELECT
				ac.idAcao,
				s.descricaoSistema,
				mo.descricaoModulo,
				pa.descricaoPagina,
				ac.caption,
				a.idAutorizacao
			FROM Sys_Acao ac
			INNER JOIN Sys_Pagina pa ON pa.idPagina = ac.idPagina
			INNER JOIN Sys_Modulo mo ON mo.idModulo = pa.idModulo
			INNER JOIN Sys_Sistema s ON s.idSistema = mo.idSistema
			LEFT JOIN Sys_Autorizacao a ON a.idAcao = ac.idAcao AND idOperador = @IdOperador
		END

		IF @TipoConsulta = 1 
		BEGIN
			SELECT idOperador, Nome
			FROM Sys_Operador
		END

		RETURN 0

	END TRY
	BEGIN CATCH
		SET @MsgErro = ERROR_MESSAGE()
		RAISERROR(@MsgErro, 16, 1)
		RETURN 1
	END CATCH
END
