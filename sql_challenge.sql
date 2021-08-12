DROP TABLE departments
DROP TABLE dept_emp
DROP TABLE dept_manager
DROP TABLE employees
DROP TABLE salaries
DROP TABLE titles

CREATE TABLE departments (
 id SERIAL Primary Key,  
 dept_no VARCHAR(20) NOT NULL,
 dept_name text NOT NULL);

CREATE TABLE dept_emp (
 emp_no int, 
 dept_no VARCHAR(20));
 
CREATE TABLE dept_manager (
 dept_no VARCHAR(20),
 emp_no int);

CREATE TABLE employees (
 emp_no int Primary Key,
 emp_title_id VARCHAR(20),
 birth_data date,
 first_name VARCHAR(30),
 last_name VARCHAR(30),
 sex VARCHAR (5),
 hire_date date);

CREATE TABLE salaries (
 emp_no int,
 salary int);

CREATE TABLE titles (
 title_id VARCHAR(20),
 title VARCHAR (30))

SELECT * FROM departments
SELECT * FROM dept_emp
SELECT * FROM dept_manager
SELECT * FROM employees
SELECT * FROM salaries
SELECT * FROM titles

-- List the following details of each employee: employee number, last name, first name, sex, and salary
SELECT employees.emp_no, employees.first_name, employees.last_name, salaries.salary
FROM employees
INNER JOIN salaries on 
employees.emp_no = salaries.emp_no;

-- List first name, last name, and hire date for employees who were hired in 1986.
SELECT employees.emp_no, employees.first_name, employees.last_name, employees.hire_date
FROM employees
WHERE DATE_PART('year',hire_date) = 1986

--List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name.
SELECT employees.emp_no, employees.first_name, employees.last_name, dept_manager.dept_no, departments.dept_name
FROM employees
INNER JOIN dept_manager ON
employees.emp_no = dept_manager.emp_no
INNER JOIN departments ON 
departments.dept_no = dept_manager.dept_no

-- List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.first_name, employees.last_name, departments.dept_name
FROM dept_emp
INNER JOIN employees ON
employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON
dept_emp.dept_no = departments.dept_no

-- List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT employees.first_name, employees.last_name, employees.sex
FROM employees
WHERE employees.first_name = 'Hercules' AND employees.last_name like 'B%'

-- List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.first_name, employees.last_name, departments.dept_name
FROM dept_emp
INNER JOIN employees ON
employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON
dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales'

-- List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.first_name, employees.last_name, departments.dept_name
FROM dept_emp
INNER JOIN employees ON
employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON
dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales' OR departments.dept_name = 'Development'

-- In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name)
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC