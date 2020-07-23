-- In your script, use DISTINCT to find the unique titles in the titles table. Your results should look like:

SELECT DISTINCT first_name
FROM employees;

-- Find your query for employees whose last names start and end with 'E'. Update the query find just the unique last names that start and end with 'E' using GROUP BY. The results should be:
SELECT last_name
FROM employees
WHERE last_name like 'E%'
AND last_name like '%e'
Group by last_name;


-- Update your previous query to now find unique combinations of first and last name where the last name starts and ends with 'E'. You should get 846 rows.
SELECT first_name,last_name
FROM employees
WHERE last_name like 'E%'
AND last_name like '%e'
Group by first_name,last_name;
-- Find the unique last names with a 'q' but not 'qu'. Your results should be:
SELECT last_name
FROM employees
WHERE last_name like '%q%'
AND last_name not like '%qu%'
Group by last_name;


-- Add a COUNT() to your results and use ORDER BY to make it easier to find employees whose unusual name is shared with others.
SELECT last_name, COUNT(last_name)
FROM employees
WHERE last_name like '%q%'
AND last_name not like '%qu%'
Group by last_name
ORDER BY COUNT(last_name);
-- Update your query for 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names. Your results should be:
SELECT gender, COUNT(*)
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
Group by gender;



-- Recall the query the generated usernames for the employees from the last lesson. Are there any duplicate usernames?
SELECT DISTINCT CONCAT(LOWER(SUBSTR(first_name,1,1)),LOWER(SUBSTR(last_name,1,4)),"_",SUBSTR(birth_date,6,2),SUBSTR(birth_date,3,2)) as username,
first_name, last_name, birth_date
from employees;
