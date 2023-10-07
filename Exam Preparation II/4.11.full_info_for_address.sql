CREATE TABLE IF NOT EXISTS search_results(
	id SERIAL PRIMARY KEY,
	address_name VARCHAR(50),
	full_name VARCHAR(100),
	level_of_bill VARCHAR(20),
	make VARCHAR(30),
	condition CHAR(1),
	category_name VARCHAR(50)
);


CREATE OR REPLACE PROCEDURE sp_courses_by_address(IN address_name VARCHAR(100))
AS $$
	BEGIN
		TRUNCATE search_results;
		INSERT INTO search_results(address_name, full_name, level_of_bill, make, condition, category_name)
		SELECT
			addresses.name AS address_name,
			clients.full_name,
			CASE
				WHEN courses.bill <= 20 THEN 'Low'
				WHEN courses.bill <= 30 THEN 'Medium'
				ELSE 'High'
			END AS level_of_bill,
			cars.make,
			cars.condition,
			categories.name AS category
		FROM
			courses
		JOIN
			cars
		ON 
			cars.id = courses.car_id
		JOIN
			addresses
		ON 
			addresses.id = courses.from_address_id
		JOIN
			categories
		ON categories.id = cars.category_id
		JOIN
			clients
		ON clients.id = courses.client_id
		WHERE addresses.name = address_name
		ORDER BY cars.make, clients.full_name;
	END;
$$
LANGUAGE plpgsql;
