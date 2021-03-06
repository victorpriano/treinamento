USE [dbTreinamento]
GO
/****** Object:  StoredProcedure [dbo].[stp_Sys_Pagina_Upd]    Script Date: 24/08/2021 16:33:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[stp_Sys_Pagina_Upd]
@IdPagina INT = NULL,
@IdModulo INT = NULL,
@DescricaoPagina VARCHAR(50) = NULL,
@CodigoPagina VARCHAR(50) = NULL
AS
BEGIN
	BEGIN TRY
		DECLARE @MsgErro VARCHAR(255)
		
		IF NULLIF(@DescricaoPagina, '') IS NULL
			BEGIN
				RAISERROR('INFORME UMA DESCRIÇÃO PARA O SISTEMA', 16, 1)
			END

		IF NULLIF(@CodigoPagina, '') IS NULL
			BEGIN
				RAISERROR('INFORME UM CÓDIGO PARA A PÁGINA', 16, 1)
			END

		IF NULLIF(@IdModulo, '') IS NULL
			BEGIN
				RAISERROR('INFORME UM MÓDULO PARA A PÁGINA', 16, 1)
			END

		UPDATE Sys_Pagina SET descricaoPagina = @DescricaoPagina, 
		codigoPagina = @CodigoPagina,
		idModulo = @IdModulo
		WHERE idPagina = @IdPagina

		RETURN 0

	END TRY
	BEGIN CATCH
		SET @MsgErro = ERROR_MESSAGE()
		RAISERROR(@MsgErro, 16, 1)
		RETURN 1
	END CATCH

END
