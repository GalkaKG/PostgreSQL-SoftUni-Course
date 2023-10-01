SELECT 
	a.name,
	sum(b.booked_for) AS sum
FROM bookings AS b
JOIN apartments AS a
USING(apartment_id)
GROUP BY a.name
ORDER BY a.name;
