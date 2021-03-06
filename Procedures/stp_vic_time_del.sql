USE [dbTreinamento]
GO
/****** Object:  StoredProcedure [dbo].[stp_Vic_Time_Del]    Script Date: 24/08/2021 16:39:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[stp_Vic_Time_Del]
	@IdTime INT = NULL,
	@Nome VARCHAR(50) = NULL
AS
BEGIN
	BEGIN TRY
		DECLARE @MsgErro VARCHAR(255)

		IF @IdTime IS NULL
		BEGIN
			RAISERROR('Informe o Id do time',16,1)
		END

		DELETE Vic_Time
		WHERE idTime = @IdTime

		RETURN 0
	END TRY
	BEGIN CATCH
		SET @MsgErro = ERROR_MESSAGE()
		RAISERROR(@MsgErro, 16, 1)
		RETURN 1
	END CATCH
END
