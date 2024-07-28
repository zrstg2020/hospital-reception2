USE [hospital reception1]
GO

/****** Object:  UserDefinedFunction [dbo].[getdoctorofthepatient]    Script Date: 7/26/2024 2:43:27 AM ******/
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

