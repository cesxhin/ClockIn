CREATE DATABASE clockin OWNER root;
\connect clockin;

/* account */
CREATE TABLE IF NOT EXISTS account(
    username varchar(250) primary key not null,
    role integer default 0
);
CREATE INDEX IF NOT EXISTS account_username_index ON account (username);


/* ticket */
CREATE TABLE IF NOT EXISTS ticket(
    id serial primary key,
    username varchar(250) REFERENCES account(username) ON DELETE CASCADE not null,
    start_date TIMESTAMP not null,
    end_date TIMESTAMP default NULL,
    comment varchar(500)
);
CREATE INDEX IF NOT EXISTS ticket_id_index ON ticket (id);
CREATE INDEX IF NOT EXISTS ticket_username_index ON ticket (username);
CREATE INDEX IF NOT EXISTS ticket_start_date_index ON ticket (start_date);
CREATE INDEX IF NOT EXISTS ticket_end_date_index ON ticket (end_date);

CREATE TABLE IF NOT EXISTS v_ticket(
    version_table integer primary key
);

CREATE TABLE IF NOT EXISTS v_account(
    version_table integer primary key
);

DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM v_ticket) THEN
        INSERT INTO v_ticket
        VALUES (1);
    END IF;
END $$;

DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM v_account) THEN
        INSERT INTO v_account
        VALUES (2);
    END IF;
END $$;