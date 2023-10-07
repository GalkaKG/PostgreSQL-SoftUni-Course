SELECT
	o.name AS owner,
	count(a.id) AS count_of_animals
FROM 
	animals AS a
JOIN
	owners As o
ON
	o.id = a.owner_id
GROUP BY
	o.name
ORDER BY
	count_of_animals DESC,
	o.name
LIMIT 5;
