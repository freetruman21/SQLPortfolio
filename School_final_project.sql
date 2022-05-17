use sakila;
-- 1
-- provide a query which will calculate the percentage 
-- of films in the films table that contain deleted scenes 
-- (look into the special_features field to determine 
-- how deleted scenes are tracked).

select * from film;
select
	count(case when special_features like '%Deleted Scenes%' then 'ds' end) as cnt,
    count(case when special_features like '%Deleted Scenes%' then 'ds' end)/count(*) as rate
from film;

-- 2
-- In looking at the manner in which special_features are tracked 
-- in the film table, would this be considered normal form? 
-- How would you change this table to track special features?

-- It would not be considered normal form, because there is not one 
-- record per row in the special_features field. I would create each 
-- field(Deleted Scenes, Behind the Scenes...) for each record. 
-- In addition, I would put datatype as binary for each field. 
select special_features from film;

-- 3
-- Using the airportdb schema: Given the relationship between airplane 
-- and airline, provide a list in descending order of airline names and 
-- the count of airplanes associated with each.

use airportdb;
select 
	al.airlinename as name,
    count(ap.airplane_id) as cnt_of_airplanes
from 
	airline al inner join
    airplane ap on al.airline_id=ap.airline_id
group by 1
order by 1 desc;

-- 4
-- using the flightschedule table from the airportdb schema, 
-- write a query that will provide a count of the flights 
-- which are scheduled to fly on Monday and Wednesday.

select * from flightschedule;
describe flightschedule;

select 
	count(flightno) as cnt
from
	flightschedule
where
	monday = 1 and wednesday = 1;
    
-- 5
-- Based on the flightschedule table from the airportdb schema,
-- write a query that will determine how many airlines are 
-- associated with flights that are scheduled to fly on Monday 
-- and Wednesday?
select * from flightschedule;

select 
	count(distinct airline_id) as cnt_of_airline
from 
	flightschedule
where 
	monday = 1 and wednesday = 1;
    
select 
	count(distinct airline_id) as cnt_of_airline
from 
	flightschedule
where 
	flightno in 
    (select flightno from flightschedule 
    where monday = 1 and wednesday = 1);

-- 6
-- From the flight table, determine the time window for the data 
-- in the table. That is, what is the beginning and ending time 
-- period for this dataset.
-- Include your query as well as the start and end dates 
-- for the time period. (Think about when the first flight 
-- in the table left and when the last flight in the table arrived)

select 
	min(departure) as start, 
    max(arrival) as end
from
	flight;

select * from flight;

-- 7
-- Given the relationship between airline and flightschedule, 
-- write a query which will determine on which airline 
-- did the most flights occur on Monday. 
-- In the query include the airline name and number of flights.

select
	al.airline_id as airline_id,
    al.airlinename as airline_name,
    count(case when fs.monday = 1 then 'yes' else null end) as cnt
from
	airline al inner join
    flightschedule fs on
    al.airline_id = fs.airline_id
group by 
	1,2
order by
	3 desc;

select
	al.airline_id as airline_id,
    al.airlinename as airline_name,
    count(fs.flightno) as cnt
from
	airline al inner join
    flightschedule fs on
    al.airline_id = fs.airline_id
where
	fs.monday = 1
group by 
	1,2
order by 3 desc;

-- 8
-- Given the schema below, provide a list of film categories
-- by name and a unique count of the actors who have starred in each.
use sakila;

select 
	c.name as category_name,
    count(distinct fa.actor_id)
from 
	category c inner join
    film_category fc on c.category_id=fc.category_id inner join
    film f on f.film_id=fc.film_id inner join
    film_actor fa on fa.film_id=f.film_id
group by 1;

select 
	c.name as category_name,
    count(distinct a.actor_id)
from 
	category c inner join
    film_category fc on c.category_id=fc.category_id inner join
    film f on f.film_id=fc.film_id inner join
    film_actor fa on fa.film_id=f.film_id inner join
    actor a on a.actor_id=fa.actor_id
group by 1;

-- 9
-- Given the relationship airport and flight, 
-- write a query that provides a list of airports from which more than
-- 100 flights departed during the month of July 2015 
-- (the From field references the airport from which flights leave).
use airportdb;

select 
	ap.airport_id as airport_id,
    ap.name as airport_name,
    count(f.from) as cnt
from
	airport ap inner join 
	flight f on ap.airport_id=f.from
where 
	f.departure like '2015-07%'
group by 1,2
having
	cnt>100;

-- 10
-- Given the schema below, write a query that will give a list of all 
-- of the actors who have been in films with the actor UMA WOOD.
use sakila;
select
	fa.actor_id as actor_id,
    fa.film_id as film_with_WOOD
from
	film_actor fa inner join
    actor a on fa.actor_id=a.actor_id 
where 
	fa.film_id in
    (select fa.film_id from film_actor fa inner join actor a
    on a.actor_id=fa.actor_id where a.first_name='UMA' and a.last_name='WOOD')
    and a.first_name<>'UMA' and a.last_name<>'WOOD';
    
select actor_id from actor
where first_name='UMA' and last_name='WOOD';
select count(*) from film_actor
where actor_id = 13;

-- 11
-- Using the airportdb schema:
-- Given the schema below, write a query that will provide 
-- a count BY MONTH (you may use departure date) of:
-- The number of flights which occurred each month
-- The number of airplanes flown each month
-- The number of unique airplane types flown each month
-- The number of airlines on which flights occurred each month
-- The number of airports from which flights departed each month
-- The number of airports to which flights arrived each month
use airportdb;
select
	month(f.departure),
	count(f.flight_id) as num_flights,
    count(a.airplane_id) as num_airplanes,
    count(distinct a.type_id) as type,
    count(distinct a.airline_id) as num_airlines,
    count(distinct f.from) as num_airports_departed,
    count(distinct f.to) as num_airports_arrived
from
	flight f inner join airplane a
    on f.airplane_id=a.airplane_id
group by 1;

-- bonus
-- Given the schema below, write a query which will calculate 
-- the total amount of money spent by customers who have rented movies 
-- starring NICK WAHLBERG. The output should include the customer names 
-- and total amount of money spent.
use sakila;
select
	c.first_name as first_name,
    c.last_name as last_name,
    sum(p.amount) as total_amt
from 
	customer c inner join
    payment p on c.customer_id=p.customer_id inner join
    rental r on p.rental_id=r.rental_id inner join
    inventory i on i.inventory_id=r.inventory_id inner join
    film f on i.film_id=f.film_id inner join
    film_actor fa on fa.film_id=f.film_id inner join
    actor a on a.actor_id=fa.actor_id
where
	a.first_name = 'NICK' and a.last_name = 'WAHLBERG'
group by 1,2
order by 3 desc;

