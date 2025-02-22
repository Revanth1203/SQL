create database Wipro4;
use Wipro4;

create table Student (studid int primary key ,
studname varchar(30),location varchar(40));

select * from Student;

--normal insert 

insert into Student values(101,'ravi','bangalore');

-- inserting as per my order 
insert into Student(location,studname,studid) values('chennai','senthil',102);

--partial insert 

insert into student(studname,studid) values('shanthi',103);--forgetting error 

--where value is forgetten there db will put null value what is null here unknown value it is not zero 

-- you cannot forget primary key column 

---multiple insert 
insert into Student values(104,'sunitha','delhi'),(105,'rajesh','patna'),(106,'junaid','hyderabad')

--updating single column in a single row (cant update prmary key )

update Student set studname='kiran' where studid=103;

--updating multiple columns in a single row (cant update prmary key )
update Student set studname='suresh',location='Pune' where studid=101;

-- updating multiples rows of a single column supoose  i want send some employees to in bangalore only location 

update Student set location='Bangalore' where studid in (101,104,105);

-- I cannot do update for rows and columns at a time okay 

--deleting commands 
-- here i can delete rows only ether single or multile or all 

-- single row delete 

delete from Student where studid=102;


-- deleting multiple rows 

delete from Student where studid in (105,104)


-- deleting all rows dont provide condition 

delete from Student ;

-- if u want to destry the table 
drop table Student ;

--select * from Student where location=null;-- error because is null is unknown value 

select * from Student where location is null;--correct way of writing 


--consraints 
--constraint <contraint_name> typeofconstraint(col list)
--1)not null or null constraint 
-- not null ot null this cann be applied only as column level dont leave the column blank if it is not null
-- duplicate are allowed for not null column but dont leave the column as blank something has to be written there 
create table demo1(id int not null,fname varchar(30),mname varchar(40),
lname varchar(30));

insert into demo1 values(null,null,null,null);--error because null is not allowed 
insert into demo1 values(101,null,null,null)-- okay this is as null is not there 
insert into demo1 values(101,null,null,null)-- okay as 101 duplicate is allowed 

insert into demo1 values(101,null,null,'janaki')--okay 

--2)unique constraint 
--unique constraint means you cannot enter duplicate values but u can enter null values but how many times null let us check 
create table demo2(id int unique,fname varchar(30) not null ,mname varchar(40) null,
lname varchar(30) not null);

insert into demo2 values(null,'kiran',null,'kumar');-- one time null is allowed again not try this command 2nd time it will not work 
insert into demo2 values(101,'suresh','kumar','singh')--okay will run but again 101 if u give it will not run as it is unique
insert into demo2 values(102,'suresh','kumar','singh')--okay as 102  is given 

--with table level defining unique constraint 
create table demo3(id int ,fname varchar(30) not null ,mname varchar(40) null,
lname varchar(30) not null,constraint uk11 unique(id) );

-- it can have multiple columns also and many times also i can apply unique constraint 

create table demo4(id int ,fname varchar(30) not null ,mname varchar(40) null,constraint uk88 unique(fname),
lname varchar(30) not null,constraint uk141 unique(id,lname) );
--3)Primary key constraint
-- a combination of not null and unique constrraint is nothing but primary key 


create table demo5(id int primary key ,fname varchar(30) not null ,mname varchar(40) null,
lname varchar(30) not null);-- primary key as column level 

create table demo6(id int ,fname varchar(30) not null ,mname varchar(40) null,
lname varchar(30) not null,constraint pk23 primary key(id));-- used as table level 


create table demo7(id int ,fname varchar(30) not null ,mname varchar(40) null,
lname varchar(30) not null,constraint pk24 primary key(id,lname))-- composite primary key table level

create table demo8(id int ,fname varchar(30) not null ,mname varchar(40) null,
lname varchar(30) not null,constraint pk25 primary key(id,lname,fname))--compsotie primary key with 3 columns 

create table demo9(id int primary key  ,fname varchar(30) not null ,mname varchar(40) null,
lname varchar(30) not null,constraint pk28 primary key(lname)) --error one time only keyword primary key is used 

create table demo10(id int primary key  ,fname varchar(30) not null ,mname varchar(40) null,
lname varchar(30) not null primary key )--error as multiple times i am using primary key one time only use but put many cols in that  

--4)Default constraint : here if u forget any column system will put null to that column but i want my default value there so 
-- default constraint is used 

create table employee(empid int primary key ,empname varchar(30) default 'Mr.X',salary int);

insert into employee(empid,salary) values(101,23000);

select * from employee;

--5)check constraint :to check some table values based on condtion then check constraint this also can be applied as col and table level

