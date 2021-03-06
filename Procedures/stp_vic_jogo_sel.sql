USE [dbTreinamento]
GO
/****** Object:  StoredProcedure [dbo].[stp_Vic_Jogo_Sel]    Script Date: 24/08/2021 16:37:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[stp_Vic_Jogo_Sel]
	@IdJogo INT = NULL,
	@IdTime1 VARCHAR(50) = NULL,
	@IdTime2 VARCHAR(50) = NULL,
	@TipoConsulta INT = NULL
AS
BEGIN
	BEGIN TRY
		DECLARE @MsgErro VARCHAR(255)

		IF @TipoConsulta IS NULL
		BEGIN
		
			SELECT T1.NOME AS NomeTime1, T2.NOME AS NomeTime2, J.Placar1 AS PLACAR1,
				J.Placar2 AS PLACAR2, JO1.Nome AS JogadorTime1, JO2.Nome AS JogadorTime2,
				P.GolsMarcados AS GolsMarcados
			FROM Vic_Jogo J
			INNER JOIN Vic_Time T1 ON J.idTime1 = T1.idTime
			INNER JOIN Vic_Time T2 ON J.idTime2 = T2.idTime
			INNER JOIN Vic_Jogador JO1 ON JO1.idJogador = T1.idTime
			INNER JOIN Vic_Jogador JO2 ON JO2.idJogador = T2.idTime
			INNER JOIN Vic_Participacao P ON J.idJogo = P.idJogo
			WHERE J.idJogo = @IdJogo OR @IdJogo IS NULL
		END

		IF @TipoConsulta = 1
		BEGIN
		
			select * 
			from Vic_Time

		END


		RETURN 0
	END TRY
	BEGIN CATCH
		SET @MsgErro = ERROR_MESSAGE()
		RAISERROR(@MsgErro, 16, 1)
		RETURN 1
	END CATCH
END
