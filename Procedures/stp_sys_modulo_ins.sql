USE [dbTreinamento]
GO
/****** Object:  StoredProcedure [dbo].[stp_Sys_Modulo_Ins]    Script Date: 24/08/2021 16:30:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[stp_Sys_Modulo_Ins]
@IdModulo INT = NULL,
@IdSistema INT = NULL,
@CodigoModulo VARCHAR(50) = NULL,
@DescricaoModulo VARCHAR(50) = NULL
AS
BEGIN
	BEGIN TRY
		DECLARE @MsgErro VARCHAR(255)

	IF NULLIF(@CodigoModulo, '') IS NULL
		BEGIN
			RAISERROR('INFORME O CÓDIGO DO MÓDULO', 16, 1)
		END

	IF NULLIF(@DescricaoModulo, '') IS NULL
		BEGIN
			RAISERROR('INFORME A DESCRIÇÃO DO MÓDULO', 16, 1)
		END

	IF NULLIF(@IdSistema, '') IS NULL
		BEGIN
			RAISERROR('INFORME O SISTEMA', 16, 1)
		END

	INSERT INTO Sys_Modulo(codigoModulo, descricaoModulo, idSistema)
	VALUES(@CodigoModulo, @DescricaoModulo, @IdSistema)

		RETURN 0

	END TRY
	BEGIN CATCH
		SET @MsgErro = ERROR_MESSAGE()
		RAISERROR(@MsgErro, 16, 1)
		RETURN 1
	END CATCH

END
