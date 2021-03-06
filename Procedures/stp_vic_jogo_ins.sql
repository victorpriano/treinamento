USE [dbTreinamento]
GO
/****** Object:  StoredProcedure [dbo].[stp_Vic_Jogo_Ins]    Script Date: 24/08/2021 16:37:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[stp_Vic_Jogo_Ins]
	@IdJogo INT = NULL,
	@IdTime1 INT = NULL,
	@IdTime2 INT = NULL
AS
BEGIN
	BEGIN TRY
		DECLARE @MsgErro VARCHAR(255)

		IF @IdTime1 IS NULL
		BEGIN
			RAISERROR('Informe o time 1',16,1)
		END

		IF NOT EXISTS(
			SELECT 1 
			FROM Vic_Time
			WHERE idTime = @IdTime1 
		)
		BEGIN
			SET @MsgErro = FORMAT(@IdTime1, 'Você está informando um time que não está cadastrado')
			RAISERROR(@MsgErro, 16,1)
		END

		IF @IdTime2 IS NULL
		BEGIN
			RAISERROR('Informe o time 2',16,1)
		END

		IF NOT EXISTS(
			SELECT 1 
			FROM Vic_Time
			WHERE idTime = @IdTime2 
		)
		BEGIN
			SET @MsgErro = FORMAT(@IdTime2, 'Você está informando um time que não está cadastrado')
			RAISERROR(@MsgErro, 16,1)
		END

		INSERT INTO Vic_Jogo(idTime1, idTime2) 
		VALUES(@IdTime1, @IdTime2)

		RETURN 0
	END TRY
	BEGIN CATCH
		SET @MsgErro = ERROR_MESSAGE()
		RAISERROR(@MsgErro, 16, 1)
		RETURN 1
	END CATCH
END
