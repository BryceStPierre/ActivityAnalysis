CREATE TABLE [Source].[TelusCallHistory]
(
	[Date] VARCHAR(20) NULL,
	[Time] VARCHAR(6) NULL,
	[Duration (min)] FLOAT NULL,
	[Caller] VARCHAR(11) NULL,
	[Callee] VARCHAR(11) NULL,
	[From Location] VARCHAR(20) NULL,
	[To Location] VARCHAR(20) NULL,
	[Long Distance Charge] FLOAT NULL,
	[Air Time Charge] FLOAT NULL,
	[Cost] FLOAT NULL,
	[Roaming] VARCHAR (5) NULL,
	[Direction] VARCHAR(20) NULL
)
