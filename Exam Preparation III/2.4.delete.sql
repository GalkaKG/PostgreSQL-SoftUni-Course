DELETE FROM board_games
WHERE publisher_id IN (
	SELECT p.id FROM publishers AS p
 	JOIN addresses AS a
 	ON a.id = p.address_id
	WHERE a.town LIKE 'L%'
);

DELETE FROM publishers
WHERE address_id IN (
	SELECT id FROM addresses
	WHERE town LIKE 'L%'
);

DELETE FROM addresses
WHERE town LIKE 'L%';
