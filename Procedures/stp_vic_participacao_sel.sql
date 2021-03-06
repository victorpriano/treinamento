USE [dbTreinamento]
GO
/****** Object:  StoredProcedure [dbo].[stp_Vic_Participacao_Sel]    Script Date: 24/08/2021 16:38:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[stp_Vic_Participacao_Sel]
	@idJogo INT = NULL,
	@TipoConsulta INT = NULL

AS
BEGIN
	BEGIN TRY
		DECLARE @MsgErro VARCHAR(255)

		IF @TipoConsulta IS NULL
		BEGIN 
			SELECT
				t.Nome AS EQUIPE,
				jo.IdJogador,
				jo.Nome AS NomeJogador,
				ISNULL(p.GolsMarcados,0) AS GOLSMARCADOS
			FROM Vic_Jogador jo
			INNER JOIN Vic_Time t ON t.idTime = jo.idTime
			INNER JOIN Vic_Jogo j ON j.idTime1 = t.idTime
			LEFT JOIN Vic_Participacao p ON p.idJogo = j.idJogo AND p.idJogador = jo.idJogador
			WHERE j.idJogo = @idJogo
			UNION
			SELECT
				t.Nome AS EQUIPE,
				jo.IdJogador,
				jo.Nome AS NomeJogador,
				ISNULL(p.GolsMarcados,0) AS GOLSMARCADOS
			FROM Vic_Jogador jo
			INNER JOIN Vic_Time t ON t.idTime = jo.idTime
			INNER JOIN Vic_Jogo j ON j.idTime2 = t.idTime
			LEFT JOIN Vic_Participacao p ON p.idJogo = j.idJogo AND p.idJogador = jo.idJogador
			WHERE j.idJogo = @idJogo
		END

		IF @TipoConsulta = 1
		BEGIN
			SELECT
				j.idJogo,
				j.idTime1,
				j.idTime2,
				T1.NOME AS Time1,
				T2.NOME AS Time2,
				J.Placar1 AS PLACAR1,
				J.Placar2 AS PLACAR2
			FROM Vic_Jogo J
			INNER JOIN Vic_Time T1 ON J.idTime1 = T1.idTime
			INNER JOIN Vic_Time T2 ON J.idTime2 = T2.idTime
		END

		RETURN 0

	END TRY
	BEGIN CATCH
		SET @MsgErro = ERROR_MESSAGE()
		RAISERROR(@MsgErro, 16, 1)
		RETURN 1
	END CATCH
END
