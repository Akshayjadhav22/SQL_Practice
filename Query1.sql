USE sakila;

SELECT * FROM actor;

SELECT first_name, last_name From actor;

SELECT first_name, last_name From actor WHERE actor_id=1;

Select * FROM address;

## Aliasing
SELECT first_name AS "First Name", last_name AS "Last Name" FROM actor;

SELECT first_name AS FirstName, last_name AS LastName FROM actor;

USE hr;

SELECT * FROM employees;

SELECT first_name, last_name FROM employees WHERE employee_id=100;

#Comparison Operators >, <, <= 
SELECT first_name, last_name FROM employees WHERE salary > 10000;
SELECT first_name, last_name FROM employees WHERE salary < 15000;
SELECT first_name, last_name FROM employees WHERE salary = 10000;
SELECT first_name, last_name FROM employees WHERE salary >=10000;
SELECT first_name, last_name FROM employees WHERE salary <=10000;

# AND Operator
SELECT * FROM employees WHERE salary > 5000 AND salary < 15000 AND department_id = 5;

# OR operator
SELECT * FROM employees WHERE salary > 15000 OR department_id = 5;

# Text based filter
SELECT * FROM employees WHERE first_name = "Adam";

# Like Operator
SELECT * FROM employees WHERE first_name LIKE "%S";

# People whose name has r in their name
SELECT * FROM employees WHERE first_name LIKE "%r%";
SELECT first_name FROM employees WHERE first_name LIKE "S%"; 

# _ exactly One Character
SELECT * FROM Employees WHERE first_name LIKE "A_e%";

# Between operator
SELECT * FROM employees WHERE salary BETWEEN 5000 AND 15000;
SELECT * FROM employees WHERE (first_name LIKE "A_e%") AND (salary BETWEEN 5000 AND 15000);

# Betwee Use with Date & Time	
SELECT * FROM employees WHERE hire_date BETWEEN "1990-01-01" AND "1995-01-01";

# IN operator
SELECT * FROM employees WHERE employee_id IN (100,105,107,110,115);


# NOT Operator  - It reverse conditions
SELECT * FROM employees WHERE employee_id NOT IN (100,105,107,110,115);
SELECT * FROM employees WHERE hire_date NOT BETWEEN "1990-01-01" AND "1995-01-01";
SELECT * FROM Employees WHERE first_name NOT LIKE "A_e%";

## Catogories my employees based on their salary (low,medium and high)
# CASE operator

SELECT employee_id, first_name, salary,
CASE
	WHEN salary <= 7000 THEN "Low"
    WHEN salary > 7000 AND salary <= 15000 THEN "Medium"
    WHEN Salary > 15000 THEN "High"
    ELSE "Not Applicable"
END AS "Income Group"
FROM employees;
SELECT employee_id, first_name, salary, case WHEN Salary <=7000 THEN "Low" WHEN Salary > 7000 AND salary <=15000 THEN "Medium" WHEN Salary >15000 THEN "High" END AS "Income Group" FROM employees; 

## SORT ----> ORDER BY
SELECT first_name, Salary
FROM employees
WHERE salary > 5000
ORDER BY salary DESC , first_name DESC;

# JOINT

# CROSS JOIN

USE hr;

SELECT *
FROM employees CROSS JOIN dependents;

# LIST of employees with dependent information (Inner Join)
SELECT e.employee_id, e.first_name, e.last_name, d.dependent_id, d.first_name, d.last_name
FROM employees AS e RIGHT OUTER JOIN dependents AS d
ON e.employee_id = d.employee_id;

SELECT * FROM dependents;
SELECT * FROm employees;

# LIST employees and their manager names
SELECT e.employee_id, e.first_name, e.last_name, m.employee_id, m.first_name, m.last_name
FROM employees AS e LEFT OUTER JOIN employees AS m
ON e.manager_id = m.employee_id
WHERE m.employee_id = 100;

#List all employees and their job title (Emplyee_id, employee name, job title)
USE hr;

SELECT e.employee_id, e.first_name, e.last_name,j.job_title

FROM employees AS e INNER JOIN jobs AS j
ON e.job_id = j.job_id;

# List employees whose salary is greater than 10000 along with their department name(Employee id, Employee name,

SELECT e.employee_id, e.first_name,e.salary,d.department_name
FROM employees AS e INNER JOIN departments AS d
ON e.department_id = d.department_id
WHERE e.salary >10000;

# #List all employees along with their location details (employee_id, employee_name, city, province )
SELECT e.employee_id, e.first_name, l.city, l.state_province
FROM employees AS e INNER JOIN departments AS d
ON e.department_id = d.department_id
INNER JOIN locations AS l
ON d.location_id = l.location_id;

# Shortcut way
SELECT e.employee_id, e.first_name, l.city, l.state_province
FROM employees AS e INNER JOIN departments AS d INNER JOIN locations l
ON e.department_id = d.department_id AND d.location_id = l.location_id;

# Aggregation in MY SQL
# Aggregation Funvtion---- AVG, SUM, COUNT, MIN, MAX
## Clause --- GROUP BY
SELECT AVG(salary)
FROM employees;

# Average salary department wise
SELECT d.department_id,d.department_name, AVG (e.salary)
FROM employees AS e INNER JOIN departments AS d
ON e.department_id = d.department_id
GROUP BY e.department_id
HAVING AVG (e.salary) > 6000;

SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id;

# LIST every department's highest salary (MAX(salary))
SELECT d.department_name, d.department_id, MAX(e.salary)
FROM employees AS e INNER JOIN departments AS d
ON e.department_id = d.department_id
GROUP BY d.department_id;

#LIST number of dependents that each employee has, (COUNT(Column))
SELECT e.employee_id,e.first_name, COUNT(d.dependent_id) AS " No of dependents "
FROM employees AS e INNER JOIN dependents as d
ON e.employee_id = d.employee_id
GROUP BY e.employee_id;

# WHERE & HAVING Operators are same
# LIST every department's highest salary (MAX(salary)) Where highest salary is greater than 10000
SELECT d.department_name, d.department_id, MAX(e.salary)
FROM employees AS e INNER JOIN departments AS d
ON e.department_id = d.department_id
GROUP BY d.department_id
HAVING MAX(e.salary) > 10000
ORDER BY MAX(e.salary) DESC;

SELECT first_name, salary FROM employees
HAVING salary > 10000;

SELECT salary FROM employees
WHERE salary > 10000;

# Find Out number of actors registered in the database
USE sakila;

SELECT COUNT(actor_id) From Actor;

# Find out of number of films each actor has acted in
SELECT COUNT(b.film_id)
FROM film_actor AS b INNER JOIN actor a
ON b.actor_id = a.actor_id
GROUP BY a.actor_id;

# Find out the number of films in each category
SELECT COUNT(f.film_id)
FROM film_category AS f INNER JOIN category AS c
ON f.catogery_id = c.catogery_id
GROUP BY c.category_id;

# Find out the actor with maximum number of films