/* Notes on SQL - Udacity Bertlesman Data Science Scholarship Program */

/* Lesson 28.16 - Quiz: LIMIT*/
SELECT	occurred_at,
		account_id,
        channel
FROM web_events
LIMIT 15;
/* LIMIT statement will limit the number of rows showed on the output */

/* Lesson 28.18 - Quiz: ORDER BY*/
/* Question 1 - Write a query to return the 10 earliest orders in the orders 
table. Include the id, occurred_at, and total_amt_usd.
*/
SELECT	id,
		occurred_at,
        total_amt_usd
FROM orders
ORDER BY occurred_at DESC
LIMIT 10;

/* Question 2 - Write a query to return the top 5 orders in terms of 
largest total_amt_usd. Include the id, account_id, and total_amt_usd.
*/
SELECT	id,
		account_id,
        total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC
LIMIT 5;

/* Question 3 - Write a query to return the bottom 20 orders in terms of 
least total. Include the id, account_id, and total.
*/
SELECT	id,
		account_id,
        total
FROM orders
ORDER BY total ASC /* ASC is the default value */
LIMIT 20;

/* Lesson 28.21 - Quiz: ORDER BY Part II */
/* Question 1 - Write a query that returns the top 5 rows from orders ordered 
according to newest to oldest, but with the largest total_amt_usd for each 
date listed first for each date. You will notice each of these dates shows up 
as unique because of the time element. When you learn about truncating dates 
in a later lesson, you will better be able to tackle this question on a day, 
month, or yearly basis.
*/
SELECT	id,
		occurred_at,
		total_amt_usd
FROM orders
ORDER BY occurred_at DESC, total_amt_usd DESC
LIMIT 5;
/* Output:
id	occurred_at	total_amt_usd
6451	2017-01-02T00:02:40.000Z	6451.76
3546	2017-01-01T23:50:16.000Z	1932.85
6454	2017-01-01T22:29:50.000Z	1854.57
3554	2017-01-01T22:17:26.000Z	2666.79
6556	2017-01-01T21:04:25.000Z	892.85
*/

/* Question 2 - Write a query that returns the top 10 rows from orders 
ordered according to oldest to newest, but with the smallest total_amt_usd for 
each date listed first for each date. You will notice each of these dates 
shows up as unique because of the time element. When you learn about 
truncating dates in a later lesson, you will better be able to tackle this 
question on a day, month, or yearly basis.
*/
SELECT	id,
		occurred_at,
		total_amt_usd
FROM orders
ORDER BY occurred_at, total_amt_usd
LIMIT 10;
/* Output:
id	occurred_at	total_amt_usd
5786	2013-12-04T04:22:44.000Z	627.48
2415	2013-12-04T04:45:54.000Z	2646.77
4108	2013-12-04T04:53:25.000Z	2709.62
4489	2013-12-05T20:29:16.000Z	277.13
287	    2013-12-05T20:33:56.000Z	3001.85

/* Lesson 28.25 - Quiz: WHERE */
/* Question 1 - pull the first 5 rows and all columns from the orders 
table that have a dollar amount of gloss_amt_usd greater than or equal
to 1000.
*/
SELECT *
FROM orders
WHERE gloss_amt_usd >= 1000
LIMIT 5;

/* Question 2 - Pull the first 10 rows and all columns from the orders 
table that have a total_amt_usd less than 500.
*/
SELECT *
FROM orders
WHERE total_amt_usd < 500
LIMIT 10;

/* Lesson 28.28 - Quiz: WHERE with Non-Numeric values */

/* We can use comparison operators (=,<,>,<=,>=,!=)in SQL with non-numerical 
data, but we need to use single quotes on the value */

/* Question 1 - Filter the accounts table to include the company name, 
website, and the primary point of contact (primary_poc) for Exxon Mobil 
in the accounts table
*/
SELECT  name,
        website,
        primary_poc
FROM accounts 
WHERE name = 'Exxon Mobil';

/* Lesson 28.31 - Quiz: Arithmetic Operators */

/* DERIVED COLUMN is a new column that is a manipulation of the existing
columns in your database */

/* As we saw with the COMPARISON OPERATORS, we can do the same with the 
ARITHMETIC OPERATORS, using them with non-numeric values */

/* Question 1 - Create a column that divides the standard_amt_usd by the 
standard_qty to find the unit price for standard paper for each order. 
Limit the results to the first 10 orders, and include the id and account_id 
fields. 
*/
SELECT  id,
        account_id,
        standard_amt_usd / standard_qty AS paper_unit_price
FROM orders
LIMIT 10;

/* Question 2 - Write a query that finds the percentage of revenue that comes 
from poster paper for each order. You will need to use only the columns that
end with _usd. (Try to do this without using the total column). Include the id 
and account_id fields. NOTE - you will be thrown an error with the correct 
solution to this question. This is for a division by zero. You will learn 
how to get a solution without an error to this query when you learn about
CASE statements in a later section. For now, you might just add some very 
small value to your denominator as a work around. 
*/
SELECT  id,
        account_id,
        total_amt_usd,
        total,
        total_amt_usd / (total + 0.001) as percentage_of_revenue
FROM orders;

/* LOGICAL OPERATORS (LIKE, IN, NOT, AND, BETWEEN, OR)

/* Lesson 28.35 - Quiz: LIKE*/

/* Use the accounts table to find: */
/* Question 1 - All the companies whose names start with 'C'. */
SELECT	name
FROM accounts
WHERE name LIKE 'C%';

/* Question 2 - All companies whose names contain the string 'one' 
somewhere in the name. */
SELECT	name
FROM accounts
WHERE name LIKE '%one%';

/* Question 3 - All companies whose names end with 's'. */
SELECT	name
FROM accounts
WHERE name LIKE '%s';

/* Lesson 28.38 - Quiz: IN*/

/* Question 1 - Use the accounts table to find the account name, primary_poc, 
and sales_rep_id for Walmart, Target, and Nordstrom.*/
SELECT	name,
		primary_poc,
        sales_rep_id
FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstrom');

/* Question 2 - Use the web_events table to find all information regarding 
individuals who were contacted via the channel of organic or adwords. */
SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords');

/* Lesson 28.41 - Quiz: NOT */

/*  By specifying NOT LIKE or NOT IN, we can grab all of the rows that 
do not meet a particular criteria */

/* Question 1 - Use the accounts table to find the account name, 
primary poc, and sales rep id for all stores except Walmart, Target, 
and Nordstrom.
*/
SELECT	name,
		primary_poc,
        sales_rep_id
FROM accounts
WHERE name NOT IN ('Walmart', 'Target', 'Nordstrom');

/* Question 2 - Use the web_events table to find all information 
regarding individuals who were contacted via any method except using 
organic or adwords methods.*/
SELECT *
FROM web_events
WHERE channel NOT IN ('organic', 'adwords');

/* Question 3 - Use the accounts table to find All the companies whose 
names do not start with 'C'.*/
SELECT name
FROM accounts
WHERE name NOT LIKE ('C%');

/* Question 4 - Use the accounts table to find All companies whose names 
do not contain the string 'one' somewhere in the name. */
SELECT name
FROM accounts
WHERE name NOT LIKE ('%one%');

/* Question 5 - Use the accounts table to find All companies whose names
do not end with 's'. */
SELECT name
FROM accounts
WHERE name NOT LIKE ('%s');

/* Lesson 28.44 - Quiz: AND and BETWEEN */
/* AND operator
e.g:*/
WHERE column >= 6 AND column <= 10 /* every time we use AND we need to specify
the name of the object we are referring to, in this case column will be 
stated two times */

/* BETWEEN operator
e.g: */
WHERE column BETWEEN 6 AND 10

/* Question 1 - Write a query that returns all the orders where the 
standard_qty is over 1000, the poster_qty is 0, and the gloss_qty is 0.*/
SELECT	id
		standard_qty,
        poster_qty,
        gloss_qty 
FROM orders
WHERE	standard_qty > 100 AND
		poster_qty = 0 AND
        gloss_qty = 0
ORDER BY standard_qty DESC; /*we used ORDER BY DESC here just to double check*/

/* Question 2 - Using the accounts table find all the companies whose names 
do not start with 'C' and end with 's'.*/
SELECT	name
FROM accounts
WHERE	name NOT LIKE ('C%') AND
		name LIKE ('%s');

/* Question 3 - Use the web_events table to find all information regarding 
individuals who were contacted via organic or adwords and started their 
account at any point in 2016 sorted from newest to oldest.*/
SELECT	*
FROM web_events
WHERE   channel IN ('organic', 'adwords') AND
        occurred_at BETWEEN '2016-01-01' AND '2017-01-01'
        /* We cannot write a statement like this >occurred_at LIKE ('%2016%')
        because the data type timezone cannot be read by this operator */
        /* You will notice that using BETWEEN is tricky for dates! While 
        BETWEEN is generally inclusive of endpoints, it assumes the time is 
        at 00:00:00 (i.e. midnight) for dates. This is the reason why we set
        the right-side endpoint of the period at '2017-01-01'.*/        
ORDER BY occurred_at DESC;

/* Lesson 28.46 - Quiz: OR */

/* When combining multiple of these operations, we frequently might need to
use parentheses to assure that logic we want to perform is being executed 
correctly. Below is one example of one of these situations: */
SELECT *
FROM demo.orders
WHERE   (standard_qty = 0 OR gloss_qty = 0 OR poster_qty =0) AND
        occurred_at >= '2016-10-01';
/* On the WHERE clause we used the OR statements inside parentheses, so if
one of the conditions are met, the whole parentheses will be TRUE and the
rows that met the AND condition will be filtered */

/* Question 1 - Find list of orders ids where either gloss_qty or poster_qty
is greater than 4000. Only include the id field in the resulting table. */
SELECT id
FROM orders
WHERE	gloss_qty > 4000 OR
		poster_qty > 4000;

/* Question 2 - Write a query that returns a list of orders where the 
standard_qty is zero and either the gloss_qty or poster_qty is over 1000.*/    
SELECT *
FROM orders
WHERE   standard_qty = 0 AND 
        (gloss_qty > 1000 OR poster_qty > 1000);        

