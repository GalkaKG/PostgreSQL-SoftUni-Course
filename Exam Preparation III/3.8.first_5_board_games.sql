SELECT
	bg.name,
	bg.rating,
	c.name AS category_name
FROM
	board_games AS bg
JOIN 
	categories AS c
ON c.id = bg.category_id
JOIN
	players_ranges AS pr
ON pr.id = bg.players_range_id
WHERE(
	bg.rating > 7.00 OR bg.name LIKE '%a%'
	AND bg.rating > 7.50
	)
	AND (pr.min_players >= 2 AND pr.max_players <= 5)
ORDER BY
	bg.name,
	bg.rating DESC
LIMIT 5;


-- SELECT
-- 	bg.name,
-- 	bg.rating,
-- 	c.name AS category_name
-- FROM
-- 	board_games AS bg
-- JOIN 
-- 	categories AS c
-- ON c.id = bg.category_id
-- JOIN
-- 	players_ranges AS pr
-- ON pr.id = bg.players_range_id
-- WHERE(
-- 	bg.rating > 7.00 OR 
-- 	(POSITION('a' IN bg.name) > 0) AND bg.rating > 7.50
-- 	)
-- 	AND (pr.min_players >= 2 AND pr.max_players <= 5)
-- ORDER BY
-- 	bg.name,
-- 	bg.rating DESC
-- LIMIT 5;