create table bankdemo(bankid int primary key ,bankname varchar(50),balance int check(balance>1000));-- as column level 
create table bankdemo1(bankid int primary key ,bankname varchar(50),balance int,constraint ck34 check(balance>1000));-- as table  level 


insert into bankdemo values (101,'BOI',300); -- will get erroro as 300 is less than 1000
insert into bankdemo1 values (101,'BOI',1000) -- here also eror as more than 1000 only u need to enter 

insert into bankdemo1 values(101,'BOB',2000);-- okay will run 


--6)Foreign key constraint : also called as referencial integrity constraint .
-- two tables are said to be related to each other if they have a common column between them and that common column should act 
-- as primary key in master table so what is master table the table which we create first is a master table and the table which we 
-- create after wards is child table always in child table only i will see this foreign key ..
-- when i am saying common column it means that that common column should have common value mean column name can be different 
-- and remember that both master and child tables will have their primary keys defined 
-- child table will take in foreign key those values only which are there in master table primary key in foreing key i can enter null 

-- let us create a table now 

create table dept(deptid int primary key ,deptname varchar(40));--master table 

insert into dept values (10,'HR');
insert into dept values (20,'Software');
insert into dept values (30,'Sales');

select * from dept ;

-- child table emp 

create table emp(empid int primary key ,empname varchar(40) ,
deptid int foreign key references dept(deptid));-- column level 

insert into emp values (1001,'ravi',20);
insert into emp values (1002,'kiran',20);
insert into emp values (1003,'sita',null);-- null can be put in foreign key 
insert into emp values(1004,'kkk',null)-- second and many times also null is allwoed it is one time only for that employee 



-- like this also u can create child table for dept table 
--and here i am using column name different and table level foreign key i am using it here 


create table empinfo(empid int primary key ,empname varchar(40) ,
worksin  int,constraint fk120  foreign key(worksin) references dept(deptid));-- 

insert into empinfo values (1001,'ravi',20);
insert into empinfo values (1002,'kiran',30);
insert into empinfo values (1003,'sita',null);-- null can be put in foreign key 
insert into empinfo values(1004,'suresh',50) --error because 50 dept is not there 

-- now the requirment is create three tables doctor ,pateint and tratement here doctor is master table of 
-- pateint for in tratemment both doctor and pateint is involved so two fk is needed one is doctor another is patient

-- Table: Doctor
CREATE TABLE Doctor (
    Doctor_ID INT PRIMARY KEY,
    Name VARCHAR(100)
  
);

insert into Doctor values(10,'ravi');
insert into Doctor values(20,'sai')

-- Table: Patient
CREATE TABLE Patient (
    Patient_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Doctor_ID INT,  -- Foreign Key linking to Doctor
   constraint fk567 FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID) 
);

insert into Patient values(1001,'santosh',20)

-- Table: Treatment
CREATE TABLE Treatment (
    Treatment_ID INT PRIMARY KEY,
    Patient_ID INT,  -- Foreign Key linking to Patient
    Doctor_ID INT,   -- Foreign Key linking to Doctor
   
 constraint fk785   FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID) ,
  constraint fk562  FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID) 
);

insert into Treatment values(101,1001,10)


CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50)
);
-- here identity means u will not create primary key system will create the primary key from where it will start 
--it is written theere 1,1 means 1 is starting point and i will increment by 1 i will not provie values while entering or inserting 


-- Insert some sample data
INSERT INTO Employees (FirstName, LastName, Department)
VALUES 
('John', 'Doe', 'HR'),
('Jane', 'Smith', 'Engineering'),
('Mark', 'Brown', 'Sales');

select * from Employees

delete from Employees where Department='Engineering';

insert into Employees values('Mark1', 'Brown1', 'Sales1');

truncate table Employees ;

--truncate table Employees where Department='Engineering';
-- first difference which i am seeing it above is i will not use where clasue in truncate command 

--now let us take another table 
drop table EmpInfo
create table EmpInfo(empid int identity(1,1) primary key ,empname varchar(40),
salary int )

insert into EmpInfo values('ravi',34000);
insert into EmpInfo values('suresh',45000)
insert into EmpInfo values('sita',39000)

select * from EmpInfo

delete EmpInfo

insert into EmpInfo values('jyothi',59000)

insert into EmpInfo values('satish',34000);
insert into EmpInfo values('monika',45000)
insert into EmpInfo values('madhu',39000)


truncate table EmpInfo 

insert into EmpInfo values('satish1',34000);
insert into EmpInfo values('monika1',45000)
insert into EmpInfo values('madhu1',39000)


---alter commands 
--it is used to modify the structure of exsisting table using which u can perform any of the following tasks 

