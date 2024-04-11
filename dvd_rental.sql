-- Retrieves all records from the rental table
select * from rental

-- Retrieves customer_id from the rental table
select customer_id from rental

-- Retrieves distinct customer_id values from the rental table to avoid duplicates
select distinct customer_id from rental

-- Retrieves all rentals for customer_id = 459
select * from rental where customer_id = 459

-- Retrieves rentals for customer_id = 459 on a specific date and time
select * from rental where customer_id = 459 and rental_date = '2005-05-24 22:54:33'

-- Retrieves rentals for customer_id = 459 on a specific date, regardless of time
select * from rental where customer_id = 459 and date(rental_date) = date('05/24/2005')

-- Retrieves city names and their associated country_id from the city table
select city, country_id from city

-- Retrieves city names starting with 'Al' and their country_id from the city table
select city, country_id from city where city like 'Al%'

-- Retrieves city names where the second character is 'l' and their country_id
select city, country_id from city where city like '_l%'

-- Retrieves all records from the film table
select * from film

-- Retrieves films with film_id 133 or 384
select * from film where film_id = 133 or film_id = 384

-- Retrieves films with film_id in the set (133, 134)
select * from film where film_id in (133, 134)

-- Retrieves R or PG-13 rated films longer than 80 minutes, ordered by length
select * from film where rating = 'R' or rating = 'PG-13' and length > 80
order by length

-- Correctly applies logical operators to retrieve R or PG-13 rated films longer than 80 minutes
select * from film where (rating = 'R' or rating = 'PG-13') and length > 80
order by length

-- Attempts to filter films by film_id and implicitly checks for release_year truthiness
select * from film where film_id in (133, 134) and release_year

-- Joins customer and rental tables on customer_id, orders by customer_id
select customer.*,
       rental.*
from customer
inner join rental
on customer.customer_id = rental.customer_id
order by customer.customer_id

-- Similar join as above but using table aliases for brevity
select cust.*,
       rent.*
from customer cust
inner join rental rent
on cust.customer_id = rent.customer_id
order by cust.customer_id

-- Selects specific customer and rental information, orders by customer_id
select cust.customer_id, cust.first_name, cust.last_name,
       rent.rental_id, rent.rental_date, rent.inventory_id
from customer cust
inner join rental rent
on cust.customer_id = rent.customer_id
order by cust.customer_id

-- Filters the selection for customer_id = 1
select cust.customer_id, cust.first_name, cust.last_name,
       rent.rental_id, rent.rental_date, rent.inventory_id
from customer cust
inner join rental rent
on cust.customer_id = rent.customer_id
where cust.customer_id = 1
order by cust.customer_id

-- Extends the join to include the inventory table and filters for customer_id = 1
select cust.customer_id, cust.first_name, cust.last_name,
       rent.rental_id, rent.rental_date, rent.inventory_id,
       inv.film_id
from customer cust
inner join rental rent on cust.customer_id = rent.customer_id
inner join inventory inv on inv.inventory_id = rent.inventory_id
where cust.customer_id = 1
order by cust.customer_id

-- Further extends the join to include the film table, filters for customer_id = 1
select cust.customer_id, cust.first_name, cust.last_name,
       rent.rental_id, rent.rental_date, rent.inventory_id,
       inv.film_id,
       f.title, f.rating
from customer cust
inner join rental rent on cust.customer_id = rent.customer_id
inner join inventory inv on inv.inventory_id = rent.inventory_id
inner join film f on f.film_id = inv.film_id
where cust.customer_id = 1
order by cust.customer_id

-- Adds a filter for films with rating 'NC-17', for customer_id = 1
select cust.customer_id, cust.first_name, cust.last_name,
       rent.rental_id, rent.rental_date, rent.inventory_id,
       inv.film_id,
       f.title, f.rating
from customer cust
inner join rental rent on cust.customer_id = rent.customer_id
inner join inventory inv on inv.inventory_id = rent.inventory_id
inner join film f on f.film_id = inv.film_id
where cust.customer_id = 1
and rating = 'NC-17'
order by cust.customer_id

-- Retrieves actors with more than one entry in the actor table
select first_name, last_name
from actor 
group by 1, 2
having count(*) > 1

-- Joins customers with duplicate address_ids to their addresses
select outer_c.first_name, outer_c.last_name, outer_addr.address, outer_addr.city_id, outer_addr.postal_code
from customer outer_c
inner join
(select c.address_id
from customer c
group by c.address_id
having count(*) > 1) dup_addr on outer_c.address_id = dup_addr.address_id
inner join address outer_addr on outer_addr.address_id = outer_c.address_id

-- Calculates the total payment amount per customer
select outer_c.first_name, outer_c.last_name, pymt.amt 
from customer outer_c
inner join
(select customer_id, sum(amount) amt
from payment
group by 1) pymt on outer_c.customer_id = pymt.customer_id

