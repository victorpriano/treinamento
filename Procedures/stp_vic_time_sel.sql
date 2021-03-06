USE [dbTreinamento]
GO
/****** Object:  StoredProcedure [dbo].[stp_Vic_Time_Sel]    Script Date: 24/08/2021 16:39:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[stp_Vic_Time_Sel]
	@IdTime INT = NULL
AS
BEGIN
	BEGIN TRY
		DECLARE @MsgErro VARCHAR(255)

		SELECT *
		FROM Vic_Time
		WHERE idTime = @IdTime OR @IdTime IS NULL

		RETURN 0
	END TRY
	BEGIN CATCH
		SET @MsgErro = ERROR_MESSAGE()
		RAISERROR(@MsgErro, 16, 1)
		RETURN 1
	END CATCH
END