--1)change the datatype of the column 
--2)Increase or Decrese the width of the columnm
--3)change  null to not null and not null to null 
--4)add a new column 
--5)drop an exsisting column 
--6)add a new constraint
--7)drop an exisiting constraint .
create table students (sno int,sname varchar(50),class int)

insert into students values (101,'ravi',12)
insert into students values(102,'kumar',4)
insert into students values (103,'senthil',8)

select * from students;

--for 1,2,3 
-- alter table <Tname> alter column <colname><dtype>[width][notnull/null]

-- always change data type in compatible manner only mean  string to string or number to number 

-- change varchar to char or int to decimal like that 

alter table students alter column sname char(60) not null;

sp_help students-- to check type has been chnaged or not 

--adding a new column 

--alter table <Tname> add <colname> <dtype><width>[not null]
--[constraint <cname>] 

alter table students add city varchar(40) not null -- this command is giving error 

-- above command will not work with not null both creation of new column and  filling 
-- the values at a time is not possible 

-- so i will write like ths 

alter table students add city varchar(40)

select * from Students;

--now run select u can see a column added wit null values 

--101	ravi                                                        	12	NULL
--102	kumar                                                       	4	NULL
--103	senthil                                                     	8	NULL

--so a I am getting values like this but u know i want to put not null also along with adding column 
--so updae nulll values then u add frist command which is adding null with change of type which i will not do 

update students set city ='Hyderabad' where sno in (101,102,103)

-- go to first command see above formula 

--alter table <Tname> alter column <colname><dtype>[width][notnull/null]

alter table students alter column city varchar(40) not null -- now it will work 

-- drop an exisiting column 
--alter table <Tname> drop column <colname>

alter table students drop column city 

select * from students

-- adding a new constraint 

--alter table <Tname> add [constraint<const_name>]
--typeofconstraint(<collist>)
-- adding  a constraint on class column 
alter table students add constraint ck12 check(class <=12);

insert into students values(104,'sohan',14);--error

--dropping a constraint
--alter table <table_name> drop constraint <constraint_name>
alter table students drop constraint ck12


insert into students values(104,'sohan',14) -- now no error as constraint is removed


-- can i add primary key for the above which is one type of constraint same formuala

--alter table <Tname> add [constraint<const_name>]
--typeofconstraint(<collist>)

alter table students add constraint pk34 primary key(sno);-- error 

--why because column is nulllable first make the column not null using first formuaa

--alter table <Tname> alter column <colname><dtype>[width][notnull/null]
alter table students alter column sno int not null

-- after making not null now apply that formuals of adding constraint 

alter table students add constraint pk34 primary key(sno) -- now no error 

--now primary key is applied 

sp_help students

-- can  i remove primay key constraint 

alter table students drop constraint pk34;

--yes i can remove 

--Transaction Demo 

CREATE TABLE Employeedata (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50)
);
--code for rollback transaction 
-----------------------------------

BEGIN TRANSACTION;
DECLARE @EmpID INT;
-- Insert a new employee and get the generated EmployeeID
INSERT INTO Employeedata (FirstName, LastName, Department) 
VALUES ('ravi1', 'kumar1', 'software1');

SET @EmpID = SCOPE_IDENTITY(); -- Get the last inserted ID

-- Update the inserted employee
UPDATE Employeedata SET Department='Testing' WHERE EmployeeID = @EmpID;

-- Force rollback by checking for an ID that does not exist
IF NOT EXISTS (SELECT * FROM Employeedata WHERE EmployeeID = 9999) -- EmployeeID 9999 does not exist
BEGIN
    PRINT 'Error: Employee not found, rolling back the transaction';
    ROLLBACK TRANSACTION;
END
ELSE
BEGIN
    PRINT 'No errors, committing transaction';
    COMMIT TRANSACTION;
END
--checking ---

select * from Employeedata

-------code for commit transaction ----
BEGIN TRANSACTION;

DECLARE @EmpID1 INT;

-- Insert a new employee and get the generated EmployeeID
INSERT INTO Employeedata (FirstName, LastName, Department) 
VALUES ('ravi1', 'kumar1', 'software1');

SET @EmpID1 = SCOPE_IDENTITY(); -- Get the last inserted ID

-- Update the inserted employee
UPDATE Employeedata SET Department='Testing' WHERE EmployeeID = @EmpID1;

-- Check if the employee exists
IF NOT EXISTS (SELECT * FROM Employeedata WHERE EmployeeID = @EmpID1)
BEGIN
    PRINT 'Error: Employee not found, rolling back the transaction';
    ROLLBACK TRANSACTION;
END
ELSE
BEGIN
    PRINT 'No errors, committing transaction';
    COMMIT TRANSACTION;
END


--chekcing transaction 

select * from Employeedata

---code for savepoint ------

