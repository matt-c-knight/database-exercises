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
WHERE titles.to_date > curdate() and departments.dept_no = "d009"
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