/* Question 3 - Find all the company names that start with a 'C' or 'W', 
and the primary contact contains 'ana' or 'Ana', but it doesn't contain 
'eana'.*/
SELECT *
FROM accounts
WHERE   (name LIKE 'C%' OR name LIKE 'W%') AND 
        ((primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%') AND 
        primary_poc NOT LIKE '%eana%');

/* Lesson 29.2 - Why would we want to split data into separate tables ? */

/* There are essentially three ideas that are aimed at database 
normalization:
1.Are the tables storing logical groupings of the data?
2.Can I make changes in a single location, rather than in many tables 
for the same information?
3.Can I access and manipulate data quickly and efficiently?
*/

/* Access this link to find more information about data base 
normalization */
/* http://www.itprotoday.com/microsoft-sql-server/sql-design-why-you-need-database-normalization */

/* Lesson 29.4 - Quiz: JOINs */

/* Question 1 - Try pulling all the data from the accounts table, 
and all the data from the orders table.*/
SELECT *
FROM orders
JOIN accounts
ON orders.account_id = accounts.id; /* will merge the 'account_id' 
column from 'orders' table with 'id' column from 'accounts' table*/

/* Question 2 - Try pulling standard_qty, gloss_qty, and poster_qty 
from the orders table, and the website and the primary_poc from the 
accounts table.*/
SELECT	orders.standard_qty,
		orders.gloss_qty,
        orders.poster_qty,
        accounts.website,
        accounts.primary_poc
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;

/* Lesson 29.10 - Video: Alias */

/* Pro Tip: the alias for a table will be created on the FROM 
or JOIN clauses like the example below: */

/* This query below ... */
SELECT  orders.*,
        accounts.*
FROM orders
JOIN accounts
ON orders.account_id = accounts.id

/* ... can be written using aliases (a and o) for the 
table names... */
SELECT  o.*,
        a.*
FROM orders o
JOIN accounts a
ON o.account_id = a.id

/* ...or aliases like these below */
SELECT  t1.*, /* we can even rename the columns names using AS */
        t2.*
FROM orders AS t1
JOIN accounts AS t2
ON t1.account_id = t2.id

/* Lesson 29.11- Quiz: JOIN Questions Part 1 */

/* Question 1 - Provide a table for all web_events associated 
with account name of Walmart. There should be three columns. 
Be sure to include the primary_poc, time of the event, and 
the channel for each event. Additionally, you might choose
to add a fourth column to assure only Walmart events were
chosen. */

SELECT  a.primary_poc,
        w.occurred_at,
        w.channel,
        a.name
FROM accounts a 
JOIN web_events w
ON w.account_id = a.id
WHERE a.name = 'Walmart'

/* Question 2 - Provide a table that provides the region for 
each sales_rep along with their associated accounts. Your 
final table should include three columns: the region name, 
the sales rep name, and the account name. Sort the accounts 
alphabetically (A-Z) according to account name. */

SELECT  r.name AS "region name",
        s.name AS "sales rep name",
        a.name AS "account name"
FROM accounts a
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
ORDER BY a.name

/* Question 3 - Provide the name for each region 
for every order, as well as the account name and the
unit price they paid (total_amt_usd/total) for the order.
Your final table should have 3 columns: region name, account 
name, and unit price. A few accounts have 0 for total, so I 
divided by (total + 0.01)to assure not dividing by zero.*/

SELECT  r.name AS "region name",
        a.name AS "account name",
        (o.total_amt_usd / (o.total + 0.0001)) AS "unit price"
FROM accounts a
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id 
JOIN orders o
ON a.id = o.account_id

/* Lesson 29.14 - LEFT and RIGHT JOINs*/

/* LEFT JOIN */

/* LEFT JOIN will take all the columns from LEFT table
and the columns from LEFT table that intersects with
RIGHT table */
SELECT 
FROM left table /* the left table name will go aways on
the FROM statement */
LEFT JOIN right table /* the right table name will go
aways on the JOIN statement */  

/* RIGHT JOIN */

/* It is the opposite that LEFT JOIN does */
SELECT 
FROM left table
RIGHT JOIN right table 

/* Lesson 29.18 - Video: JOINs and Filtering */

/* PRO TIPS: */

/* Logic in the ON clause reduces the rows
before combining the tables */
/* Logic in the WHERE clause occurs after the 
JOIN occurs, see the example below: */

/*  Query used previously to filter Walmart 
rows only... */
SELECT  a.primary_poc,
        w.occurred_at,
        w.channel,
        a.name
FROM accounts a 
JOIN web_events w
ON w.account_id = a.id
WHERE a.name = 'Walmart'

/* ... now we changed the query so we filter
Walmart rows before the JOIN is done. */
SELECT  a.primary_poc,
        w.occurred_at,
        w.channel,
        a.name
FROM accounts a 
JOIN web_events w
ON w.account_id = a.id
AND a.name = 'Walmart'

/* Good tip for making the query run faster
the INNER JOIN */

/* Using this TIP wth LEFT JOIN and RIGHT JOIN
will be useful with DATA AGREGATION */

/* Lesson 29.19 - Quiz: Last check */

/* Question 1 - Provide a table that provides the 
region for each sales_rep along with their associated
accounts. This time only for the Midwest region. 
Your final table should include three columns: 
the region name, the sales rep name, and the account
name. Sort the accounts alphabetically (A-Z) 
according to account name. */
SELECT  r.name AS region_name,
        s.name AS sales_rep_name,
        a.name AS account_name
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON s.region_id = r.id
AND r.name = 'Midwest' /* We could use
WHERE r.name = 'Midwest' here as well */
ORDER BY a.name;

/* Question 2 - Provide a table that provides the 
region for each sales_rep along with their associated
accounts. This time only for accounts where the 
sales rep has a first name starting with S and 
in the Midwest region. Your final table should 
include three columns: the region name, the sales
rep name, and the account name. Sort the accounts
alphabetically (A-Z) according to account name. 
*/
SELECT  r.name AS region_name,
        s.name AS sales_rep_name,
        a.name AS account_name
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON s.region_id = r.id
AND s.name LIKE ('S%')
AND r.name = 'Midwest'
ORDER BY a.name;

/* Question 3 - Provide a table that provides the region
for each sales_rep along with their associated accounts. 
This time only for accounts where the sales rep has a 
last name starting with K and in the Midwest region. 
Your final table should include three columns: the 
region name, the sales rep name, and the account name. 
Sort the accounts alphabetically (A-Z) according to 
account name. */
SELECT  r.name AS region_name,
        s.name AS sales_rep_name,
        a.name AS account_name
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON s.region_id = r.id
AND s.name LIKE ('% K%') /* here we put a space to only
catch the K on the last name */
AND r.name = 'Midwest'
ORDER BY a.name;

/* Question 4 - Provide the name for each region 
for every order, as well as the account name and
the unit price they paid (total_amt_usd/total) 
for the order. However, you should only provide 
the results if the standard order quantity exceeds 100. 
Your final table should have 3 columns: region name, 
account name, and unit price. In order to avoid a 
division by zero error, adding .01 to the denominator 
here is helpful total_amt_usd/(total+0.01). */
SELECT  r.name AS region_name,
        a.name AS account_name,
        o.total_amt_usd / (o.total + 0.001) AS unit_price
FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
AND o.standard_qty > 100;

/* This query below produces the same result:
The only difference here is that the AND clause
is next to its table */ 

SELECT  r.name AS region_name, 
        a.name AS account_name,
        o.total_amt_usd/(o.total + 0.01) AS unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
AND o.standard_qty > 100;

/* Question 5 - Provide the name for each region for every 
order, as well as the account name and the unit price they 
paid (total_amt_usd/total) for the order. However, you 
should only provide the results if the standard order 
quantity exceeds 100 and the poster order quantity exceeds
50. Your final table should have 3 columns: region name, 
account name, and unit price. Sort for the smallest unit 
price first. In order to avoid a division by zero error, 
adding .01 to the denominator here is helpful 
total_amt_usd/(total+0.01). */
SELECT  r.name AS region, 
        a.name AS account, 
        o.total_amt_usd/(o.total + 0.01) AS unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100 
AND o.poster_qty > 50
ORDER BY unit_price;

/* Question 6 - Provide the name for each region for 
every order, as well as the account name and the unit 
price they paid (total_amt_usd/total) for the order. 
However, you should only provide the results if the 
standard order quantity exceeds 100 and the poster 
order quantity exceeds 50. Your final table should 
have 3 columns: region name, account name, and unit 
price. Sort for the largest unit price first. In 
order to avoid a division by zero error, adding 
.01 to the denominator here is helpful 
(total_amt_usd/(total+0.01). */
SELECT  r.name AS region, 
        a.name AS account, 
        o.total_amt_usd/(o.total + 0.01) AS unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100 
AND o.poster_qty > 50
ORDER BY unit_price DESC;

/* Question 7 - What are the different channels used 
by account id 1001? Your final table should have only 
2 columns: account name and the different channels. 
You can try SELECT DISTINCT to narrow down the 
results to only the unique values. */

SELECT DISTINCT a.name AS account_name,
                w.channel AS channel
/* DISTINCT is used to narrow down the results to 
only the unique values */
FROM accounts a
JOIN web_events w
ON w.account_id = a.id
AND a.id = '1001';

/* Question 8 - Find all the orders that occurred in 
2015. Your final table should have 4 columns: 
occurred_at, account name, order total, and 
order total_amt_usd. */
SELECT  o.occurred_at, 
        a.name, 
        o.total, 
        o.total_amt_usd
FROM accounts a 
JOIN orders o 
ON o.account_id = a.id
AND o.occurred_at BETWEEN '01-01-2015' AND '01-01-2016'
/* always follow this order >>> MM-DD-YYYY */
ORDER BY o.occurred_at DESC;

/* Lesson 30.3 - NULLs and Aggregations  */

/* Expert TIP: */

/* There are two common ways in which you are 
likely to encounter NULLs:

/* NULLs frequently occur when performing a 
LEFT or RIGHT JOIN. You saw in the last lesson 
- when some rows in the left table of a left join
are not matched with rows in the right table, 
those rows will contain some NULL values in the
result set. */

/* NULLs can also occur from simply missing data 
in our database. */

/* Lesson 30.5 - COUNT & NULLs  */

/* PRO TIP: */

/* COUNT can help us identify the number of null
values in any particular column */

/* If the COUNT result of a column is LESS than the
number of rows in the table, we know the difference is
the number of NULLs */

/* COUNT function can be used on any column in 
a table */

/* lesson 30.7 - Quiz: SUM */

/* Question 1 - Find the total amount of poster_qty 
paper ordered in the orders table.*/
SELECT SUM(poster_qty) AS "Poster Total Sales"
FROM orders;

/* Question 2 - Find the total amount of standard_qty
paper ordered in the orders table. */
SELECT SUM(standard_qty) AS "Standard Total Sales"
FROM orders;

/* Question 3 - Find the total dollar amount of sales
using the total_amt_usd in the orders table. */
SELECT SUM(total_amt_usd) AS "Total Dollar Amount"
FROM orders;

/* Question 4 - Find the total amount spent on 
standard_amt_usd and gloss_amt_usd paper for 
each order in the orders table. This should 
give a dollar amount for each order in the 
table. */
SELECT standard_amt_usd + gloss_amt_usd AS total_standard_gloss
FROM orders;

/* Question 5 - Find the standard_amt_usd per unit of 
standard_qty paper. Your solution should use both an 
aggregation and a mathematical operator. */
SELECT SUM(standard_amt_usd) / SUM(standard_qty) AS std_price_per_unit
FROM orders;

/* Lesson 30.9 - Video: MIN & MAX */

/* PRO TIP: */
/* Functionally, MIN and MAX are similar to 
COUNT in that they can be used on non-numerical 
columns. Depending on the column type, MIN will 
return the lowest number, earliest date, or 
non-numerical value as early in the alphabet 
as possible. As you might suspect, MAX does 
the opposite—it returns the highest number, 
the latest date, or the non-numerical value 
closest alphabetically to “Z.” */

/* Lesson 30.11 - Quiz: MIN, MAX & AVG */

/* Question 1 - When was the earliest order ever
placed? You only need to return the date. */
SELECT MIN(occurred_at) 
FROM orders;
 
/* Question 2 -  Try performing the same query 
as in question 1 without using an aggregation 
function. */
SELECT occurred_at 
FROM orders
ORDER BY occurred_at ASC
LIMIT 1;

/* Question 3 - When did the most recent 
(latest) web_event occur? */
SELECT MAX(occurred_at)
FROM web_events;

/* Question 4 -  Try performing the same query 
as in question 1 without using an aggregation 
function. */
SELECT occurred_at 
FROM web_events
ORDER BY occurred_at DESC
LIMIT 1;

/* Question 5 - Find the mean (AVERAGE) 
amount spent per order on each paper type, as
well as the mean amount of each paper type 
purchased per order. Your final answer should
have 6 values - one for each paper type for the
average number of sales, as well as the average amount. */
SELECT  AVG(standard_qty) mean_standard, 
        AVG(gloss_qty) mean_gloss, 
        AVG(poster_qty) mean_poster, 
        AVG(standard_amt_usd) mean_standard_usd, 
        AVG(gloss_amt_usd) mean_gloss_usd,
        AVG(poster_amt_usd) mean_poster_usd
FROM orders;

/* Question 6 - Via the video, you might be interested
in how to calculate the MEDIAN. Though this is more 
advanced than what we have covered so far try finding
- what is the MEDIAN total_usd spent on all orders? */
/* Here is the default syntax from SQL Server (Windows) */
SELECT  PERCENTILE_CONT(0.5) 
        WITHIN GROUP (ORDER BY total_amt_usd)
        AS median_total_amt_usd_per_order
FROM orders;

/* Here is the resolution for the question from Udacity */
SELECT *
FROM (SELECT total_amt_usd
      FROM orders
      ORDER BY total_amt_usd
      LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;

/* Here there is another way for the answer, the fastest 
so far I know:
https://sqlperformance.com/2012/08/t-sql-queries/median */

/* Lesson 30.13 - Video: GROUP BY */

/* PRO TIP: */

/* GROUP BY clause goes in-between the WHERE and 
ORDER clause*/ 

/* Before we dive deeper into aggregations using 
GROUP BY statements, it is worth noting that SQL 
evaluates the aggregations before the LIMIT clause.
If you don’t group by any columns, you’ll get a 
1-row result—no problem there. If you group by a
column with enough unique values that it exceeds 
the LIMIT number, the aggregates will be calculated,
and then some rows will simply be omitted from 
the results. */

/* Lesson 30.14 - Quiz: GROUP BY */

/* Question 1 - Which account (by name) placed the 
earliest order? Your solution should have the 
account name and the date of the order. */
SELECT  a.name,
        o.occurred_at
FROM accounts a
JOIN orders o
ON o.account_id = a.id
ORDER BY o.occurred_at
LIMIT 1;

/* Question 2 - Find the total sales in usd for each 
account. You should include two columns - the total 
sales for each company's orders in usd and the 
company name */
SELECT  a.name,
        SUM(o.total_amt_usd) AS total_sales
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY a.name;

/* Question 3 - Via what channel did the most recent 
(latest) web_event occur, which account was associated 
with this web_event? Your query should return only three 
values - the date, channel, and account name. */
SELECT  w.channel,
        a.name,
        w.occurred_at
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
ORDER BY w.occurred_at DESC
LIMIT 1;

/* Question 4 - Find the total number of times each type
of channel from the web_events was used. Your final table
should have two columns - the channel and the number of 
times the channel was used. */
SELECT  w.channel,
        COUNT(w.id) AS "Number of times used" /* we could
        use the clause COUNT(*) as well */
FROM web_events w
GROUP BY w.channel
ORDER BY COUNT(w.id) DESC;

/* Question 5 - Who was the primary contact associated 
with the earliest web_event? */
SELECT  a.primary_poc,
FROM accounts a
JOIN web_events w
ON w.account_id = a.id
ORDER BY w.occurred_at ASC
LIMIT 1;

/* Question 6 - What was the smallest order placed by each
account in terms of total usd. Provide only two columns - 
the account name and the total usd. Order from smallest 
dollar amounts to largest. */
SELECT  a.name,
        MIN(o.total_amt_usd) AS smallest_order
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY a.name
ORDER BY SUM(o.total_amt_usd) ASC;

/* Question 7 - Find the number of sales reps in each region.
Your final table should have two columns - the region and the 
number of sales_reps. Order from fewest reps to most reps. */
SELECT  r.name AS "Region name",
        COUNT(s.id) AS "Number of sales reps"
        /* we could use the clause COUNT(*) here as well*/
FROM sales_reps s
JOIN region r
ON s.region_id = r.id 
GROUP BY r.name; 

/* Lesson 30.17 - Quiz: GROUP BY Part II*/

/* Question 1 - For each account, determine the average amount 
of each type of paper they purchased across their orders. 
Your result should have four columns - one for the account 
name and one for the average quantity purchased for each of 
the paper types for each account. */
SELECT  a.name,
        AVG(o.standard_qty) AS avg_stand_qty,
        AVG(o.poster_qty) AS avg_poster_qty,
        AVG(o.gloss_qty) AS avg_gloss_qty
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY a.name;

/* Question 2 - For each account, determine the average amount
spent per order on each paper type. Your result should have 
four columns - one for the account name and one for the 
average amount spent on each paper type. */
SELECT  a.name,
        AVG(o.standard_amt_usd) AS avg_stand_usd,
        AVG(o.poster_amt_usd) AS avg_poster_usd,
        AVG(o.gloss_amt_usd) AS avg_gloss_usd
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY a.name;

/* Question 3 - Determine the number of times a particular 
channel was used in the web_events table for each sales rep. 
Your final table should have three columns - the name of 
the sales rep, the channel, and the number of occurrences. 
Order your table with the highest number of occurrences 
first.*/

SELECT  s.name,
        w.channel,
        COUNT(w.channel) AS number_of_events     
FROM web_events w
JOIN accounts a  
ON w.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
GROUP BY w.channel, s.name
ORDER BY COUNT(w.channel) DESC;
/* we could use (number_of_events) on
the ORDER BY clause as well */

/* Question 4 - Determine the number of times a particular 
channel was used in the web_events table for each region. 
Your final table should have three columns - the region 
name, the channel, and the number of occurrences. 
Order your table with the highest number of occurrences 
first. */
SELECT  r.name,
        w.channel,
        COUNT(w.channel) AS number_of_events
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
GROUP BY r.name, w.channel
ORDER BY number_of_events DESC;

/* Lesson 30.19 - Video: DISTINCT */

/* DISTINCT is used only once in a SELECT statement
to provide the unique rows for all columns written 
in the SELECT statement. Using DISTINCT we replace
the GROUP BY */

/* PRO TIP */
/* It’s worth noting that using DISTINCT, particularly
in aggregations, can slow your queries down quite a bit. 
*/

/* Lesson 30.20 - Quiz: DISTINCT */

/* Question 1 - Use DISTINCT to test if there are any 
accounts associated with more than one region. */
SELECT  a.id as "account id",
        r.id as "region id", 
        a.name as "account name", 
        r.name as "region name"
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id;

/* The output of this QUERY is 351 rows, then we compare
with the output of this QUERY below:*/

SELECT DISTINCT id, name
FROM accounts;

/* It will pull all rows on the id and name columns from the 
accounts table, the output is 351 rows. So there is no
account row associated with more than one region. 
If each account was associated with more than one region,
the first query should have returned more rows than the 
second query.*/

/* Question 2 - Have any sales reps worked on more than 
one account? */
SELECT  s.id, 
        s.name, 
        COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
ORDER BY num_accounts;

/* The output of this QUERY is 50 rows, then we compare
with the output of this QUERY below:*/

SELECT DISTINCT id, name
FROM sales_reps;

/* It will pull all rows on the id and name columns from the 
sales_reps table, the output is 50 rows.  */

/* Actually all of the sales reps have worked on more than 
one account. The fewest number of accounts any sales rep works
on is 3. There are 50 sales reps, and they all have more than
one account. Using DISTINCT in the second query assures that
all of the sales reps are accounted for in the first query.
*/

/* Lesson 30.22 - Video: HAVING */

/* HAVING is the “clean” way to filter a query that has 
been aggregated, but this is also commonly done using a 
subquery. */

/* Essentially, any time you want to perform a WHERE on 
an element of your query that was created by an aggregate,
you need to use HAVING instead. */

/* It is only useful when grouping one or more columns */

/* On the example below, we are trying to filter the rows of
account_id in which the sum of total_amt_usd is greater than 
250000 */
SELECT  account_id,
        SUM(total_amt_usd) AS sum_total_amt_usd
FROM orders
WHERE SUM(total_amt_usd) >= 250000
GROUP BY 1 /* refers to first column on SELECT */
ORDER BY  2 /* refers to second column on SELECT */

/* This QUERY returns the ERROR below: */
/* aggregate functions are not allowed in WHERE */

/* As the ERROR said, we cannot use WHERE clause to filter
aggregated functions on the SELECT statement, so either we
use a subquery, or we use HAVING, as below: */
SELECT  account_id,
        SUM(total_amt_usd) AS sum_total_amt_usd
FROM orders
GROUP BY 1 /* refers to first column on SELECT */
HAVING SUM(total_amt_usd) >= 250000
ORDER BY  2; 
/* HAVING appears after the GROUP BY clause but before the 
ORDER BY clause */

/* Lesson 30.23 - Quiz: HAVING */

/* Question 1 - How many of the sales reps have more 
than 5 accounts that they manage? */
SELECT  s.id, 
        s.name, 
        COUNT(*) AS num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
HAVING COUNT(*) > 5
ORDER BY num_accounts;

/* we can get the same result using this SUBQUERY
below. The same logic can be used to the others */
SELECT COUNT(*) num_reps_above5
FROM(SELECT s.id, s.name, COUNT(*) num_accounts
     FROM accounts a
     JOIN sales_reps s
     ON s.id = a.sales_rep_id
     GROUP BY s.id, s.name
     HAVING COUNT(*) > 5
     ORDER BY num_accounts
     ) AS Table1;

/* Question 2 - How many accounts have more than 
20 orders? */
SELECT  a.id, 
        a.name,
        COUNT(*) AS number_of_orders
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY a.id, a.name 
HAVING COUNT(*) > 20
ORDER BY number_of_orders;

/* Question 3 - Which account has the most 
orders? */
SELECT  a.id,
        a.name,
        COUNT(*) AS number_of_orders
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY a.id, a.name 
ORDER BY number_of_orders DESC
LIMIT 1;

/* Question 4 - How many accounts spent more
than 30,000 usd total across all orders? */
SELECT COUNT(*) AS "Number of accounts with 
orders greater than 30.000 USD" 
FROM (SELECT    SUM(o.total_amt_usd),
                a.id
      FROM accounts a
      JOIN orders o
      ON o.account_id = a.id
      GROUP BY a.id
      HAVING SUM(o.total_amt_usd) > 30000
    ) AS table1;

/* On this example I just met thoroughly the
answer of the question, which is get the number of
accounts with orders greater than 30K */ 

/* The output is going to be the following:
accounts_with_above_30k_usd
204
*/

/* Question 5 - How many accounts spent less than 
1,000 usd total across all orders? */
SELECT  a.id,
        a.name,
        SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY a.id, a.name
HAVING SUM(o.total_amt_usd) < 1000
ORDER BY total_spent ASC;

/* Question 6 - Which account has spent the 
most with us? */
SELECT  a.id,
        a.name,
        SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY a.id, a.name
ORDER BY total_spent DESC
LIMIT 1;

/* Question 7 - Which account has spent the 
least with us? */
SELECT  a.id,
        a.name,
        SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY a.id, a.name
ORDER BY total_spent ASC
LIMIT 1;

/* Question 8 - Which accounts used facebook 
as a channel to contact customers more than 
6 times? */
SELECT  a.id, 
        a.name, 
        w.channel, 
        COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
AND w.channel IN ('facebook')
GROUP BY a.id, a.name, w.channel
HAVING COUNT(w.id) > 6
ORDER BY use_of_channel;

/* or we can use the QUERY below to give the
same result */
SELECT  a.id, 
        a.name, 
        w.channel, 
        COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
HAVING COUNT(*) > 6 AND w.channel = 'facebook'
ORDER BY use_of_channel;

/* Question 9 - Which account used facebook
most as a channel? */
SELECT  a.id, 
        a.name, 
        w.channel, 
        COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
HAVING COUNT(*) > 6 AND w.channel = 'facebook'
ORDER BY use_of_channel DESC
LIMIT 1;

/* Question 10 - Which channel was most frequently
used by most accounts? */
SELECT  a.id,
        a.name,
        w.channel, 
        COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
ORDER BY use_of_channel DESC
LIMIT 1;

/* Lesson 30.26 - Video: DATE Functions II */

/* DATE_TRUNC function */

/* allows you to truncate your date to a particular 
part of your date-time column. */

/* https://blog.modeanalytics.com/date-trunc-sql-timestamp-function-count-on/
*/

/* DATE_PART function */

/* can be useful for pulling a specific portion of a date, 
but notice pulling month or day of the week (dow) means 
that you are no longer keeping the years in order. 
Rather you are grouping for certain components regardless
of which year they belonged in.*/

/* For information on all other functions related to DATE,
check the link below: */

/* https://www.postgresql.org/docs/9.1/static/functions-datetime.html
*/

/* Lesson 30.27 - Quiz: DATE Functions */

/* Question 1 - Find the sales in terms of total dollars
for all orders in each year, ordered from greatest to 
least. Do you notice any trends in the yearly sales 
totals? */

/* Using DATE_TRUNC function...*/
SELECT  DATE_TRUNC('year',o.occurred_at) AS year,
        SUM(o.total_amt_usd) AS year_total_sales
FROM orders o
GROUP BY 1
ORDER BY 2 DESC;

/* ... the output is: */
/*
year                        year_total_sales
2016-01-01T00:00:00.000Z	12864917.92
2015-01-01T00:00:00.000Z	5752004.94
2014-01-01T00:00:00.000Z	4069106.54
2013-01-01T00:00:00.000Z	377331.00
2017-01-01T00:00:00.000Z	78151.43
*/

/* Using DATE_PART function ... */
SELECT  DATE_PART('year',o.occurred_at) AS year,
        SUM(o.total_amt_usd) AS year_total_sales
FROM orders o
GROUP BY 1
ORDER BY 2 DESC;

/* ... the output is: */
/*
year	year_total_sales
2016	12864917.92
2015	5752004.94
2014	4069106.54
2013	377331.00
2017	78151.43
*/

/* Question 2 - Which month did Parch & Posey have
the greatest sales in terms of total dollars? Are 
all months evenly represented by the dataset? */

/* In order for this to be 'fair', we should remove 
the sales from 2013 and 2017 as they have only one 
month accountable for 2013 and one for 2017. */
SELECT  DATE_PART('month',o.occurred_at) AS ord_month,
        SUM(o.total_amt_usd) AS month_total_sales
FROM orders o
WHERE o.occurred_at BETWEEN '2014-01-01' AND '2017-01-01' 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1; 

/* Question 3 - Which year did Parch & Posey have the 
greatest sales in terms of total number of orders? 
Are all years evenly represented by the dataset? */
SELECT  DATE_PART('year',o.occurred_at) AS ord_year,
        COUNT(o.id) AS number_of_orders
FROM orders o
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

/* Question 4 - Which month did Parch & Posey have the 
greatest sales in terms of total number of orders? Are
all months evenly represented by the dataset? */

/* Here, again, we remove the single month from 2013
and 2017 */
SELECT  DATE_PART('month',o.occurred_at) AS ord_month,
        COUNT(o.id)
FROM orders o
WHERE o.occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

/* Question 4 - In which month of which year did 
Walmart spend the most on gloss paper in terms of
dollars? */

/* Using DATE_PART function ... */
/* Here is an example of what is explained on lines
1246 to 1250, when we use DATE_PART to */

SELECT  DATE_PART('year',o.occurred_at) AS ord_year,
        DATE_PART('month',o.occurred_at) AS ord_month,
        SUM(o.gloss_amt_usd) AS tot_spent
FROM orders o
JOIN accounts a
ON o.account_id = a.id
WHERE a.name = 'Walmart'
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 1;

/* OUTPUT: 
ord_year	ord_month	tot_spent
2016	        5	       9257.64
*/

/* ... using DATE_TRUNC function */

SELECT  DATE_TRUNC('month', o.occurred_at) ord_date, 
        SUM(o.gloss_amt_usd) tot_spent
FROM orders o 
JOIN accounts a
ON a.id = o.account_id
WHERE a.name = 'Walmart'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

/* OUTPUT: 
ord_date	                tot_spent
2016-05-01T00:00:00.000Z	9257.6456
*/

/* lesson 30.29 - Video: CASE Statements */

/* CASE is used on Derived columns (columns 
taken from existing data and modified  */

/* In previous Lessons we used arithmetic, now
we'll use CASE statement, that uses IF logic. */

/* It goes inside the SELECT statement and CASE 
must include the following components: WHEN, THEN,
and END. ELSE is an optional component to catch 
cases that didn’t meet any of the other previous 
CASE conditions. */

/* lesson 30.30 - Video: CASE & Aggregations */

/* Here is one example where is use CASE to 
create 2 columns with >500 and <500, and count 
the number of orders in each of those columns 
created. */
SELECT  CASE    WHEN total > 500 THEN 'Over 500'
                ELSE '500 or under' END AS total_group,
        COUNT(*) AS order_count
FROM orders
GROUP BY 1;

/* This is the advantage of using CASE against using
the GROUP BY clause with all these conditions, or maybe
using a lots of queries with WHERE clauses for the 
conditions), it would make the QUERY(IES) very long */

/* Lesson 30.31 - QUIZ: CASE */

/* Question 1 - We would like to understand 3 different
levels of customers based on the amount associated with 
their purchases. The top branch includes anyone with a 
Lifetime Value (total sales of all orders) greater than 
200,000 usd. The second branch is between 200,000 and 
100,000 usd. The lowest branch is anyone under 100,000 usd. 
Provide a table that includes the level associated with 
each account. You should provide the account name, the 
total sales of all orders for the customer, and the level. 
Order with the top spending customers listed first. */
SELECT  a.name,
        SUM(total_amt_usd) total_spent, 
        CASE    WHEN SUM(total_amt_usd) > 200000 THEN 'top'
                WHEN SUM(total_amt_usd) > 100000 THEN 'middle'
                ELSE 'low' END AS customer_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id 
GROUP BY a.name
ORDER BY 2 DESC;

/* Question 2 - We would now like to perform a similar 
calculation to the first, but we want to obtain the total
amount spent by customers only in 2016 and 2017. Keep 
the same levels as in the previous question. Order with 
the top spending customers listed first. */
SELECT  a.name,
        SUM(total_amt_usd) total_spent, 
        CASE    WHEN SUM(total_amt_usd) > 200000 THEN 'top'
                WHEN SUM(total_amt_usd) > 100000 THEN 'middle'
                ELSE 'low' END AS customer_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id 
AND o.occurred_at BETWEEN '2016-01-01' AND '2017-12-31'
/* we could have used WHERE here as well*/
GROUP BY a.name
ORDER BY 2 DESC;

/* Question 3 - We would like to identify top performing 
sales reps, which are sales reps associated with more 
than 200 orders. Create a table with the sales rep name,
the total number of orders, and a column with top or not
depending on if they have more than 200 orders. Place the
top sales people first in your final table. */
SELECT  s.name,
        COUNT(o.id) number_of_orders,
        /* could use COUNT(*) here as well */ 
        CASE    WHEN COUNT(o.id) > 200 THEN 'top'
                ELSE 'not top' END AS sales_rep_level
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o 
ON o.account_id = a.id
GROUP BY s.name
ORDER BY 2 DESC;

/* Question 4 - The previous didn't account for the 
middle, nor the dollar amount associated with the sales.
Management decides they want to see these characteristics
represented as well. We would like to identify top 
performing sales reps, which are sales reps associated
with more than 200 orders or more than 750000 in total
sales. The middle group has any rep with more than 150
orders or 500000 in sales. Create a table with the sales
rep name, the total number of orders, total sales across
all orders, and a column with top, middle, or low depending
on this criteria. Place the top sales people based on 
dollar amount of sales first in your final table. You
might see a few upset sales people by this criteria! */
SELECT  s.name,
        COUNT(o.id) number_of_orders,
        SUM(o.total_amt_usd) total_sales_usd,
        /* instead of COUNT(o.id), could use COUNT(*) here as well */ 
        CASE    WHEN COUNT(o.id) > 200 OR SUM(o.total_amt_usd) > 750000 THEN 'top'
                WHEN COUNT(o.id) > 150 OR SUM(o.total_amt_usd) > 500000THEN 'middle'
                ELSE 'low' END AS sales_rep_level
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o 
ON o.account_id = a.id
GROUP BY s.name
ORDER BY 3 DESC;

/* Lesson 31.3 - Video + Quiz: Your first subquery */

/* Quiz 1 - Find the number of events that occur 
for each day for each channel */
SELECT  DATE_TRUNC('day',occurred_at) AS day,
        channel, 
        COUNT(*) as events
FROM web_events
GROUP BY 1,2
ORDER BY 3 DESC;

/* Quiz 2 - Now create a subquery that simply provides
all the data from your list query. */
SELECT  *
FROM (SELECT    DATE_TRUNC('day',occurred_at) AS day,
                channel, 
                COUNT(*) as events
      FROM web_events 
      GROUP BY 1,2) sub
GROUP BY channel
ORDER BY 2 DESC;

/* Quiz 3 - Now find the avg number of events for each
channel. Since you broke out by day earlier, this is 
giving you an average per day. */
SELECT  channel, 
        AVG(events) AS avg_count_events
FROM (SELECT    DATE_TRUNC('day',occurred_at) AS day,
                channel, 
                COUNT(*) as events
      FROM web_events 
      GROUP BY 1,2) sub
GROUP BY channel
ORDER BY 2 DESC;

/* Lesson 31.6 - Video: More on Subqueries */

/* In the first subquery you wrote, you
created a table that you could then query again in the
FROM statement. However, if you are only returning a 
single value, you might use that value in a logical 
statement like WHERE, HAVING, or even SELECT - the 
value could be nested within a CASE statement. */

/* PRO TIP */

/* Note that you should not include an alias when 
ou write a subquery in a conditional statement. 
This is because the subquery is treated as an 
individual value (or set of values in the IN case)
rather than as a table. */

/* Also, notice the query here compared a single value.
If we returned an entire column IN would need to be 
used to perform a logical argument. If we are returning 
an entire table, then we must use an ALIAS for the table, 
and perform additional logic on the entire table. */

/* Lesson 31.7 - Quiz: MOre on Subqueries */

/* Quiz 1 - Use DATE_TRUNC to pull month level about
the first order ever placed in orders table */
SELECT DATE_TRUNC('month', MIN(occurred_at))
FROM orders 

/* Quiz 2 - Use the result of the previous query
to find only the orders that took place in the same
month and year as the first order, and then pull the
average for each type of paper qty in this month */
SELECT  DATE_TRUNC('month', occurred_at),
        AVG(standard_qty) AS avg_standard_qty,
        AVG(poster_qty) AS avg_poster_qty,
        AVG(gloss_qty) AS avg_gloss_qty,
        SUM(total_amt_usd) AS total_amt_usd
FROM orders         
WHERE DATE_TRUNC('month', occurred_at) =
    (SELECT DATE_TRUNC('month', MIN(occurred_at)) AS min_month
    FROM orders)
GROUP BY 1;

/* OUTPUT:
date_trunc  2013-12-01T00:00:00.000Z
avg_standard_qty    268.2222222222222222	
avg_poster_qty  111.8181818181818182
avg_gloss_qty   208.9494949494949495
total_amt_usd   377331.00
*/

/* Lesson 31.10 - Quiz: Subquery Mania */

/* The importance of Subqueries is that it allows 
your query to be dynamic in answering the question 
- even if the data changes, you still arrive at 
the right answer */

/* You should write your solution as a subquery 
or subqueries, not by finding one solution and 
copying the output.*/

/* Quiz 1 - Provide the name of the sales_rep 
in each region with the largest amount of 
total_amt_usd sales. */

/* 1.1 - First we will create the subquery that 
is getting the info we need - t1: */
SELECT  s.name rep_name, 
        r.name region_name, 
        SUM(o.total_amt_usd) total_amt
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
JOIN region r
ON r.id = s.region_id
GROUP BY 1, 2

/* Output of this query - 6 first rows:
rep_name	    region_name	total_amt
Akilah Drinkard	Northeast	136613.99
Arica Stoltzfus	West	    810353.34
Ayesha Monica	Northeast	217146.59
Babette Soukup	Southeast	215905.27
Brandie Riva	West	    675917.64
Calvin Ollison	Southeast	594516.08
*/

/* 1.2 - Then, from this subquery 't1', we will get 
the region_name and MAX of total_amt from t1,
this is going to be the t2 subquery. */  
SELECT  region_name, 
        MAX(total_amt) total_amt
FROM(SELECT     s.name rep_name, 
                r.name region_name, 
                SUM(o.total_amt_usd) total_amt
    FROM sales_reps s
    JOIN accounts a
    ON a.sales_rep_id = s.id
    JOIN orders o
    ON o.account_id = a.id
    JOIN region r
    ON r.id = s.region_id
    GROUP BY 1, 2) t1
GROUP BY 1

/* Output of this query:
region_name	    total_amt
Midwest	        675637.19
Southeast	    1098137.72
Northeast	    1010690.60
West	        886244.12

/* 1.3 - Now, the subquery t3 is the result table.
It will pull rep_name, region_name and total_amt 
from the inner join of t2 and t3.  */
SELECT  t3.rep_name,
        t3.region_name, 
        t3.total_amt
FROM    (SELECT region_name, 
                MAX(total_amt) total_amt
        FROM    (SELECT s.name rep_name, 
                        r.name region_name, 
                        SUM(o.total_amt_usd) total_amt
                FROM sales_reps s
                JOIN accounts a
                ON a.sales_rep_id = s.id
                JOIN orders o
                ON o.account_id = a.id
                JOIN region r
                ON r.id = s.region_id
                GROUP BY 1, 2) t1
        GROUP BY 1) t2
JOIN    (SELECT s.name rep_name, 
                r.name region_name, 
                SUM(o.total_amt_usd) total_amt
        FROM sales_reps s
        JOIN accounts a
        ON a.sales_rep_id = s.id
        JOIN orders o
        ON o.account_id = a.id
        JOIN region r
        ON r.id = s.region_id
        GROUP BY 1, 2
        ORDER BY 3 DESC) t3
ON t3.region_name = t2.region_name AND t3.total_amt = t2.total_amt
ORDER BY 3 DESC; 

/* Here is the OUTPUT: 
rep_name	        region_name	    total_amt
Earlie Schleusner	Southeast	    1098137.72
Tia Amato	        Northeast	    1010690.60
Georgianna Chisholm	West	        886244.12
Charles Bidwell	    Midwest	        675637.19
*/

/* Quiz 2 - For the region with the largest (sum)
of sales total_amt_usd, how many total (count) 
orders were placed? */

/* Note: If we just wanted to simply pull
region_name, total_amt_usd and order_count 
using JOIN, this would be the QUERY to use: */

SELECT r.name AS region_name,
        SUM(o.total_amt_usd) AS total_amt_usd,
        COUNT(o.id) AS order_count
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
JOIN region r
ON r.id = s.region_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

/* The output would be this: 
region_name	    total_amt_usd	order_count
Northeast	    7744405.36	    2357
*/

/* However, we don't want to show the total_amt_usd
on the output, we just want region_name and order_count
*/

/* So, we will take the use of subqueries again: */

/* 2.1 - The first query I wrote was to pull the 
total_amt_usd for each region. */

SELECT  r.name region_name, 
        SUM(o.total_amt_usd) total_amt
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name;

/* Output of this part:
region_name	    total_amt
Midwest	        3013486.51
Southeast	    6458497.00
Northeast	    7744405.36
West	        5925122.96
*/

/* 2.2 -  Second, pull the max using a subquery
(We could pull the max using ORDER BY DESC and 
LIMIT 1 clauses). */

SELECT MAX(total_amt)
FROM    (SELECT r.name region_name, 
                SUM(o.total_amt_usd) total_amt
        FROM sales_reps s
        JOIN accounts a
        ON a.sales_rep_id = s.id
        JOIN orders o
        ON o.account_id = a.id
        JOIN region r
        ON r.id = s.region_id
        GROUP BY r.name) sub;

/* Output of this part:
max
7744405.36 
*/

/* 2.3 - Finally, we want to pull the total orders
for the region with this amount (max). HAVING clause
will filter the columns when SUM(o.total_amt_usd) = 
MAX(total_amt) from the subquery created */

SELECT  r.name, 
        COUNT(o.total) total_orders
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name
HAVING SUM(o.total_amt_usd) = (
    SELECT MAX(total_amt)
    FROM    (SELECT r.name region_name, 
                    SUM(o.total_amt_usd) total_amt
            FROM sales_reps s
            JOIN accounts a
            ON a.sales_rep_id = s.id
            JOIN orders o
            ON o.account_id = a.id
            JOIN region r
            ON r.id = s.region_id
            GROUP BY r.name) sub);

/* Output of this part:
name	    total_orders
Northeast	2357
*/            

/* Quiz 3 - For the name of the account that purchased
the most (in total over their lifetime as a customer) 
standard_qty paper, how many accounts still had more 
in total purchases? */

/* 3.1 - Pull the account that had the most 
standard_qty paper. */
SELECT  a.name account_name, 
        SUM(o.standard_qty) total_std, 
        SUM(o.total) total
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

/* output of this part:
account_name	    total_std	total
Core-Mark Holding	41617	    44750
*/

/* 3.2 - Now, we'll use this total (from 
column 3 on the query above) to filter the 
account_name's that are above this number: */
SELECT a.name
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY 1
HAVING SUM(o.total) > 
    (SELECT total 
    FROM    (SELECT a.name act_name, 
                    SUM(o.standard_qty) tot_std, 
                    SUM(o.total) total
            FROM accounts a
            JOIN orders o
            ON o.account_id = a.id
            GROUP BY 1
            ORDER BY 2 DESC
            LIMIT 1) sub1);

/* output of this part:
name
Mosaic
EOG Resources
IBM
*/

/* 3.3 - Now we create a subquery sub2, in which 
we use COUNT(*) to output the number of accounts
that are on sub1: */
SELECT COUNT(*)
FROM    (SELECT a.name
        FROM orders o
        JOIN accounts a
        ON a.id = o.account_id
        GROUP BY 1
        HAVING SUM(o.total) > 
        (SELECT total 
        FROM    (SELECT     a.name act_name, 
                            SUM(o.standard_qty) tot_std, 
                            SUM(o.total) total
                FROM accounts a
                JOIN orders o
                ON o.account_id = a.id
                GROUP BY 1
                ORDER BY 2 DESC
                LIMIT 1) sub1)
        ) sub2;

/* output of this part:
count
3
*/

/* Quiz 4 - For the customer that spent the most
(in total over their lifetime as a customer) 
total_amt_usd, how many web_events did they have
for each channel? */

/* 4.1 - First I created the subquery 1 (sub1) 
to get the account_name, channel and 
count_web_events. */
SELECT  a.name AS account_name,
        w.channel,
        COUNT(w.id) AS count_web_events
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
GROUP BY 1, 2

/* output of this part (LIMITED BY 6 ROWS):
account_name	        channel	    count_web_events
3M	                    direct	    19
3M	                    adwords	    2
3M	                    facebook	2
Abbott Laboratories	    direct	    20
Abbott Laboratories	    banner	    1
Abbott Laboratories	    organic	    1
*/

/* 4.2 - Second, I created the subquery 2 (sub2),
to pull the account_name with the most spent in 
lifetime value (total_amt_usd). */

SELECT  a.name AS account_name,
        SUM(o.total_amt_usd) AS total_amt_usd
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1

/* output of this part:
account_name	        total_amt_usd
EOG Resources	        382873.30        
*/

/* 4.3 - Wrapping up the query to JOIN subqueries 1
and 2 when the account_name of both tables match. 
PS: in the real word, it would be safer tagging
the subqueries with 'id' column, as it is the 
PRIMARY KEY. */

SELECT  channel,
        count_web_events
FROM    (SELECT a.name AS account_name,
                w.channel,
                COUNT(w.id) AS count_web_events
        FROM web_events w
        JOIN accounts a
        ON w.account_id = a.id
        GROUP BY 1, 2) AS sub1
JOIN    (SELECT a.name AS account_name,
                SUM(o.total_amt_usd) AS total_amt_usd
        FROM orders o
        JOIN accounts a
        ON o.account_id = a.id
        GROUP BY 1
        ORDER BY 2 DESC
        LIMIT 1) AS sub2  
ON sub1.account_name = sub2.account_name

/* output of this part:

channel	    count_web_events
direct	    44
banner	    4
adwords	    12
twitter	    5
organic	    13
facebook	11
*/

/* Quiz 5 - What is the lifetime average amount
spent in terms of total_amt_usd for the top 10 
total spending accounts? */

/* 5.1 - First, we create the subquery 1 (sub1)
that will bring the account_id, account_name,
and total_amt_usd. */

SELECT  a.id AS account_id,
        a.name AS account_name,
        SUM(o.total_amt_usd) total_amt_usd
FROM accounts a
JOIN orders o 
ON o.account_id = a.id
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 10

/* output of this part:

account_id	account_name	        total_amt_usd
4211	    EOG Resources	        382873.30
4151	    Mosaic	                345618.59
1301	    IBM	                    326819.48
1871	    General Dynamics	    300694.79
4111	    Republic Services	    293861.14
3411	    Leucadia National	    291047.25
2181	    Arrow Electronics	    281018.36
1561	    Sysco	                278575.64
2591	    Supervalu	            275288.30
1401	    Archer Daniels Midland	272672.84
*/

/* 5.2 - Second, I create the avg for each
account_id */

SELECT  a.id AS account_id,
        AVG(o.total_amt_usd) avg_total_amt_usd
FROM accounts a
JOIN orders o 
ON o.account_id = a.id
GROUP BY 1

/* output of this part (LIMITED BY 6 ROWS):

account_id	    avg_total_amt_usd
2951	        2709.3257894736842105
2651	        5106.0793750000000000
3401	        1113.2900000000000000
2941	        5389.8850000000000000
1501	        3993.2714285714285714
1351	        4440.7220000000000000
*/

/* 5.3 - Last, I wrap the subqueries and JOIN
them using the account_id key to get the avg 
for the TOP 10 buyers. */

SELECT  account_name,
        avg_total_amt_usd
FROM    (SELECT a.id AS account_id,
                a.name AS account_name,
                SUM(o.total_amt_usd) total_amt_usd
        FROM accounts a
        JOIN orders o 
        ON o.account_id = a.id
        GROUP BY 1, 2
        ORDER BY 3 DESC
        LIMIT 10) AS sub1     
JOIN    (SELECT a.id AS account_id,
                AVG(o.total_amt_usd) avg_total_amt_usd
        FROM accounts a
        JOIN orders o 
        ON o.account_id = a.id
        GROUP BY 1) sub2
ON sub1.account_id = sub2.account_id
ORDER BY 2 DESC;

/* output of this part:
account_name                avg_total_amt_usd
EOG Resources	            6175.3758064516129032
Republic Services	        5877.2228000000000000
IBM	                        5446.9913333333333333
Mosaic	                    5236.6453030303030303
General Dynamics	        4555.9816666666666667
Arrow Electronics	        4194.3038805970149254
Archer Daniels Midland	    4131.4066666666666667
Leucadia National	        4099.2570422535211268
Sysco	                    4096.7005882352941176
Supervalu	                4048.3573529411764706
*/

/* Quiz 6 - What is the lifetime average amount
spent in terms of total_amt_usd for only the 
companies that spent more than the average of 
all orders. */

/* 6.1 - First, we want to pull the average of all
accounts in terms of total_amt_usd*/

SELECT AVG(o.total_amt_usd) avg_all
FROM orders o
JOIN accounts a
ON a.id = o.account_id;

/*output of this part:

avg_all
66118.605228571429
*/

/* 6.2 - Then, we want to only pull the accounts 
with more than this average amount */

SELECT  o.account_id, 
        AVG(o.total_amt_usd)
FROM orders o
GROUP BY 1
HAVING AVG(o.total_amt_usd) > (SELECT AVG(o.total_amt_usd) avg_all
                               FROM orders o
                               JOIN accounts a
                               ON a.id = o.account_id);

/*output of this part (limited by 6 rows):

account_id	    avg
2651	        5106.0793750000000000
2941	        5389.8850000000000000
1501	        3993.2714285714285714
1351	        4440.7220000000000000
1721	        4230.8875000000000000
2961	        3909.1275000000000000
*/

/* 6.3 - Finally, we just want the average of 
these values.*/

SELECT AVG(avg_amt)
FROM    (SELECT o.account_id, 
                AVG(o.total_amt_usd) avg_amt
        FROM orders o
        GROUP BY 1
        HAVING AVG(o.total_amt_usd) >   (SELECT AVG(o.total_amt_usd) avg_all
                                        FROM orders o
                                        JOIN accounts a
                                        ON a.id = o.account_id)
        ) temp_table;
  
/* Remember that we only need to set an ALIAS 
for the subquery when it is used on the FROM
clause */        

/*output of this part: 
avg
4721.1397439971747168
*/

/* Lesson 31.12 - Video: WITH or
Common Table Expression (CTE) */

/* The WITH statement is often called a Common
Table Expression or CTE. Though these expressions
serve the exact same purpose as subqueries, 
they are more common in practice, as they tend
to be cleaner for a future reader to follow 
the logic.*/

/* The WITH statement works like this:
We run the the subquery outside of the main
query, the WITH creates an alias table, that can
be accessed by any other query. */

/* Instead of this... */
SELECT  channel, 
        AVG(events) AS average_events
FROM (SELECT DATE_TRUNC('day',occurred_at) AS day,
             channel, COUNT(*) as events
      FROM web_events 
      GROUP BY 1,2) table1
GROUP BY channel
ORDER BY 2 DESC;

/* ... we use this: */
WITH table1 AS
            (SELECT DATE_TRUNC('day',occurred_at) AS day, 
                    channel, COUNT(*) as events
            FROM web_events 
            GROUP BY 1,2)

SELECT channel, AVG(events) AS average_events
FROM table1
GROUP BY channel
ORDER BY 2 DESC;

/* Notice that we aliases the table as 'table1' */

/* If we want to create more than one table 
on the WITH clause, we do like this: */

WITH    table1 AS 
            (SELECT *
            FROM web_events),

        table2 AS
            (SELECT *
            FROM accounts)

SELECT *
FROM table1
JOIN table2
ON table1.account_id = table2.id;

/* Lesson 31.14 - Quiz: WITH */

/* Quiz 1 - Provide the name of the sales_rep 
in each region with the largest amount of 
total_amt_usd sales */
WITH t1 AS
        (SELECT s.name AS sales_rep_name,
                r.name AS region_name,
                SUM(o.total_amt_usd) AS total_amt_usd
        FROM region r
        JOIN sales_reps s
        ON s.region_id = r.id
        JOIN accounts a
        ON a.sales_rep_id = s.id
        JOIN orders o
        ON o.account_id = a.id
        GROUP BY 1, 2),

     t2 AS
        (SELECT region_name, 
                MAX(total_amt_usd) AS max_total_amt
        FROM t1
        GROUP BY 1)
SELECT  t1.sales_rep_name,
        t1.region_name,
        t1.total_amt_usd
FROM t1
JOIN t2
ON t1.region_name = t2.region_name AND t1.total_amt_usd = t2.max_total_amt
GROUP BY 1, 2, 3;
       
/* Here is the output:
sales_rep_name              region_name	    total_amt_usd
Charles Bidwell	            Midwest	        675637.19
Earlie Schleusner	        Southeast	    1098137.72
Georgianna Chisholm	        West	        886244.12
Tia Amato	                Northeast	    1010690.60
*/

/* Quiz 2 - For the region with the largest
sales total_amt_usd, how many total orders 
were placed? */
WITH t1 AS
        (SELECT r.name AS region_name,
                SUM(o.total_amt_usd) AS total_amt_usd
        FROM region r
        JOIN sales_reps s
        ON s.region_id = r.id
        JOIN accounts a
        ON a.sales_rep_id = s.id
        JOIN orders o
        ON o.account_id = a.id
        GROUP BY 1),  
     
     t2 AS
        (SELECT MAX(total_amt_usd) AS max_total_amt_usd
        FROM t1)

SELECT  r.name, 
        COUNT(o.total) total_orders
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name 
HAVING SUM(o.total_amt_usd) = (SELECT max_total_amt_usd FROM t2);

/* Here is the output:

name	        total_orders
Northeast       2357
*/

/* Quiz 3 - For the name of the account that
purchased the most (in total over their 
lifetime as a customer) standard_qty paper, 
how many accounts still had more in total 
purchases? */
WITH t1 AS 
        (SELECT a.name AS account_name,
                SUM(o.total) AS total_purchases,
                SUM(o.standard_qty) AS total_standard_qty
        FROM accounts a
        JOIN orders o 
        ON o.account_id = a.id
        GROUP BY 1
        ORDER BY 3 DESC
        LIMIT 1),
        
     t2 AS        
        (SELECT a.name AS account_name
        FROM accounts a
        JOIN orders o
        ON o.account_id = a.id
        GROUP BY 1
        HAVING SUM(o.total) > (SELECT total_purchases FROM t1))

SELECT COUNT(*) 
FROM t2;

/* Quiz 4 - For the customer that spent the most 
(in total over their lifetime as a customer) 
total_amt_usd, how many web_events did they have
for each channel? */
WITH t1 AS 
        (SELECT a.name AS account_name,
                SUM(o.total_amt_usd) AS total_amt_usd
        FROM accounts a
        JOIN orders o 
        ON o.account_id = a.id
        GROUP BY 1
        ORDER BY 2 DESC
        LIMIT 1),
        
     t2 AS        
        (SELECT a.name AS account_name,
                w.channel AS channel,
                COUNT(*) AS count_events
        FROM web_events w
        JOIN accounts a
        ON w.account_id = a.id
        GROUP BY 1, 2)

SELECT  t2.channel,
        t2.count_events
FROM t2
JOIN t1
ON t1.account_name = t2.account_name;

/* Quiz 5 - What is the lifetime average amount
spent in terms of total_amt_usd for the top 10
total spending accounts? */
WITH t1 AS 
        (SELECT a.name AS account_name,
                SUM(o.total_amt_usd) AS total_amt_usd
        FROM accounts a
        JOIN orders o 
        ON o.account_id = a.id
        GROUP BY 1
        ORDER BY 2 DESC
        LIMIT 10)

SELECT AVG(total_amt_usd)
FROM t1

/* Quiz 6 - What is the lifetime average amount
spent in terms of total_amt_usd for only the 
companies that spent more than the average of
all accounts. */
WITH t1 AS
        (SELECT AVG(o.total_amt_usd) avg_all
        FROM orders o
        JOIN accounts a
        ON a.id = o.account_id),
        
     t2 AS (
        SELECT o.account_id, AVG(o.total_amt_usd) avg_amt
        FROM orders o
        GROUP BY 1
        HAVING AVG(o.total_amt_usd) > (SELECT avg_all FROM t1))

SELECT AVG(avg_amt)
FROM t2;

/* Lesson 32.3 - Quiz: LEFT & RIGHT */

/* Quiz 1 - In the accounts table, there is a column
holding the website for each company. The last three
digits specify what type of web address they are using.
A list of extensions (and pricing) is provided here. 
Pull these extensions and provide how many of each 
website type exist in the accounts table. */
SELECT  RIGHT(website, 3) AS website_type,
        COUNT(RIGHT(website, 3)) AS count_web_type
FROM accounts 
GROUP BY 1;

/* Quiz 2 - There is much debate about how much the 
name (or even the first letter of a company name) 
matters. Use the accounts table to pull the first 
letter of each company name to see the distribution 
of company names that begin with each letter 
(or number). */
SELECT  name,
        LEFT(name, 1) AS first_char,
        COUNT(LEFT(name, 1)) AS count_first_char
FROM accounts
GROUP BY 1;

/* Quiz 3 - Use the accounts table and a CASE statement
to create two groups: one group of company names that 
start with a number and a second group of those company
names that start with a letter. What proportion of 
company names start with a letter? */
WITH t1 AS 
        (SELECT name,
                CASE    WHEN LEFT(name, 1) BETWEEN 'a' AND 'z' THEN 'letter'
                        ELSE 'number' END AS name_initials_type,
                COUNT(*) AS type_count
        FROM accounts
        GROUP BY 1),

     t2 AS 
        (SELECT SUM(type_count) AS sum_number
        FROM t1
        WHERE name_initials_type = 'number'),

     t3 AS 
        (SELECT SUM(type_count) AS sum_letter
        FROM t1
        WHERE name_initials_type = 'letter')

SELECT (t2.sum_number / t3.sum_letter) AS ratio_number_per_letter
FROM t2, t3;

/* This is the output: 
ratio_number_per_letter
0.00285714285714285714
*/

/* This is the fastest answer for the same Quiz: */
SELECT  SUM(num) nums, 
        SUM(letter) letters
FROM (SELECT    name, 
                CASE WHEN LEFT(UPPER(name), 1) IN ('0','1','2','3','4','5','6','7','8','9') THEN 1 
                ELSE 0 END AS num, 
                CASE WHEN LEFT(UPPER(name), 1) IN ('0','1','2','3','4','5','6','7','8','9') THEN 0 
                ELSE 1 END AS letter
      FROM accounts) t1;

/* PRO TIP: */

/* Using UPPER clause avoid SQL not
reading the lower and upper letters. On the next
quiz (4), if I do not use UPPER it will grab the 
lowercase letters */ 
      
/* This is the output:
nums	letters
1	    350
*/

/* Quiz 4 - Consider vowels as a, e, i, o, and u.
What proportion of company names start with a 
vowel, and what percent start with anything 
else? */
WITH t1 AS 
        (SELECT name,
                CASE    WHEN LEFT(UPPER(name), 1) = 'A' THEN 'A'
                        WHEN LEFT(UPPER(name), 1) = 'E' THEN 'E'
                        WHEN LEFT(UPPER(name), 1) = 'I' THEN 'I'
                        WHEN LEFT(UPPER(name), 1) = 'O' THEN 'O'
                        WHEN LEFT(UPPER(name), 1) = 'U' THEN 'U'
                        ELSE 'consonants' END AS name_initials_type,
                COUNT(*) AS type_count
        FROM accounts
        GROUP BY 1),
     
     t2 AS
        (SELECT name_initials_type,
                SUM(type_count) AS total 
        FROM t1
        GROUP BY 1
        ORDER BY 2),
     
     t3 AS
        (SELECT SUM(total) AS sum_total 
        FROM t2)

SELECT  name_initials_type,
        total,
        total * 100.0 / sum_total AS percentage
FROM t2, t3
GROUP BY 1, 2, 3
ORDER BY 2 DESC;

/* The output would be: 
name_initials_type	total	percentage_%
A	                37	    10.5413105413105413
I	                7	    1.9943019943019943
U	                13	    3.7037037037037037
O	                7	    1.9943019943019943
E	                16	    4.5584045584045584
consonants	        271	    77.2079772079772080
*/

/* This is the fastest answer for the same Quiz: */

SELECT  SUM(vowels) vowels, 
        SUM(other) other
FROM    (SELECT    name, 
                CASE WHEN LEFT(UPPER(name), 1) IN ('A','E','I','O','U') 
                        THEN 1 ELSE 0 END AS vowels, 
                CASE WHEN LEFT(UPPER(name), 1) IN ('A','E','I','O','U') 
                       THEN 0 ELSE 1 END AS other
        FROM accounts) t1;

/* The output would be: 
vowels	other
80	    271
*/

/* lesson 32.5 - Video: POSITION, STRPOS 
& SUBSTR */

/* POSITION takes a character and a column, 
and provides the index where that character 
is for each row. The index of the first position
is 1 in SQL. If you come from another programming 
language, many begin indexing at 0. Here, you saw
that you can pull the index of a comma as 
POSITION(',' IN city_state) */

/* STRPOS provides the same result as POSITION, but
the syntax for achieving those results is a bit 
different as shown here: STRPOS(city_state, ',').*/

/* PRO TIP */
/* POSITION and STRPOS are case sensitive */

/* Therefore, if you want to pull an index regardless
of the case of a letter, you might want to use LOWER 
or UPPER to make all of the characters lower or 
uppercase.*/

/* lesson 32.6 - QUIZ: POSITION, STRPOS 
& SUBSTR */

/* Quiz 1 - Use the accounts table to create first
and last name columns that hold the first and last
names for the primary_poc */
SELECT  primary_poc,
        LEFT(primary_poc, STRPOS(primary_poc, ' ') -1 ) first_name, 
        /* on Tamara's row, the space is the 7th position, so it 
        will print from left to the (7-1) position  */
        RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name
        /* on Tamara's row, it will print from right to the (11-7) position */
FROM accounts;

/* THIS IS THE OUTPUT:
primary_poc	        first_name	        last_name
Tamara Tuma	        Tamara	            Tuma
Sung Shields	    Sung	            Shields
*/

/* Quiz 2 - Now see if you can do the same thing 
for every rep name in the sales_reps table. 
Again provide first and last name columns. */
SELECT  name,
        LEFT(name, STRPOS(name, ' ') -1 ) first_name, 
        RIGHT(name, LENGTH(name) - STRPOS(name, ' ')) last_name
FROM sales_reps;

/* Lesson 32.8 - Video: CONCAT */

/* PRO TIP */
/* Both 'CONCAT' and '||' (means piping) can be used to 
concatenate strings together, see below the syntaxes: 

we can use CONCAT:
CONCAT(first_name, ' ', last_name)

OR ||:
first_name || ' ' || last_name
*/

/* Lesson 32.9 - Quiz: CONCAT */ 

/* Quiz 1 & 2 - Each company in the accounts table wants 
to create an email address for each primary_poc. The 
email address should be the first name of the 
primary_poc. last name primary_poc @ company name.com.
*/
WITH t1 AS
        (SELECT primary_poc,
        LOWER(LEFT(primary_poc, STRPOS(LOWER(primary_poc), ' ') -1 )) AS first_name,
        /* used LOWER inside STRPOS clause because the last is case sensitive */
        LOWER(RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(LOWER(primary_poc), ' '))) AS last_name,
        LOWER(REPLACE(name, ' ', '')) AS account_name
        FROM accounts)

SELECT first_name, last_name, CONCAT(first_name, '.', last_name, '@', account_name, '.com')
/* could write the statement as firts_name || '.' || last_name '@' || account_name || '.com' */
FROM t1;

/* Here is the output (limited by 6 rows): 
first_name	    last_name	    concat
tamara	        tuma	        tamara.tuma@walmart.com
sung	        shields	        sung.shields@exxonmobil.com
jodee	        lupo	        jodee.lupo@apple.com
serafina	    banda	        serafina.banda@berkshirehathaway.com
angeles	        crusoe	        angeles.crusoe@mckesson.com
savanna	        gayman	        savanna.gayman@unitedhealthgroup.com
*/

/* Quiz 3 - We would also like to create an initial
password, which they will change after their first
log in. The first password will be the first letter
of the primary_poc's first name (lowercase), then 
the last letter of their first name (lowercase), 
the first letter of their last name (lowercase), 
the last letter of their last name (lowercase), 
the number of letters in their first name, 
the number of letters in their last name, 
and then the name of the company they are working
with, all capitalized with no spaces. */
WITH t1 AS
        (SELECT primary_poc,
        LOWER(LEFT(primary_poc, STRPOS(LOWER(primary_poc), ' ') -1 )) AS first_name,
        LOWER(RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(LOWER(primary_poc), ' '))) AS last_name,
        LOWER(REPLACE(name, ' ', '')) AS account_name
        FROM accounts)

