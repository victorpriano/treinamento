USE [dbTreinamento]
GO
/****** Object:  StoredProcedure [dbo].[stp_Vic_Jogador_Sel]    Script Date: 24/08/2021 16:36:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[stp_Vic_Jogador_Sel]
	@IdJogador INT = NULL,
	@TipoConsulta INT = NULL
AS
BEGIN
	BEGIN TRY
		DECLARE @MsgErro VARCHAR(255)

		IF @TipoConsulta IS NULL
		BEGIN
			SELECT j.idJogador, j.Nome, t.idTime, t.Nome as NomeTime 
			FROM Vic_Jogador j
			INNER JOIN Vic_Time t ON t.idTime = j.idTime
			WHERE idJogador = @IdJogador OR @IdJogador IS NULL
		END

		IF @TipoConsulta = 1
		BEGIN
			SELECT *
			FROM Vic_Time
		END

		RETURN 0
	END TRY
	BEGIN CATCH
		SET @MsgErro = ERROR_MESSAGE()
		RAISERROR(@MsgErro, 16, 1)
		RETURN 1
	END CATCH
END
