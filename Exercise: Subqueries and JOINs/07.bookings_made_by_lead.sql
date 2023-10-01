SELECT 
	b.apartment_id,
	b.booked_for,
	c.first_name,
	c.country
FROM bookings AS b
INNER JOIN customers AS c
USING(customer_id)
WHERE job_type = 'Lead';
