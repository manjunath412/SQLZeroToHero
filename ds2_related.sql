-- Casting strings to fixed length character types with padding for 'FIRSTNAME' and 'LASTNAME'
SELECT CAST('Manjunath' AS CHARACTER(20)) AS "FIRSTNAME",
       'Bettadapura'::CHARACTER(20) AS "LASTNAME",
       'Is a dummanna' AS TEXT; -- Text type with unlimited length

-- Casting strings to variable length character types with a maximum length for 'FIRSTNAME' and 'LASTNAME'
SELECT CAST('Manjunath' AS CHARACTER VARYING(20)) AS "FIRSTNAME",
       'Bettadapura'::VARCHAR(20) AS "LASTNAME";

-- Demonstrating maximum values that can be stored in various integer types
SELECT CAST(2^15-1 AS SMALLINT) AS "smallint or int2",
       CAST(2^31 -1 AS INTEGER) AS "integer or int or int4",
       CAST(-2^63 AS BIGINT) AS "bigint or int8";

-- Casting a floating-point number to a numeric type with specified precision and scale for 'pi'
SELECT CAST(3.1415936 AS NUMERIC(8,7)) AS "pi";

-- Demonstrating casting of 'NAN' string to numeric type
SELECT CAST('NAN' AS NUMERIC) AS "NaN";

-- Creating and immediately dropping a table to demonstrate SQL DDL commands
CREATE TABLE foo (bar NUMERIC(1000));
DROP TABLE foo;

-- Demonstrating casting of floating-point numbers to real and double precision types, and comparison of real and float types
SELECT 3.145936 ::REAL AS "Real Pi",
       3.145936 ::DOUBLE PRECISION AS "Double Precision";
SELECT '3.145936' ::FLOAT(53) = '3.145936' ::REAL AS "Are they equal";

-- Casting a formatted string to the money type
SELECT CAST('$1,000.00' AS MONEY) AS 'DOLLAR AMOUNT';

-- Calculating time since a specific date and defining a time interval
SELECT CURRENT_TIMESTAMP - 'Jan 1 1900' ::TIMESTAMP AS "Time since Jan 1 1900",
       '21 hours, 30 minutes ago' ::INTERVAL AS "10 and a half hours ago";

-- Casting a string to a date type to celebrate a specific event
SELECT 'June 2, 1953' ::DATE AS "Go Elizabeth II!";

-- Demonstrating time and time with time zone types
SELECT '00:00:00' ::TIME(6) AS "The Midnight Hour",
       '12:00:00 CET' ::TIME WITH TIME ZONE AS "High Noon in Amsterdam";

-- Demonstrating boolean values and representations
SELECT 1::BOOLEAN AS "True",
       0 ::BOOLEAN AS "False",
       't':: BOOLEAN AS "True",
       'f':: BOOLEAN AS "False",
       'y':: BOOLEAN AS "True",
       'n':: BOOLEAN AS "False",
       'n'::BOOL AS "Unknown";

-- Simple SELECT returning TRUE and FALSE boolean values
SELECT TRUE, FALSE;

-- Demonstrating arrays of integers, floating-point numbers, and strings
SELECT ARRAY[1,2,3]::INTEGER[] AS "Array of integers",
       CAST('{4,5,6}' AS FLOAT[]) AS "Another array of real numbers",
       '{7,8,9}' ::VARCHAR[] AS "An array of text/cha items";

-- Accessing the first entry in a character array
SELECT (ARRAY['a', 'b', 'c']::CHAR[])[1] AS "First entry in a character array";

-- Demonstrating the use of XML data type for storing XML content
SELECT '<a>42</a>'::XML AS "XML Content";

-- Storing and querying XML documents
SELECT XML '<?xml version="1.0"?>
<book>
    <title>Manual</title>
    <chapter>...</chapter>
</book>' AS "XML Document";

-- Demonstrating JSON and JSONB data types for storing and querying JSON data
SELECT '{"name":"Manjunath"}' ::JSON,
       '{"name":"Bettadapura"}' ::JSONB, -- JSONB for binary storage
       JSON '{"name":"Dumma"}';

-- Demonstrating range types for integers and numeric values
SELECT INT4RANGE(10, 20) AS "Range of integers",
       NUMRANGE(2.17, 3.14) AS "Range of numerics";

-- Demonstrating timestamp and date range types
SELECT TSRANGE('20240408 00:00:00', '20240412 11:59:59') AS "Timestamp range",
       DATERANGE('20300101', '20401231') AS "Date Range";

-- Demonstrating basic arithmetic operations
SELECT 2 + 3 AS "Addition",
       2 - 3 AS "Subtraction",
       2 * 3 AS "Multiplication",
       5 / 2 AS "Division (Integer)", DIV(5, 2),
       5.0 / 2 AS "Division (Non-Integer)";

