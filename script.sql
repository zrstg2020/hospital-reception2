USE [hospital reception1]
GO
/****** Object:  UserDefinedFunction [dbo].[getfullnamepatient]    Script Date: 7/26/2024 1:41:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[getfullnamepatient](@panationalcode as char(10))
returns nvarchar(100)
begin
declare @result nvarchar(100)
set @result = (select fname + ' ' + lname from patient where panationalcode = @panationalcode);
return @result;
end
GO
/****** Object:  Table [dbo].[patient]    Script Date: 7/26/2024 1:41:09 AM ******/
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
/****** Object:  Table [dbo].[acceptance]    Script Date: 7/26/2024 1:41:09 AM ******/
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
/****** Object:  Table [dbo].[department]    Script Date: 7/26/2024 1:41:09 AM ******/
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
/****** Object:  View [dbo].[patient of each department]    Script Date: 7/26/2024 1:41:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[patient of each department]
AS
SELECT        dbo.department.depname, dbo.patient.fname, dbo.patient.lname, dbo.patient.panationalcode
FROM            dbo.acceptance INNER JOIN
                         dbo.department ON dbo.acceptance.dep_id = dbo.department.dep_id INNER JOIN
                         dbo.patient ON dbo.acceptance.pa_id = dbo.patient.pa_id
GO
/****** Object:  View [dbo].[count of all patient]    Script Date: 7/26/2024 1:41:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[count of all patient]
AS
SELECT        COUNT(pa_id) AS Expr1
FROM            dbo.patient
GO
/****** Object:  UserDefinedFunction [dbo].[getpatientinthedate]    Script Date: 7/26/2024 1:41:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function	[dbo].[getpatientinthedate](@date  as date)

returns table
as
return(select panationalcode,fname,lname
             from patient inner join acceptance on patient.pa_id=acceptance.pa_id
			 where  
			 @date >= admission_date and @date <= releas_date
)
GO
/****** Object:  Table [dbo].[personnels]    Script Date: 7/26/2024 1:41:09 AM ******/
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
/****** Object:  UserDefinedFunction [dbo].[getdoctorofthepatient]    Script Date: 7/26/2024 1:41:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[getdoctorofthepatient](@panationalcode as char(10))
returns table
as
return(select personnels.penationalcode,personnels.fname,
				personnels.lname
				from patient inner join acceptance  on patient.pa_id=acceptance.pa_id
				inner join personnels on acceptance.pe_id=personnels.pe_id
			where patient.panationalcode = @panationalcode
)
GO
/****** Object:  Table [dbo].[examinations]    Script Date: 7/26/2024 1:41:09 AM ******/
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
SET IDENTITY_INSERT [dbo].[acceptance] ON 

INSERT [dbo].[acceptance] ([ac_id], [pa_id], [pe_id], [dep_id], [admission_date], [releas_date], [admision_time], [discharge_time], [sickness], [accept_discription]) VALUES (1000, 1, 1, 102, CAST(N'2024-12-03' AS Date), CAST(N'2024-12-07' AS Date), CAST(N'12:02:03' AS Time), CAST(N'12:22:03' AS Time), N'fever', NULL)
INSERT [dbo].[acceptance] ([ac_id], [pa_id], [pe_id], [dep_id], [admission_date], [releas_date], [admision_time], [discharge_time], [sickness], [accept_discription]) VALUES (1001, 2, 2, 103, CAST(N'2024-12-05' AS Date), CAST(N'2024-12-07' AS Date), CAST(N'12:33:06' AS Time), CAST(N'12:05:03' AS Time), N'ards', NULL)
INSERT [dbo].[acceptance] ([ac_id], [pa_id], [pe_id], [dep_id], [admission_date], [releas_date], [admision_time], [discharge_time], [sickness], [accept_discription]) VALUES (1002, 3, 3, 106, CAST(N'2024-11-03' AS Date), CAST(N'2024-11-06' AS Date), CAST(N'12:24:12' AS Time), CAST(N'11:22:05' AS Time), N'heart sutgery', NULL)
SET IDENTITY_INSERT [dbo].[acceptance] OFF
GO
SET IDENTITY_INSERT [dbo].[department] ON 

