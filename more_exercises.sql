-- How much do the current managers of each department get paid, 
-- relative to the average salary for the department? 
-- Is there any department where the department manager gets paid less than the average salary?

use employees;

SELECT CONCAT(first_name, " ", last_name) as fullname, salary, dept_name
FROM dept_manager
JOIN salaries ON dept_manager.emp_no = salaries.emp_no
JOIN employees ON salaries.emp_no = employees.emp_no
JOIN dept_emp ON salaries.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE employees.emp_no = dept_manager.emp_no and salaries.to_date > curdate() and dept_manager.to_date > curdate();

-- Use the world database for the questions below.

-- What languages are spoken in Santa Monica?

SELECT Language, Percentage
from countrylanguage
JOIN city on countrylanguage.CountryCode = city.CountryCode
Where city.Name = "Santa Monica"
order by percentage;

-- How many different countries are in each region?
SELECT Region, COUNT(REGION) as num_countries
from country
GROUP BY Region
ORDER BY COUNT(REGION);