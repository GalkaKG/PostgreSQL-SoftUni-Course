CREATE OR REPLACE PROCEDURE sp_withdraw_money(
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
        IF (SELECT balance FROM accounts WHERE id = account_id ) > money_amount
            THEN
            UPDATE accounts
            SET balance = balance - money_amount
            WHERE id = account_id;
            COMMIT;
        ELSE RAISE NOTICE 'Insufficient balance for withdrawal.';
        END IF;
    END IF;
END; $$;
