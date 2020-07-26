-- Find all the employees with the same hire date as employee 101010 using a sub-query.
SELECT first_name, last_name, birth_date
FROM employees
WHERE hire_date IN (
	SELECT hire_date
	FROM employees
	WHERE emp_no = "101010"
	);
-- Find all the titles held by all employees with the first name Aamod.
SELECT title, COUNT(*)
FROM titles 
WHERE emp_no IN (
	SELECT emp_no
	from employees
	WHERE first_name = "Aamod")
	Group by title;

-- How many people in the employees table are no longer working for the company?
SELECT CONCAT(first_name, ' ', last_name)
from employees
WHERE emp_no IN (
	SELECT emp_no
	from dept_emp
	WHERE to_date != "9999-01-01"
	)

-- Find all the current department managers that are female.
SELECT first_name, last_name
from employees
WHERE employees.emp_no IN (
	SELECT employees.emp_no
	from employees
	JOIN dept_manager ON employees.emp_no = dept_manager.emp_no 
	WHERE employees.gender = "F" and dept_manager.to_date > curdate()
	)

-- Find all the employees that currently have a higher than average salary.
SELECT first_name, last_name, salary
FROM employees
JOIN salaries on employees.emp_no = salaries.emp_no
WHERE to_date > curdate()
    and salary > (select avg(salary)
                from salaries);


-- How many current salaries are within 1 standard deviation of the highest salary?

avg=63810.75
stddev=16904.83
max=158,220
158220 - 141,315.17 = 141315.17

SELECT first_name, last_name, salary
FROM employees
JOIN salaries on employees.emp_no = salaries.emp_no
WHERE to_date > curdate()
    and salary >= "141315.17";

SELECT first_name, last_name, salary
FROM employees
JOIN salaries on employees.emp_no = salaries.emp_no
WHERE to_date > curdate()
    and salary >= (SELECT max(salary) - stddev(salary) as salary_total
    	from salaries)
    	ORDER BY salary desc;
