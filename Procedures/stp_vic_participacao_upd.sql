USE [dbTreinamento]
GO
/****** Object:  StoredProcedure [dbo].[stp_Vic_Participacao_Upd]    Script Date: 24/08/2021 16:38:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[stp_Vic_Participacao_Upd]
	@IdJogo INT = NULL,
	@IdJogador INT = NULL

AS
BEGIN
	BEGIN TRY
		DECLARE
			@MsgErro VARCHAR(255),
			@idTime INT = NULL

		IF @IdJogo IS NULL
		BEGIN
			RAISERROR('INFORME O JOGO', 16, 1)
		END
			
		IF @IdJogador IS NULL
		BEGIN
			RAISERROR('INFORME O JOGADOR', 16, 1)
		END

		IF NOT EXISTS(
			SELECT 1
			FROM Vic_Jogo
			WHERE idJogo = @IdJogo
		)
		BEGIN
			SET @MsgErro = FORMAT(@IdJogo, 'O JOGO INFORMADO NÃO EXISTE')
			RAISERROR(@MsgErro, 16, 1)
		END

		IF NOT EXISTS(
			SELECT 1
			FROM Vic_Jogador
			WHERE idJogador = @IdJogador
		)
		BEGIN
			SET @MsgErro = FORMAT(@IdJogador, 'O JOGADOR INFORMADO NÃO EXISTE')
			RAISERROR(@MsgErro, 16, 1)
		END

		SELECT @idTime = idTime
		FROM Vic_Jogador
		WHERE idJogador = @IdJogador

		BEGIN TRANSACTION

		IF EXISTS(
			SELECT 1
			FROM Vic_Participacao
			WHERE idJogo = @IdJogo AND idJogador = @IdJogador
		)
		BEGIN
			UPDATE Vic_Participacao SET
				GolsMarcados = GolsMarcados + 1
			WHERE idJogo = @IdJogo AND idJogador = @IdJogador
		END
		ELSE
		BEGIN
			INSERT INTO Vic_Participacao
			(
				idJogo,
				idJogador,
				GolsMarcados
			)
			VALUES (
				@idJogo,
				@IdJogador,
				1
			)
		END

		UPDATE Vic_Jogo SET
			Placar1 = CASE 
				WHEN idTIme1 = @idTime THEN Placar1 + 1
				ELSE Placar1
			END,
			Placar2 = CASE 
				WHEN idTIme2 = @idTime THEN Placar2 + 1
				ELSE Placar2
			END
		WHERE idJogo = @IdJogo

		COMMIT TRANSACTION

		RETURN 0
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK  TRANSACTION

		SET @MsgErro = ERROR_MESSAGE()
		RAISERROR(@MsgErro, 16, 1)
		RETURN 1
	END CATCH
END
