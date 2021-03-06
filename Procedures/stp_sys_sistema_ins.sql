USE [dbTreinamento]
GO
/****** Object:  StoredProcedure [dbo].[stp_Sys_Sistema_Ins]    Script Date: 24/08/2021 16:33:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[stp_Sys_Sistema_Ins]
@IdSistema INT = NULL,
@CodigoSistema VARCHAR(50) = NULL,
@DescricaoSistema VARCHAR(50) = NULL
AS
BEGIN
	BEGIN TRY
		DECLARE @MsgErro VARCHAR(255)

	IF NULLIF(@CodigoSistema, '') IS NULL
		BEGIN
			RAISERROR('INFORME UM CÓDIGO PARA O SISTEMA', 16, 1)
		END

	IF NULLIF(@DescricaoSistema, '') IS NULL
		BEGIN
			RAISERROR('INFORME UMA DESCRIÇÃO PARA O SISTEMA', 16, 1)
		END

	INSERT INTO Sys_Sistema(codigoSistema, DescricaoSistema)
	VALUES (@CodigoSistema, @DescricaoSistema)

		RETURN 0

	END TRY
	BEGIN CATCH
		SET @MsgErro = ERROR_MESSAGE()
		RAISERROR(@MsgErro, 16, 1)
		RETURN 1
	END CATCH

END
