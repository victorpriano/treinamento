USE [dbTreinamento]
GO
/****** Object:  StoredProcedure [dbo].[stp_Sys_Pagina_Sel]    Script Date: 24/08/2021 16:33:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[stp_Sys_Pagina_Sel]
	@IdPagina INT = NULL,
	@IdSistema INT = NULL,
	@TipoConsulta INT = NULL
AS
BEGIN
	BEGIN TRY
		DECLARE @MsgErro VARCHAR(255)
		
		IF @TipoConsulta IS NULL
			BEGIN
				SELECT 
					p.idPagina, 
					p.codigoPagina, 
					p.descricaoPagina,
					m.IdModulo,
					m.descricaoModulo, 
					s.IdSistema,
					s.descricaoSistema
				FROM Sys_Pagina p
				INNER JOIN Sys_Modulo m ON m.idModulo = p.idModulo
				INNER JOIN Sys_Sistema s ON s.idSistema = m.idSistema
				WHERE p.idPagina = @IdPagina OR @IdPagina IS NULL
			END

		IF @TipoConsulta = 1
		BEGIN
			SELECT * 
			FROM Sys_Sistema
		END

		IF @TipoConsulta = 2
		BEGIN
			SELECT * 
			FROM Sys_Modulo
			WHERE idSistema = @IdSistema
		END

		RETURN 0

	END TRY
	BEGIN CATCH
		SET @MsgErro = ERROR_MESSAGE()
		RAISERROR(@MsgErro, 16, 1)
		RETURN 1
	END CATCH

END
