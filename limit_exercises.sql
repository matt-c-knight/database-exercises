Create a new SQL script named limit_exercises.sql.

MySQL provides a way to return only unique results from our queries with the keyword DISTINCT. For example, to find all the unique titles within the company, we could run the following query:

SELECT DISTINCT title FROM titles;
-- List the first 10 distinct last name sorted in descending order. Your result should look like this:
use employees;


Select DISTINCT last_name
From employees
Order by last_name desc
Limit 10;


-- Find your query for employees born on Christmas and hired in the 90s from order_by_exercises.sql. Update it to find just the first 5 employees. Their names should be:
SELECT *
FROM employees
WHERE hire_date Between '1990-01-01' and '1999-12-31'
AND birth_date Like '%12-25'
order by birth_date asc, hire_date desc
Limit 5;


-- Try to think of your results as batches, sets, or pages. The first five results are your first page. The five after that would be your second page, etc. Update the query to find the tenth page of results. The employee names should be:
SELECT *
FROM employees
WHERE hire_date Between '1990-01-01' and '1999-12-31'
AND birth_date Like '%12-25'
order by birth_date asc, hire_date desc
Limit 5 Offset 45;


-- LIMIT and OFFSET can be used to create multiple pages of data. What is the relationship between OFFSET (number of results to skip), LIMIT (number of results per page), and the page number?