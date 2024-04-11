--List all students from the student table
select * from student

--List SUVs in the price range: $25,000 to $30,000
select * from vehicle
	where vehicle_type = 'suv'
	and price between 25000 and 30000

--List vehicles while excluding certain makes, and sort by make asc, model desc
select * from vehicle where make not in ('Hyundai', 'Toyota')
order by make asc, model desc

--Exclude rows with missing value
select a from aggregation_example where a is not null

--Convert student name to Lowercase and Uppercase.
select name, lower(name) as lower_name, upper(name) as upper_name from student

--List all students who enrolled in the year 2023 
select * from student where date_part('year', enrolled_date) = 2023

--Perform Unit Conversion: Calculate Kilometers per Liter from Miles per Gallon
select make, model, (mpg*1.6/3.8) as kilometers_per_ltr from vehicle

--Retrieve the First Five Rows from the Billing Table
select * from billing limit 5

--Retrieve the Top 3 Most Fuel-Efficient Vehicles Based on Kilometers Per Liter
select make, model, round(cast(mpg as numeric)*1.6/3.8, 1) as kmpl from vehicle

--Display Top 3 Most Expensive Bills
select * from billing 
order by 3 desc
limit 3

--Concatenate student Address columns together.
select name, concat_ws(' ', street, city, state, postal_code) from student
select name, concat(street, ' ', city, ' ', state, ' ', postal_code) from student

--Extract Month and Year from enrolled Date Columns.
select enrolled_date, date_part('month', enrolled_date) as enrolled_month from student
select enrolled_date, to_char(enrolled_date, 'Month') as enrolled_month from student
--similar for years

--Replace NULL Values in the prereq_id in course table with None
select *, coalesce(prereq_id, '0') from course

--Display Student Information with State Abbreviation and Full State Name.
select student_id, name,
        state,
        case 
            when state = 'CA' then 'California'
            when state = 'TX' then 'Texas'
            when state = 'FL' then 'Florida'
            when state = 'IL' then 'Illinois'
            else 'Unknown'
        end as state_name
from student

--Assign Fuel Efficiency Ratings to Vehicles Based on MPG Values
select make, model, mpg,
	case 
		when mpg <= 20 then 'Poor'
		when mpg > 21 and mpg <= 25 then 'Average'
		when mpg > 25 then 'Good'
	end
from vehicle
order by mpg desc

--Join Student and Course Tables
select s.student_id, s.name, c.course_name
	from student s
	inner join student_course sc on sc.student_id = s.student_id
	inner join course c on c.course_id = sc.course_id

--List Courses for a Specific Student: Display Details for Akil
select 
    s.student_id, s.name as student_name, 
    sc.course_id, c.course_name
	from student s 
	inner join student_course sc 
	on sc.student_id = s.student_id
	inner join course c 
	on c.course_id = sc.course_id 
	where s.name = 'Akil'
	order by s.student_id, c.course_name

--Retrieve Students Enrolled in a Specific Course 'public speaking'
select
    s.student_id, s.name as student_name, 
    sc.course_id, c.course_name
from student s 
inner join student_course sc 
on sc.student_id = s.student_id
inner join course c 
on c.course_id = sc.course_id 
where c.course_name = 'Public Speaking'
order by s.student_id, c.course_name

--Retrieve Students Enrolled in a Specific Course 'public speaking' or 'akil'
select
    s.student_id, s.name as student_name, 
    sc.course_id, c.course_name
from student s 
inner join student_course sc 
on sc.student_id = s.student_id
inner join course c 
on c.course_id = sc.course_id 
where (c.course_name = 'Public Speaking' or s.name = 'Akil')

--Retrieve Students Enrolled in a Specific Course 'public speaking' and 'akil'
select
    s.student_id, s.name as student_name, 
    sc.course_id, c.course_name
from student s 
inner join student_course sc 
on sc.student_id = s.student_id
inner join course c 
on c.course_id = sc.course_id 
where (c.course_name = 'Public Speaking' and s.name = 'Akil') --Photography Basics

--List students who are enrolled in either 'Dance 3' or 'Photography Basics'

select s.student_id, s.name, c.course_name
	from student s
	inner join student_course sc on sc.student_id = s.student_id
	inner join course c on c.course_id = sc.course_id
	where c.course_name in ('Dance 3', 'Photography Basics')

--List Students Not Enrolled in Any Course
select s.student_id, s.name, sc.course_id
	from student s
	left outer join student_course sc on s.student_id = sc.student_id
	where course_id is null

