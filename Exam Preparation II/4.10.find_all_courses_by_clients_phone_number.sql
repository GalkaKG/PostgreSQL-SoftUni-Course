CREATE OR REPLACE FUNCTION fn_courses_by_client(phone_num VARCHAR(20))
RETURNS INT
AS $$
	BEGIN
		RETURN(
			SELECT
				COUNT(courses.client_id) 
			FROM 
				clients
			JOIN 
				courses ON courses.client_id = clients.id
			WHERE
				clients.phone_number = phone_num
		);
	END;
$$
LANGUAGE plpgsql;

SELECT fn_courses_by_client('(803) 6386812');
SELECT fn_courses_by_client('(831) 1391236');
SELECT fn_courses_by_client('(704) 2502909');
