﻿CREATE TABLE [Integration].[DataSets]
(
	[Id] INT IDENTITY(1,1) PRIMARY KEY, 
    [Name] VARCHAR(50) NOT NULL,
	[Path] VARCHAR(250) NOT NULL DEFAULT NULL,
    [Label] VARCHAR(75) NOT NULL,
	[Summary] VARCHAR(200) NULL,
	[DataSourceId] INT NOT NULL, 
	[Updated] DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    [Created] DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
    CONSTRAINT [FK_DataSourceId] FOREIGN KEY ([DataSourceId]) REFERENCES [Integration].[DataSources]([Id])
)
