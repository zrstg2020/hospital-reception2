USE [hospital reception1]
GO

/****** Object:  Table [dbo].[patient]    Script Date: 7/26/2024 2:06:18 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[patient](
	[pa_id] [int] IDENTITY(1,1) NOT NULL,
	[panationalcode] [char](10) NOT NULL,
	[fname] [nvarchar](50) NOT NULL,
	[lname] [nvarchar](50) NOT NULL,
	[insurance_code] [nvarchar](50) NULL,
	[landline_phone] [nvarchar](50) NULL,
	[cellular_phone] [nvarchar](50) NULL,
	[pa_address] [text] NULL,
	[medical_allergy] [nvarchar](50) NULL,
	[pa_description] [text] NULL,
 CONSTRAINT [PK_patient] PRIMARY KEY CLUSTERED 
(
	[pa_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'patient id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'patient', @level2type=N'COLUMN',@level2name=N'pa_id'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'[patient national code]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'patient', @level2type=N'COLUMN',@level2name=N'panationalcode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'patient', @level2type=N'COLUMN',@level2name=N'pa_description'
GO

