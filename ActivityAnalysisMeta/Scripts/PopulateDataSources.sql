TRUNCATE TABLE [Integration].[DataSources]
GO
SET IDENTITY_INSERT [Integration].[DataSources] ON 
GO
INSERT [Integration].[DataSources] ([Id], [Name], [Description], [Updated], [Created]) VALUES (1, N'Apple', N'My smartphone''s manufacturer.', GETDATE(), GETDATE())
GO
INSERT [Integration].[DataSources] ([Id], [Name], [Description], [Updated], [Created]) VALUES (2, N'Telus', N'My cellular service provider.', GETDATE(), GETDATE())
GO
INSERT [Integration].[DataSources] ([Id], [Name], [Description], [Updated], [Created]) VALUES (3, N'TekSavvy', N'My Internet service provider.', GETDATE(), GETDATE())
GO
INSERT [Integration].[DataSources] ([Id], [Name], [Description], [Updated], [Created]) VALUES (4, N'Twitter', N'One of my social media accounts.', GETDATE(), GETDATE())
GO
INSERT [Integration].[DataSources] ([Id], [Name], [Description], [Updated], [Created]) VALUES (5, N'Instagram', N'One of my social media accounts.', GETDATE(), GETDATE())
GO
INSERT [Integration].[DataSources] ([Id], [Name], [Description], [Updated], [Created]) VALUES (6, N'Snapchat', N'One of my social media accounts.', GETDATE(), GETDATE())
GO
INSERT [Integration].[DataSources] ([Id], [Name], [Description], [Updated], [Created]) VALUES (7, N'Facebook', N'One of my social media accounts.', GETDATE(), GETDATE())
GO
INSERT [Integration].[DataSources] ([Id], [Name], [Description], [Updated], [Created]) VALUES (8, N'Netflix', N'My television streaming service.', GETDATE(), GETDATE())
GO
INSERT [Integration].[DataSources] ([Id], [Name], [Description], [Updated], [Created]) VALUES (9, N'RBC', N'My banking institution.', GETDATE(), GETDATE())
GO
INSERT [Integration].[DataSources] ([Id], [Name], [Description], [Updated], [Created]) VALUES (10, N'Google', N'My browser service.', GETDATE(), GETDATE())
GO
INSERT [Integration].[DataSources] ([Id], [Name], [Description], [Updated], [Created]) VALUES (11, N'YouTube', N'My video service.', GETDATE(), GETDATE())
GO
SET IDENTITY_INSERT [Integration].[DataSources] OFF
GO