----List Students both enrolled Not Enrolled in Any Course
select s.student_id, s.name, sc.course_id
	from student s
	left outer join student_course sc on s.student_id = sc.student_id
	
--List courses that have a pre-requisite
select c.course_id, c.course_name, 
       pc.course_name as prereq_course_name
from course c
inner join course pc
on pc.course_id = c.prereq_id

select c.course_id, 
		c.course_name,
       coalesce(pc.course_name, 'N/A') as prereq_course_name
from course c
left outer join course pc
on pc.course_id = c.prereq_id

--Identify Data Quality Issues: Duplicate Postal Codes Assigned to Different States
select postal_code, state from student
order by 1

select postal_code, count(state) from student
group by 1

select postal_code, string_agg(state, ',')
from student
group by 1
having count(state) > 1

select postal_code, string_agg(state, ',')
from student
group by 1
having count(distinct state) > 1


--CROSS JOIN, Generate a List of All Possible Course Combinations for Each Student
select 
    s.student_id, s.name as student_name, 
    c.course_name
from student s 
cross join course c 
order by s.student_id, c.course_name

--Display the List of Students Who Have Not Yet Enrolled in a Course
select s.student_id, s.name 
from student s 
where s.student_id not in (select distinct sc.student_id from student_course sc)

--using left outer join like earlier
select s.student_id, s.name 
from student s 
left outer join student_course sc
on sc.student_id = s.student_id
where sc.course_id is null
order by s.student_id

--List Courses with No Student Enrollments
select c.course_id, c.course_name 
from course c where course_id not in 
(select distinct course_id from student_course)

--cars that give better mileage than average
select *
from vehicle v 
where v.vehicle_type = 'car'
and v.mpg >= (select avg(mpg) from vehicle where vehicle_type = 'car')

--Display Vehicle with the Highest Fuel Efficiency
select make, model, mpg from vehicle order by 3 desc limit 1

select make, model, mpg from vehicle where mpg = (
select max(mpg) from vehicle)
limit 1


--SECOND HIGHEST MPG
WITH RankedVehicles AS (
    SELECT
        make,
        model,
        mpg,
        RANK() OVER (ORDER BY mpg DESC) AS mpg_rank
    FROM vehicle
)
SELECT make, model, mpg
FROM RankedVehicles
WHERE mpg_rank = 2

WITH NumberedVehicles AS (
    SELECT
        make,
        model,
        mpg,
        ROW_NUMBER() OVER (ORDER BY mpg DESC) AS row_num
    FROM vehicle
)
SELECT make, model, mpg
FROM NumberedVehicles
WHERE row_num = 2

SELECT make, model, mpg
FROM (
    SELECT
        make,
        model,
        mpg,
        RANK() OVER (ORDER BY mpg DESC) AS mpg_rank
    FROM vehicle
) AS RankedVehicles
WHERE mpg_rank = 2

select 
    count(*) as total_rows, 
    count(a) as count_a,
    count(b) as count_b,	   
from aggregation_example

select 
    count(*) as total_rows, 
    count(a) as count_a,
    count(b) as count_b	   
from aggregation_example


select 
    sum(a) as sum_a, 
    sum(b) as sum_b
from aggregation_example


select a, b, a+b 
from aggregation_example
select 
    a, 
    b, 
    coalesce (a,0) + coalesce (b,0) as a_b, 
from aggregation_example

select
    avg(a) as avg_a,
    avg(b) as avg_b
from aggregation_example

select 
    avg(a) as avg_a,
    avg(coalesce (a, 0)) as avg_a1,
    avg(b) as avg_b,
    avg(coalesce (b, 0)) as avg_b1
from aggregation_example

select min(a) as min_a, 
	   max(a) as max_a, 
	   min(b) min_b,
	   max(b) max_b
from aggregation_example

--Show Total Courses, Courses with Prerequisites, and Courses without Prerequisites
select * from 
(select count(*) from course) c,
(select count(*) from course where prereq_id is null) no_pre_req,
(select count(*) from course where prereq_id is not null) pre_req

--Counting Models Produced by Each Manufacturer Using UNION
select v.make, count(*) as models
from vehicle v 
where v.make = 'Ford'
group by 1
UNION
select v.make, count(*) as models
from vehicle v 
where v.make = 'GMC'
group by 1
UNION
select v.make, count(*) as models
from vehicle v 
where v.make = 'Honda'
group by 1

