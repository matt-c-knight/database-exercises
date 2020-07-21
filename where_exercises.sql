use employees;

SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya');

SELECT *
FROM employees
Where last_name like 'E%';

SELECT *
FROM employees 
WHERE hire_date Between '1990-01-01' and '1999-12-31';

SELECT *
FROM employees
WHERE birth_date Like '%12-25'; 

SELECT *
FROM employees
WHERE last_name like '%q%';

SELECT *
FROM employees
WHERE first_name = 'Irena' 
OR first_name = 'Vidya'
OR first_name = 'Maya';

SELECT *
FROM employees
WHERE gender = 'M'
AND (
	first_name = 'Irena' 
	OR first_name = 'Vidya'
	OR first_name = 'Maya'
);

SELECT *
FROM employees
WHERE last_name like 'E%'
OR last_name like '%e';

SELECT *
FROM employees
WHERE last_name like 'E%'
AND last_name like '%e';

SELECT *
FROM employees
WHERE hire_date Between '1990-01-01' and '1999-12-31'
AND birth_date Like '%12-25';

SELECT * 
FROM employees
WHERE last_name like '%q%'
AND last_name not like '%qu%';

