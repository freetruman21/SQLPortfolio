#Write an SQL query to fetch “FIRST_NAME” from Worker table using the alias name as <WORKER_NAME>.

select first_name as worker_name from worker;

#Write an SQL query to fetch “FIRST_NAME” from Worker table in upper case.

select upper(first_name) from worker;

#Write an SQL query to fetch unique values of DEPARTMENT from Worker table.

select * from worker ;
select distinct department from worker ;

#Write an SQL query to print the first three characters of  FIRST_NAME from Worker table.

select substr(first_name, 1,3) from worker;

#Write an SQL query to find the position of the alphabet (‘a’) in the first name column ‘Amitabh’ from Worker table.

select instr(first_name, 'a') from worker where first_name ='Amitabh';


# Write an SQL query to print the FIRST_NAME from Worker table after removing white spaces from the right side.
use org;

select rtrim(first_name) from worker;

#Write an SQL query to print the DEPARTMENT from Worker table after removing white spaces from the left side.

select ltrim(first_name) from worker;

#Write an SQL query that fetches the unique values of DEPARTMENT from Worker table and prints its length.

select distinct department, length(department) from worker;

#Write an SQL query to print the FIRST_NAME from Worker table after replacing ‘a’ with ‘A’.

select first_name, replace(first_name,'a','A') from worker;

#Write an SQL query to print the FIRST_NAME and LAST_NAME from Worker table into a single column COMPLETE_NAME. A space char should separate them.

select first_name, last_name, concat(first_name,' ', last_name) as COMPLETE_NAME from worker;

#Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending.

select * from worker order by first_name;	

# Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending and DEPARTMENT Descending.

select * from worker order by first_name, department desc;

#Write an SQL query to print details for Workers with the first name as “Vipul” and “Satish” from Worker table.

select * from worker where first_name in ( 'Vipul' ,'Satish');

#Write an SQL query to print details of workers excluding first names, “Vipul” and “Satish” from Worker table.

select * from worker where first_name not in ('Vipul','Satish');

#Write an SQL query to print details of Workers with DEPARTMENT name as “Admin”.

select * from worker where department = 'Admin';

select * from worker where department like 'Admin%';