SELECT  CONCAT(LEFT(LOWER(first_name), 1), /* first_letter_first_name */
        RIGHT(LOWER(first_name), 1), /* last_letter_first_name */
        LEFT(LOWER(last_name), 1), /* first_letter_last_name */
        RIGHT(LOWER(last_name), 1), /* last_letter_last_name */
        LENGTH(first_name), /* number_letters_first_name */
        LENGTH(last_name), /* number_letters_last_name */
        UPPER(account_name)) /* company_name in uppercase */
        AS password
FROM t1;

/* THIS IS THE OUTPUT (limited by 4 rows):
password
tata64WALMART
sgss47EXXONMOBIL
jelo54APPLE
saba85BERKSHIREHATHAWAY
*/

/* Lesson 32.11 - Video: CAST */

/* CAST is used to change the datatype
of the columns */

/* On this lesson, we also learned TO_DATE
clause, used inside a DATE_PART clause to
change a month name into the number associated
with that particular month, as below: 
DATE_PART('month', TO_DATE(month, 'month')) 
*/

/* We also saw another way to CAST:
instead of CAST(date_column AS DATE), 
you can use date_column::DATE */

/* PRO TIP */

/* LEFT, RIGHT, and TRIM are all used to select 
only certain elements of strings, but using 
them to select elements of a number or date 
will treat them as strings for the purpose 
of the function */

