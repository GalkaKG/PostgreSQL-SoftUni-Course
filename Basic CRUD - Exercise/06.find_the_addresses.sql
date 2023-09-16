SELECT
	"id",
	CONCAT(number, ' ', street) AS "Address",
	"city_id"
FROM addresses
WHERE ID >= 20
