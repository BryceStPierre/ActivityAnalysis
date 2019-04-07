TRUNCATE TABLE [Integration].[DataSets]
GO
SET IDENTITY_INSERT [Integration].[DataSets] ON 
GO
INSERT [Integration].[DataSets] ([Id], [DataSource], [Name], [Label], [Type], [PrePath], [PostPath], [Load], [Updated], [Created]) VALUES (1, N'Apple', N'AppDownloads', N'App Downloads', N'CSV', NULL, NULL, 1, GETDATE(), GETDATE())
GO
INSERT [Integration].[DataSets] ([Id], [DataSource], [Name], [Label], [Type], [PrePath], [PostPath], [Load], [Updated], [Created]) VALUES (2, N'Apple', N'Podcasts', N'Podcasts', N'CSV', NULL, NULL, 1, GETDATE(), GETDATE())
GO
INSERT [Integration].[DataSets] ([Id], [DataSource], [Name], [Label], [Type], [PrePath], [PostPath], [Load], [Updated], [Created]) VALUES (3, N'Apple', N'PodcastHistory', N'Podcast History', N'CSV', NULL, NULL, 1, GETDATE(), GETDATE())
GO
INSERT [Integration].[DataSets] ([Id], [DataSource], [Name], [Label], [Type], [PrePath], [PostPath], [Load], [Updated], [Created]) VALUES (4, N'Facebook', N'Comments', N'Comments', N'JSON', NULL, NULL, 1, GETDATE(), GETDATE())
GO
INSERT [Integration].[DataSets] ([Id], [DataSource], [Name], [Label], [Type], [PrePath], [PostPath], [Load], [Updated], [Created]) VALUES (5, N'Facebook', N'ExternalShares', N'External Shares', N'JSON', NULL, NULL, 1, GETDATE(), GETDATE())
GO
INSERT [Integration].[DataSets] ([Id], [DataSource], [Name], [Label], [Type], [PrePath], [PostPath], [Load], [Updated], [Created]) VALUES (6, N'Facebook', N'LikesReactions', N'Likes and Reactions', N'JSON', NULL, NULL, 1, GETDATE(), GETDATE())
GO
INSERT [Integration].[DataSets] ([Id], [DataSource], [Name], [Label], [Type], [PrePath], [PostPath], [Load], [Updated], [Created]) VALUES (7, N'Facebook', N'LoginActivity', N'Login Activity', N'JSON', NULL, NULL, 1, GETDATE(), GETDATE())
GO
INSERT [Integration].[DataSets] ([Id], [DataSource], [Name], [Label], [Type], [PrePath], [PostPath], [Load], [Updated], [Created]) VALUES (8, N'Facebook', N'Messages', N'Messages', N'JSON', NULL, NULL, 1, GETDATE(), GETDATE())
GO
INSERT [Integration].[DataSets] ([Id], [DataSource], [Name], [Label], [Type], [PrePath], [PostPath], [Load], [Updated], [Created]) VALUES (9, N'Facebook', N'Posts', N'Posts', N'JSON', NULL, NULL, 1, GETDATE(), GETDATE())
GO
INSERT [Integration].[DataSets] ([Id], [DataSource], [Name], [Label], [Type], [PrePath], [PostPath], [Load], [Updated], [Created]) VALUES (10, N'Google', N'BrowserHistory', N'Browser History', N'JSON', NULL, NULL, 1, GETDATE(), GETDATE())
GO
INSERT [Integration].[DataSets] ([Id], [DataSource], [Name], [Label], [Type], [PrePath], [PostPath], [Load], [Updated], [Created]) VALUES (11, N'Instagram', N'Likes', N'Likes', N'JSON', NULL, NULL, 1, GETDATE(), GETDATE())
GO
INSERT [Integration].[DataSets] ([Id], [DataSource], [Name], [Label], [Type], [PrePath], [PostPath], [Load], [Updated], [Created]) VALUES (12, N'Instagram', N'Posts', N'Posts', N'JSON', NULL, NULL, 1, GETDATE(), GETDATE())
GO
INSERT [Integration].[DataSets] ([Id], [DataSource], [Name], [Label], [Type], [PrePath], [PostPath], [Load], [Updated], [Created]) VALUES (13, N'Netflix', N'ViewingHistory', N'Viewing History', N'CSV', NULL, NULL, 1, GETDATE(), GETDATE())
GO
INSERT [Integration].[DataSets] ([Id], [DataSource], [Name], [Label], [Type], [PrePath], [PostPath], [Load], [Updated], [Created]) VALUES (14, N'Rbc', N'BankTransactions', N'Bank Transactions', N'CSV', NULL, NULL, 1, GETDATE(), GETDATE())
GO
INSERT [Integration].[DataSets] ([Id], [DataSource], [Name], [Label], [Type], [PrePath], [PostPath], [Load], [Updated], [Created]) VALUES (15, N'RescueTime', N'ActivityHistory', N'Activity History', N'CSV', NULL, NULL, 1, GETDATE(), GETDATE())
GO
INSERT [Integration].[DataSets] ([Id], [DataSource], [Name], [Label], [Type], [PrePath], [PostPath], [Load], [Updated], [Created]) VALUES (16, N'Snapchat', N'ChatHistory', N'Chat History', N'JSON', NULL, NULL, 1, GETDATE(), GETDATE())
GO
INSERT [Integration].[DataSets] ([Id], [DataSource], [Name], [Label], [Type], [PrePath], [PostPath], [Load], [Updated], [Created]) VALUES (17, N'Snapchat', N'SnapHistory', N'Snap History', N'JSON', NULL, NULL, 1, GETDATE(), GETDATE())
GO
INSERT [Integration].[DataSets] ([Id], [DataSource], [Name], [Label], [Type], [PrePath], [PostPath], [Load], [Updated], [Created]) VALUES (18, N'Snapchat', N'TalkHistory', N'Talk History', N'JSON', NULL, NULL, 1, GETDATE(), GETDATE())
GO
INSERT [Integration].[DataSets] ([Id], [DataSource], [Name], [Label], [Type], [PrePath], [PostPath], [Load], [Updated], [Created]) VALUES (19, N'TekSavvy', N'InternetUsage', N'Internet Usage', N'CSV', NULL, NULL, 1, GETDATE(), GETDATE())
GO
INSERT [Integration].[DataSets] ([Id], [DataSource], [Name], [Label], [Type], [PrePath], [PostPath], [Load], [Updated], [Created]) VALUES (20, N'Telus', N'CallHistory', N'Call History', N'CSV', NULL, NULL, 1, GETDATE(), GETDATE())
GO
INSERT [Integration].[DataSets] ([Id], [DataSource], [Name], [Label], [Type], [PrePath], [PostPath], [Load], [Updated], [Created]) VALUES (21, N'Telus', N'DataHistory', N'Data History', N'CSV', NULL, NULL, 1, GETDATE(), GETDATE())
GO
INSERT [Integration].[DataSets] ([Id], [DataSource], [Name], [Label], [Type], [PrePath], [PostPath], [Load], [Updated], [Created]) VALUES (22, N'Telus', N'MessageHistory', N'Message History', N'CSV', NULL, NULL, 1, GETDATE(), GETDATE())
GO
INSERT [Integration].[DataSets] ([Id], [DataSource], [Name], [Label], [Type], [PrePath], [PostPath], [Load], [Updated], [Created]) VALUES (23, N'YouTube', N'SearchHistory', N'Search History', N'HTML', NULL, NULL, 1, GETDATE(), GETDATE())
GO
INSERT [Integration].[DataSets] ([Id], [DataSource], [Name], [Label], [Type], [PrePath], [PostPath], [Load], [Updated], [Created]) VALUES (24, N'YouTube', N'ViewingHistory', N'Viewing History', N'HTML', NULL, NULL, 1, GETDATE(), GETDATE())
GO
SET IDENTITY_INSERT [Integration].[DataSets] OFF
GO