USE [dbTreinamento]
GO
/****** Object:  StoredProcedure [dbo].[stp_Sys_AbreSessao]    Script Date: 31/08/2021 15:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[stp_Sys_AbreSessao]
	@Cpf Varchar(11) = NULL,
	@Senha Varchar(50) = NULL
AS
BEGIN
	BEGIN TRY
		DECLARE @MsgErro VARCHAR(255)

		IF NULLIF(@Cpf, '') IS NULL
			BEGIN
				RAISERROR('INFORME O CPF', 16, 1)
			END

		IF NULLIF(@Senha, '') IS NULL
			BEGIN
				RAISERROR('INFORME UMA SENHA', 16, 1)
			END

		SELECT idOperador, nome
		FROM Sys_Operador
		WHERE cpf = @Cpf AND senha = @senha
		
		RETURN 0

	END TRY
	BEGIN CATCH
		SET @MsgErro = ERROR_MESSAGE()
		RAISERROR(@MsgErro, 16, 1)
		RETURN 1
	END CATCH

END
