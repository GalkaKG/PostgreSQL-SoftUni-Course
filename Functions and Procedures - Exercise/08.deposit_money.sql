CREATE OR REPLACE PROCEDURE sp_deposit_money(
    account_id INT,
    money_amount NUMERIC(20, 4)
    )
LANGUAGE plpgsql
AS $$
BEGIN
    IF EXISTS (
            SELECT 1 FROM accounts
            WHERE id = account_id
        ) THEN
        UPDATE accounts
        SET balance = balance + money_amount
        WHERE id = account_id;
        COMMIT;
    END IF;
END; $$;