/* Though we didn't cover TRIM in this lesson 
explicitly, it can be used to remove characters
from the beginning and end of a string. This 
can remove unwanted spaces at the beginning 
or end of a row that often happen with data 
being moved from Excel or other storage 
systems.*/

/* Lesson 32.12 - Quiz: CAST */

/* This is how the date is stored inside the table:
date
01/31/2014 08:00:00 AM +0000 
*/

/* Task 4 - Write a query to change the date
into correct SQL date format. You will need
to use at least SUBSTR and CONCAT to perform
this operation */

SELECT  SUBSTR(date, 7, 4) || 
        '-' ||
        SUBSTR(date, 1, 2) ||
        '-' ||
        SUBSTR(date, 4, 2) AS date_string
FROM sf_crime_data;

/* Task 5 - Once you have created a column in 
the correct format, use either CAST or :: to
convert this to a date */

SELECT  CAST(SUBSTR(date, 7, 4) || 
        '-' ||
        SUBSTR(date, 1, 2) ||
        '-' ||
        SUBSTR(date, 4, 2) AS DATE) AS date_formated
/* we could re-write this last clause like this:
SUBSTR(date, 4, 2))::DATE AS date_formated*/
FROM sf_crime_data; 

/* THIS IS THE OUTPUT (limited by 3 rows):
date_formated
2014-01-31T00:00:00.000Z
2014-01-31T00:00:00.000Z
2014-01-31T00:00:00.000Z
*/

