USE [dbTreinamento]
GO
/****** Object:  StoredProcedure [dbo].[stp_Vic_Jogador_Ins]    Script Date: 24/08/2021 16:36:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[stp_Vic_Jogador_Ins]
	@IdJogador INT = NULL,
	@Nome VARCHAR(50) = NULL,
	@IdTime INT = NULL
AS
BEGIN
	BEGIN TRY
		DECLARE @MsgErro VARCHAR(255)

		IF NULLIF(@Nome, '') IS NULL
			BEGIN
				SET @MsgErro = 'Campo nome não pode ficar em branco'
				RAISERROR(@MsgErro, 16, 1)
			END

		IF @Nome IS NULL
			BEGIN
				RAISERROR('Informe o nome do jogador', 16,1)
			END

		IF EXISTS(
			SELECT 1 
			FROM Vic_Jogador
			WHERE Nome = @Nome
		)
		BEGIN
			SET @MsgErro = ' O jogador informado já existe'
			RAISERROR(@MsgErro, 16, 1)
		END

		IF NOT EXISTS(
			SELECT 1
			FROM Vic_Time 
			WHERE idTime = @IdTime
		)
		BEGIN
			SET @MsgErro = FORMAT(@IdTime, 'O time informado não existe')
			RAISERROR(@MsgErro, 16, 1)
		END

		INSERT INTO Vic_Jogador(Nome, idTime) VALUES(@Nome, @IdTime)

		RETURN 0
	END TRY
	BEGIN CATCH
		SET @MsgErro = ERROR_MESSAGE()
		RAISERROR(@MsgErro, 16, 1)
		RETURN 1
	END CATCH
END