--Counting Models Produced by Each Manufacturer Using GROUP BY
select make, count(distinct model) as models
from vehicle v 
group by make
order by make
--Display Additional Metrics for Each Manufacturer: Price Range, Average MPG
select make, 
       count(distinct model) as models,
       min(v.price) as min_price,
       max(v.price) as max_price,
       round(avg(v.mpg)) as avg_mpg
from vehicle v 
group by make
order by make

--Aggregating Metrics by Car Manufacturer
select make, 
       count(distinct model) as models,
       min(v.price) as min_price,
       max(v.price) as max_price,
       round(avg(v.mpg)) as avg_mpg
from vehicle v 
where v.vehicle_type ='car'
group by make
order by make

--GROUP BY: NULL
select 
    a, 
    count(*) total_rows
from aggregation_example ae 
group by a
order by a

--Show Average Bill Amount by Account
select account, round(avg(amount)) from billing
group by 1
order by 2 desc

--Display Student Enrollments by Year
select date_part('year', enrolled_date), count(*) from student
group by 1

--Compute Average Price By Manufacturer and Vehicle Type
select make, vehicle_type, round(avg(price)) from vehicle
where make in ('Ford', 'Mazda','Toyota')
group by 1, 2
order by 1

--Aggregating Data: Counting Students Enrolled in Each Course
select 
    c.course_name,
    count(distinct sc.student_id) as student_count     
from course c  
inner join student_course sc 
on sc.course_id = c.course_id 
group by c.course_name  
order by student_count, course_name

select 
    c.course_name,
    count(distinct sc.student_id) as student_count
from course c  
left outer join student_course sc 
on sc.course_id = c.course_id 
group by c.course_name
order by student_count, course_name

--Retrieve Students Enrolled in Both 'Photography Basics' and 'Resume Writing for Success' Courses

select s.name as student_name, count(sc.course_id) as courses_enrolled
from student s
inner join student_course sc on sc.student_id = s.student_id
inner join course c on c.course_id = sc.course_id
where upper(c.course_name) in (upper('Photography Basics'), upper('Resume Writing for Success'))				   
group by 1
having count(sc.course_id) = 2	

--Write a query to display the monthly charges for each account,
--along with the total charges for each month, and compute the grand total of all bills. 
--Order the results by bill_date.
SELECT
    COALESCE(TO_CHAR(DATE_TRUNC('month', bill_date), 'YYYY-MM-DD'), 'SubTotal') AS bill_date,
    CASE WHEN GROUPING(account) = 1 THEN 'SubTotal' ELSE account END AS account,
    SUM(amount) AS total_charges
FROM
    billing
GROUP BY ROLLUP(DATE_TRUNC('month', bill_date), account)
ORDER BY
    DATE_TRUNC('month', bill_date),
    GROUPING(DATE_TRUNC('month', bill_date)),
    account

--PIVOTING: Query Example with SUBQUERIES, CASE, and Aggregation Functions
--start
select 
    make, 
    vehicle_type, 
    count(*) as models
from vehicle v 
group by make, vehicle_type
order by make, vehicle_type

--step 1
select 
	make,
	case
		when vehicle_type = 'car' then model_count
		else 0
	end as car_model,	   	
	case
		when vehicle_type = 'suv' then model_count
		else 0
	end as suv_model
from 
	(select make, vehicle_type, count(*) as model_count
	   from vehicle v 
         group by make, vehicle_type) as inner
order by make

--final step
select 
	make,
	sum(case
		when vehicle_type = 'car' then model_count
		else 0
		end) as car_models,	   
	sum(case
		when vehicle_type = 'suv' then model_count
		else 0
		end) as suv_models
from (select make, vehicle_type, count(*) as model_count
	from vehicle v 
      group by make, vehicle_type) as inner
group by make
order by make

--Convert Billing Data From Long Format to Wide Format

SELECT
    bill_date,
    SUM(CASE WHEN account = 'Prod' THEN amt_sum ELSE 0 END) AS Prod,
    SUM(CASE WHEN account = 'Test' THEN amt_sum ELSE 0 END) AS Test,
    SUM(CASE WHEN account = 'Dev' THEN amt_sum ELSE 0 END) AS Dev
FROM (
    SELECT 
        b.bill_date, 
        b.account, 
        SUM(b.amount) AS amt_sum
    FROM billing b 
    GROUP BY b.bill_date, b.account
) AS inner_table 
GROUP BY bill_date
ORDER BY bill_date

--CTE or common table expression
-- Display vehicles that outperform the average mileage for their types
with vehicle_type_avg as (	
	select vehicle_type, round(avg(mpg)) as avg_mpg
	from vehicle v
	group by vehicle_type)
	
