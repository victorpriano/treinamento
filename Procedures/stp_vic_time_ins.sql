USE [dbTreinamento]
GO
/****** Object:  StoredProcedure [dbo].[stp_Vic_Time_Ins]    Script Date: 24/08/2021 16:39:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[stp_Vic_Time_Ins]
	@IdTime INT = NULL,
	@Nome VARCHAR(50) = NULL
AS
BEGIN
	BEGIN TRY
		DECLARE @MsgErro VARCHAR(255)

		IF NULLIF(@Nome, '') IS NULL
			BEGIN
			SET @MsgErro = 'INFORME O NOME DO TIME'
				RAISERROR(@MsgErro, 16,1)
			END

		IF EXISTS (
			SELECT 1
			FROM Vic_Time
			WHERE Nome = @Nome 
		)
		BEGIN
			RAISERROR('Time já cadastrado',16,1)
		END

		INSERT INTO Vic_Time(nome) values (@Nome)

		RETURN 0
	END TRY
	BEGIN CATCH
		SET @MsgErro = ERROR_MESSAGE()
		RAISERROR(@MsgErro, 16, 1)
		RETURN 1
	END CATCH
END
