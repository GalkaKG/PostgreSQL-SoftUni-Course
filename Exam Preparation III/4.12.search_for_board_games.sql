CREATE TABLE search_results (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    release_year INT,
    rating FLOAT,
    category_name VARCHAR(50),
    publisher_name VARCHAR(50),
    min_players VARCHAR(50),
    max_players VARCHAR(50)
);

CREATE OR REPLACE PROCEDURE usp_search_by_category(category VARCHAR(50))
AS
$$
	BEGIN
		TRUNCATE search_results;
		INSERT INTO search_results (name, release_year, rating, category_name, publisher_name, min_players, max_players)
		SELECT
			bg.name,
			bg.release_year,
			bg.rating,
			c.name AS category_name,
			p.name AS publisher_name,
			pr.min_players::VARCHAR || ' ' || 'people' AS min_player,
			pr.max_players::VARCHAR || ' ' || 'people' AS max_player
		FROM
			board_games AS bg
		JOIN
			players_ranges AS pr
		ON
			bg.players_range_id = pr.id
		JOIN
			publishers AS p
		ON
			p.id = bg.publisher_id
		JOIN
			categories AS c
		ON
			c.id = bg.category_id
		WHERE 
			c.name = category
		ORDER BY
			publisher_name,
			release_year DESC;
	END;
$$
LANGUAGE plpgsql

-- CALL usp_search_by_category('Wargames')

-- SELECT * FROM search_results;
