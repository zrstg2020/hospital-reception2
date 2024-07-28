USE [hospital reception1]
GO

/****** Object:  Table [dbo].[department]    Script Date: 7/26/2024 2:05:14 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[department](
	[dep_id] [int] IDENTITY(100,1) NOT NULL,
	[depname] [nvarchar](50) NOT NULL,
	[nbeds] [int] NOT NULL,
	[manager_pe_id] [int] NULL,
	[number_personnels] [int] NULL,
	[cost_per_bed] [decimal](18, 2) NULL,
	[dep_discription] [text] NULL,
 CONSTRAINT [PK_department] PRIMARY KEY CLUSTERED 
(
	[dep_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'department id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'department', @level2type=N'COLUMN',@level2name=N'dep_id'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'[department name]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'department', @level2type=N'COLUMN',@level2name=N'depname'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'number of beds' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'department', @level2type=N'COLUMN',@level2name=N'nbeds'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'[manager name]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'department', @level2type=N'COLUMN',@level2name=N'manager_pe_id'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'[number of personnels]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'department', @level2type=N'COLUMN',@level2name=N'number_personnels'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'[cost per bed]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'department', @level2type=N'COLUMN',@level2name=N'cost_per_bed'
GO

