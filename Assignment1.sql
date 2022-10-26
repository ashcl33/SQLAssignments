#QUESTION NO.1
create table employeedetails(
empID int unique,
salary Decimal(60,2) Not Null,
employmentType varchar(275) Not Null,
gender varchar(15),
check(salary>=0),
check(employmentType in ("full-time", "part-time")),
foreign key(empID) references employees(employeenumber));


#QUESTION NO.2
Insert into employeedetails(empID, salary, employmentType, gender)
values
(1002, 99000.00,"full-time", "female"),
(1056, 65000.00, "part-time", "female"),
(1076, 110000, "full-time", "male"),
(1088, 75000.00, "full-time", "male"),
(1102, 120000, "full-time", "male");


#QUESTION NO.3
update employeedetails set salary=(salary+salary*0.05) where employmentType="full-time";
update employeedetails set salary=(salary+salary*0.03) where employmentType="part-time";

#QUESTION NO.4
alter table employeedetails
modify column salary decimal(8,2) not null;

alter table employeedetails
modify column employmentType varchar(14) not null;


#QUESTION NO.5
alter table employeedetails
add weeklyhours int;

update employeedetails set weeklyhours=40 where employmentType = "full-time";


#QUESTION NO.6
alter table employeedetails
drop gender;


#QUESTION NO.7
delete from employeedetails where empID=1002;












