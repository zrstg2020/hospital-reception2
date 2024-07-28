USE [hospital reception1]
GO
/****** Object:  Table [dbo].[acceptance]    Script Date: 7/24/2024 5:02:36 PM ******/
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
/****** Object:  Table [dbo].[department]    Script Date: 7/24/2024 5:02:36 PM ******/
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
/****** Object:  Table [dbo].[examinations]    Script Date: 7/24/2024 5:02:36 PM ******/
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
/****** Object:  Table [dbo].[patient]    Script Date: 7/24/2024 5:02:36 PM ******/
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
/****** Object:  Table [dbo].[personnels]    Script Date: 7/24/2024 5:02:36 PM ******/
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
ALTER TABLE [dbo].[acceptance] ADD  CONSTRAINT [DF_Table_1_date of admission]  DEFAULT (getdate()) FOR [admission_date]
GO
ALTER TABLE [dbo].[examinations] ADD  CONSTRAINT [DF_examinations_date]  DEFAULT (getdate()) FOR [date]
GO
ALTER TABLE [dbo].[personnels] ADD  CONSTRAINT [DF_personnels_date of employeement]  DEFAULT (getdate()) FOR [date_employeement]
GO
ALTER TABLE [dbo].[acceptance]  WITH CHECK ADD  CONSTRAINT [FK_acceptance_patient] FOREIGN KEY([pa_id])
REFERENCES [dbo].[patient] ([pa_id])
GO
ALTER TABLE [dbo].[acceptance] CHECK CONSTRAINT [FK_acceptance_patient]
GO
ALTER TABLE [dbo].[examinations]  WITH CHECK ADD  CONSTRAINT [FK_examinations_patient] FOREIGN KEY([pa_id])
REFERENCES [dbo].[patient] ([pa_id])
GO
ALTER TABLE [dbo].[examinations] CHECK CONSTRAINT [FK_examinations_patient]
GO
ALTER TABLE [dbo].[personnels]  WITH CHECK ADD  CONSTRAINT [FK_personnels_department] FOREIGN KEY([dep_id])
REFERENCES [dbo].[department] ([dep_id])
GO
ALTER TABLE [dbo].[personnels] CHECK CONSTRAINT [FK_personnels_department]
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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'examinations id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'examinations', @level2type=N'COLUMN',@level2name=N'ex_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'patient id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'examinations', @level2type=N'COLUMN',@level2name=N'pa_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'personnel_code' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'examinations', @level2type=N'COLUMN',@level2name=N'pe_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'patient id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'patient', @level2type=N'COLUMN',@level2name=N'pa_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'[patient national code]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'patient', @level2type=N'COLUMN',@level2name=N'panationalcode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'patient', @level2type=N'COLUMN',@level2name=N'pa_description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'personnel_code' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'personnels', @level2type=N'COLUMN',@level2name=N'pe_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'department id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'personnels', @level2type=N'COLUMN',@level2name=N'dep_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'[date of employeement]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'personnels', @level2type=N'COLUMN',@level2name=N'date_employeement'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'[previous work experience]p' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'personnels', @level2type=N'COLUMN',@level2name=N'prev_job'
GO