-- Demonstrating modulus, exponentiation, square root, and absolute value operations
SELECT 5 % 2 AS "Modulus", MOD(5,2),
       5 ^ 2 AS "Exponent", POWER(5, 2),
       |/ 25 AS "Square Root", SQRT(25),
       @ -42 AS "Absolute Value", ABS(-42);

-- Demonstrating cube root and factorial functions
SELECT ||/ 27 AS "Cube Root", CBRT(27),
       factorial(5);

-- Demonstrating logarithmic and absolute value functions
SELECT ABS(-42) AS "Absolute Value",
       MOD(5, 2) AS "Modulus",
       LOG(2, 8) AS "General Logarithm",
       LN(42) AS "Natural Logarithm";

-- Demonstrating exponential, power, square root, floor, ceil, round, scale, sign, and truncate functions
SELECT EXP(1) AS "Exponential of e",
       POWER(5, 2) AS "Power",
       SQRT(2) AS "Square Root",
       FLOOR(3.14159) AS "Floor",
       CEIL(3.14159) AS "Ceiling", CEILING(3.14159),
       ROUND(42.4) AS "Round to the nearest integer",
       ROUND(42.1234, 2) AS "Round to a number of decimal places",
       SCALE(42.5321) AS "Number of digits after decimal point",
       SIGN(-1) AS "Sign",
       TRUNC(42.5) AS "Truncate toward zero",
       TRUNC(42.1234, 2) AS "Truncate to a number of decimal places";

-- Generating a random number
SELECT RANDOM();

-- Demonstrating aggregate functions with optional filters
SELECT COUNT(*),
       COUNT(DISTINCT "state"),
       MIN(age),
       AVG(age),
       MAX(age),
       SUM(income),
       AVG(age) FILTER(WHERE "state" in ('NY', 'CA'))
FROM customers;

-- Demonstrating GROUP BY, HAVING, ORDER BY, and LIMIT clauses in aggregation
SELECT "state",
       AVG(income)
FROM customers
GROUP BY "state"
HAVING MAX(age) > 50
ORDER BY "state"
LIMIT 5;

-- Demonstrating statistical functions
SELECT STDDEV_POP(age),
       STDDEV_SAMP(age) FILTER (WHERE "state" = 'NY'),
       VAR_SAMP(income) FILTER (WHERE age < 25),
       VAR_POP(income)
FROM customers;

-- Demonstrating correlation, covariance, and regression analysis functions
SELECT c.state,
       CORR(c.age, o.netamount),
       COVAR_POP(c.age, o.netamount),
       REGR_INTERCEPT(c.age, o.netamount)
FROM orders o
JOIN customers c ON o.customerid = c.customerid
WHERE c.state in ('NY', 'CA', 'FL')
GROUP BY c.state;

-- Demonstrating ordered-set aggregate functions
SELECT MODE() WITHIN GROUP (ORDER BY age),
       PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY age),
       PERCENTILE_DISC(ARRAY[0, 0.25, 0.5, 0.75, 1]) WITHIN GROUP (ORDER BY age)
FROM customers;

-- Demonstrating string concatenation
SELECT 'foo' || 'bar';
SELECT 'The ' || 'answer' || 'is ' || 42;
SELECT 'pi = '|| 3.14159::float8;
SELECT 'Today is: ' || CURRENT_DATE;

-- Demonstrating string functions for case conversion, trimming, substring extraction, and other manipulations
SELECT upper('abc'),
       lower('ABC'),
       char_length('abc'),
       trim('   ABC   '),
       trim(leading '-' from '---abc---'),
       trim(trailing '-' from '---abc---'),
       trim(both '-' from '---abc---'),
       position('Trillian' in 'Arthur and Trillian'),
       substring('Arthur and Trillian' from 12 for 4),
       substring('Arthur and Trillian' from 12),
       left('Arthur and Trillian', 4),
       right('Arthur and Trillian', 4),
       length('Arthur'),
       ltrim('   abcd'),
       rtrim('def.  ', '-x'),
       lpad('Arthur', 5),
       rpad('Trill', 5, '-x'),
       repeat('Rr', 5),
       overlay('Arthur and Trillian' placing 'Zaphod' from 1 for 6),
       replace('manjunath bettadapura', 'manjunath', 'dumma'),
       reverse('manjunath'),
       split_part('/man/jun/ath', '/', 3);

-- Demonstrating aggregation with string concatenation and filtering
SELECT string_agg(categoryname, ','),
       string_agg(categoryname, ',' order by categoryname desc),
       string_agg(categoryname, ',') filter(where categoryname like '%s')
