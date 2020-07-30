-- Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.

SELECT employees.emp_no, dept_no, hire_date, to_date, 
	CASE WHEN to_date > curdate() THEN 1
		ELSE 0
		END AS is_current_employee
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no;

-- Write a query that returns all employee names, and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.



SELECT first_name, last_name, 
	CASE WHEN SUBSTRING(last_name,1,1) >= 'A' and SUBSTRING(last_name,1,1) < 'I' THEN 'A-H'
		 WHEN SUBSTRING(last_name,1,1) >= 'I' and SUBSTRING(last_name,1,1) < 'R' THEN 'I-Q'
		 WHEN SUBSTRING(last_name,1,1) >= 'R' and SUBSTRING(last_name,1,1) <= 'Z' THEN 'R-Z'
		ELSE null
		END AS alpha_group
FROM employees;

-- How many employees were born in each decade?

SELECT first_name, last_name, birth_date,
	CASE WHEN birth_date BETWEEN '1940-01-01' AND '1949-12-31' THEN "1940s"
		 WHEN birth_date BETWEEN '1950-01-01' AND '1959-12-31' THEN "1950s"
		 WHEN birth_date BETWEEN '1960-01-01' AND '1969-12-31' THEN "1960s"
		 WHEN birth_date BETWEEN '1970-01-01' AND "1979-12-31" THEN "1970s"
		 WHEN birth_date BETWEEN "1980-01-01" AND "1989-12-31" THEN "1980s"
		 WHEN birth_date BETWEEN "1990-01-01" AND "1999-12-31" THEN "1990s"
		 WHEN birth_date BETWEEN "2000-01-01" AND "2009-12-31" THEN "2000s"
		 ELSE null
		 END as birth_decade
FROM employees
ORDER by birth_decade;

-- What is the average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

SELECT CASE 
		WHEN dept_name = 'Development' OR dept_name = 'Research' THEN 'R&D'
		WHEN dept_name = 'Production' OR dept_name = 'Quality Management' THEN 'PROD & QM'
		WHEN dept_name = 'Customer Service' THEN 'Customer Service'
		WHEN dept_name = 'Finance' OR dept_name = 'Human Resources' THEN 'FINANCE & HR'
		WHEN dept_name = 'Sales' OR dept_name= 'Marketing' THEN 'Sales and Marketing'
		ELSE null
		END as dept_group, round(avg(salary), 2) as avg_salary
FROM departments 
JOIN dept_emp ON departments.dept_no = dept_emp.dept_no
JOIN salaries ON dept_emp.emp_no = salaries.emp_no
GROUP by dept_group;