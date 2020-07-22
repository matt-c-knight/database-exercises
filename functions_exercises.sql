Copy the order by exercise and save it as functions_exercises.sql.

-- Update your queries for employees whose names start and end with 'E'. Use concat() to combine their first and last name together as a single column named full_name.
SELECT CONCAT(first_name, " ", last_name) AS full_name
FROM employees
WHERE last_name like 'E%'
AND last_name like '%e';

-- Convert the names produced in your last query to all uppercase.
SELECT CONCAT(UPPER(first_name), " ", UPPER(last_name)) AS full_name
FROM employees
WHERE last_name like 'E%'
AND last_name like '%e';

-- For your query of employees born on Christmas and hired in the 90s, use datediff() to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE())
SELECT datediff(CURDATE(),hire_date) as days_employed
FROM employees
WHERE hire_date Between '1990-01-01' and '1999-12-31'
AND birth_date Like '%12-25'
order by birth_date asc, hire_date desc;


-- Find the smallest and largest salary from the salaries table.
SELECT MIN(salary) as min_salary, MAX(salary) as max_salary 
from salaries;

-- Use your knowledge of built in SQL functions to generate a username for all of the employees. A username should be all lowercase, and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born. Below is an example of what the first 10 rows will look like:
SELECT CONCAT(LOWER(SUBSTR(first_name,1,1)),LOWER(SUBSTR(last_name,1,4)),"_",SUBSTR(birth_date,6,2),SUBSTR(birth_date,3,2)) as username,
first_name, last_name, birth_date
from employees;

+------------+------------+-----------+------------+
| username   | first_name | last_name | birth_date |
+------------+------------+-----------+------------+
| gface_0953 | Georgi     | Facello   | 1953-09-02 |
| bsimm_0664 | Bezalel    | Simmel    | 1964-06-02 |
| pbamf_1259 | Parto      | Bamford   | 1959-12-03 |
| ckobl_0554 | Chirstian  | Koblick   | 1954-05-01 |
| kmali_0155 | Kyoichi    | Maliniak  | 1955-01-21 |
| apreu_0453 | Anneke     | Preusig   | 1953-04-20 |
| tziel_0557 | Tzvetan    | Zielinski | 1957-05-23 |
| skall_0258 | Saniya     | Kalloufi  | 1958-02-19 |
| speac_0452 | Sumant     | Peac      | 1952-04-19 |
| dpive_0663 | Duangkaew  | Piveteau  | 1963-06-01 |
+------------+------------+-----------+------------+
10 rows in set (0.05 sec)

