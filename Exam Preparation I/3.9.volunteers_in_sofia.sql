SELECT
	v.name,
	v.phone_number,
	REPLACE(REPLACE(address, 'Sofia', ''), ',', '') AS address
FROM
	volunteers AS v
JOIN	
	volunteers_departments AS vp
ON
	v.department_id = vp.id
WHERE
	vp.department_name = 'Education program assistant' AND v.address LIKE '%Sofia%'
ORDER BY	
	v.name;
	
