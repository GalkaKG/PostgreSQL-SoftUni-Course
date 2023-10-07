SELECT
	a.name AS animal,
	EXTRACT(YEAR FROM a.birthdate) AS birth_year,
	at.animal_type
FROM
	animals AS a
JOIN
	animal_types AS at
ON
	at.id = a.animal_type_id
LEFT JOIN
	OWNERS as o
ON
	o.id = a.owner_id
WHERE 	
	o.id IS NULL
	AND at.animal_type != 'Birds'
	AND a.birthdate >= '2017-01-01'
  AND a.birthdate < '2023-01-01'
ORDER BY
	a.name

-- SELECT
--     a.name AS animal_name,
--     EXTRACT(YEAR FROM a.birthdate) AS birth_year,
--     at.animal_type
-- FROM
--     animals AS a
-- JOIN
--     animal_types AS at
-- ON
--     a.animal_type_id = at.id
-- LEFT JOIN
--     owners AS o
-- ON
--     a.owner_id = o.id
-- WHERE
--     o.id IS NULL
--     AND at.animal_type != 'Birds'
--     AND EXTRACT(YEAR FROM AGE('2022-01-01', a.birthdate)) < 5
-- ORDER BY
--     a.name ASC;
