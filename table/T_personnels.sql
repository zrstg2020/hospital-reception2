USE [hospital reception1]
GO

/****** Object:  Table [dbo].[personnels]    Script Date: 7/26/2024 2:06:47 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[personnels](
	[pe_id] [int] IDENTITY(1,1) NOT NULL,
	[penationalcode] [char](10) NOT NULL,
	[lname] [nvarchar](50) NOT NULL,
	[fname] [nvarchar](50) NOT NULL,
	[dep_id] [int] NOT NULL,
	[job_specialty] [nvarchar](50) NOT NULL,
	[pe_education] [nvarchar](50) NULL,
	[pe_landline_phone] [nvarchar](50) NULL,
	[pe_cellular_phone] [nvarchar](50) NULL,
	[date_employeement] [date] NOT NULL,
	[pe_adress] [text] NULL,
	[prev_job] [text] NULL,
	[pe_description] [text] NULL,
 CONSTRAINT [PK_personnels] PRIMARY KEY CLUSTERED 
(
	[pe_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[personnels] ADD  CONSTRAINT [DF_personnels_date of employeement]  DEFAULT (getdate()) FOR [date_employeement]
GO

ALTER TABLE [dbo].[personnels]  WITH CHECK ADD  CONSTRAINT [FK_personnels_department] FOREIGN KEY([dep_id])
REFERENCES [dbo].[department] ([dep_id])
GO

ALTER TABLE [dbo].[personnels] CHECK CONSTRAINT [FK_personnels_department]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'personnel_code' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'personnels', @level2type=N'COLUMN',@level2name=N'pe_id'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'department id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'personnels', @level2type=N'COLUMN',@level2name=N'dep_id'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'[date of employeement]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'personnels', @level2type=N'COLUMN',@level2name=N'date_employeement'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'[previous work experience]p' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'personnels', @level2type=N'COLUMN',@level2name=N'prev_job'
GO

