--stored procedure  batch of statements grouped as logical unit and stored in database
/* benefits
1.easily modify- without need restart or deploy application  (Alter procedure)
2.reduce n/w traffic-only procedure name pass over the network instead of whole sql code
3.reusable
4.security
5.performance-executes a first tym creates plan and store it in buffer pool so that the plan can be reuse when it execute next tym
*/

--@@rowcount is counting system rows counts
use Employee
create procedure GetEmpSal_Desc
As
begin
select e.first_name,s.salary 
from employees e
inner join salaries s
on e.emp_no=s.emp_no
end;

--set nocount on is to hide the number of rows affected message
create procedure min_exp
as
begin 
set nocount on
select datediff(year,hire_date,getDate()) from employees
end
exec GetEmpSal_Desc
exec min_exp

--using with parameters
create procedure sal_validParams(@num int)
as
begin
set nocount on
select s.salary,e.first_name from employees e 
inner join salaries s
on e.emp_no=s.emp_no
where e.emp_no=@num
end

exec sal_validParams 1013

--using defaultparameter
create procedure salr_def_params(@id int=1001)
as
begin
set nocount on
select e.first_name,s.salary 
from employees e
inner join  salaries s
on e.emp_no=s.emp_no
where e.emp_no=@id
end

exec salr_def_params

--store procedure with output parameter
create table employee (empid int identity(1,1),empname varchar(50))


create procedure ins_new_emp_op_params
(@ename varchar(50),@eid int output    --@name as varchar(50)
As
begin
set nocount on
Insert into employee(empname) values (@ename)
select @eid=SCOPE_IDENTITY()
end

declare @empid int
exec ins_new_emp_op_params 'Giri',@empid output
select @empid as employeeid

select * from employee

--encryption store procedure
create procedure Getemployee
with encryption
as
begin 
set nocount on
select * from employee
end

exec getemployee
sp_helptext getemployee --return encrypted or not

----creating a temporary database
--atomatically gone connections is close
create procedure #temp
as
begin
print 'local temporary database'
end

exec #temp

--global temp procedure
create procedure ##globe
as
begin
print 'global temp database'
end
use employee
---------------modifying store procedure-------------
Alter procedure getempsal_desc
as
begin
set nocount on
select e.first_name,e.last_name,s.salary
from employees e
inner join  salaries s
on e.emp_no=s.emp_no
end

-------renaming store procedure-----------
sp_rename 'getempsal_desc' ,'getempsal'

---cursor------
use employee
declare
@ename as varchar(50),
@gmail varchar(max);
Declare curson_emp Cursor
For select first_name,gmail from employees;

open cursor_emp;
Fetch Next from cursor_emp into @ename,@gmail;
while @@Fetch_status=0
begin 
print @ename+@gmail;
fetch next from cursor_emp into @ename,@gmail;
end;
close cursor_emp;
deallocate cursor_emp;








---catch block functions-----
/*
Error_Line()
Error_Message()
Error_Procedure()
Error_Number()
Error_Severity()
Error_state()*/
create procedure Divide(@a as decimal,@b decimal,@c decimal output)
as 
begin
	Begin try
		set @c=@a/@b;
	end try
	Begin catch
		select
			Error_Number(),ERROR_SEVERITY(),ERROR_LINE(),
			ERROR_PROCEDURE(),ERROR_MESSAGE();
	end catch
end;

declare @r decimal
exec divide 10,2 ,@r output;
print @r;


-----Raiseerror allows u to generate own exception---------
-- to add a  new user defined error message by sp_addmessage
exec sp_addmessage
	 @msgnum=50001,  --error mwessage is > 50000
	 @severity=1,
	 @msgtext='a custom error';

select * from sys.messages where message_id=50001;

exec sp_dropmessage @msgnum=50001;

Raiseerror ('whoops, an error',1,1)  --not working here
--severity level 0-25
--0-10 informational msg,11-18 errors,19-25 fatal errors
--state 0-255

Declare 
	@errormessage nvarchar(4000),
	@errorseverity int,
	@errorstate int;
Begin try
	Raiseerror('error occured in try block.' 17,1);
end try
Begin catch
	select 
		@errormessage=ERROR_LINE(),
		@errorseverity=ERROR_SEVERITY(),
		@errorstate=ERROR_STATE();
	RaiseError(@errormessage,@errorseverity,@errorstate);
end catch


DECLARE @MessageText NVARCHAR(100);
SET @MessageText = N'Cannot delete the sales order %s';

RAISERROR(
    @MessageText, -- Message text
    16, -- severity
    1, -- state
    N'2001' -- first argument to the message text
);