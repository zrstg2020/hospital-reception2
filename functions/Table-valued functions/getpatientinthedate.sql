USE [hospital reception1]
GO

/****** Object:  UserDefinedFunction [dbo].[getpatientinthedate]    Script Date: 7/26/2024 2:44:02 AM ******/
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

