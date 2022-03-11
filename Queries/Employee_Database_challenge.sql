SELECT e.emp_no, e.first_name, e.last_name, titles.title, titles.from_date, titles.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles
ON (titles.emp_no = e.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1952-12-31')
ORDER BY emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

-- Creating retiring_titles.csv
SELECT COUNT(emp_no), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT DESC;

-- Creating mentorship_eligibility.csv
SELECT DISTINCT ON (emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, t.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
ON (de.emp_no = e.emp_no)
INNER JOIN titles as t
ON (t.emp_no = e.emp_no)
WHERE de.to_date = '9999-01-01'
AND birth_date BETWEEN '1965-01-01' and '1965-12-31'
ORDER BY emp_no;