select 
	v.make, 
	v.model, 
	v.vehicle_type, 
	v.mpg,
	vt.avg_mpg
from vehicle v 
inner join vehicle_type_avg vt
on v.vehicle_type = vt.vehicle_type
and v.mpg >= vt.avg_mpg
order by vehicle_type, v.mpg

--Present Monthly Bill Amounts with Account Average
WITH AvgBillAmount AS (
    SELECT
        account,
        AVG(amount) AS avg_bill
    FROM billing
    GROUP BY account
)
SELECT
    b.bill_date,
    b.account,
    b.amount,
    round(a.avg_bill::numeric, 2),
    round((b.amount - a.avg_bill)::numeric, 2) AS difference
FROM billing b
INNER JOIN AvgBillAmount a ON b.account = a.account
ORDER BY b.bill_date, b.account

--WINDOW Functions to List vehicles along with average new vehicle price

select 
    make, model, vehicle_type as type, 
    mpg, price,
    round(avg(price) over()) as avg_new_vehicle_price,
    count(*) over () as total_models --over the entire dataset
from vehicle v
order by price

select 
    make, model, vehicle_type as type, 
    mpg, price,
    round(avg(price) over()) as avg_toyota_price,
    count(*) over() as total_models  --over what is the where clause , Toyota
from vehicle v
where make ='Toyota'
order by price

--Partition List vehicles along with average price for the vehicle type
select 
    make, model, 
    vehicle_type as type, 
    mpg, 
    price,
    round(avg(price) over(partition by vehicle_type)) avg_price,
    count(*) over(partition by vehicle_type) total_models
from vehicle v
order by vehicle_type, price

--Multiple Windows: List vehicles along with their respective average price 
--by vehicle type, the number of models per vehicle type, and the average price of all vehicles
select 
    make, model, 
    vehicle_type as type, 
    mpg, 
    price,
    round(avg(price) over(partition by vehicle_type)) avg_price,
    count(*) over(partition by vehicle_type) total_models,
    round(avg(price) over()) avg_price_all_vehicles
from vehicle v
order by vehicle_type, price

--Present Monthly Bill Amounts with Account Average
WITH BillingWithAvg AS (
    SELECT
        bill_date,
        account,
        amount,
        ROUND(CAST(AVG(amount) OVER (PARTITION BY account) AS NUMERIC), 2) AS avg_bill
    FROM billing
)
SELECT
    bill_date,
    account,
    amount,
    avg_bill,
    round(amount - avg_bill) AS difference
FROM BillingWithAvg
ORDER BY bill_date, account;

--NON-CTE subquery option for above:
SELECT
    bill_date,
    account,
    amount,
    avg_bill,
    amount - avg_bill AS difference
FROM (
    SELECT
        bill_date,
        account,
        amount,
        ROUND(CAST(AVG(amount) OVER (PARTITION BY account) AS NUMERIC), 2) AS avg_bill
    FROM billing
) AS subquery
ORDER BY bill_date, account;

--Listing Each Vehicle with Its Previous and Next Vehicle by Price
select 
    make, model, vehicle_type, price,
    lag (price,1) over (partition by vehicle_type order by price) as prev_model,
    lead(price,1) over (partition by vehicle_type order by price) as next_model
from vehicle v
order by vehicle_type, price

--Analyzing Monthly Billing Trends: Calculating Differences by Month
select 
    bill_date,
    account,
    amount,
    prev_month,
    (amount-prev_month) difference
from (select 
    	bill_date, 
	account, 
	amount,
	lag(amount,1) over(partition by account order by bill_date) as prev_month
      from billing b) as inr
order by account, bill_date

--Show the Three Most Affordable Cars and SUVs
with vehicle_rank as (
    select 
    	v.make, 
	v.model, 
	v.vehicle_type, 
	v.price,
	dense_rank() over (
		partition by vehicle_type 
		order by price desc) as d_rank
    from vehicle v)
 
select 
    make, 
    model, 
    vehicle_type, 
    price, 
    d_rank
from vehicle_rank
where d_rank = 3
order by vehicle_type, d_rank

--Identify Third-Highest Priced Vehicle
with vehicle_rank as (
    select 
        v.make, 
	v.model, 
	v.vehicle_type, 
	v.price,
	dense_rank() over (
		partition by vehicle_type 
		order by price desc) as d_rank
    from vehicle v)
 
select 
    make, 
    model, 
    vehicle_type, 
    price, 
    d_rank
from vehicle_rank
where d_rank = 3
order by vehicle_type, d_rank
