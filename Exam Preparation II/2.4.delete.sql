DELETE FROM clients CASCADE
WHERE 
	id NOT IN (SELECT client_id FROM courses)
	AND LENGTH(full_name) > 3;
