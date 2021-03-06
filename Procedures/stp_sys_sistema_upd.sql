USE [dbTreinamento]
GO
/****** Object:  StoredProcedure [dbo].[stp_Sys_Sistema_Upd]    Script Date: 24/08/2021 16:34:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[stp_Sys_Sistema_Upd]
@IdSistema INT = NULL,
@CodigoSistema VARCHAR(50) = NULL,
@DescricaoSistema VARCHAR(50) = NULL
AS
BEGIN
	BEGIN TRY
		DECLARE @MsgErro VARCHAR(255)

	IF NULLIF(@CodigoSistema, '') IS NULL
		BEGIN
			RAISERROR('INFORME O CODIGO DO SISTEMA', 16, 1)
		END

	IF NULLIF(@DescricaoSistema, '') IS NULL
		BEGIN
			RAISERROR('INFORME A DESCRIÇÃO DO SISTEMA', 16, 1)
		END

	IF @IdSistema IS NULL
		BEGIN
			RAISERROR('INFORME O ID DO SISTEMA', 16, 1)
		END

	UPDATE Sys_Sistema SET DescricaoSistema = @DescricaoSistema, codigoSistema = @CodigoSistema
	WHERE idSistema = @IdSistema

		RETURN 0

	END TRY
	BEGIN CATCH
		SET @MsgErro = ERROR_MESSAGE()
		RAISERROR(@MsgErro, 16, 1)
		RETURN 1
	END CATCH

END
