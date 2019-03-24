TRUNCATE TABLE [Integration].[DataSets]
GO
SET IDENTITY_INSERT [Integration].[DataSets] ON 
GO
INSERT [Integration].[DataSets] ([Id], [DataSource], [Name], [Label], [Type], [PrePath], [PostPath], [Load], [Updated], [Created]) VALUES (1, N'Apple', N'Podcasts', N'Podcasts', N'CSV', NULL, NULL, 1, GETDATE(), GETDATE())
GO
INSERT [Integration].[DataSets] ([Id], [DataSource], [Name], [Label], [Type], [PrePath], [PostPath], [Load], [Updated], [Created]) VALUES (2, N'Apple', N'PodcastHistory', N'Podcast History', N'CSV', NULL, NULL, 1, GETDATE(), GETDATE())
GO
INSERT [Integration].[DataSets] ([Id], [DataSource], [Name], [Label], [Type], [PrePath], [PostPath], [Load], [Updated], [Created]) VALUES (3, N'Netflix', N'ViewingHistory', N'Viewing History', N'CSV', NULL, NULL, 1, GETDATE(), GETDATE())
GO
INSERT [Integration].[DataSets] ([Id], [DataSource], [Name], [Label], [Type], [PrePath], [PostPath], [Load], [Updated], [Created]) VALUES (4, N'TekSavvy', N'InternetUsage', N'Internet Usage', N'CSV', NULL, NULL, 1, GETDATE(), GETDATE())
GO
SET IDENTITY_INSERT [Integration].[DataSets] OFF
GO