USE [dbTreinamento]
GO
/****** Object:  StoredProcedure [dbo].[stp_Sys_Modulo_Sel]    Script Date: 24/08/2021 16:30:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[stp_Sys_Modulo_Sel]
	@IdModulo INT = NULL,
	@TipoConsulta INT = NULL
AS
BEGIN
	BEGIN TRY
		DECLARE @MsgErro VARCHAR(255)

		IF @TipoConsulta IS NULL
		BEGIN
			SELECT
				m.idModulo,
				m.codigoModulo,
				m.descricaoModulo,
				s.descricaoSistema
			FROM Sys_Modulo m
			INNER JOIN Sys_Sistema s ON s.idSistema = m.idSistema
			WHERE idModulo = @IdModulo OR @IdModulo IS NULL
		END

		IF @TipoConsulta = 1
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
