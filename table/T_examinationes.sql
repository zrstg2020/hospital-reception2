USE [hospital reception1]
GO

/****** Object:  Table [dbo].[examinations]    Script Date: 7/26/2024 2:05:45 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[examinations](
	[ex_id] [int] IDENTITY(1,1) NOT NULL,
	[pa_id] [int] NOT NULL,
	[pe_id] [int] NOT NULL,
	[prescriptions] [text] NOT NULL,
	[date] [date] NOT NULL,
	[time] [time](7) NOT NULL,
	[shift_code] [int] NULL,
	[ex_discription] [text] NULL,
 CONSTRAINT [PK_examinations] PRIMARY KEY CLUSTERED 
(
	[ex_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[examinations] ADD  CONSTRAINT [DF_examinations_date]  DEFAULT (getdate()) FOR [date]
GO

ALTER TABLE [dbo].[examinations]  WITH CHECK ADD  CONSTRAINT [FK_examinations_patient] FOREIGN KEY([pa_id])
REFERENCES [dbo].[patient] ([pa_id])
GO

ALTER TABLE [dbo].[examinations] CHECK CONSTRAINT [FK_examinations_patient]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'examinations id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'examinations', @level2type=N'COLUMN',@level2name=N'ex_id'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'patient id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'examinations', @level2type=N'COLUMN',@level2name=N'pa_id'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'personnel_code' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'examinations', @level2type=N'COLUMN',@level2name=N'pe_id'
GO

