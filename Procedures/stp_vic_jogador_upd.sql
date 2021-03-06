USE [dbTreinamento]
GO
/****** Object:  StoredProcedure [dbo].[stp_Vic_Jogador_Upd]    Script Date: 24/08/2021 16:36:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[stp_Vic_Jogador_Upd]
	@IdJogador INT = NULL,
	@Nome VARCHAR(50) = NULL,
	@IdTime INT = NULL
AS
BEGIN
	BEGIN TRY
		DECLARE @MsgErro VARCHAR(255)

		IF NULLIF(@Nome, '') IS NULL
			BEGIN
				SET @MsgErro = @Nome + 'Campo nome não pode ficar em branco'
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
			SET @MsgErro = @Nome + ' O jogador informado já existe'
			RAISERROR(@MsgErro, 16, 1)
		END

		IF NOT EXISTS(
			SELECT 1
			FROM Vic_Jogador 
			WHERE idJogador = @IdJogador
		)
		BEGIN
			SET @MsgErro = FORMAT(@IdJogador, 'O jogador informado não existe')
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

		UPDATE Vic_Jogador SET Nome = @Nome, idTime = @IdTime
		WHERE idJogador = @IdJogador

		RETURN 0
	END TRY
	BEGIN CATCH
		SET @MsgErro = ERROR_MESSAGE()
		RAISERROR(@MsgErro, 16, 1)
		RETURN 1
	END CATCH
END