INSERT [dbo].[department] ([dep_id], [depname], [nbeds], [manager_pe_id], [number_personnels], [cost_per_bed], [dep_discription]) VALUES (102, N'Emergency', 22, 1, 12, CAST(52.00 AS Decimal(18, 2)), N'no')
INSERT [dbo].[department] ([dep_id], [depname], [nbeds], [manager_pe_id], [number_personnels], [cost_per_bed], [dep_discription]) VALUES (103, N'icu', 9, 2, 11, CAST(96.00 AS Decimal(18, 2)), N'no')
INSERT [dbo].[department] ([dep_id], [depname], [nbeds], [manager_pe_id], [number_personnels], [cost_per_bed], [dep_discription]) VALUES (106, N'surgery', 34, 3, 19, CAST(57.00 AS Decimal(18, 2)), N'no')
INSERT [dbo].[department] ([dep_id], [depname], [nbeds], [manager_pe_id], [number_personnels], [cost_per_bed], [dep_discription]) VALUES (107, N'urology', 12, 4, 5, CAST(45.00 AS Decimal(18, 2)), N'no')
SET IDENTITY_INSERT [dbo].[department] OFF
GO
SET IDENTITY_INSERT [dbo].[examinations] ON 

INSERT [dbo].[examinations] ([ex_id], [pa_id], [pe_id], [prescriptions], [date], [time], [shift_code], [ex_discription]) VALUES (2, 1, 1, N'acetaminophen', CAST(N'2024-07-17' AS Date), CAST(N'12:22:12' AS Time), 1, NULL)
INSERT [dbo].[examinations] ([ex_id], [pa_id], [pe_id], [prescriptions], [date], [time], [shift_code], [ex_discription]) VALUES (3, 2, 1, N'rest', CAST(N'2024-07-17' AS Date), CAST(N'12:15:14' AS Time), 1, NULL)
INSERT [dbo].[examinations] ([ex_id], [pa_id], [pe_id], [prescriptions], [date], [time], [shift_code], [ex_discription]) VALUES (4, 3, 2, N'rest', CAST(N'2024-07-17' AS Date), CAST(N'12:30:45' AS Time), 1, NULL)
SET IDENTITY_INSERT [dbo].[examinations] OFF
GO
SET IDENTITY_INSERT [dbo].[patient] ON 

INSERT [dbo].[patient] ([pa_id], [panationalcode], [fname], [lname], [insurance_code], [landline_phone], [cellular_phone], [pa_address], [medical_allergy], [pa_description]) VALUES (1, N'2511253658', N'mina', N'ahmadi', N'12345678', N'07125475896', N'09362583654', N'new york', N'no', N'no')
INSERT [dbo].[patient] ([pa_id], [panationalcode], [fname], [lname], [insurance_code], [landline_phone], [cellular_phone], [pa_address], [medical_allergy], [pa_description]) VALUES (2, N'2501251478', N'maryam', N'amiri', N'45678956', N'07125632589', N'09352658978', N'phoenix', N'no', N'no')
INSERT [dbo].[patient] ([pa_id], [panationalcode], [fname], [lname], [insurance_code], [landline_phone], [cellular_phone], [pa_address], [medical_allergy], [pa_description]) VALUES (3, N'2581452639', N'amin', N'rezayi', N'12345678', N'08125369874', N'09876541245', N'new york', N'Ibuprofen', N'no')
SET IDENTITY_INSERT [dbo].[patient] OFF
GO
SET IDENTITY_INSERT [dbo].[personnels] ON 

