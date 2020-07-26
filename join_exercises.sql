-- Use the join_example_db. Select all the records from both the users and roles tables.
SELECT *
FROM users
JOIN roles ON users.role_id = roles.id;
-- Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.
SELECT *
FROM users
JOIN roles ON users.role_id = roles.id;

SELECT *
FROM users
LEFT JOIN roles ON users.role_id = roles.id;

SELECT *
FROM users
RIGHT JOIN roles ON users.role_id = roles.id;
-- Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.
SELECT roles.name, COUNT(*)
FROM roles
JOIN users ON users.role_id = roles.id
GROUP BY roles.name ;

-- Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.
SELECT departments.dept_name, CONCAT(employees.first_name, " ", employees.last_name) as full_name
FROM departments
JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
JOIN employees ON dept_manager.emp_no = employees.emp_no
WHERE dept_manager.to_date > curdate();

-- Find the name of all departments currently managed by women.
SELECT departments.dept_name, CONCAT(employees.first_name, " ", employees.last_name) as full_name
FROM departments
JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
JOIN employees ON dept_manager.emp_no = employees.emp_no
WHERE dept_manager.to_date > curdate() and gender = "F";

-- Find the current titles of employees currently working in the Customer Service department.
SELECT titles.title, COUNT(*)
from titles
JOIN employees ON titles.emp_no = employees.emp_no
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE titles.to_date > curdate() and dept_emp.to_date > curdate() and departments.dept_no = "d009"
GROUP by titles.title;
-- Find the current salary of all current managers.
SELECT dept_name, CONCAT(first_name, " ",last_name), salary
FROM departments
JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
JOIN salaries ON dept_manager.emp_no = salaries.emp_no
JOIN employees ON salaries.emp_no = employees.emp_no
WHERE dept_manager.to_date > curdate() and salaries.to_date > curdate();

-- Find the number of employees in each department.
SELECT departments.dept_no, departments.dept_name, COUNT(*)
from departments
JOIN dept_emp ON dept_emp.dept_no = departments.dept_no
JOIN employees ON dept_emp.emp_no = employees.emp_no
WHERE dept_emp.to_date > CURDATE()
GROUP by departments.dept_no;

-- Which department has the highest average salary?
SELECT dept_name, AVG(salary) as average_salary
FROM departments 
JOIN dept_emp ON departments.dept_no = dept_emp.dept_no
JOIN salaries ON dept_emp.emp_no = salaries.emp_no
WHERE dept_emp.to_date > CURDATE() and salaries.to_date > CURDATE()
Group by dept_name 
Order by average_salary desc 
limit 1;

-- Who is the highest paid employee in the Marketing department?
SELECT first_name, last_name
from employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
JOIN salaries ON employees.emp_no = salaries.emp_no
WHERE dept_emp.to_date > CURDATE() and salaries.to_date > CURDATE() and departments.dept_no = "d001" 
Group by first_name, last_name
Order by avg(salary) desc 
limit 1;

-- Which current department manager has the highest salary?
SELECT first_name, last_name, salary, dept_name
FROM departments
JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
JOIN salaries ON dept_manager.emp_no = salaries.emp_no
JOIN employees ON salaries.emp_no = employees.emp_no
WHERE dept_manager.to_date > curdate() and salaries.to_date > curdate()
Group by first_name, last_name, salary, dept_name
Order by avg(salary) desc 
limit 1;

--10. Bonus Find the names of all current employees, their department name, and their current manager's name.

-- In DB language: 
-- 1. get all employees who are CURRENTLY in a department 
-- (dept_emp, currently -> filter to_date), 
-- 2. and get their name (employees)
-- 3. and get their department name (departments)
-- 4. and add the current manager of each department (dept_manager) (departments, employees)
-- 5. tie those current managers to the employees' departments 

-- 1. 
SELECT de.emp_no, de.dept_no
FROM dept_emp AS de
WHERE de.to_date > curdate();

-- 2. GET EMP NAMES
SELECT de.emp_no, e.emp_no, de.dept_no, e.first_name, e.last_name
FROM dept_emp AS de
JOIN employees AS e ON de.emp_no = e.emp_no
WHERE de.to_date > curdate();

-- 3. GET DEPT NAMES
SELECT de.emp_no, de.dept_no, e.first_name, e.last_name, d.dept_name
FROM dept_emp AS de
JOIN employees AS e ON de.emp_no = e.emp_no
JOIN departments AS d ON de.dept_no = d.dept_no
WHERE de.to_date > curdate();

-- 4. GET CURRENT MANAGER OF EACH DEPARTMENT
SELECT dm.emp_no, dm.dept_no
FROM dept_manager dm
WHERE dm.to_date > curdate();

-- 5. TIE THE MANAGERS DEPARTMENTS WITH THE CURRENT EMPLOYEES DEPARTMENTS, I.E. JOIN
SELECT de.emp_no
        , de.dept_no
        , e.first_name
        , e.last_name
        , d.dept_name
        , dm.emp_no AS mgr_emp_no
FROM dept_emp AS de
JOIN employees AS e ON de.emp_no = e.emp_no
JOIN departments AS d ON de.dept_no = d.dept_no
JOIN dept_manager AS dm ON de.dept_no = dm.dept_no AND dm.to_date > curdate()
WHERE de.to_date > curdate();

-- 6. get managers name by joining manager employee number on employees table
SELECT de.emp_no
        , de.dept_no
        , e.first_name
        , e.last_name
        , d.dept_name
        , dm.emp_no AS mgr_emp_no
        , ee.first_name AS mgr_first
        , ee.last_name AS mgr_last
FROM dept_emp AS de
JOIN employees AS e ON de.emp_no = e.emp_no
JOIN departments AS d ON de.dept_no = d.dept_no
JOIN dept_manager AS dm ON de.dept_no = dm.dept_no AND dm.to_date > curdate()
JOIN employees AS ee ON dm.emp_no = ee.emp_no
WHERE de.to_date > curdate();

-- 7. clean it up to make it look as requested

SELECT CONCAT(emp.first_name, ' ', emp.last_name) AS employee_name
        , d.dept_name
        , CONCAT(manager_emp.first_name, ' ', manager_emp.last_name) AS manager_name
FROM dept_emp AS de
JOIN employees AS emp ON de.emp_no = emp.emp_no
JOIN departments AS d ON de.dept_no = d.dept_no
JOIN dept_manager AS dm ON de.dept_no = dm.dept_no 
        AND dm.to_date > curdate()
JOIN employees AS manager_emp ON dm.emp_no = manager_emp.emp_no
WHERE de.to_date > curdate();


SELECT DISTINCT sub.dept_name
FROM (

SELECT CONCAT(emp.first_name, ' ', emp.last_name) AS employee_name
        , d.dept_name
        , CONCAT(manager_emp.first_name, ' ', manager_emp.last_name) AS manager_name
FROM dept_emp AS de
JOIN employees AS emp ON de.emp_no = emp.emp_no
JOIN departments AS d ON de.dept_no = d.dept_no
JOIN dept_manager AS dm ON de.dept_no = dm.dept_no 
        AND dm.to_date > curdate()
JOIN employees AS manager_emp ON dm.emp_no = manager_emp.emp_no
WHERE de.to_date > curdate()

) AS sub;