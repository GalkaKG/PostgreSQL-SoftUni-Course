CREATE OR REPLACE FUNCTION fn_creator_with_board_games(first_name_of_creator VARCHAR(30))
RETURNS INT AS
$$
	BEGIN
		RETURN(
			SELECT 
				count(cbg.creator_id)
			FROM
				creators AS c
			JOIN 
				creators_board_games AS cbg
			ON
				c.id = cbg.creator_id
			WHERE 
				c.first_name = first_name_of_creator
		);
	END;
$$
LANGUAGE plpgsql


-- SELECT fn_creator_with_board_games('Bruno') 
-- SELECT fn_creator_with_board_games('Alexander')
