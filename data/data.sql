USE [hospital reception1]
GO
SET IDENTITY_INSERT [dbo].[patient] ON 

INSERT [dbo].[patient] ([pa_id], [panationalcode], [fname], [lname], [insurance_code], [landline_phone], [cellular_phone], [pa_address], [medical_allergy], [pa_description]) VALUES (1, N'2511253658', N'mina', N'ahmadi', N'12345678', N'07125475896', N'09362583654', N'new york', N'no', N'no')
INSERT [dbo].[patient] ([pa_id], [panationalcode], [fname], [lname], [insurance_code], [landline_phone], [cellular_phone], [pa_address], [medical_allergy], [pa_description]) VALUES (2, N'2501251478', N'maryam', N'amiri', N'45678956', N'07125632589', N'09352658978', N'phoenix', N'no', N'no')
INSERT [dbo].[patient] ([pa_id], [panationalcode], [fname], [lname], [insurance_code], [landline_phone], [cellular_phone], [pa_address], [medical_allergy], [pa_description]) VALUES (3, N'2581452639', N'amin', N'rezayi', N'12345678', N'08125369874', N'09876541245', N'new york', N'Ibuprofen', N'no')
SET IDENTITY_INSERT [dbo].[patient] OFF
GO
SET IDENTITY_INSERT [dbo].[examinations] ON 

INSERT [dbo].[examinations] ([ex_id], [pa_id], [pe_id], [prescriptions], [date], [time], [shift_code], [ex_discription]) VALUES (2, 1, 1, N'acetaminophen', CAST(N'2024-07-17' AS Date), CAST(N'12:22:12' AS Time), 1, NULL)
INSERT [dbo].[examinations] ([ex_id], [pa_id], [pe_id], [prescriptions], [date], [time], [shift_code], [ex_discription]) VALUES (3, 2, 1, N'rest', CAST(N'2024-07-17' AS Date), CAST(N'12:15:14' AS Time), 1, NULL)
INSERT [dbo].[examinations] ([ex_id], [pa_id], [pe_id], [prescriptions], [date], [time], [shift_code], [ex_discription]) VALUES (4, 3, 2, N'rest', CAST(N'2024-07-17' AS Date), CAST(N'12:30:45' AS Time), 1, NULL)
SET IDENTITY_INSERT [dbo].[examinations] OFF
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
SET IDENTITY_INSERT [dbo].[personnels] ON 

INSERT [dbo].[personnels] ([pe_id], [penationalcode], [lname], [fname], [dep_id], [job_specialty], [pe_education], [pe_landline_phone], [pe_cellular_phone], [date_employeement], [pe_adress], [prev_job], [pe_description]) VALUES (1, N'2511584789', N'sina', N'sobhani', 102, N'doctor', N'md', N'02187546985', N'06358745623', CAST(N'2010-10-04' AS Date), N'new york', N'doctor', NULL)
INSERT [dbo].[personnels] ([pe_id], [penationalcode], [lname], [fname], [dep_id], [job_specialty], [pe_education], [pe_landline_phone], [pe_cellular_phone], [date_employeement], [pe_adress], [prev_job], [pe_description]) VALUES (2, N'2502547896', N'mahsa', N'sarmad', 103, N'doctor', N'md', N'02154789654', N'09658956987', CAST(N'2009-02-02' AS Date), N'new york', N'doctor', NULL)
INSERT [dbo].[personnels] ([pe_id], [penationalcode], [lname], [fname], [dep_id], [job_specialty], [pe_education], [pe_landline_phone], [pe_cellular_phone], [date_employeement], [pe_adress], [prev_job], [pe_description]) VALUES (3, N'2541253695', N'james', N'johnson', 106, N'doctor', N'md', N'06154698725', N'09632587456', CAST(N'2012-02-06' AS Date), N'new york', N'doctor', NULL)
INSERT [dbo].[personnels] ([pe_id], [penationalcode], [lname], [fname], [dep_id], [job_specialty], [pe_education], [pe_landline_phone], [pe_cellular_phone], [date_employeement], [pe_adress], [prev_job], [pe_description]) VALUES (4, N'2511362547', N'mary', N'brown', 103, N'nurse', N'bsn', N'02145695847', N'09657854521', CAST(N'2010-01-06' AS Date), N'new york', NULL, NULL)
SET IDENTITY_INSERT [dbo].[personnels] OFF
GO
