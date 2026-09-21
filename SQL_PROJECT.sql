-- Project Name: Employee Database Analysis
-- Project Title: Employee Management & Salary Analysis System.
-- Create a new schema as employees.
CREATE DATABASE employees;
USE employees;
-- Import the dataset employees.csv into MySQL (use Table Data Import Wizard).
SELECT * FROM EMPLOYEES;
-- Basic-Level Question
-- 1.Display all records from the employees table.
   SELECT * FROM employees;
-- 2.Find employees whose first name starts with the letter A.
   SELECT emp_no, first_name, last_name,
       hire_date
FROM employees
WHERE first_name LIKE "A%";
-- 3.Display all employees whose gender is 'M'.
SELECT emp_no,first_name,last_name,
       gender,
       hire_date
FROM employees
WHERE gender = "M";
 
-- 4.Count the total number of employees for each gender.
SELECT 
    COUNT(*) AS COUNT_OF_GENDER, GENDER
FROM
    EMPLOYEES
GROUP BY GENDER;

-- 5.Display employees whose salary is greater than the average salary.
SELECT  e.emp_no,
       CONCAT(e.first_name, " ", e.last_name) AS employee_name,
       s.salary
FROM employees e JOIN salaries s ON e.emp_no = s.emp_no 
      WHERE s.salary > (SELECT AVG(salary) FROM salaries
      WHERE to_date = "9999-01-01") AND s.to_date="9999-01-01";
      
      
-- Advance-Level Questions:
-- 1.Display the name of the top employee with the highest salary among all departments.
SELECT e.emp_no,
       CONCAT(e.first_name, " ", e.last_name) AS employee_name,
       s.salary
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no ORDER BY s.salary DESC LIMIT 1;

-- 2.Each Department-wise average salary?
SELECT d.dept_name,
       ROUND(AVG(s.salary), 2) AS avg_salary
FROM departments d
JOIN dept_emp de
    ON d.dept_no = de.dept_no
JOIN salaries s
    ON de.emp_no = s.emp_no
GROUP BY d.dept_name;

-- 3.Display the employees names along with their department names.
SELECT 
    CONCAT(e.first_name, " ", e.last_name) AS employee_name,
    d.dept_name
FROM employees e
JOIN dept_emp de
    ON e.emp_no = de.emp_no
JOIN departments d
    ON de.dept_no = d.dept_no;
    
-- 4.Display employees who have worked in more than one department.
SELECT e.emp_no,
       e.first_name,
       e.last_name,
       COUNT(DISTINCT de.dept_no) AS total_departments
FROM employees e
JOIN dept_emp de
ON e.emp_no = de.emp_no
GROUP BY e.emp_no, e.first_name, e.last_name
HAVING COUNT(DISTINCT de.dept_no) > 1;

    
-- 5.  Running Total of Salary
-- List the name of employees whose salary is between 50000 and 60000.
select e.emp_no,s.salary from employees e join salaries s on e.emp_no=s.emp_no where s.salary between 140000 and 150000;

SELECT emp_no,
salary,
SUM(salary)
OVER(ORDER BY salary) AS Running_Total
FROM salaries limit 10;

-- 6. Display the top 5 highest-paid employee.
SELECT CONCAT(e.first_name, " ", e.last_name) AS employee_name, s.salary
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no
ORDER BY s.salary DESC
LIMIT 5;

-- 7.Display the current manager of each department.
SELECT d.dept_name,
       CONCAT(e.first_name, " ",e.last_name) AS manager_name
FROM dept_manager dm
JOIN employees e
ON dm.emp_no = e.emp_no
JOIN departments d
ON dm.dept_no = d.dept_no
WHERE dm.to_date = "9999-01-01" ;

-- 8.Find employees who joined in the same year.
SELECT YEAR(hire_date) AS Hire_Year,
       COUNT(*) AS Employee_Count
FROM employees
GROUP BY YEAR(hire_date)
HAVING COUNT(*) > 1;


-- 9.Find employees who have worked for more than 20 years.
SELECT emp_no,
       CONCAT(first_name,' ',last_name) AS employee_name,
       TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) AS experience
FROM employees
WHERE TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) > 30;

-- 10.Find employees whose first name starts with the letter R.
SELECT emp_no,
       first_name,
       last_name,
       hire_date
FROM employees
WHERE first_name LIKE "R%";



-- only it dept
SELECT *
FROM employee_1
WHERE emp_id IN
(
    SELECT emp_id
    FROM dept_2
    WHERE dept_name = 'IT'
);







