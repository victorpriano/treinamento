USE [dbTreinamento]
GO
/****** Object:  StoredProcedure [dbo].[stp_Sys_Operador_Ins]    Script Date: 24/08/2021 16:31:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[stp_Sys_Operador_Ins]
@IdOperador INT = NULL,
@Cpf VARCHAR(50) = NULL,
@Nome VARCHAR(50) = NULL
AS
BEGIN
	BEGIN TRY
		DECLARE @MsgErro VARCHAR(255)

		IF NULLIF(@Cpf, '') IS NULL
			BEGIN
				RAISERROR('INFORME UM CPF', 16, 1)
			END

		IF NULLIF(@Nome, '') IS NULL
			BEGIN
				RAISERROR('INFORME O NOME DO OPERADOR', 16, 1)
			END
		
		INSERT INTO Sys_Operador(nome, cpf)
		VALUES(@Nome, @Cpf)

		RETURN 0

	END TRY
	BEGIN CATCH
		SET @MsgErro = ERROR_MESSAGE()
		RAISERROR(@MsgErro, 16, 1)
		RETURN 1
	END CATCH

END