BEGIN TRANSACTION;
DECLARE @EmpID3 INT;

-- Insert a new employee and get the generated EmployeeID
INSERT INTO Employeedata (FirstName, LastName, Department) 
VALUES ('ravi3', 'kumar3', 'software3');
save transaction savepoint1;
SET @EmpID3 = SCOPE_IDENTITY(); -- Get the last inserted ID
-- Update the inserted employee
UPDATE Employeedata SET Department='Testing6' WHERE EmployeeID = @EmpID3;

-- Check if the employee exists
IF NOT EXISTS (SELECT * FROM Employeedata WHERE EmployeeID = 999)
BEGIN
   PRINT 'An error occurred, rolling back only part of the transaction';
    ROLLBACK TRANSACTION savepoint1; -- Rollback to before Employee 2 insert
    PRINT 'Rolled back the error, but Employee is only inserted but that is not updated ';
END
ELSE
BEGIN
    PRINT 'No errors, committing transaction';
    COMMIT TRANSACTION;
END

-- chekcing whether save point is applied or not 

select * from Employeedata ;

---scalar functions 

--CREATE FUNCTION <function_name>
--(@input_variables  type)
--RETURNS data_type of result returned by function
--AS
--BEGIN
--.....  SQL Statements
--    RETURN (data_value)
--END
--demo1 

create function multiply(@x int ,@y int)
returns int
as
begin
return @x*@y;
end 

select dbo.multiply(12,3);

select * from students

select dbo.multiply(sno,class) from students;

--example 2 on scalar function 
--____________________________
create table orders(orderid int primary key ,orderdate datetime,
whichcustomer varchar(10))

insert into orders values(101,'1996-08-01','c01')
insert into orders values(102,'1997-04-02','c01')
insert into orders values(103,'2012-08-01','c01')
insert into orders values(104,'2013-08-05','c02')
insert into orders values(105,'2014-08-01','c02')

select * from orders;
--write a function to find last or latest  order ordered by the given customer ..
-- having two customers i will give customer id which is whichcustomer you have to 
-- tell me his latest order usingn a function

create function findlatestorder(@custid varchar(10))
returns datetime
as begin
declare @recentorder datetime;

select @recentorder= max(orderdate) from orders where whichcustomer=@custid;
return @recentorder;
end 

select dbo.findlatestorder('c01')

--suppose u want to alter the fucntion like u didint like the variable name 
-- @recentorder1 u can do it so for available functions only  u can alter 
-- dont alter the function which is not there 

alter function findlatestorder(@custid varchar(10))
returns datetime
as begin
declare @recentorder1 datetime;

select @recentorder1= max(orderdate) from orders where whichcustomer=@custid;
return @recentorder1;
end 

--Example 3 on scalar function 
--__________________________________
create table Books(
title_id varchar(10),
pages int,
qty_sold int)

insert into Books values('bo101',200,89)
insert into Books values('b0102',300,79)
insert into Books values('b0103',700,85)

select * from Books
--Q) write a function on this table which will give me no of books sold
--based on id value u provide to the function ?

create function copies_sold(@title_id varchar(10))
returns int
as
begin 
declare @quantity int;
select @quantity=0;
select @quantity=qty_sold from Books where title_id=@title_id
return @quantity;
end 

select dbo.copies_sold('bo101')


--syntax:
----------



--create function <function_name> (parameters-list)
--returns @table Table (list_of_column_names)
--as
--begin 
--insert @table 
----------
-------
--end 


---- Example on inline table valued function 
--_______________________________________________
create table employee_info(
     ID          int,
     name        varchar (10),
     salary      int,
     start_date  datetime,
     city       varchar (10),
     region      char (1))

insert into employee_info
               values (1,  'Jason', 40420,  '02/01/94', 'New York', 'W')
 insert into employee_info 
               values (2,  'Robert',14420,  '01/02/95', 'Vancouver','N')
 insert into employee_info 
               values (3,  'Celia', 24020,  '12/03/96', 'Toronto',  'W')

select * from employee_info
select name ,'hello' from employee_info

-- write a inline table value function to find employees in the region 

--create function <function_name>(parameters_list)
--returns table as
--return (<any select command which will give me resultset>)

alter function listemp (@region char(1))
returns table as 
return select * from employee_info where region=@region;


select * from listemp('W')

-- write a multiline table value function to find employees in the region 

--create function <function_name> (parameters-list)
--returns @table Table (list_of_column_names)
--as
--begin 
--insert @table 
----------
-------
--end 

create function listempmultiline(@region char(1))
returns @table Table 
(
 ID  int not null,
 name  varchar (50),
 city       varchar (40),
 message varchar(100)
)
as 
begin
if exists(select ID,name,city from employee_info where region=@region)