-- Orders the total payment amounts in descending order
select outer_c.first_name, outer_c.last_name, pymt.amt 
from customer outer_c
inner join
(select customer_id, sum(amount) amt
from payment
group by 1) pymt on outer_c.customer_id = pymt.customer_id
order by 3 desc

-- Limits the result to the top 5 customers by total payment amount
select outer_c.first_name, outer_c.last_name, pymt.amt 
from customer outer_c
inner join
(select customer_id, sum(amount) amt
from payment
group by 1) pymt on outer_c.customer_id = pymt.customer_id
order by 3 desc limit 5

-- Groups rentals by film title and rating, counting the number of rentals
select f.title, f.rating, count(inv.film_id)
from rental r
inner join inventory inv on inv.inventory_id = r.inventory_id
inner join film f on f.film_id = inv.film_id
group by f.title, f.rating

-- Joins actors with rental count by film rating
select a.first_name, a.last_name, sub.rental_count
from actor a
inner join
(select fa.actor_id, f.rating, count(inv.film_id) rental_count
from rental r
inner join inventory inv on inv.inventory_id = r.inventory_id
inner join film f on f.film_id = inv.film_id
inner join film_actor fa on fa.film_id = f.film_id
group by fa.actor_id, f.rating) sub on a.actor_id = sub.actor_id
order by 3 desc

-- Retrieves customers who have never made a rental
select * from customer c
where c.customer_id not in (select distinct customer_id from rental)

-- Uses a left outer join to include films not present in inventory
select distinct f.film_id, f.title, inv.store_id
from film f
left outer join inventory inv on f.film_id = inv.film_id
order by 3 desc

-- Aggregates payments by staff_id
select p.staff_id, sum(amount)
from payment p
inner join staff s on s.staff_id = p.staff_id
group by p.staff_id

-- Retrieves the maximum payment amount by staff_id
select p.staff_id, MAX(amount)
from payment p
inner join staff s on s.staff_id = p.staff_id
group by p.staff_id

-- Calculates the average payment amount by staff_id
select p.staff_id, AVG(amount)
from payment p
inner join staff s on s.staff_id = p.staff_id
group by p.staff_id

-- Aggregates payments by customer_id
select p.customer_id, SUM(amount)
from payment p
inner join customer c on c.customer_id = p.customer_id
group by p.customer_id

-- Retrieves the maximum payment amount by customer_id
select p.customer_id, MAX(amount)
from payment p
inner join customer c on c.customer_id = p.customer_id
group by p.customer_id

-- Calculates the average payment amount by customer_id, ordered by average amount in descending order
select p.customer_id, AVG(amount)
from payment p
inner join customer c on c.customer_id = p.customer_id
group by p.customer_id
order by 2 desc

-- Calculates overall average, sum, minimum, and maximum payment amounts
select AVG(amount), sum(amount), min(amount), max(amount)
from payment p

-- Retrieves customers with an average payment amount greater than 4
select p.customer_id, count(*)
from payment p
inner join customer c on c.customer_id = p.customer_id
group by p.customer_id
having AVG(p.amount) > 4

-- Filters payments for customer_id < 10, groups by customer_id, having average amount > 4 or total > 10
select p.customer_id, count(*)
from payment p
inner join customer c on c.customer_id = p.customer_id
where p.customer_id < 10
group by p.customer_id
having (AVG(p.amount) > 4 or sum(p.amount) > 10)

-- Retrieves distinct customer IDs from the payment table, calculates a running total of the payment amount
-- ordered by customer ID, and assigns both rank and dense rank based on the order of customer IDs. 
-- The result is ordered by the rank and dense rank.
select distinct customer_id, 
        sum(amount) over(order by customer_id) as running_total,
        rank() over(order by customer_id) as rank,
        dense_rank() over(order by customer_id) as dense_rank       
from payment 
order by 3, 4

--also need to explore FIRST_VAlUE, LAST_VALUE(), WINDOW, LAG() and LEAD(), WITH etc..
-- This query first aggregates payments by date, calculating the total amount for each day and orders the result by amount in descending order within a CTE (Common Table Expression) named 'daily_amounts'.
-- It then selects each day's payment date and total amount from 'daily_amounts', calculates the total amount of the previous day using the LAG window function, and computes the net change in total amount from the previous day.
-- The final output is ordered by payment date, showing the daily amount, the amount from the previous day, and the net change between these two days.
WITH daily_amounts AS (
    SELECT date(payment_date) AS payment_date, 
           sum(amount) AS amt 
    FROM payment 
    GROUP BY 1 
    ORDER BY 2 DESC
)

SELECT payment_date, 
       amt, 
       LAG(amt, 1) OVER (ORDER BY payment_date) AS prev_day_amt,
       amt - LAG(amt, 1) OVER (ORDER BY payment_date) AS net_change
FROM daily_amounts

