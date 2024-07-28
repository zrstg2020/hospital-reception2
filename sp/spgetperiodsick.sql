USE [hospital reception1]
GO

/****** Object:  StoredProcedure [dbo].[spgetperiodsick]    Script Date: 7/26/2024 2:26:24 AM ******/
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

