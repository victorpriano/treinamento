USE [dbTreinamento]
GO
/****** Object:  StoredProcedure [dbo].[stp_Sys_Acao_Del]    Script Date: 24/08/2021 16:27:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[stp_Sys_Acao_Del]
@IdAcao INT = NULL,
@IdPagina INT = NULL,
@CodigoAcao VARCHAR(50) = NULL,
@Caption VARCHAR(50) = NULL,
@NomeProcedure VARCHAR(50)
AS
BEGIN
	BEGIN TRY
		DECLARE @MsgErro VARCHAR(255)
		
		IF @IdAcao IS NULL
			BEGIN
				RAISERROR('INFORME O ID DA AÇÃO', 16, 1)
			END

		DELETE Sys_Acao
		WHERE idAcao = @IdAcao

		RETURN 0

	END TRY
	BEGIN CATCH
		SET @MsgErro = ERROR_MESSAGE()
		RAISERROR(@MsgErro, 16, 1)
		RETURN 1
	END CATCH

END
