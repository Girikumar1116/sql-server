-- creating table valued function using a user created function--
/*
create function Fun_employeeinformation()
returns table
as
return (Select * from employees);

--select * from Fun_employeeinformation();

--scalar valued function  is to create 2 column join function  
--nchar and nvarchar can store unicode characters(u-00012) varchar char notstore 
*/
/*
Create function FUn_JoinEMpColumnInfo
(
@first_name nvarchar(25),
@last_name nvarchar(25),
@COntact nchar(15)
)
returns nvarchar(100)
as
begin return(select @first_name+' '+@last_name+' '+@contact)
end*/
/*
select  dbo.FUn_JoinEMpColumnInfo
(first_name,last_name,contact) as Detail from employees;
*/
--basic pay function
create function basicpay(
@totalamount int,
@taxpay int)
returns int
as
begin
	return @totalamount+@taxpay
	
end;
select dbo.basicpay(10,20) as sum;




select min(indexs) from employees;
select max(indexs) from employees;

select * from salaries; 
--Average
select Avg(salary) from salaries;

select Avg(salary) as salaryavg from salaries;
--count 
select count(emp_no) from salaries;
select count(*) from salaries;
select count(Distinct salary) from salaries;

--first() and last() functions are not there in server

----------Scalar Functions----------
select * from employees;
--Lcase,Ucase,Mid function is not there in scalar functions
select len(first_name) from employees;
--select Round(column_name,decimals) from table
select ROund(salary,1) from salaries;

--Now()  fetchcurrent system time  not there in server
select first_name,Format(GetDate(),'yyyy/mm/dd') from employees

select char(65);
select Ascii('giri');
select charIndex('i','giri');
select charIndex('i','giri',2);
--concatenation
select concat('giri',' ','kumar');
select 'giri'+'kumar';
select 'giri'+' '+'kumar';
select concat_ws(' ','hy','hello','namastey');
--lengths
select DataLength('girikumar');
select len('girikumar');
--differece b/w 2 chars
select DIFFERENCE('alias','as');
--format
select format(123456789,'##-##-#####'); -- 12-34-56789
Declare @d Datetime='12/08/2018'; -- @ means user defined variable
select format(@d,'d','en-us') As 'us- english',
Format(@d,'d','no') As 'norwegin result',
Format(@d,'d','zu')As 'Zulu result';

--left
select left('Sql server',1);
--right
select right('sql server',1);
--Lower
select lower('server studio');
--upper
select upper('server studio');
--trim
select trim('  server   ');
--LTrim
select ltrim('   servers');
--Rtrim
select rtrim('servers  ');
--Nchar numbercode unicode character
select nchar(65) ;

--pattern index
select patindex('%kumar','girikumar');

--quotename
select quotename('abcd','()');
select quotename('abcd','[');
select quotename('abcd','[]');

--replace
select replace('girikumar','i','!');
--replicate  repeating no of times mention
select replicate('girikumar',2);
--reverse
select reverse('girirkumar');

--soundex converts string to four character code based on sound when spoken
select soundex('juice'),soundex('jucy');
--space
select space(10);
--str converts into string
select str(185);  --number,length,decimal
select str(185.4788,6,2);
--stuff (string,start,length(end index),new string) same like replace
select stuff('sql server',1,3,'studio');

--substring 
select substring('sql server',1,3);

--translate(string,characters,translation)
select translate('monday','monday','sunday');  --same characters contains
select translate('3*[2+1]/{8-4}','[]{}','()[]');

--unicode
select unicode('giri');

------------Mathematical functions-------------------------
--sqrt
select sqrt(100);
--pi
select pi()
--square()
select square(16);
--round  nearest decimal
select round(125.2626,2);
--ceiling next highest value
select ceiling(123.9283)
--floor next lowest value
select floor(123.9283);

----date functions----------------
select CURRENT_TIMESTAMP;
--dateadd
select dateadd(month,2,'2017/08/25') as date
select dateadd(year,2,'2017/08/25') 
select dateadd(hour,2,current_timestamp)

--datediff
select datediff(year,'2017/08/29','2023/09/20')

--date from parts
select datefromparts(2001,06,11);
--datename
select datename(year,'2001/07/10');  --2001
--datepart
select datepart(yy,'2018/03/29') --2008
--day
select day('2017/04/29')
--getdate
select getdate();
--getutcdate  current databse system time
select getutcdate();
--isdate
select isdate('2017-09-26')
select isdate('2001')
select isdate('helloworld');

------advanced functions-------
select cast(25.65 as int)
select cast(25.65 as varchar)
--coalesce first value is given as output if null 2nd value get
select coalesce(null,1,2,'giri')  --1 o/p 
select coalesce('hy','hello','namastey') --hy o/p

--current user
select CURRENT_USER

--iif  if condition
select iif(50<100 ,'yes','no')
