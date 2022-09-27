# Write an SQL query to show the current date and time.

select curdate(), now();

# Write an SQL query to show the top n (say 10) records of a table.

select * from worker order by salary desc limit 10;


# Write an SQL query to determine the nth (say n=5) highest salary from a table.

select salary, concat(first_name, ' ', last_name) as full_name
from (select * from worker order by salary desc limit 5) as top5 order by salary limit 1;

# Write an SQL query to determine the 5th highest salary without using TOP or limit method.

select salary, first_name from (select *, rank() over(order by salary desc) as rn from worker) as top_sal where rn = 5;

select * from worker w1 where 4 = (select count(distinct salary) from worker w2 where w2.salary >= w1.salary);

#  Write an SQL query to fetch the list of employees with the same salary(Cross join).

Select distinct *
from Worker w1, Worker w2 
where w1.salary = w2.salary and w1.worker_id != w2.worker_id;

# Write an SQL query to show the second highest salary from a table.

select distinct salary, first_name from (select distinct salary, first_name from worker order by salary desc limit 2) as top2 order by salary limit 1;

select max(salary), first_name from worker where salary not in (select max(salary) from worker);

select salary, first_name from worker order by salary desc;

# Write an SQL query to show one row twice in results from a table.

select * from worker w1 
union all
select * from worker w2 order by worker_id;

# Write an SQL query to fetch intersecting records of two tables.

select * from worker w1 join worker w2 on w1.worker_id = w2.worker_id;

# Write an SQL query to fetch the first 50% records from a table.

select * from worker where worker_id <= (select count(worker_id)/2 	from worker);

# Write an SQL query to fetch the departments that have less than five people in it.

select count(worker_id), department from worker group by department having count(worker_id) <5;

# Write an SQL query to show all departments along with the number of people in there.

select count(worker_id), department from worker group by department ;

# Write an SQL query to show the last record from a table.

select *, row_number() over(order by worker_id desc) as rn from worker limit 1;

select * from worker where worker_id = (select max(worker_id) from worker);

#  Write an SQL query to fetch the first row of a table.

select * from worker where worker_id = (select min(worker_id) from worker);

select *, row_number() over(order by worker_id) as rn from worker limit 1;

# Write an SQL query to fetch the last five records from a table.

select * from (select *, row_number() over(order by worker_id desc) as rn from worker) as worker2 limit 5;

select * from worker order by worker_id desc limit 5;

# Write an SQL query to print the name of employees having the highest salary in each department.

select first_name, department from worker group by department having max(salary);

SELECT t.DEPARTMENT,t.FIRST_NAME,t.Salary from(SELECT max(Salary) as TotalSalary,DEPARTMENT from Worker group by DEPARTMENT) as n  
Inner Join Worker t on n.DEPARTMENT=t.DEPARTMENT 
 and n.TotalSalary=t.Salary;
 
 select salary, department, first_name from worker where salary  in (select max(salary) from worker group by department);

select max(salary), department, worker_id, first_name from worker group by department;

# Write an SQL query to fetch three max salaries from a table.

select distinct salary from (select distinct salary, dense_rank() over (order by salary desc) as dr from worker) as worker2 limit 3;

SELECT distinct Salary from worker a WHERE 3 >= (SELECT count(distinct Salary) from worker b WHERE a.Salary <= b.Salary) order by a.Salary desc;

#  Write an SQL query to fetch three min salaries from a table.

select distinct salary from (select *, dense_rank() over(order by salary ) as dr from worker) as worker2 limit 3;

# Write an SQL query to fetch nth max salaries from a table.


delimiter $$
create procedure nth(in n int)
begin 

select distinct salary from (select distinct salary, dense_rank() over (order by salary desc) as dr from worker) as worker2 limit n;

end $$
delimiter ;

call nth(5);


# Write an SQL query to fetch departments along with the total salaries paid for each of them.

select department, sum(salary) from worker group by 1;

# Write an SQL query to fetch the names of workers who earn the highest salary.

select first_name, last_name, salary from worker where salary = (select max(salary) from worker);


