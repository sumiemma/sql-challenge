-- create tables for all the CSVs


-- create table for departments CSV
CREATE TABLE departments (
	dept_no VARCHAR,
	dept_name VARCHAR,
	PRIMARY KEY (dept_no)
);

SELECT *
FROM departments;


-- create table for dept_emp CSV
CREATE TABLE dept_emp (
 	emp_no INT,
 	dept_no VARCHAR
);

SELECT *
FROM dept_emp;


-- create table for dept_manager CSV
CREATE TABLE dept_manager (
 	dept_no VARCHAR,
 	emp_no INT
);

SELECT *
FROM dept_manager;


-- create table for salaries CSV
CREATE TABLE salaries (
 	emp_no INT,
 	salary INT
);

SELECT *
FROM salaries;


-- create table for titles CSV
CREATE TABLE titles (
 	title_id VARCHAR,
 	title VARCHAR,
	PRIMARY KEY (title_id)
);

SELECT *
FROM titles;


-- create table for employees CSV
CREATE TABLE employees (
 	emp_no INT,
 	emp_title VARCHAR,
	birth_date DATE,
	first_name VARCHAR,
	last_name VARCHAR,
	sex VARCHAR,
	hire_date DATE,
	PRIMARY KEY (emp_no)
);

SELECT *
FROM employees;



-- question 1: list emp_no, last name, first name, sex and salary of each employee
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
INNER JOIN salaries ON
employees.emp_no = salaries.emp_no;



-- question 2: list first name, last name and hire date for employees who were hired in 1986
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date >= '1986-1-1' AND hire_date < '1987-1-1';


-- question 3: list manager of each department along with dept_no, dept_name, emp_no, last_name and first_name
SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM departments
INNER JOIN dept_manager ON
departments.dept_no = dept_manager.dept_no
INNER JOIN employees ON
employees.emp_no = dept_manager.emp_no;


-- question 4: list department number for each employee with emp_no, last_name, first_name and dept_name
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
INNER JOIN departments ON
departments.dept_no = dept_emp.dept_no
INNER JOIN employees ON
employees.emp_no = dept_emp.emp_no;


-- list first_name, last_name and sex for 'Hercules' and last names beginning with 'B'
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';


-- question 6: list employees in sales, emp_no, last_name and first_name
SELECT emp_no, last_name, first_name
FROM employees
WHERE emp_no IN (SELECT emp_no
				FROM dept_emp
				WHERE dept_no IN (SELECT dept_no
								FROM departments
								WHERE dept_name = 'Sales'))
ORDER BY emp_no ASC;


-- question 7: list employee in Sales and Development, emp_no, last_name, first_name and dept_name
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
INNER JOIN departments ON
departments.dept_no = dept_emp.dept_no
INNER JOIN employees ON
employees.emp_no = dept_emp.emp_no
WHERE dept_name = 'Sales' OR dept_name = 'Development';


--question 8: list frequency counts in DESC of all employees last name
SELECT last_name, count(last_name) AS "Number of last name"
FROM employees
GROUP BY last_name
ORDER BY count(last_name) DESC;
