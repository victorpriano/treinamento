USE [dbTreinamento]
GO
/****** Object:  StoredProcedure [dbo].[stp_Sys_Sistema_Del]    Script Date: 24/08/2021 16:33:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[stp_Sys_Sistema_Del]
@IdSistema INT = NULL,
@CodigoSistema INT = NULL,
@DescricaoSistema VARCHAR(50) = NULL
AS
BEGIN
	BEGIN TRY
		DECLARE @MsgErro VARCHAR(255)

	IF @IdSistema IS NULL
		BEGIN
			RAISERROR('INFORME O ID DO SISTEMA', 16, 1)
		END

	DELETE Sys_Sistema 
	WHERE idSistema = @IdSistema

		RETURN 0

	END TRY
	BEGIN CATCH
		SET @MsgErro = ERROR_MESSAGE()
		RAISERROR(@MsgErro, 16, 1)
		RETURN 1
	END CATCH

END
