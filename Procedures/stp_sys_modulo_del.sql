USE [dbTreinamento]
GO
/****** Object:  StoredProcedure [dbo].[stp_Sys_Modulo_Del]    Script Date: 24/08/2021 16:30:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[stp_Sys_Modulo_Del]
@IdModulo INT = NULL,
@IdSistema INT = NULL,
@CodigoModulo VARCHAR(50) = NULL,
@DescricaoModulo VARCHAR(50) = NULL
AS
BEGIN
	BEGIN TRY
		DECLARE @MsgErro VARCHAR(255)
	
	IF @IdModulo IS NULL
		BEGIN
			RAISERROR('INFORME O ID DO MODULO', 16, 1)
		END

	DELETE Sys_Modulo
	WHERE idModulo = @IdModulo

		RETURN 0

	END TRY
	BEGIN CATCH
		SET @MsgErro = ERROR_MESSAGE()
		RAISERROR(@MsgErro, 16, 1)
		RETURN 1
	END CATCH

END
