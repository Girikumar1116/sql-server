use Employee;
----creating table employees
create table employees(
indexs int Identity primary key,
emp_no int,
first_name varchar(50) Not Null,
last_name varchar(50) Not Null,
birth_date Date,
gender varchar(10) Not Null check(gender In('M','F')),
hire_date Date Not Null,
contact bigint Not null)

Alter table employees
alter column emp_no int not null
--alter table employees
--drop constraint indexs;
alter table employees
Add primary key (emp_no)

--drop table employees
--Alter table employees
--drop column birth_date;

--Alter table employees 
--alter column emp_No int  NOt Null;

select * from employees;
Insert into employees(emp_no,first_name,last_name,birth_date,gender,hire_date,contact) values


(1001,'giri','kumar','2000/02/28','M','2022/09/11',7897989988),
(1002,'ram','sharma','1998/12/28','M','2001/01/05',8987564323),
(1003,'bhavik','koka','2002/01/21','M','2022/12/17',9374639832),
(1004,'tagore','kasturi','2001/07/26','M','2021/04/25',9457321970),
(1005,'karthik','sivala','1999/11/20','M','2023/01/31',9465739422),
(1006,'Mahesh','babu','1973/09/16','M','2016/06/09',9485347320),
(1007,'kalyan','ram','1997/06/30','M','2020/05/14',9532917052),
(1008,'hanumanth','rao','1999/02/27','M','2019/07/20',9543821964),
(1009,'revanth','kumar','2001/08/23','M','2022/08/10',6532910352),
(1010,'jeevan','puli','2000/05/22','M','2022/04/14',7238901381),
(1011,'subhani','shaik','1998/01/09','M','2020/01/23',9834628192),
(1012,'hemanth','kumar','1998/03/27','M','2023/05/31',8689273456),
(1013,'venky','dagubatti','1974/08/28','M','2002/05/24',9845678291),
(1014,'rana','dagubatti','1989/03/21','M','2004/02/21',8534521678),
(1015,'pavankalyan','powerstar','1983/08/02','M','2002/07/17',7654321098);

----check identity column value
Dbcc checkident('employees')  --table name enter
 --reset the identity column value
delete from employees where indexs=34
dbcc checkident ('employees',Reseed,1)
Insert into dbo.employees(emp_no,first_name,last_name,birth_date,gender,hire_date,contact) values
(1007,'kalyan','ram','1997/06/30','M','2020/05/14',9532917052);


select * from employees
--Ascii function
select Ascii(first_name) as numcodeoffirstchar from employees;
--CharLength function
select char(first_name) as length from employees;


select * from employees
Alter table employees
--drop column gmail;
Add gmail varchar(50);
--updating
update  employees
set gmail='giri@gmail.com' 
where emp_no=1001;

--update multiple rows
update employees
set gmail=case
when emp_no=1002 then 'ram@gmail.com'
when emp_no=1003 then 'bhavik@gmail.com'
when emp_no=1004 then 'tagorekasturi@gmail.com'
when emp_no=1005 then 'karthik_123@gmail.com'
when emp_no=1006 then 'Mahesh@gmail.com'
when emp_no=1007 then 'kalyanram.123@gmail.com'
when emp_no=1008 then 'hanuman@gmail.com'
when emp_no=1009 then 'revanth2001@gmail.com'
when emp_no=1010 then 'jeeva234@gmail.com'
when emp_no=1011 then 'subhanisahu@gmail.com'
when emp_no=1012 then 'hemanth@gmail.com'
when emp_no=1013 then 'venkymama@gmail.com'
when emp_no=1014 then 'rananaidu@gmail.com'
when emp_no=1015 then 'powerstar@gmail.com'
end where emp_no in(1002,1003,1004,1005,1006,1007,1008,1009,1010,1011,1012,1013,1014,1015);


Alter table employees
Add foreign Key(emp_no) references department_employee(emp_no);




 
create table Department(
dept_no varchar(10) primary key,
dept_name varchar(50))
--drop table Department
Insert into Department(dept_no,dept_name) Values
('AF01','Accounts and Finance');

Insert into Department(dept_no,dept_name) Values
('HR02','Human resource'),
('R&d03','Research and development'),
('IT04','It services'),
('pd05','product development'),
('Admin06','admin department');

Alter table Department
Add foreign key(dept_no) references employee(dept_no)

create table department_employee(
emp_no int primary key,
dept_no varchar(10) Not null)

--drop table department_employee
Insert into department_employee(emp_no,dept_no) Values
(1001,'IT04'),
(1002,'AF01'),
(1003,'Admin06'),
(1004,'pd05'),
(1005,'R&d03'),
(1006,'HR02'),(1007,'Admin06'),(1008,'pd05'),(1009,'IT04'),(1010,'pd05'),
(1011,'R&d03'),(1012,'AF01'),(1013,'R&d03'),(1014,'AF01'),(1015,'IT04');

select * from department_employee
create table department_manager(
dept_no varchar(20) primary key,
emp_no int)

 select * from department_manager;
Insert into department_manager(dept_no,emp_no) values
('IT04',1001),('R&d03',1015),('HR02',1005),('pd05',1009),('AF01',1003),('Admin06',1004);


create table salaries(
emp_no int,
salary money,bonus money)

select  * from salaries
Insert into salaries(emp_no,salary) values
(1001,70000),(1002,50000),(1003,48000),(1004,60000),(1005,45000),(1006,35000),(1007,40000),(1008,52000),
(1009,40000),(1010,60000),(1011,65000),(1012,45000),(1013,70000),(1014,50000),(1015,100000);

Alter table salaries
--alter column emp_no  int not null;
Add   primary key (emp_no)

Alter table salaries
Add foreign key(emp_no) references department_employees(emp_no)

--inner join
select  first_name,e.emp_no,dept_no
from employees e 
inner join department_employee d
on e.emp_no=d.emp_no;

select first_name,e.emp_no,d.dept_no
from department_employee d
inner join employees e
on e.emp_no=d.emp_no

select e.emp_no,first_name,gmail,contact,salary
from salaries s
join employees e
on s.emp_no=e.emp_no;

--self join
select e1.first_name ,e2.last_name,e2.gmail
from employees e1,employees e2
where e1.gender=e2.gender and e1.indexs <>e2.indexs


--cross join
select e.emp_no,e.first_name,e.gmail,d.dept_no
from employees e
cross join department_manager d
where e.emp_no=d.emp_no;

select e.emp_no,e.first_name,e.gmail,d.dept_no
from department_manager d
cross join employees e
where d.emp_no=e.emp_no;

--left join   check first given table
select d.dept_no,s.salary
from department_manager d
left join salaries s
on d.emp_no=s.emp_no


select d.dept_no,s.salary
from salaries s   
left join department_manager d
on d.emp_no=s.emp_no

--right join  after join given table values first consideres
select d.dept_no,e.emp_no,d.dept_name
from department_employee e
right join  Department d
on d.dept_no=e.dept_no

--full join or full outer join
select d.dept_no,m.emp_no
from department_manager m
full join Department d
on d.dept_no=m.dept_no;

select d+++.dept_no,m.emp_no
from department d
full join department_manager m
on d.dept_no=m.dept_no;