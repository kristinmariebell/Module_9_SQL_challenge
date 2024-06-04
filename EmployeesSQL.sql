--create the employees table
CREATE TABLE employees (
    emp_no INT  NOT NULL PRIMARY KEY,
    emp_title_id VARCHAR(20)  NOT NULL,
    birth_date DATE  NOT NULL,
    first_name VARCHAR(20)  NOT NULL,
    last_name VARCHAR(20)  NOT NULL,
    sex VARCHAR(5)  NOT NULL,
    hire_date DATE  NOT NULL
    );

--view the empty employees table
SELECT * FROM employees 

--import employees CSV file into the employees table

--view populated employees table
SELECT * FROM employees 
	
--create the departments table
CREATE TABLE departments (
    dept_no VARCHAR(20)  NOT NULL PRIMARY KEY,
    dept_name VARCHAR(20)  NOT NULL 
	);

--view the empty departments table
SELECT * FROM departments

--import departments CSV file into the departments table

--view the populated departments table
SELECT * FROM departments

--create dept_emp table as junction table from employees table and departments table
CREATE TABLE dept_emp (
    emp_no INT   NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    dept_no VARCHAR(5)   NOT NULL,
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	PRIMARY KEY (dept_no, emp_no)
);

--view empty dept_emp table
SELECT * FROM dept_emp

--import dept_emp CSV file into the dept_emp table

--view populated dept_emp table
SELECT * FROM dept_emp

--create dept_manager table as a junction table from departments table and employees table
CREATE TABLE dept_manager (
    dept_no VARCHAR(20)  NOT NULL ,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
    emp_no INT  NOT NULL ,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    PRIMARY KEY (dept_no, emp_no)
);

--view empty dept_manager table
SELECT * FROM dept_manager

--import dept_manager CSV file into the dept_manager table

--view populated dept_manager table
SELECT * FROM dept_manager

--create salaries table
CREATE TABLE salaries (
    emp_no INT  NOT NULL PRIMARY KEY,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	salary INT  NOT NULL 
);

--vew emty salaries table
SELECT * FROM salaries

--import salaries CSV file into the salaries table

--view populated salaries table
SELECT * FROM salaries

--create titles table
CREATE TABLE titles (
    title_id VARCHAR(20)  NOT NULL PRIMARY KEY,
    title VARCHAR(20)  NOT NULL 
);

--view empty titles table
SELECT * FROM titles

--import titles CSV file into the titles table
	
--view populated titles table
SELECT * FROM titles


-----------------------Data Analysis----------------------
--1.	List the employee number, last name, first name, sex, and salary of each employee.
SELECT
employees.emp_no, 
employees.last_name,
employees.first_name,
employees.sex,
salaries.salary
FROM employees
LEFT JOIN salaries
ON employees.emp_no = salaries.emp_no;

--2.	List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT 
first_name, last_name, hire_date
FROM employees
WHERE hire_date >= '1986-01-01' AND hire_date <= '1986-12-31';
	
--3.	List the manager of each department along with their department number, department name, 
--employee number, last name, and first name.
SELECT
dept_manager.emp_no,
dept_manager.dept_no,
departments.dept_name,
employees.last_name, 
employees.first_name
FROM dept_manager
LEFT JOIN departments
ON dept_manager.dept_no = departments.dept_no
LEFT JOIN employees
ON dept_manager.emp_no = employees.emp_no;

--4.	List the department number for each employee along with that employee’s employee number, last name, first name, 
--and department name.
SELECT
dept_emp.dept_no,
employees.emp_no,
employees.last_name,
employees.first_name,
departments.dept_name
FROM dept_emp
LEFT JOIN employees
ON dept_emp.emp_no = employees.emp_no
LEFT JOIN departments
ON dept_emp.dept_no = departments.dept_no;

--5.	List first name, last name, and sex of each employee whose first name is Hercules and whose last name 
--begins with the letter B.
SELECT
first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE '%B%';

--6.	List each employee in the Sales department, including their employee number, last name, and first name.
SELECT
dept_emp.dept_no,
employees.emp_no, 
employees.last_name, 
employees.first_name
FROM dept_emp
INNER JOIN employees
ON dept_emp.emp_no = employees.emp_no
WHERE dept_emp.dept_no = 'd007';

--7.	List each employee in the Sales and Development departments, including their employee number, last name, 
--first name, and department name.
SELECT
dept_emp.dept_no,
departments.dept_name,
employees.emp_no, 
employees.last_name, 
employees.first_name
FROM dept_emp
INNER JOIN employees
ON dept_emp.emp_no = employees.emp_no
INNER JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE dept_emp.dept_no = 'd007' OR dept_emp.dept_no ='d005';

--8.	List the frequency counts, in descending order, of all the employee last names 
--(that is, how many employees share each last name).
SELECT
last_name,
COUNT (*) as all_last_names
FROM employees
GROUP BY last_name
ORDER BY all_last_names DESC;