begin
insert into @table(ID,name,city,message)
select ID,name,city,'present in that region' from employee_info where region=@region;
end

else

begin
insert into @table(ID,name,city,message) values(0,'Nodata','Nodata','No values are there in the table for that region');

end
return;
end

select * from listempmultiline('Z')

--1)Mathematical functions:
--_______________________

--a) abs(n) : it returns a absolute value of given number n
   eg: select abs(-12)=12
--b)square(n) : It return the square of n
eg: select square(25)=9
--c)sqrt(n) :it will give u square root of n
eg: select sqrt(4)=2
--d)power(n,m) :it will give u n to the power of m value
eg:select power(2,3) =8
--e)round(n,size):it will round a value n is the value 
--and size is how many values to round
eg:select round(156.6789,2)=156.68
     select round(156.6789,0)=157
      select round(156.6789,-1)=160
--f)ceiling(n) :it returns an least integer greater than n
  eg: select ceiling(15.6)=16
         select ceiling (-15.6)=-15
--g)floor(n) :it returns the highest integer less than given n
eg: select floor(15.6)=15
select floor(-15.6)=-16

--2)String functions :strings are nothing but set of chracters so these
--string functions can also be applied to columns having string values.
--_________________________________________________
a) Ascii(s): it returns ascii value of first character in the given string 
eg: select ascii('D')=65
select ascii('def')=100
b)char(n):This is reverse of ascii it takes ascii value 
and returns the character represented by it
eg: select char(65)=A
c)Len(s) : it returns length of given string
eg:select len('Tanzania')=8
select len(Title) from HumanResources.Employee
d)lower(s):it return given string converted into lower case
eg: select left(Title,3) from HumanResources.Employee
e)upper(s):it retuen the given string converted in upper case
eg: select upper('apple')=APPLE
f)  left(s,n) it returns the selected n no of  characters from left
   side of given string
  eg: select  left('Hello',3)=Hel
g)right(s,n) : same as above but from right 
h)substring (s,start,length) :it returns part of string from a given string
    s 
eg: select substring('Hello',1,3)=Hel

g) reverse(n): it returns the given string in reverse order.
eg:select reverse('Hello')=0lleH
h)Ltrim(s) : it eilimates empty character that are present in left side 
of given string s
select Rtrim('hello             ')
eg: select Ltrim('       hello')=hello
i)Rtrim (s) : is is ame as left but at right side we eliminate spaces 
from the given string
eg: select Rtrim('heloo     ')=heloo
j)replace (s,searchstr,replacestr): it replaces each occurence of 
searchstr with replacestr in the given string s
select replace('Hello world','o','x')=Hellx wxrld
k)stuff(s,start,length,replacestr):
it repalces specified no of characters with replace string in the 
given string s
eg: select stuff('abxxcdxx',3,2,'yy')=abyycdxx
select stuff('abxxcdxx',3,2,'yy')



3) Date functions ; 
-----------------------
a)getdate( ) : To get todays date we use getdate( ) function 
 eg: select getdate() as Todaysdate

b) datediff: calculates the no of  date parts between two dates.

   select datediff(mm,'01/01/1990',getdate( ) ) as Ageinmonths
   select datediff(yy,'7/8/1982' ,getdate( )) as Ageinyears
   select datediff(hh,'7/8/1982',getdate() ) as Ageinhours
  select datediff(dd,'7/8/1982',getdate( )) as Ageindays
  select datediff(mi,'7/8/1982',getdate( )) as Age
 
 c) dateadd: It returns the datepart listed from the listed 
date as integer.

    select dateadd(mm,30,getdate( ) )

  d) datename(datepart,d) :it is used for picking any specified 
     date part value from the given date d

   Note: seconds=ss,year =yy,quarter=q,month =mm,
             day =dd,day of the year =dy,weak of the year=wk,
             milliseconds=ms,weekday=dw,hours=hh,minutes=mi

  eg:   select datename(dw,getdate( ))=monday


  4) Conversion functions :
-------------------------
--when we want to convert one data type to another we go for 
--conversion functions they  are of two types
a)conversion functions :
_______________________________

convert(varchar,@x) --here @x is converted to varchar type 
cast(@x as varchar) -- here again @x is converted into varchar type @x can be of any type 

declare @age int ;
declare @name varchar(30)
set @name='ravi'
set @age=23;
print 'The person with the name '+Convert(varchar(30),@name)+' is having '+Convert(varchar(30),@age) +' years of age ';
print 'The person with the name '+@name+' is having '+Convert(varchar(30),@age) +' years of age '; 
print 'The person with the name '+cast(@name as varchar)+' is having '+cast(@age as varchar) +' years of age ';


--- what ever code i had wrttien is temperroy









