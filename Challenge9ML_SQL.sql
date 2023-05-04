--Begining of project, drop tables

DROP TABLE salaries;
DROP TABLE employees;
DROP TABLE titles;
DROP TABLE dept_manager;
DROP TABLE dept_emp;
DROP TABLE departments;


--Create departments table
CREATE TABLE departments (
dept_no VARCHAR PRIMARY KEY NOT NULL,
dept_name VARCHAR NOT NULL

);

--Create dept_emp table (make sure when importing to uncheck emp_id in columns to import)
DROP TABLE dept_emp;

CREATE TABLE dept_emp(
	emp_id SERIAL PRIMARY KEY,
	emp_no INTEGER NOT NULL,
	dept_no VARCHAR NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

SELECT * FROM dept_emp;


--Create dept_manager table (make sure when importing to uncheck id_man in columns to import)
Drop table dept_manager;

CREATE TABLE dept_manager (
id_man SERIAL PRIMARY KEY,
dept_no VARCHAR NOT NULL,
FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
emp_no INTEGER NOT NULL

);

SELECT * FROM dept_manager;

--Create titles table
CREATE TABLE titles (
title_id VARCHAR PRIMARY KEY NOT NULL,
title VARCHAR NOT NULL

);

--Create employees table
DROP TABLE employees;

CREATE TABLE employees (
	--emp2_id SERIAL PRIMARY KEY,
	emp_no INTEGER NOT NULL,
	--FOREIGN KEY (emp_no) REFERENCES dept_emp(emp_no),
	emp_title_id VARCHAR NOT NULL,
	FOREIGN KEY (emp_title_id) REFERENCES titles(title_id),
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	sex VARCHAR(1) NOT NULL,
	hire_date DATE NOT NULL
);


ALTER TABLE employees
ADD PRIMARY KEY (first_name,last_name, birth_date, hire_date, sex);

SELECT * FROM employees;

--Create salaries table
DROP TABLE salaries;

CREATE TABLE salaries (
	salary_id SERIAL PRIMARY KEY,
	emp_no INTEGER NOT NULL,
	--FOREIGN KEY (emp_no) REFERENCES dept_emp(emp_no),
	salary INTEGER NOT NULL
);	

SELECT * FROM salaries;

--Data Visualization (1): List the employee number, last name, first name, sex, and salary of each employee

SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
LEFT JOIN salaries ON employees.emp_no = salaries.emp_no;

--Data Visualization (2): List the first name, last name, and hire date for the employees who were hired in 1986 

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

--Data Visualization (3): List the manager of each department along with their department number, 
--department name, employee number, last name, and first name 

SELECT dept_manager.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM dept_manager
LEFT JOIN departments ON dept_manager.dept_no = departments.dept_no
LEFT JOIN employees ON dept_manager.emp_no = employees.emp_no;

--Data Visualization (4): List the department number for each employee along with 
--that employee’s employee number, last name, first name, and department name 

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
LEFT JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
LEFT JOIN departments ON dept_emp.dept_no = departments.dept_no;

--Data Visualizaion (5): List first name, last name, and sex of each employee 
--whose first name is Hercules and whose last name begins with the letter B

SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name::text LIKE 'B%';

--Data Visualization (6): List each employee in the Sales department, including their employee number, last name, and first name 

SELECT * FROM departments;

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
LEFT JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
LEFT JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_no = 'd007';

--Data Visualization (7): List each employee in the Sales and Development departments, 
--including their employee number, last name, first name, and department name 

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
LEFT JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
LEFT JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_no = 'd007' OR departments.dept_no = 'd005'

--Data Visualizaion (8): List the frequency counts, in descending order, of all the employee last names (that is, 
--how many employees share each last name) 

SELECT last_name, COUNT(last_name) AS "Frequency Counts"
FROM employees
GROUP BY last_name
ORDER BY "Frequency Counts" DESC;

--END...


