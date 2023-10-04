CREATE OR REPLACE FUNCTION fn_count_employees_by_town(town_name VARCHAR(20))
RETURNS INT AS
$$
	DECLARE
	empl_count INT;
	BEGIN
		SELECT
			count(*)
		FROM
			employees AS e
		JOIN
			addresses AS a
		USING
			(address_id)
		JOIN 
			towns AS t
		USING
			(town_id)
		WHERE t.name = town_name
		INTO empl_count;
		RETURN empl_count;
	END
$$
LANGUAGE plpgsql;