/* Lesson 32.14 - Video: COALESCE */

/* COALESCE (which means merge, unite, join),
is used to give actual values to NULL rows.

/* It is pretty usefull when you are dealing
with tables with numeric values, or join
tables that you are going to group some
columns that could become empty. */

/* PRO TIP */
/* Using COALESCE, we fill the NULL values 
and get a value in every cell
*/

/* Lesson 32.15 - Quiz: COALESCE */

/* Quiz 1 - Run the query to get the row with
missing data */
SELECT *
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;

/*  As we don’t have account_id 1731 in orders 
table, it will return a NULL value on id */

/* This is the output, see that id and last columns
are blank (NULL values):
id	name	            website	    lat	        long	        primary_poc	    sales_rep_id	
    Goldman Sachs Group	www.gs.com	40.75744399	-73.96730918	Loris Manfredi	321690										

All these columns below are all blank
account_id	occurred_at	standard_qty gloss_qty	
poster_qty	total	standard_amt_usd	
gloss_amt_usd	poster_amt_usd	total_amt_usd
*/

/* Quiz 2 - Use COALESCE to fill in the 
accounts.id column with the account.id for the
null value for the table in Quiz 1. */
SELECT  COALESCE(a.id, a.id) filled_id,
        /* COALESCE will grab the id from 
        accounts table and fill the NULL row */
        a.name,
        a.website,
        a.lat, 
        a.long, 
        a.primary_poc, 
        a.sales_rep_id, 
        o.*
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;
  
