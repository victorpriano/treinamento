USE [dbTreinamento]
GO
/****** Object:  StoredProcedure [dbo].[stp_Sys_Pagina_Ins]    Script Date: 24/08/2021 16:32:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[stp_Sys_Pagina_Ins]
@IdModulo INT = NULL,
@IdPagina INT = NULL,
@CodigoPagina VARCHAR(50) = NULL,
@DescricaoPagina VARCHAR(50) = NULL
AS
BEGIN
	BEGIN TRY
		DECLARE @MsgErro VARCHAR(255)

		IF NULLIF(@CodigoPagina, '') IS NULL
			BEGIN
				RAISERROR('INFORME O CÓDIGO DA PÁGINA', 16, 1)
			END

		IF NULLIF(@DescricaoPagina, '') IS NULL
			BEGIN
				RAISERROR('INFORME UMA DESCRIÇÃO DA PÁGINA', 16, 1)
			END

		IF NULLIF(@IdModulo, '') IS NULL
		BEGIN
			RAISERROR('INFORME O Modulo', 16, 1)
		END
	
		INSERT INTO Sys_Pagina(idModulo, descricaoPagina, codigoPagina)
		VALUES(@IdModulo, @DescricaoPagina, @CodigoPagina)

		RETURN 0

	END TRY
	BEGIN CATCH
		SET @MsgErro = ERROR_MESSAGE()
		RAISERROR(@MsgErro, 16, 1)
		RETURN 1
	END CATCH

END
