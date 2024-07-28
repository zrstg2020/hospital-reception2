USE [hospital reception1]
GO

/****** Object:  StoredProcedure [dbo].[spgetperiodsickall]    Script Date: 7/26/2024 2:27:22 AM ******/
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