/* This is the output:
filled_id	name	            website	    lat	        long	        primary_poc	    sales_rep_id	
1731        Goldman Sachs Group	www.gs.com	40.75744399	-73.96730918	Loris Manfredi	321690	

All these columns below are all blank
account_id	occurred_at	standard_qty gloss_qty	
poster_qty	total	standard_amt_usd	
gloss_amt_usd	poster_amt_usd	total_amt_usd
*/

/* Quiz 3 - Use COALESCE to fill in the 
orders.accounts_id column with the account.id for the
null value for the table in Quiz 1. */
SELECT  COALESCE(a.id, a.id) filled_id, 
        a.name,
        a.website,
        a.lat, 
        a.long, 
        a.primary_poc, 
        a.sales_rep_id, 
        COALESCE(o.account_id, a.id) account_id, 
        o.occurred_at, 
        o.standard_qty, 
        o.gloss_qty, 
        o.poster_qty, 
        o.total, 
        o.standard_amt_usd, 
        o.gloss_amt_usd, 
        o.poster_amt_usd, 
        o.total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;

/* This is the output:
filled_id	name	            website	    lat	        long	        primary_poc	    sales_rep_id	
1731        Goldman Sachs Group	www.gs.com	40.75744399	-73.96730918	Loris Manfredi	321690	

account_id
1731

All these columns below are all blank
occurred_at	standard_qty gloss_qty	
poster_qty	total	standard_amt_usd	
gloss_amt_usd	poster_amt_usd	total_amt_usd
*/

