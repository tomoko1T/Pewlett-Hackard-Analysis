--Deliverable 1

-- Retrieve employees table 
SELECT emp_no, first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'

-- Retrieve titles table
SELECT title, from_date, to_date
FROM titles

-- Drop table if exists
DROP TABLE retirement_info;

--Create a new table using the INTO clause.
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT * FROM retirement_info;

--Join both tables on the primary key.
---where the two tables are linked with the ON clause
SELECT retirement_info.emp_no,
 	   retirement_info.first_name,
	   retirement_info.last_name,
       titles.title,
       titles.from_date,
       titles.to_date
INTO retirement_titles
FROM retirement_info
LEFT JOIN titles
ON retirement_info.emp_no = titles.emp_no
ORDER BY "emp_no" ASC;

SELECT * FROM retirement_titles;

---Retrieve the employee number, first and last name, and title columns 
---from the Retirement Titles table.
SELECT emp_no, first_name, last_name, title
FROM retirement_titles

DROP TABLE unique_titles

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no ASC, to_date DESC;

SELECT * FROM unique_titles;

DROP TABLE retiring_titles

---Retrieve the number of titles from the Unique Titles table.
SELECT COUNT(title),title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

SELECT * FROM retiring_titles;

--Deliverable 2

-- Retrieve employees table 
SELECT emp_no, first_name, last_name, birth_date
FROM employees

---Retrieve the from_date and to_date columns from the Department Employee table.
SELECT from_date, to_date
FROM dept_emp

---Retrieve the title column from the Titles table.
SELECT title
FROM titles 


---Create a new table using the INTO clause
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
birth_date
INTO ment_elig
FROM employees;

SELECT * FROM ment_elig;
DROP TABLE ment_elig;

---Write a query to create a Mentorship Eligibility table that holds the employees
---who are eligible to participate in a mentorship program.
SELECT DISTINCT ON (emp_no) e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
t.title
INTO ment_elig
FROM employees as e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01')
	AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;

SELECT * FROM ment_elig;

--How many employees are eligeable for mentorship?
SELECT COUNT(first_name) AS "Emp eligible for mentorship"
FROM ment_elig


---Retrieve the number of employees elibible for mentorship by title.
SELECT COUNT(title), title AS "Employees eligile for mentorship"
FROM ment_elig
GROUP BY title
ORDER BY count DESC;

DROP TABLE backups;

--- Are there current employees who were born from 1966-01-01 to 1967-12-31 in employee data sheet? 
SELECT DISTINCT ON (emp_no) e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
t.title
INTO backups
FROM employees as e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01')
	AND (e.birth_date BETWEEN '1966-01-01' AND '1967-12-31')
ORDER BY emp_no;

SELECT * FROM backups;

