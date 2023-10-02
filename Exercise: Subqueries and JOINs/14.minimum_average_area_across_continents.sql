SELECT
	min(average) AS min_average_area
FROM (
	SELECT
		avg(area_in_sq_km) AS average
	FROM
		countries
	GROUP BY
		continent_code)
AS average_area;
