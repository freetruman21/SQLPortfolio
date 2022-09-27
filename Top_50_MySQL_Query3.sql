# Write an SQL query to print details of the Workers whose FIRST_NAME contains ‘a’.

select * from worker where first_name like '%a%';

#Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘a’.

select * from worker where first_name like '%a';

#Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘h’ and contains six alphabets

select * from worker where first_name like '_____h'; 

#Write an SQL query to print details of the Workers whose SALARY lies between 100000 and 500000.

select * from worker where salary between 100000 and 500000;

#Write an SQL query to print details of the Workers who have joined in Feb’2014.

select * from worker where joining_date between '2014-02-01' and '2014-02-28';

select * from worker where year(joining_date) = 2014 and month(joining_date) = 2;

#Write an SQL query to fetch the count of employees working in the department ‘Admin’.

select count(worker_id) from worker where department = 'Admin';

#Write an SQL query to fetch worker names with salaries >= 50000 and <= 100000.

select first_name, last_name from worker where salary >= 50000 and salary <= 100000;

select concat(first_name, ' ', last_name) as full_name from worker where worker_id in (select worker_id from worker where salary >= 50000 and salary <= 100000);

# Write an SQL query to fetch the no. of workers for each department in the descending order.
use org;
select * from worker;

select count(worker_id), department from worker group by 2 order by 1 desc;

#  Write an SQL query to print details of the Workers who are also Managers.

select * from worker w join title t on w.worker_id = t.worker_ref_id where worker_title in('Manager');

# Write an SQL query to fetch duplicate records having matching data in some fields of a table.

select * from (select * , row_number() over(partition by worker_ref_id) as rn from bonus) as sub_set where rn > 1;

#Write an SQL query to show only odd rows from a table.

select * from worker where worker_id%2 =1;
select * from worker where mod(worker_id, 2) != 0;

# Write an SQL query to show only even rows from a table.
select * from worker where mod(worker_id, 2) = 0 ;

# Write an SQL query to clone a new table from another table.

create table worker2 as select * from worker;

create table worker3 like worker2;

# Write an SQL query to fetch intersecting records of two tables.

select * from worker w join title t on w.worker_id = t.worker_ref_id;

# Write an SQL query to show records from one table that another table does not have.
select * from worker w left join title t on w.worker_id = t.worker_ref_id;

