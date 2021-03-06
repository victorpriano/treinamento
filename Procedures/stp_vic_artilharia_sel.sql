USE [dbTreinamento]
GO
/****** Object:  StoredProcedure [dbo].[stp_Vic_Artilharia_Sel]    Script Date: 24/08/2021 16:34:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[stp_Vic_Artilharia_Sel]
	@IdJogador INT = NULL
AS
BEGIN
	BEGIN TRY
		DECLARE @MsgErro VARCHAR(255)

	SELECT NomeJogador, NomeTime, QuantidadeGols
	FROM (
	select
		j.Nome AS NomeJogador,
		t.Nome AS NomeTime,
		sum(GolsMarcados) QuantidadeGols,
		DENSE_RANK() OVER(PARTITION BY t.Nome ORDER BY SUM(p.golsMarcados) DESC) Ranking
	from Vic_Participacao p
	inner join Vic_Jogador j on j.idJogador = p.idJogador
	INNER JOIN vic_Time t ON t.idTime = j.idTime
	group by j.Nome, t.Nome
) t
WHERE Ranking = 1
ORDER BY QuantidadeGols DESC
		
		RETURN 0

	END TRY
	BEGIN CATCH
		SET @MsgErro = ERROR_MESSAGE()
		RAISERROR(@MsgErro, 16, 1)
		RETURN 1
	END CATCH

END
