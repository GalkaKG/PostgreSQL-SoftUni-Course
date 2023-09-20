SELECT
	population,
	LENGTH(CAST(population AS VARCHAR)) AS "lenght"
FROM
	countries;
