USE [dbTreinamento]
GO
/****** Object:  StoredProcedure [dbo].[stp_Vic_Classificacao_Sel]    Script Date: 24/08/2021 16:35:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[stp_Vic_Classificacao_Sel]
	@IdTime INT = NULL
AS
BEGIN
	BEGIN TRY
		DECLARE @MsgErro VARCHAR(255)


	declare @vitoria int
	declare @empate int

	set @vitoria = 3
	set @empate = 1

	select
	t.Nome AS Nome,
	NumeroPontos = 
	(
		(
			select isnull(sum(
				case 
					when j.Placar1 > j.Placar2 then @vitoria
					when j.Placar1 = j.Placar2 then @empate
				end),0)
			from Vic_Jogo j
			where j.idTime1 = t.idTime
		) 
		+
		(	select isnull(sum(
				case 
					when j.Placar1 < j.Placar2 then @vitoria
					when j.Placar1 = j.Placar2 then @empate
				end),0)
			from Vic_Jogo j
			where j.idTime2 = t.idTime
		)
	),
	SaldoGols = (
		(
			(select
				isnull(sum(j.Placar1),0)
			from Vic_Jogo j
			where j.idTime1 = t.idTime
			)
			+
			(select
				isnull(sum(j.Placar2),0)
			from Vic_Jogo j
			where j.idTime2 = t.idTime
			) /*gols marcados*/
			)
		)
		-
		(
			(select
				isnull(sum(j.Placar2),0)
			from Vic_Jogo j
			where j.idTime1 = t.idTime
			) 
			+
			(select
				isnull(sum(j.Placar1),0)
			from Vic_Jogo j
			where j.idTime2 = t.idTime
		) /*gols marcados e gols sofridos*/
	),
	GolsMarcados = (
		(select
			isnull(sum(j.Placar1),0)
		from Vic_Jogo j
		where j.idTime1 = t.idTime
		)
		+
		(select
			isnull(sum(j.Placar2),0)
		from Vic_Jogo j
		where j.idTime2 = t.idTime
		)
	)
	from Vic_Time t
	WHERE t.idTime = @IdTime OR @IdTime IS NULL
	order by NumeroPontos desc, t.Nome, SaldoGols desc, GolsMarcados desc

	RETURN 0

	END TRY
	BEGIN CATCH
		SET @MsgErro = ERROR_MESSAGE()
		RAISERROR(@MsgErro, 16, 1)
		RETURN 1
	END CATCH
END
