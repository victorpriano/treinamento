USE [dbTreinamento]
GO
/****** Object:  StoredProcedure [dbo].[stp_Vic_Jogo_Del]    Script Date: 24/08/2021 16:37:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[stp_Vic_Jogo_Del]
	@IdJogo INT = NULL

AS
BEGIN
	BEGIN TRY
		DECLARE @MsgErro VARCHAR(255)

		IF @IdJogo IS NULL
		BEGIN
			RAISERROR('Informe o Id do jogo',16,1)
		END

		DELETE Vic_Jogo
		WHERE idJogo = @IdJogo

		RETURN 0
	END TRY
	BEGIN CATCH
		SET @MsgErro = ERROR_MESSAGE()
		RAISERROR(@MsgErro, 16, 1)
		RETURN 1
	END CATCH
END