select * from HumanResources.Employee
select JobTitle ,Gender,LoginID from HumanResources.Employee

select * from HumanResources.Department



select 'Department Number'=DepartmentID,'DepartmentName'=Name from HumanResources.Department

select DepartmentID as 'Department Number',Name as 'Department Name' from HumanResources.Department

select BusinessEntityID ,'Desgination: 'as k,JobTitle from HumanResources.Employee


select Name + '   department comes under  '+ GroupName +'  group   ' as Department from HumanResources.Department

  
select * from HumanResources.EmployeePayHistory

select BusinessEntityID,Rate,per_day_rate=8*Rate from HumanResources.EmployeePayHistory


select * from HumanResources.Department where groupname='research and development'


  
select * from HumanResources.Employee
--here relational operators are used...to check condition
select BusinessEntityID ,NationalIDNumber,JobTitle,VacationHours from 
HumanResources.Employee where VacationHours > 20



select * from humanresources.Department where Groupname='Manufacturing' or Groupname='Inventory management'

select * from Humanresources.Employee where JobTitle='production Technician - wc60' and Gender='M'

select * from HumanResources.Department where Groupname='Manufacturing' or NOT GroupName='quality Assurance'



select BusinessEntityID,VacationHours  from Humanresources.Employee
where vacationhours between 20 and 50

select BusinessEntityID,VacationHours from Humanresources.Employee where
vacationhours not between 20 and 80


select BusinessEntityID,JobTitle,LoginID from HumanResources.Employee where
JobTitle  in('Recruiter','Stocker') 

select BusinessEntityID,JobTitle,LoginID from Humanresources.Employee where
JobTitle not in('recruiter','stocked','janitor')

--retriving records that contain matched pattern
select * from HumanResources.Department where Name Like 'Production [c]%'
select * from HumanResources.Department
select * from HumanResources.Department where Name like 'Pro%'

select * from HumanResources.Department where Name like 'Sale_'

  
create table hi( names varchar(10), rollno int)


insert into hi values ('Karsen',200)
insert into hi values('Karson',500)
insert into hi values('raghu',62)
insert into hi values ('Carsen',100)
insert into hi values('kiran',46)
insert into hi values ('Carson',300)

select * from hi;
select * from hi where names like '[CK]ars[eo]n'
select * from hi where names like '[^K]ars[eo]n'

select * from hi where names like '[ck]ir[ad]n'
select * from hi where names like '[re][da]g[kh]u'
select * from hi where names like '[^c]ars[^e]n'



drop table hi



-- Retriving record that contain null values

select * from [HumanResources].[EmployeeDepartmentHistory]
select BusinessEntityID,EndDate from 
HumanResources.EmployeeDepartmentHistory where EndDate is null

select BusinessEntityID,Enddate from
HumanResources.EmployeeDepartmentHistory where Enddate is not null
select DepartmentID ,BusinessEntityID from HumanResources.EmployeeDepartmentHistory
order by DepartmentID


select * from HumanResources.Department
select DepartmentID ,Name from HumanResources.Department order by Name 


select * from HumanResources.EmployeeDepartmentHistory 
select top 3 BusinessEntityID,Enddate 
from HumanResources.EmployeeDepartmentHistory where Enddate is not null

select top 50 percent * from HumanResources .EmployeeDepartmentHistory


Aggregate functions 

select count(*) as k from HumanResources.EmployeePayHistory

select sum(Rate) from HumanResources.EmployeePayHistory

select max(Rate) from HumanResources.EmployeePayHistory

select min(Rate) from HumanResources.EmployeePayHistory

select avg(Rate) from HumanResources.EmployeePayHistory

  
create table id(id int)
insert into id values(1),(2),(1),(3),(1),(2),(3),(1)

select * from id
select *from id group by id;
select count(id) as count from id--returns total value
select *,count(id) from id group by id 

--------------------------------------------

create table dept1(
  deptno int ,
  dname  varchar(14),
  loc    varchar(13),
  constraint pkk1 primary key(deptno)
);
 
 create table emp1(
  empno    int primary key,
  ename    varchar(10),
  job      varchar(9),
  mgr      int,
  hiredate date,
  sal      int,
  comm     int,
  deptno   int  foreign key  references dept1 (deptno)
);

insert into dept1 values(10, 'ACCOUNTING', 'NEW YORK');
insert into dept1 values(20, 'RESEARCH', 'DALLAS');
insert into dept1
values(30, 'SALES', 'CHICAGO');
insert into dept1
values(40, 'OPERATIONS', 'BOSTON'); 

