USE [dbTreinamento]
GO
/****** Object:  StoredProcedure [dbo].[stp_Sys_Operador_Upd]    Script Date: 24/08/2021 16:32:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[stp_Sys_Operador_Upd]
@Idoperador INT = NULL,
@Cpf VARCHAR(50) = NULL,
@Nome VARCHAR(50) = NULL
AS
BEGIN
	BEGIN TRY
		DECLARE @MsgErro VARCHAR(255)

		IF NULLIF(@Cpf, '') IS NULL
			BEGIN
				RAISERROR('INFORME O CPF', 16, 1)
			END
		
		IF NULLIF(@Nome, '') IS NULL
			BEGIN
				RAISERROR('INFORME UM NOME', 16, 1)
			END

		IF @Idoperador IS NULL
			BEGIN
				RAISERROR('INFORME O ID DO OPERADOR', 16, 1)
			END

		IF NOT EXISTS(
			SELECT 1
			FROM Sys_Operador
			WHERE idOperador = @Idoperador
		)
		BEGIN
			RAISERROR('ID DO OPERADOR NÃO EXISTE', 16, 1)
		END

		UPDATE Sys_Operador SET nome = @nome, cpf = @Cpf
		WHERE idOperador = @Idoperador

		RETURN 0

	END TRY
	BEGIN CATCH
		SET @MsgErro = ERROR_MESSAGE()
		RAISERROR(@MsgErro, 16, 1)
		RETURN 1
	END CATCH

END
