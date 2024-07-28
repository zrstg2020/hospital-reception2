USE [hospital reception1]
GO

/****** Object:  StoredProcedure [dbo].[spinserttodepartment]    Script Date: 7/26/2024 2:29:01 AM ******/
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

