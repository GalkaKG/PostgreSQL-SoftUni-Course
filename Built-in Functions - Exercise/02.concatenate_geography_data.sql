CREATE OR REPLACE VIEW
	view_continents_countries_currencies_details
AS SELECT
	CONCAT(continent_name, ': ', cont.continent_code) AS "Continent Details",
	CONCAT_WS(' - ', cntr.country_name, cntr.capital, cntr.area_in_sq_km, 'km2') AS "Country Information",
	CONCAT(curr.description, ' (', curr.currency_code, ')') AS "Currencies"
FROM
	continents AS cont,
	countries AS cntr,
	currencies AS curr
WHERE
	cont.continent_code = cntr.continent_code
		AND 
	cntr.currency_code = curr.currency_code
ORDER BY
	"Country Information" ASC,
	"Currencies" ASC;
