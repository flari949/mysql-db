DROP TABLE IF EXISTS playlist;
DROP TABLE IF EXISTS playlists;

CREATE TABLE playlist(
    playlist_id          INT              PRIMARY KEY,
    playlist_name        VARCHAR(15)      NOT NULL
);

CREATE TABLE playlists(
    user_id             VARCHAR(15)        NOT NULL,
    playlist_id         INT                NOT NULL
    PRIMARY KEY (playlist_id, user_id),
    FOREIGN KEY (playlist_id) REFERENCES playlist(playlist_id),
    FOREIGN KEY (user_id) REFERENCES individual(user_id)
);

COMMIT;