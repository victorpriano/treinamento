USE [dbTreinamento]
GO
/****** Object:  StoredProcedure [dbo].[stp_Sys_Pagina_Del]    Script Date: 24/08/2021 16:32:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[stp_Sys_Pagina_Del]
@IdPagina INT = NULL,
@IdModulo INT = NULL,
@DescricaoPagina VARCHAR(50) = NULL,
@CodigoPagina VARCHAR(50) = NULL
AS
BEGIN
	BEGIN TRY
		DECLARE @MsgErro VARCHAR(255)

		IF @IdPagina IS NULL
			BEGIN
				RAISERROR('INFORME O ID DA PÁGINA', 16, 1)
			END

		DELETE Sys_Pagina
		WHERE idPagina = @IdPagina

		RETURN 0

	END TRY
	BEGIN CATCH
		SET @MsgErro = ERROR_MESSAGE()
		RAISERROR(@MsgErro, 16, 1)
		RETURN 1
	END CATCH

END
