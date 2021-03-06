USE [dbTreinamento]
GO
/****** Object:  StoredProcedure [dbo].[stp_Vic_Jogo_Upd]    Script Date: 24/08/2021 16:37:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[stp_Vic_Jogo_Upd]
	@IdJogo INT = NULL,
	@IdTime1 VARCHAR(50) = NULL,
	@IdTime2 VARCHAR(50) = NULL

AS
BEGIN
	BEGIN TRY
		DECLARE @MsgErro VARCHAR(255)

		IF NOT EXISTS(
			SELECT 1 
			FROM Vic_Jogo
			WHERE idJogo = @IdJogo
		)
		BEGIN
			RAISERROR('Esse jogo não existe',16,1)
		END

		UPDATE Vic_Jogo SET idTime1 = @IdTime1, idTime2 = @IdTime2
		WHERE idJogo = @IdJogo

		RETURN 0
	END TRY
	BEGIN CATCH
		SET @MsgErro = ERROR_MESSAGE()
		RAISERROR(@MsgErro, 16, 1)
		RETURN 1
	END CATCH
END