INSERT [dbo].[personnels] ([pe_id], [penationalcode], [lname], [fname], [dep_id], [job_specialty], [pe_education], [pe_landline_phone], [pe_cellular_phone], [date_employeement], [pe_adress], [prev_job], [pe_description]) VALUES (1, N'2511584789', N'sina', N'sobhani', 102, N'doctor', N'md', N'02187546985', N'06358745623', CAST(N'2010-10-04' AS Date), N'new york', N'doctor', NULL)
INSERT [dbo].[personnels] ([pe_id], [penationalcode], [lname], [fname], [dep_id], [job_specialty], [pe_education], [pe_landline_phone], [pe_cellular_phone], [date_employeement], [pe_adress], [prev_job], [pe_description]) VALUES (2, N'2502547896', N'mahsa', N'sarmad', 103, N'doctor', N'md', N'02154789654', N'09658956987', CAST(N'2009-02-02' AS Date), N'new york', N'doctor', NULL)
INSERT [dbo].[personnels] ([pe_id], [penationalcode], [lname], [fname], [dep_id], [job_specialty], [pe_education], [pe_landline_phone], [pe_cellular_phone], [date_employeement], [pe_adress], [prev_job], [pe_description]) VALUES (3, N'2541253695', N'james', N'johnson', 106, N'doctor', N'md', N'06154698725', N'09632587456', CAST(N'2012-02-06' AS Date), N'new york', N'doctor', NULL)
INSERT [dbo].[personnels] ([pe_id], [penationalcode], [lname], [fname], [dep_id], [job_specialty], [pe_education], [pe_landline_phone], [pe_cellular_phone], [date_employeement], [pe_adress], [prev_job], [pe_description]) VALUES (4, N'2511362547', N'mary', N'brown', 103, N'nurse', N'bsn', N'02145695847', N'09657854521', CAST(N'2010-01-06' AS Date), N'new york', NULL, NULL)
SET IDENTITY_INSERT [dbo].[personnels] OFF
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
/****** Object:  StoredProcedure [dbo].[spgetperiodsick]    Script Date: 7/26/2024 1:41:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spgetperiodsick]
@ac_id as int
as
select DATEDIFF(day,admission_date,releas_date) as sickness_period
from acceptance 
where ac_id=@ac_id
GO
/****** Object:  StoredProcedure [dbo].[spgetperiodsickall]    Script Date: 7/26/2024 1:41:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spgetperiodsickall]

as
select sickness,max(DATEDIFF(day,admission_date,releas_date)) as sickness_period
from acceptance 
group by sickness 
GO
/****** Object:  StoredProcedure [dbo].[spinserttodepartment]    Script Date: 7/26/2024 1:41:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spinserttodepartment]
@depname	nvarchar(50),	
@nbeds	int,	
@manager_pe_id	int,
@number_personnels	int,
@cost_per_bed	decimal(18, 2),	
@dep_discription	text	
as
   insert into department(depname , nbeds , manager_pe_id,
   number_personnels , cost_per_bed , dep_discription)
   values (@depname , @nbeds , @manager_pe_id,
   @number_personnels , @cost_per_bed , @dep_discription);	
GO
/****** Object:  Trigger [dbo].[TR_PreventDeleteUpdate]    Script Date: 7/26/2024 1:41:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--use [hospital reception1];
create trigger
[dbo].[TR_PreventDeleteUpdate]
on [dbo].[acceptance]
instead of delete,update
as
begin
raiserror('Delete and Update operatiens are not allowed on the acceptance table.',16,1);
rollback transaction;
end;
GO
ALTER TABLE [dbo].[acceptance] DISABLE TRIGGER [TR_PreventDeleteUpdate]
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
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "patient"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 209
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'count of all patient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'count of all patient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "acceptance"
            Begin Extent = 
               Top = 4
               Left = 321
               Bottom = 134
               Right = 506
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "department"
            Begin Extent = 
               Top = 2
               Left = 616
               Bottom = 132
               Right = 809
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "patient"
            Begin Extent = 
               Top = 12
               Left = 32
               Bottom = 142
               Right = 203
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'patient of each department'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'patient of each department'
GO
