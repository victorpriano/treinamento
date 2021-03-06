USE [dbTreinamento]
GO
/****** Object:  StoredProcedure [dbo].[stp_Sys_Operador_Del]    Script Date: 24/08/2021 16:31:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[stp_Sys_Operador_Del]
@Idoperador INT = NULL,
@Nome VARCHAR(50) = NULL,
@Cpf VARCHAR(50) = NULL
AS
BEGIN
	BEGIN TRY
		DECLARE @MsgErro VARCHAR(255)
		
		IF @Idoperador IS NULL
			BEGIN
				RAISERROR('INFORME O ID DO OPERADOR', 16, 1)
			END

		DELETE Sys_Operador
		WHERE idOperador = @Idoperador

		RETURN 0

	END TRY
	BEGIN CATCH
		SET @MsgErro = ERROR_MESSAGE()
		RAISERROR(@MsgErro, 16, 1)
		RETURN 1
	END CATCH

END
