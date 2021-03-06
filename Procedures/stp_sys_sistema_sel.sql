USE [dbTreinamento]
GO
/****** Object:  StoredProcedure [dbo].[stp_Sys_Sistema_Sel]    Script Date: 24/08/2021 16:34:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[stp_Sys_Sistema_Sel]
@IdSistema INT = NULL,
@TipoConsulta INT = NULL
AS
BEGIN
	BEGIN TRY
		DECLARE @MsgErro VARCHAR(255)

		IF @TipoConsulta IS NULL
			BEGIN
				SELECT	s.idSistema as IdSistema, s.codigoSistema as CodigoSistema,
				s.DescricaoSistema as DescricaoSistema
				FROM Sys_Sistema s
				WHERE idSistema = @IdSistema OR @IdSistema IS NULL
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
