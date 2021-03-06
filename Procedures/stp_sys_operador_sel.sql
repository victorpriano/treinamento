USE [dbTreinamento]
GO
/****** Object:  StoredProcedure [dbo].[stp_Sys_Operador_Sel]    Script Date: 24/08/2021 16:31:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[stp_Sys_Operador_Sel]
@IdOperador INT = NULL
AS
BEGIN
	BEGIN TRY
		DECLARE @MsgErro VARCHAR(255)
		
			BEGIN
				SELECT idOperador AS IdOperador,
					cpf AS Cpf,
					nome AS Nome
				FROM Sys_Operador
				WHERE idOperador = @IdOperador OR @IdOperador IS NULL 
			END

		RETURN 0

	END TRY
	BEGIN CATCH
		SET @MsgErro = ERROR_MESSAGE()
		RAISERROR(@MsgErro, 16, 1)
		RETURN 1
	END CATCH

END
