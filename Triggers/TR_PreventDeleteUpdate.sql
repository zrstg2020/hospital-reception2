USE [hospital reception1]
GO

/****** Object:  Trigger [dbo].[TR_PreventDeleteUpdate]    Script Date: 7/26/2024 2:50:08 AM ******/
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

