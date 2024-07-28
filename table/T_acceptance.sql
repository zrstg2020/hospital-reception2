USE [hospital reception1]
GO

/****** Object:  Table [dbo].[acceptance]    Script Date: 7/26/2024 2:02:26 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[acceptance](
	[ac_id] [int] IDENTITY(1000,1) NOT NULL,
	[pa_id] [int] NOT NULL,
	[pe_id] [int] NOT NULL,
	[dep_id] [int] NOT NULL,
	[admission_date] [date] NOT NULL,
	[releas_date] [date] NULL,
	[admision_time] [time](7) NULL,
	[discharge_time] [time](7) NOT NULL,
	[sickness] [nvarchar](50) NULL,
	[accept_discription] [text] NULL,
 CONSTRAINT [PK_acceptance] PRIMARY KEY CLUSTERED 
(
	[ac_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[acceptance] ADD  CONSTRAINT [DF_Table_1_date of admission]  DEFAULT (getdate()) FOR [admission_date]
GO

ALTER TABLE [dbo].[acceptance]  WITH CHECK ADD  CONSTRAINT [FK_acceptance_patient] FOREIGN KEY([pa_id])
REFERENCES [dbo].[patient] ([pa_id])
GO

ALTER TABLE [dbo].[acceptance] CHECK CONSTRAINT [FK_acceptance_patient]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'acceptance_code' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'acceptance', @level2type=N'COLUMN',@level2name=N'ac_id'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'patient id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'acceptance', @level2type=N'COLUMN',@level2name=N'pa_id'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'personnel_code of doctore' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'acceptance', @level2type=N'COLUMN',@level2name=N'pe_id'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'department id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'acceptance', @level2type=N'COLUMN',@level2name=N'dep_id'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'date_of_admission' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'acceptance', @level2type=N'COLUMN',@level2name=N'admission_date'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'releas_date' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'acceptance', @level2type=N'COLUMN',@level2name=N'releas_date'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'time_of_admision' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'acceptance', @level2type=N'COLUMN',@level2name=N'admision_time'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'discription' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'acceptance', @level2type=N'COLUMN',@level2name=N'accept_discription'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'acceptance'
GO

