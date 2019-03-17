TRUNCATE TABLE [Environment].[Locations]
GO

SET IDENTITY_INSERT [Environment].[Locations] ON 
GO
INSERT [Environment].[Locations] ([Id], [Name], [Path], [Updated], [Created]) VALUES (1, N'Root', N'C:\Users\bryce\Data', GETDATE(), GETDATE())
GO
SET IDENTITY_INSERT [Environment].[Locations] OFF
GO