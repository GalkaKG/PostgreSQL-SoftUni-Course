SELECT
	id,
	first_name,
	last_name,
	trunc(salary, 2),
	department_id,
	CASE department_id
		WHEN 1 THEN 'Management'
		WHEN 2 THEN 'Kitchen Staff'
		WHEN 3 THEN 'Service Staff'
		ELSE 'Other'
	END AS department_name
FROM	
	employees

-- SELECT
-- 	id,
-- 	first_name,
-- 	last_name,
-- 	trunc(salary, 2),
-- 	department_id,
-- 	CASE
-- 		WHEN department_id = 1 THEN 'Management'
-- 		WHEN department_id = 2 THEN 'Kitchen Staff'
-- 		WHEN department_id = 3 THEN 'Service Staff'
-- 		ELSE 'Other'
-- 	END AS department_name
-- FROM	
-- 	employees
