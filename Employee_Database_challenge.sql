--1.  First Query. Retrieve information from employees table
SELECT employees.emp_no,
employees.first_name, 
employees.last_name, 
titles.title, 
titles.from_date, 
titles.to_date
INTO retirement_titles
FROM employees
INNER JOIN titles
ON (employees.emp_no = titles.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY employees.emp_no;


-- 2. --Second Query Use Distinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) retirement_titles.emp_no, 
retirement_titles.first_name, 
retirement_titles.last_name,
retirement_titles.title
INTO unique_titles
FROM retirement_titles
WHERE retirement_titles.to_date = ('9999-01-01')
ORDER BY retirement_titles.emp_no, retirement_titles.to_date DESC;

-- 3.  Third Query-Retiring Titles
SELECT COUNT(unique_titles.title), unique_titles.title
INTO retiring_titles
FROM unique_titles
GROUP BY unique_titles.title
ORDER BY COUNT(unique_titles.title) DESC;

--Deliverable 2
SELECT DISTINCT ON (emp_no) 
employees.emp_no, 
employees.first_name,
employees.last_name,
employees.birth_date,
dept_emp.from_date,
dept_emp.to_date,
titles.title
INTO mentorship_eligibility
FROM employees
INNER JOIN dept_emp
ON (employees.emp_no = dept_emp.emp_no)
INNER JOIN titles
ON (employees.emp_no = titles.emp_no)
WHERE dept_emp.to_date = ('9999-01-01')
AND (employees.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY (employees.emp_no), titles.title ASC;