SELECT
	addresses.name,
	CASE  
		WHEN EXTRACT(HOUR FROM courses.start) BETWEEN 6 AND 20 THEN 'Day'
		ELSE 'Night'
	END AS day_time,
	courses.bill,
	clients.full_name,
	cars.make,
	cars.model,
	categories.name
FROM
	clients 
JOIN
	courses
ON
	courses.client_id = clients.id
JOIN
	addresses
ON
	addresses.id = courses.from_address_id
JOIN 
	cars 
ON
	cars.id = courses.car_id
JOIN
	categories
ON
	categories.id = cars.category_id
ORDER BY
	courses.id;
