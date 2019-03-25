CREATE PROCEDURE [Stage].[TransformRbcBankTransactions]
AS
	TRUNCATE TABLE [Stage].[RbcBankTransactions];

	INSERT INTO [Stage].[RbcBankTransactions] (
		[Account],
		[Date],
		[Description],
		[Amount]
	) SELECT
		[Account Type] AS Account,
		[Transaction Date] AS Date,
		ISNULL([Description 1], '')
			+ CASE WHEN [Description 2] IS NULL THEN '' ELSE ' - ' END 
			+ ISNULL([Description 2], '') 
		AS Description,
		[CAD$] AS Amount
	FROM Source.RbcBankTransactions;