FROM categories;

SELECT state,
       string_agg(distinct age::text, ',' order by age::text asc) filter(where mod(age, 2) = 0 and age < 30),
       string_agg(distinct age::text, ',' order by age::text asc) filter(where mod(age, 2) = 1 and age > 80)
FROM customers
WHERE state like '_N%'
GROUP BY 1
ORDER BY 1
LIMIT 4;

-- Demonstrating date and time construction functions
SELECT make_date(2024, 04, 01),
       make_time(1, 2, 3.45),
       make_timestamp(2024, 04, 01, 1, 2, 3.45);

-- Demonstrating extraction of date parts and intervals
SELECT extract(day from current_timestamp),
       date_part('day', current_timestamp),
       date_part('year', current_date),
       extract(century from interval '200 years, 10 months, 11 days');

-- Demonstrating overlap checks for date ranges and intervals
SELECT (date '2001-02-16', date '2001-12-21') overlaps (date '2001-10-30', date '2002-10-30'),
       (date '2001-02-16', interval '100 days') overlaps (date '2001-10-30', date '2002-10-30');

-- Demonstrating simple GROUP BY and LIMIT in aggregation
SELECT region, state, max(age)
FROM customers
GROUP BY region, state
LIMIT 5;

-- Demonstrating self-join with aggregation for finding maximum age
SELECT c.region, c.state, c.firstname, c.lastname, c.age
FROM customers c
JOIN (SELECT region, state, max(age) as max_age FROM customers GROUP BY region, state) s ON c.region = s.region AND c.state = s.state AND c.age = s.max_age
ORDER BY c.region, c.state
LIMIT 5;

--OVER() defines the set of rows to which the function will be applied
--PARTITION BY rows are partitiioned to form groups of rows
--ORDER BY in this context orders the rows within each partitiion, and this will impact the results
--RANK and DENSE_RANK help with ranking but 2 rows might share the same rank, and there maybe skipping
-- Demonstrating window function for calculating maximum age per region and state
SELECT c.region, c.state, c.firstname, c.lastname, c.age,
       max(age) over(partition by region, state) as max_age
FROM customers c
ORDER BY c.region, c.state
LIMIT 5;

-- Filtering results of a window function to show only rows matching the maximum age
SELECT s.region, s.state, s.firstname, s.lastname, s.age
FROM (SELECT c.region, c.state, c.firstname, c.lastname, c.age,
             max(age) over(partition by region, state) as max_age
      FROM customers c) s
WHERE s.age = s.max_age
ORDER BY s.region, s.state
LIMIT 5;

-- Demonstrating window functions for sum, min, avg, and max over partitions
SELECT orderid,
       prod_id,
       quantity,
       sum(quantity) over(partition by prod_id),
       min(quantity) over(partition by prod_id),
       avg(quantity) over(partition by prod_id),
       max(quantity) over(partition by prod_id)
FROM orderlines
LIMIT 5;

-- Demonstrating row numbering within partitions
SELECT state,
       lastname,
       firstname,
       row_number() over(partition by state order by lastname desc) as row_num
FROM customers
WHERE length(state) > 0
LIMIT 5;

-- Demonstrating EXISTS subquery for filtering
SELECT c.*
FROM customers c
WHERE EXISTS (SELECT * FROM orders o WHERE c.customerid = o.customerid);

-- Demonstrating IN subquery for filtering
SELECT c.*
FROM customers c
WHERE c.customerid IN (SELECT o.customerid FROM orders o);

-- Demonstrating join for distinct selection
SELECT DISTINCT c.*
FROM customers c
JOIN orders o ON o.customerid = c.customerid;

-- Demonstrating LEFT JOIN for finding customers without orders
SELECT c.*
FROM customers c
LEFT JOIN orders o ON c.customerid = o.customerid
WHERE o.customerid is null;

-- Retrieving database name from information schema
SELECT catalog_name as "Database Name"
FROM information_schema.information_schema_catalog_name;

-- Aggregating non-PostgreSQL schema names
SELECT string_agg(schema_name, ',') as "non-pgsql schemas"
FROM information_schema.schemata
WHERE schema_name not like 'pg%';

-- Aggregating table names in the public schema
SELECT string_agg(table_name, ',') 
FROM information_schema.tables
WHERE table_schema = 'public';

-- Listing views in the information_schema
SELECT table_name as "information_schema views"
FROM information_schema.views
WHERE table_schema = 'information_schema';

-- Querying column metadata for a specific table
SELECT * FROM information_schema.columns
WHERE table_name = 'orderlines';

-- Demonstrating various system information retrieval
SELECT current_catalog,
       current_database(),
       current_schema,
       current_user,
       session_user,
       version();
