DROP TABLE IF EXISTS individual;
DROP TABLE IF EXISTS account;


CREATE TABLE individual(
    user_id             VARCHAR(15)     PRIMARY KEY,
    user_name           VARCHAR(30)     NOT NULL,
    birth_date          VARCHAR         NOT NULL
);

CREATE TABLE account(
    user_id             VARCHAR(15)     NOT NULL,
    email               VARCHAR(30)     NOT NULL,
    age_restricted      BOOLEAN         NOT NULL,
    FOREIGN KEY (user_id) REFERENCES individual(user_id)
);

COMMIT