/* Quiz 4 - Use COALESCE to fill in each of the qty
and usd columns with 0 for table 1. */
SELECT  COALESCE(a.id, a.id) filled_id, 
        a.name, 
        a.website, 
        a.lat, 
        a.long, 
        a.primary_poc, 
        a.sales_rep_id, 
        COALESCE(o.account_id, a.id) account_id, 
        o.occurred_at, 
        COALESCE(o.standard_qty, 0) standard_qty, 
        COALESCE(o.gloss_qty,0) gloss_qty, 
        COALESCE(o.poster_qty,0) poster_qty, 
        COALESCE(o.total,0) total, 
        COALESCE(o.standard_amt_usd,0) standard_amt_usd, 
        COALESCE(o.gloss_amt_usd,0) gloss_amt_usd, 
        COALESCE(o.poster_amt_usd,0) poster_amt_usd, 
        COALESCE(o.total_amt_usd,0) total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;

/* COALESCE will fill all the columns that were empty
before */

/* Quiz 5 - Run the query in 1 with the WHERE removed
and COUNT the number of ids. */
SELECT COUNT(a.id)
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id;

/* This is the output:
count
6913
*/

/* Quiz 6 - Run the query in 5, but with the COALESCE
function used in 4. */
SELECT  COALESCE(a.id, a.id) filled_id, 
        a.name, 
        a.website, 
        a.lat, 
        a.long, 
        a.primary_poc, 
        a.sales_rep_id, 
        COALESCE(o.account_id, a.id) account_id, 
        o.occurred_at, 
        COALESCE(o.standard_qty, 0) standard_qty, 
        COALESCE(o.gloss_qty,0) gloss_qty, 
        COALESCE(o.poster_qty,0) poster_qty, 
        COALESCE(o.total,0) total, 
        COALESCE(o.standard_amt_usd,0) standard_amt_usd, 
        COALESCE(o.gloss_amt_usd,0) gloss_amt_usd, 
        COALESCE(o.poster_amt_usd,0) poster_amt_usd, 
        COALESCE(o.total_amt_usd,0) total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id;

/* It will fill up all the NULL values on this JOIN */

/* Some other functions that do the job of cleaning 
data: 
https://www.w3schools.com/sql/sql_isnull.asp 
https://community.modeanalytics.com/sql/tutorial/sql-string-functions-for-cleaning/ */










