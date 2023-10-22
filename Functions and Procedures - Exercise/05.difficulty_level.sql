CREATE OR REPLACE FUNCTION fn_difficulty_level(level INT)
RETURNS VARCHAR(50) AS $$
BEGIN
    IF level <= 40 THEN
        RETURN 'Normal Difficulty';
    ELSIF level BETWEEN 41 AND 60 THEN
        RETURN 'Nightmare Difficulty';
    ELSE RETURN 'Hell Difficulty';
    END IF;
END;
$$ LANGUAGE plpgsql;

SELECT
    ug.user_id,
    ug.level,
    ug.cash,
    fn_difficulty_level(ug.level) AS difficulty_level
FROM users_games ug
ORDER BY ug.user_id ASC;
