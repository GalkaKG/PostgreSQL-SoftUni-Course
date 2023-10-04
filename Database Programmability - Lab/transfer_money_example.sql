-- CREATE and INSERT into table
CREATE TABLE bank(
	id SERIAL,
	name VARCHAR(25),
	amount FLOAT
);

INSERT INTO bank (name, amount)
VALUES
	('Ivan', 1000),
	('Peter', 300);

SELECT * FROM bank;

-- Create transfer procedure
CREATE OR REPLACE PROCEDURE p_transfer_money(
	IN sender_id INT,
	IN receiver_id INT,
	IN transfer_amount FLOAT,
	OUT status VARCHAR
) AS
$$
	DECLARE
		sender_amount FLOAT;
		receiver_amount FLOAT;
		temp_val FLOAT;
	BEGIN
		SELECT b.amount FROM bank AS b
		WHERE id = sender_id
		INTO sender_amount;
		IF sender_amount < transfer_amount THEN
			status := 'Not enough money';
			RETURN;
		END IF;
		SELECT b.amount FROM bank AS b WHERE id = receiver_id INTO receiver_amount;
		UPDATE bank SET amount = amount - transfer_amount WHERE id = sender_id;
		UPDATE bank SET amount = amount + transfer_amount WHERE id = receiver_id;
		SELECT b.amount FROM bank AS b WHERE id = sender_id INTO temp_val;
		IF sender_amount - transfer_amount <>  temp_val THEN
			status = 'Error in sender';
			ROLLBACK;
			RETURN;
		END IF;
		SELECT b.amount FROM bank AS b WHERE id = receiver_id INTO temp_val;
		IF receiver_amount + transfer_amount <> temp_val THEN
			status := 'Error in receiver';
			ROLLBACK;
			RETURN;
		END IF;
		status := 'Transfer done';
		COMMIT;
		RETURN;
	END;
$$
LANGUAGE plpgsql;

-- Tests examples
CALL p_transfer_money(2, 1, 500, NULL);
CALL p_transfer_money(1, 2, 500, NULL);
SELECT * FROM bank;
