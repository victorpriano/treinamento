USE [dbTreinamento]
GO
/****** Object:  StoredProcedure [dbo].[stp_Sys_Acao_Ins]    Script Date: 24/08/2021 16:27:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[stp_Sys_Acao_Ins]
@IdAcao INT = NULL,
@IdPagina INT = NULL,
@CodigoAcao VARCHAR(50) = NULL,
@Caption VARCHAR(50) = NULL,
@NomeProcedure VARCHAR(50) = NULL
AS
BEGIN
	BEGIN TRY
		DECLARE @MsgErro VARCHAR(255)

		IF NULLIF(@Caption, '') IS NULL
			BEGIN
				RAISERROR('INFORME O CAPTION', 16, 1)
			END

		IF NULLIF(@NomeProcedure, '') IS NULL
			BEGIN
				RAISERROR('INFORME O NOME DA PROCEDURE', 16, 1)
			END

		IF NULLIF(@CodigoAcao, '') IS NULL
			BEGIN
				RAISERROR('INFORME O CÓDIGO DA AÇÃO', 16, 1)
			END
	
		INSERT INTO Sys_Acao(idPagina, codigoAcao, caption, nomeProcedure)
		VALUES(@IdPagina, @CodigoAcao, @Caption, @NomeProcedure)

		RETURN 0

	END TRY
	BEGIN CATCH
		SET @MsgErro = ERROR_MESSAGE()
		RAISERROR(@MsgErro, 16, 1)
		RETURN 1
	END CATCH

END
