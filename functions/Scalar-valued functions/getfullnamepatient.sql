USE [hospital reception1]
GO

/****** Object:  UserDefinedFunction [dbo].[getfullnamepatient]    Script Date: 7/26/2024 2:44:47 AM ******/
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

