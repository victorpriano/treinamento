USE [dbTreinamento]
GO
/****** Object:  StoredProcedure [dbo].[stp_Sys_Acao_Sel]    Script Date: 24/08/2021 16:28:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[stp_Sys_Acao_Sel]
@IdAcao INT = NULL,
@TipoConsulta INT = NULL
AS
BEGIN
	BEGIN TRY
		DECLARE @MsgErro VARCHAR(255)
		
		IF @TipoConsulta IS NULL
			BEGIN
				SELECT a.idAcao AS IdAcao, 
					p.descricaoPagina As IdPagina,
					a.codigoAcao AS CodigoAcao,
					a.caption AS Caption, 
					a.nomeProcedure AS NomeProcedure
				FROM Sys_Acao a
				INNER JOIN Sys_Pagina p ON p.idPagina = a.idPagina
				WHERE a.idAcao = @IdAcao OR @IdAcao IS NULL
			END

		IF @TipoConsulta = 1
			BEGIN
				SELECT * 
				FROM Sys_Pagina
			END

		IF @TipoConsulta = 2
			BEGIN
				SELECT * 
				FROM Sys_Modulo
			END

		IF @TipoConsulta = 3
			BEGIN
				SELECT * 
				FROM Sys_Sistema
			END


		RETURN 0

	END TRY
	BEGIN CATCH
		SET @MsgErro = ERROR_MESSAGE()
		RAISERROR(@MsgErro, 16, 1)
		RETURN 1
	END CATCH

END