select * from dept1;
insert into emp1 values( 7839, 'KING', 'PRESIDENT', null,'1981-11-17' , 5000, null, 10);
insert into emp1 values( 7698, 'BLAKE', 'MANAGER', 7839,'1981-05-01',2850, null, 30);
insert into emp1 values( 7782, 'CLARK', 'MANAGER', 7839,'1981-06-09', 2450, null, 10);
insert into emp1 values( 7566, 'JONES', 'MANAGER', 7839,'1981-04-02', 2975, null, 20);
insert into emp1 values( 7788, 'SCOTT', 'ANALYST', 7566,'1987-04-19', 3000, null, 20);
insert into emp1 values( 7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000, null, 20);
insert into emp1 values( 7369, 'SMITH', 'CLERK', 7902,'1980-12-17', 800, null, 20);
insert into emp1 values( 7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600, 300, 30);
insert into emp1 values(  7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250, 500, 30);
insert into emp1 values( 7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250, 1400, 30);
insert into emp1 values(  7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', 1500, 0, 30);
insert into emp1 values( 7876, 'ADAMS', 'CLERK', 7788, '1987-05-23', 1100, null, 20);
insert into emp1 values( 7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950, null, 30);
insert into emp1 values( 7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300, null, 10);


select * from dept1;
select * from emp1;

select deptno,count(ename) from emp1 group by deptno;
select deptno,count(deptno) from emp1 group by deptno;
select job,count(ename) as no_of_employees from emp1 group by job
select job,max(sal) as max_salary from emp1 group by job
select job,min(sal) as min_salary from emp1 group by job
select job ,sum(sal) from emp1 group by job 
select job ,sum(sal) from emp1 group by job having sum(sal)>5000


 create table dept3(deptid int primary key ,deptname varchar(30));
insert into dept3 values(10,'sales'),(20,'Marketing'),
(30,'Software'),(40,'HR');
create table emp3(empid int primary key ,empname varchar(30),
worksin int foreign key 
references dept3(deptid));
insert into emp3 values(101,'ravi',10),
(102,'kiran',20),(103,'mahesh',30),(104,'suresh',20),
(105,'satish',null);

select * from dept3;
select * from emp3;

select e1.empname,d1.deptname from emp3 e1 inner join dept3 d1
on e1.worksin=d1.deptid;

select e1.empname,d1.deptname from emp3 e1 left join dept3 d1
on e1.worksin=d1.deptid;

select e1.empname,d1.deptname from emp3 e1 right join dept3 d1
on e1.worksin=d1.deptid;

select empid,deptname from emp3  inner join dept3 on worksin=deptid;--working
select empid,deptname from emp3  left join dept3 on worksin=deptid;--working
select empid,deptname from emp3  right join dept3 on worksin=deptid;--working


select deptname,empname from dept3 left join emp3 on deptid=worksin
where empname is null
  
select d1.deptname,count(e1.empname) from emp3 e1 join dept3 d1
on e1.worksin =d1.deptid group by d1.deptname

-- give me all the employees who have got location and also dept 
select e1.empname,d1.deptname,l1.locname from emp3 e1 join dept3 d1 on e1.worksin=d1.deptid
join location l1 on e1.empid=l1.empid;

-- give me all the employees who got dept but not locaton 
select e1.empname,d1.deptname,l1.locname from emp3 e1 join dept3 d1 on e1.worksin=d1.deptid
left join location l1 on e1.empid=l1.empid;-- to find null values 

select e1.empname,d1.deptname,l1.locname from emp3 e1 join dept3 d1 on e1.worksin=d1.deptid
left join location l1 on e1.empid=l1.empid where l1.locname is null;-- after this filtering

select e1.empname from emp3 e1 join dept3 d1 on e1.worksin=d1.deptid
left join location l1 on e1.empid=l1.empid where l1.locname is null

-- give me all employees who got location but not dept 

select e1.empname,d1.deptname,l1.locname from emp3 e1 left join dept3 d1 on e1.worksin=d1.deptid
 join location l1 on e1.empid=l1.empid;-- to find null values 

select e1.empname,d1.deptname,l1.locname from emp3 e1 left join dept3 d1 on e1.worksin=d1.deptid
 join location l1 on e1.empid=l1.empid where d1.deptname is null;-- after this filtering

select e1.empname from emp3 e1 left join dept3 d1 on e1.worksin=d1.deptid
 join location l1 on e1.empid=l1.empid where d1.deptname is null


CREATE TABLE Employees_A (
    employee_id INT,
    first_name NVARCHAR(50),
    last_name NVARCHAR(50));

INSERT INTO Employees_A (employee_id, first_name, last_name)
VALUES (1, 'John', 'Doe'),
       (2, 'Jane', 'Smith'),
       (3, 'Alice', 'Johnson');

-- Table: Employees_B
CREATE TABLE Employees_B (
    employee_id INT,
    first_name NVARCHAR(50),
    last_name NVARCHAR(50));

INSERT INTO Employees_B (employee_id, first_name, last_name)
VALUES (2, 'Jane', 'Smith'),
       (3, 'Alice', 'Johnson'),
       (4, 'Bob', 'Brown');

SELECT employee_id, first_name, last_name FROM Employees_A
SELECT employee_id, first_name, last_name FROM Employees_B;

-- Get all distinct employees from both tables
SELECT employee_id, first_name, last_name FROM Employees_A
UNION
SELECT employee_id, first_name, last_name FROM Employees_B;


-- Get the employees that are present in both tables
SELECT employee_id, first_name, last_name FROM Employees_A
INTERSECT
SELECT employee_id, first_name, last_name FROM Employees_B;



-- Get employees that are present in Employees_A but not in Employees_B
SELECT employee_id, first_name, last_name FROM Employees_A
EXCEPT
SELECT employee_id, first_name, last_name FROM Employees_B;


-- Combine UNION, INTERSECT, and EXCEPT in one query
-- Step 1: Find all employees from both tables using UNION
-- Step 2: Find common employees using INTERSECT
-- Step 3: Find employees that are only in Employees_A but not in Employees_B using EXCEPT
SELECT employee_id, first_name, last_name FROM Employees_A
UNION
SELECT employee_id, first_name, last_name FROM Employees_B
INTERSECT
SELECT employee_id, first_name, last_name FROM Employees_A
EXCEPT
SELECT employee_id, first_name, last_name FROM Employees_B;



-- using joins along with set operators 
--------------------------------------------
-- let us take emp1 and dept1 
select * from dept1;
select * from emp1 ;

-- give me all the employees who are working as clerk job or working in dept sales 

select e1.ename from emp1 e1 join dept1 d1 on e1.deptno=d1.deptno where e1.job='CLERK'
union
select e1.ename from emp1 e1 join dept1 d1 on e1.deptno=d1.deptno where d1.dname='SALES'

-- give me all the employees who are working as clerk job and working in dept sales 
select e1.ename from emp1 e1 join dept1 d1 on e1.deptno=d1.deptno where e1.job='CLERK'
intersect 
select e1.ename from emp1 e1 join dept1 d1 on e1.deptno=d1.deptno where d1.dname='SALES'

-- give me all the  employees who are working as clerk job but not in  working in dept sales 
select e1.ename from emp1 e1 join dept1 d1 on e1.deptno=d1.deptno where e1.job='CLERK'
except
select e1.ename from emp1 e1 join dept1 d1 on e1.deptno=d1.deptno where d1.dname='SALES'
----------------------------------------------------------------------------------------------------------------

--assingment
create table students(studentid int ,studentname varchar(30));
insert into students values(1,'john'),(2,'Matt'),(3,'James');
create table classes(classid int ,classname varchar(30));
insert into classes values(1,'art'),(2,'history'),(3,'Maths');
create table studentclass(studentid int,classid int );
insert into studentclass values(1,1),(1,2),(3,1),(3,2),(3,3);

select * from students;
select * from classes;
select * from studentclass;

--Q)what will be best possible join if i want to know 
-- all the students u have taken classes ?

