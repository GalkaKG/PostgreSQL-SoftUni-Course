SELECT t.town_id, t.name AS town_name, a.address_text
FROM addresses AS a 
JOIN towns AS t
ON t.town_id = a.town_id
WHERE name in ('San Francisco', 'Sofia', 'Carnation')
ORDER BY town_id, address_id;
