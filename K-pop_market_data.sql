use market_db;

drop procedure if exists ifproc1;


Delimiter $$
create procedure ifproc1()
begin
	if 100 =200 then
		select '100 equals 200';
	end if;
end $$
delimiter ;

call ifproc1();

drop procedure if exists ifproc2;

delimiter $$
create procedure ifproc2()
begin
	declare mynum int ;
    set mynum = 200;
    if mynum = 100 then
		select ' mynum is 100';
	else
		select 'mynum is not 100';
	end if;
end $$
delimiter ;

call ifproc2();

drop procedure if exists ifproc3;

delimiter $$
create procedure ifproc3()
begin 
	declare debutdate Date;
    declare curDate Date;
    declare days int;
    
    select debut_date into debutdate
		from market_db.member
        where mem_id = 'APN';
        
	set curDate = current_date();
    set days = datediff(curDate, debutdate);
    
    if (days/365) >= 5 then
		select concat('it has been', days, 'days since they debut the scene');
	else 
		select 'it has been' + days + 'days. It was not long ago';
	end if;
end $$
delimiter ;

call ifproc3();

# CASE Clause

drop procedure if exists caseproc;

delimiter $$
create procedure caseproc()
begin
	declare point int ;
    declare credit char(1);
    set point = 88;

	case 
		when point >= 90 then
			set credit = 'A';
		when point >= 80 then
			set credit = 'B';
		when point >= 70 then
			set credit = 'C';
		when point >= 60 then
			set credit = 'D';
		else 
			set credit = 'F';
	end case;
    select concat('your point is', ' ' , point) score , concat('your grade is' , ' ', credit) grade;
end $$

call caseproc();

 select mem_id, sum(price*amount)
	from buy
    group by 1;
    
 select mem_id, sum(price*amount)
	from buy
    group by 1
    order by 2 desc;

select m.mem_id, m.mem_name, sum(price*amount)
	from buy b 
    right join member m
    on b.mem_id = m.mem_id
    group by 1
    order by 3 desc;

select m.mem_id, m.mem_name, sum(price*amount),
		case
			when (sum(price*amount) >=1500 ) then 'VIP'
			when (sum(price*amount) >=1000 ) then 'regular customer'
			when (sum(price*amount) >= 1 ) then 'new customer'
			else 'potential customer'
		end 'customer level'
	from buy b 
		right join member m
		on b.mem_id = m.mem_id
	group by 1
	order by 3 desc;

drop procedure if exists whileproc;

delimiter $$
create procedure whileproc()
begin
	declare i int;
    declare total int;
    set i =1;
    set total = 0;
    
    while( i<= 100) do
		set total = total + i;
        set i = i + 1;
	end while;
    
    select ' total' ,total ;
    
end $$
delimiter ;

call whileproc();

use market_db;

prepare myquery from 'select * from member where lower(mem_id) = "blk"';
execute myquery;

drop table if exists gate_table;
create table gate_table (id int auto_increment primary key, entry_time datetime);

set @curdate = current_timestamp();

prepare myquery from 'insert into gate_table values(null, ?)';
execute myquery using @curdate;


select * from gate_table;
















    
