SELECT
	department_id,
	count(salary) as employee_count
FROM	
	employees
GROUP BY department_id
ORDER by department_id;
