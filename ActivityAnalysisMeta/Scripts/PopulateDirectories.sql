TRUNCATE TABLE [Environment].[Directories]
GO
SET IDENTITY_INSERT [Environment].[Directories] ON 
GO
INSERT [Environment].[Directories] ([Id], [Name], [Value], [Updated], [Created]) VALUES (1, N'Input', N'C:\Users\bryce\Data', GETDATE(), GETDATE())
GO
INSERT [Environment].[Directories] ([Id], [Name], [Value], [Updated], [Created]) VALUES (2, N'Processing', N'C:\Users\bryce\DataProcessing', GETDATE(), GETDATE())
GO
SET IDENTITY_INSERT [Environment].[Directories] OFF
GO