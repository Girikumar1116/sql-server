--views
/* reduce redundancy and  dependancy in sql base
normalisation is a process for organising the data in db by spli large tables into smaller tables

view like a virtual table that contains data from one or more table.It
doesnt hold any data and doent exist physical  in the db
2.we can also control user security for accessing the dat
*/
use employee
--create sql view
create view employeerecords
as
	select *
	from [employees];
--use  sp_helptext to retrieve view definition
sp_helptext employeerecords;
--retrieve fromviews
select * from employeerecords;
--alter table
alter table employees add city nvarchar(50)  
--after alter and add column in the view has not exist column
--sp_refreshview
exec sp_refreshview employeerecords
 ---------------------------

 ------schemabinding a sql view---------------
 /*1.we dont want any changes to be made in the tables being used in view
 then we use schemabinding option to lock all tabes used in view*/
 */
 create view demoview
 with schemabinding
 as    --gives error select has * not use
	select * from [employee].[dbo].[employees];


create view deomview
with schemabinding
as
	select first_name,gmail 
	from [employee].[dbo].[employees]; -- this line gives error not use like this

create view demo
with schemabinding
as
	select first_name,gmail
	from [dbo].[employees]  --given like this successfully created

--not change after schemabinding view
Alter table dbo.employees alter column last_name varchar(max);

--encryption
create view demovies
with encryption
as
	select * from employees

exec sp_helptext demovies

-- sql view and check option
create view views
as
	select * from employees
	where first_name like 'm%'
with check option;

--error
Insert into views(emp_no,first_name,gender,hire_date,contact) values(1100,'Madhu','F',getdate(),8499573880);