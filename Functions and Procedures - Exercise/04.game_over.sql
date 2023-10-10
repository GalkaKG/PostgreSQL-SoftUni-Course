CREATE OR REPLACE FUNCTION fn_is_game_over(is_game_over BOOLEAN)
RETURNS TABLE (game_name VARCHAR(50), game_type_id INT, is_finished BOOL) AS $$
BEGIN
    RETURN QUERY
    SELECT
        g.name AS "name",
        g.game_type_id,
        g.is_finished
    FROM games g
    WHERE g.is_finished = is_game_over;
END;
$$ LANGUAGE plpgsql;

SELECT fn_is_game_over(true);
SELECT fn_is_game_over(false);