select s1.studentname from students s1 join studentclass sc1 on s1.studentid=sc1.studentid
left join classes c1 on sc1.classid=c1.classid group by s1.studentname--no need of this line only group by needed


--q) what will be the best possible join if we want to retrive 
--all the students who have  not signed for any batches ?

select s1.studentname from students s1 left join studentclass sc1 on s1.studentid=sc1.studentid
WHERE sc1.studentid IS NULL  




--self join 

create table Employee(id int primary key ,
name varchar(50) not null,
managerid int );


insert into employee values(1,'mike',3),(2,'David',3),(3,'Roger',null),(4,'Marry',2),(5,'Joseph',2),
(7,'Ben',2);

select * from employee;


--Q1) give me all the employees with names and their coresspnding manager means display 
-- employee name and manager name as well 

select e1.name as Employeename, e2.name as manager from Employee e1 
join Employee e2 on  e1.managerid=e2.id

--Q2)-- give me the name of the employee also in the list who is not having manager 
-- and if he is top manager of the company tell it as top manager like that okay 
-- hint copy the same above code and for null specify left and use ifnull function over here 
-- like this u can do it for any column by joining any no of tables eventhough u dont 
-- have to perfom self join and instead null display temperorlay some value means use ifnull okay 


 select e1.name as employeename ,isnull(e2.name,'CEO') as manager 
 from  Employee e1 left join Employee e2 on e1.managerid=e2.id;



 --cross join--------- 

select * from dept3 
select * from emp3;

select * from dept3 cross join emp3 ;
