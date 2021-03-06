USE [dbTreinamento]
GO
/****** Object:  StoredProcedure [dbo].[stp_Sys_MontaMenu]    Script Date: 31/08/2021 15:11:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[stp_Sys_MontaMenu]
	@IdOperador INT = NULL,
	@Sistema VARCHAR(50) = NULL,
	@Modulo VARCHAR(50) = NULL,
	@Pagina VARCHAR(50) = NULL,
	@TipoConsulta INT = NULL
AS
BEGIN
	BEGIN TRY
		DECLARE @MsgErro VARCHAR(255)

	IF @TipoConsulta IS NULL
	BEGIN
		SELECT 
			S.idSistema,
			S.CodigoSistema,
			S.DescricaoSistema, 
			M.CodigoModulo,
			M.idModulo,
			M.DescricaoModulo, 
			P.CodigoPagina, 
			P.DescricaoPagina 
		FROM Sys_Sistema S
		INNER JOIN Sys_Modulo M ON M.idSistema = S.idSistema
		INNER JOIN Sys_Pagina P ON P.idModulo = M.idModulo
		WHERE EXISTS(
			SELECT 1
			FROM Sys_Acao AC
			INNER JOIN Sys_Autorizacao A ON A.idAcao = AC.idAcao
			WHERE idOperador = @IdOperador AND AC.idPagina = P.idPagina
		)
		ORDER BY s.idSistema, m.idModulo, p.idPagina
	END

	IF @TipoConsulta = 1
	BEGIN
		SELECT 
			a.codigoAcao,
			a.caption,
			a.nomeProcedure
		FROM Sys_Acao a
		INNER JOIN Sys_Autorizacao u ON u.idAcao = a.idAcao
										AND u.idOperador = @IdOperador
		WHERE EXISTS (
			SELECT 1
			FROM Sys_Pagina p
			INNER JOIN Sys_Modulo m ON m.idModulo = p.idModulo
			INNER JOIN Sys_Sistema s ON s.idSistema = m.idSistema
			WHERE 
				p.idPagina = a.idPagina	
				AND s.CodigoSistema = @Sistema
				AND m.CodigoModulo = @Modulo
				AND p.codigoPagina = @Pagina
		)
	END
		
		RETURN 0

	END TRY
	BEGIN CATCH
		SET @MsgErro = ERROR_MESSAGE()
		RAISERROR(@MsgErro, 16, 1)
		RETURN 1
	END CATCH

END
