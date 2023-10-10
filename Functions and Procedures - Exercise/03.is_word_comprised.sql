CREATE OR REPLACE FUNCTION fn_is_word_comprised(set_of_letters VARCHAR(50), word VARCHAR(50))
RETURNS BOOLEAN
AS
$$
    DECLARE
        i INT;
        letter CHAR(1);
        set_of_letters_lowercase VARCHAR(50);
        word_lowercase VARCHAR(50);
    BEGIN
        set_of_letters_lowercase = LOWER(set_of_letters);
        word_lowercase = LOWER(word);

        i = 1;
        WHILE i <= LENGTH(word_lowercase) LOOP
            letter = SUBSTRING(word_lowercase FROM i FOR 1);
            IF POSITION(letter in set_of_letters_lowercase) = 0 THEN
               RETURN FALSE;
            END IF;
            i = i + 1;
        END LOOP;
        RETURN TRUE;
    END;
$$
LANGUAGE plpgsql;
