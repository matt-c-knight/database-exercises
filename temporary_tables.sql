-- Using the example from the lesson, re-create the employees_with_departments table.

-- Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
-- Update the table so that full name column contains the correct data
-- Remove the first_name and last_name columns from the table.
-- What is another way you could have ended up with this same table?


CREATE TEMPORARY TABLE employees_with_departments AS
SELECT employees.employees.emp_no, employees.employees.first_name, employees.employees.last_name, employees.dept_emp.dept_no, employees.departments.dept_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
LIMIT 100;

SELECT * 
FROM employees_with_departments;

ALTER TABLE employees_with_departments ADD full_name VARCHAR();

ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;

-- Create a temporary table based on the payment table from the sakila database.
use darden_1042

CREATE TEMPORARY TABLE payments_in_cents AS
SELECT * 
FROM sakila.payment
LIMIT 100;

SELECT *
FROM payments_in_cents;


UPDATE payments_in_cents SET amount = amount * 100;

ALTER TABLE payments_in_cents ADD cent_value INT(10);
SET cent_value = amount * 100;

SELECT *
FROM payments_in_cents;

Update payments_in_cents
SET cent_value = amount * 100;

-- Find out how the average pay in each department compares to the overall average pay.
--  In order to make the comparison easier, you should use the Z-score for salaries.
--  In terms of salary, what is the best department to work for? The worst?

use darden_1042;

CREATE TEMPORARY TABLE average_pay_by_dept AS
SELECT employees.departments.dept_name, employees.salaries.salary as salary_z_score
FROM employees.departments
JOIN employees.dept_emp ON employees.departments.dept_no = employees.dept_emp.dept_no
JOIN employees.salaries ON employees.dept_emp.emp_no = employees.salaries.emp_no;


--emps table has employee names, their departments, and all salary info
CREATE TABLE emps AS
SELECT
e. *,
s.salary,
d.dept_name as department,
d.dept_no
FROM employees.employees as e
JOIN employees.salaries as s USING(emp_no)
JOIN employees.dept_emp as de USING(emp_no)
JOIN employees.departments as d USING(dept_no);

ALTER TABLE emps ADD mean_salary FLOAT;
ALTER TABLE emp ADD sd_salary FLOAT;
ALTER TABLE emps ADD z_salary FLOAT;

SELECT * from emps limit 50;

CREATE TEMPORARY TABLE salary_aggregates AS
SELECT avg(salary) as mean,
stddev(salary) as sd_salary
FROM emps;

SELECT * from salary_aggregates;

--now let's update the emps table from salary_aggregates
UPDATE emps SET mean_salary = (SELECT mean salary_aggregates);

UPDATE emp SET sd_salary = (SELECT sd from salary_aggregates);

--We can calc the z if we have the above nums
UPDATE emps SET z_salary = (salary - mean_salary) / sd_salary;

SELECT department, avg(z_salary) as z_salary
FROM emps
GROUP by department
ORDER by z_salary;

--We can calculate the average salary
-- SELECT avg(salary) from emps;

--We can calculate the standard deviation of the salary
-- SELECT stddev(salary) from emps;

--We can calculate the z_score if we have the above two numbers

