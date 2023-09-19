DROP TABLE IF EXISTS artist;
DROP TABLE IF EXISTS aliases;


CREATE TABLE artist(
    artist_id          INT              PRIMARY KEY,
    artist_name        VARCHAR(30)      NOT NULL
    user_id            VARCHAR(15)      NOT NULL,
    FOREIGN KEY (user_id) REFERENCES individual(user_id)
);

CREATE TABLE aliases(
    artist_id          INT              NOT NULL,
    artist_name        VARCHAR(30)      NOT NULL
    FOREIGN KEY (artist_id) REFERENCES artist(artist_id)
);

COMMIT;