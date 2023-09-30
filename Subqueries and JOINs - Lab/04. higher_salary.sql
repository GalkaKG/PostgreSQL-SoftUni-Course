SELECT
	COUNT(*)
FROM employees
WHERE salary > (SELECT avg(salary) FROM employees);
