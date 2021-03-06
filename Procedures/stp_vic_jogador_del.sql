USE [dbTreinamento]
GO
/****** Object:  StoredProcedure [dbo].[stp_Vic_Jogador_Del]    Script Date: 24/08/2021 16:36:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[stp_Vic_Jogador_Del]
	@IdJogador INT = NULL,
	@Nome VARCHAR(50) = NULL,
	@IdTime INT = NULL
AS
BEGIN
	BEGIN TRY
		DECLARE @MsgErro VARCHAR(255)

		IF @IdJogador IS NULL
			BEGIN
				RAISERROR('Informe o id do jogador', 16, 1)
			END

		DELETE Vic_Jogador
		WHERE idJogador = @IdJogador

		RETURN 0
	END TRY
	BEGIN CATCH
		SET @MsgErro = ERROR_MESSAGE()
		RAISERROR(@MsgErro, 16, 1)
		RETURN 1
	END CATCH
END
