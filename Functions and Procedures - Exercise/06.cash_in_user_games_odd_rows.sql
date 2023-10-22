CREATE OR REPLACE FUNCTION fn_cash_in_users_games(game_name VARCHAR(50))
RETURNS TABLE (total_cash NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT ROUND(SUM(cash)::NUMERIC, 2) AS total_cash
    FROM (
        SELECT cash,
               ROW_NUMBER() OVER (ORDER BY cash DESC) AS row_num
        FROM users_games
        JOIN games g on g.id = users_games.game_id
        WHERE g.name = game_name
    ) AS ranked_rows
    WHERE row_num % 2 <> 0;
END;
$$ LANGUAGE plpgsql;
