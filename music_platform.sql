USE company;

DROP TABLE IF EXISTS releases;
DROP TABLE IF EXISTS album_songs;
DROP TABLE IF EXISTS playlists_of;
DROP TABLE IF EXISTS playlist_songs;
DROP TABLE IF EXISTS playlist;
DROP TABLE IF EXISTS writes;
DROP TABLE IF EXISTS features_on;
DROP TABLE IF EXISTS accounts;
DROP TABLE IF EXISTS aliases;
DROP TABLE IF EXISTS writer;
DROP TABLE IF EXISTS pop;
DROP TABLE IF EXISTS rock;
DROP TABLE IF EXISTS jazz;
DROP TABLE IF EXISTS song;
DROP TABLE IF EXISTS album;
DROP TABLE IF EXISTS artist;
DROP TABLE IF EXISTS individual;
DROP TABLE IF EXISTS recording_label;


CREATE TABLE individual(
    user_id             VARCHAR(15)     PRIMARY KEY,
    user_name           VARCHAR(30)     NOT NULL,
    birth_date          VARCHAR(10)     NOT NULL
);

INSERT INTO individual VALUES
    ("AAA", "John Doe", "1982-01-01");
INSERT INTO individual VALUES
    ("BBB", "Cheryl Bones", "2011-09-17");
INSERT INTO individual VALUES
    ("CCC", "Harry", "2001-02-20");


CREATE TABLE accounts(
    user_id             VARCHAR(15)     NOT NULL,
    email               VARCHAR(30)     NOT NULL,
    age_restricted      BOOLEAN         NOT NULL,
    FOREIGN KEY (user_id) REFERENCES individual(user_id)
);

INSERT INTO accounts VALUES
    ("AAA", "John@email.com", 0);
INSERT INTO accounts VALUES
    ("BBB", "Cheryl@hotmail.co.nz", 0);
INSERT INTO accounts VALUES
    ("CCC", "Hazza@outlook.com", 1);


CREATE TABLE artist(
    artist_id          INT              PRIMARY KEY,
    artist_name        VARCHAR(30)      NOT NULL,
    user_id            VARCHAR(15)      NOT NULL,
    FOREIGN KEY (user_id) REFERENCES individual(user_id)
);

INSERT INTO artist VALUES
    (1, "Nubble", "AAA");
INSERT INTO artist VALUES
    (2, "Mary Well", "CCC");


CREATE TABLE aliases(
    artist_id          INT              NOT NULL,
    artist_name        VARCHAR(30)      NOT NULL,
    FOREIGN KEY (artist_id) REFERENCES artist(artist_id)
);

INSERT INTO aliases VALUES
    (1, "Goofy");


CREATE TABLE writer(
    writer_id           INT             PRIMARY KEY,
    writer_name         VARCHAR(200)    NOT NULL
);

INSERT INTO writer VALUES
    (1, "Ben Glove");
INSERT INTO writer VALUES
    (2, "CJ");


CREATE TABLE recording_label(
   label_name		    VARCHAR(30) 	NOT NULL,
   label_branch		    VARCHAR(30) 	NOT NULL,
   PRIMARY KEY (label_name, label_branch)
   );

INSERT INTO recording_label VALUES
    ("Music co", "Dunedin");
INSERT INTO recording_label VALUES
    ("Music co", "Christchurch");
INSERT INTO recording_label VALUES
    ("Wacky Records", "Dunedin");
    

CREATE TABLE album(
   album_id			    VARCHAR(15)  	PRIMARY KEY,
   title      		    VARCHAR(15)		NOT NULL,
   release_date		    DATE 			NOT NULL
   );

INSERT INTO album VALUES
    ("ABC123", "Green Album", "2002-01-12");
INSERT INTO album VALUES
    ("TRA111", "Wonder", "2010-05-29");
INSERT INTO album VALUES
    ("POI909", "NEVER", "2022-11-11");


CREATE TABLE song(
    track_id            INTEGER         PRIMARY KEY,
    song_name           VARCHAR(200),
    num_artists         INT             DEFAULT 1,
    date_released       DATE            NOT NULL,
    lead_artist_id      INTEGER         NOT NULL,
    FOREIGN KEY (lead_artist_id) REFERENCES artist(artist_id)
);

INSERT INTO song VALUES
    (1, "Saturday Blues", 1, "2001-02-02", 1);
INSERT INTO song VALUES
    (2, "Only Us", 1, "2001-02-02", 1);
INSERT INTO song VALUES
    (3, "Yesterday", 1, "1966-02-08", 2);
INSERT INTO song VALUES
    (4, "Highs and Lows", 1, "2008-12-22", 1);


CREATE TABLE pop(
    track_id            INTEGER         NOT NULL,
    bpm                 INTEGER,
    FOREIGN KEY (track_id) REFERENCES song(track_id)
);

INSERT INTO pop VALUES
    (1, 100);


CREATE TABLE rock(
    track_id            INTEGER         NOT NULL,
    vocals              BOOLEAN,
    FOREIGN KEY (track_id) REFERENCES song(track_id)
);

INSERT INTO rock VALUES
    (1, 1);
INSERT INTO rock VALUES
    (2, 0);
INSERT INTO rock VALUES
    (3, 1);


CREATE TABLE jazz(
    track_id            INTEGER         NOT NULL,
    jazz_style          VARCHAR(200), 
    FOREIGN KEY (track_id) REFERENCES song(track_id)
);

INSERT INTO jazz VALUES
    (4, "Groovy");


CREATE TABLE features_on (
  track_id              INT             NOT NULL,
  artist_id             INT             NOT NULL,
  PRIMARY KEY (track_id, artist_id),
  FOREIGN KEY (track_id) REFERENCES song(track_id),
  FOREIGN KEY (artist_id) REFERENCES artist(artist_id)
);

-- Triggers to maintain SONG entity attribute artist_count
DROP TRIGGER IF EXISTS update_song_artist_count_insert;
DROP TRIGGER IF EXISTS update_song_artist_count_delete;
DELIMITER //
-- Trigger for updating song artist count on Update
CREATE TRIGGER update_song_artist_count_insert
AFTER INSERT ON features_on
FOR EACH ROW
BEGIN
    UPDATE song
    SET num_artists = num_artists + 1
    WHERE song.track_id = NEW.track_id;
END //

-- Trigger for updating song artist count on Delete
CREATE TRIGGER update_song_artist_count_delete
AFTER DELETE ON features_on
FOR EACH ROW
BEGIN
    UPDATE song
    SET num_artists = num_artists - 1
    WHERE song.track_id = OLD.track_id;
END //
DELIMITER ;

INSERT INTO features_on VALUES
    (1, 2);


CREATE TABLE writes (
  writer_id             INT             NOT NULL,
  track_id              INT             NOT NULL,
  PRIMARY KEY (writer_id, track_id),
  FOREIGN KEY (writer_id) REFERENCES writer(writer_id),
  FOREIGN KEY (track_id) REFERENCES song(track_id)
);

INSERT INTO writes VALUES
    (1, 1);
INSERT INTO writes VALUES
    (1, 2);
INSERT INTO writes VALUES
    (1, 3);
INSERT INTO writes VALUES
    (2, 4);


CREATE TABLE playlist(
    playlist_id         INT             PRIMARY KEY,
    playlist_name       VARCHAR(15)     NOT NULL
);

INSERT INTO playlist VALUES
    (1221, "My playlist 2");


CREATE TABLE playlists_of(
    user_id             VARCHAR(15)     NOT NULL,
    playlist_id         INT             NOT NULL,
    PRIMARY KEY (playlist_id, user_id),
    FOREIGN KEY (playlist_id) REFERENCES playlist(playlist_id),
    FOREIGN KEY (user_id) REFERENCES individual(user_id)
);

INSERT INTO playlists_of VALUES
    ("AAA", 1221);
INSERT INTO playlists_of VALUES
    ("BBB", 1221);


CREATE TABLE playlist_songs (
  playlist_id           INT             NOT NULL,
  track_id              INT             NOT NULL,
  PRIMARY KEY (playlist_id, track_id),
  FOREIGN KEY (playlist_id) REFERENCES playlist(playlist_id),
  FOREIGN KEY (track_id) REFERENCES song(track_id)
);

INSERT INTO playlist_songs VALUES
    (1221, 1);
INSERT INTO playlist_songs VALUES
    (1221, 4);


CREATE TABLE album_songs(
    album_id           	VARCHAR(15)      NOT NULL,
    track_id            INTEGER          NOT NULL,
    PRIMARY KEY (album_id, track_id),
    FOREIGN KEY (album_id) REFERENCES album(album_id),
    FOREIGN KEY (track_id) REFERENCES song(track_id)
);

INSERT INTO album_songs VALUES
    ("ABC123", 1);
INSERT INTO album_songs VALUES
    ("ABC123", 2);
INSERT INTO album_songs VALUES
    ("TRA111", 3);
INSERT INTO album_songs VALUES
    ("POI909", 4);


CREATE TABLE releases(
    album_id			 VARCHAR(15)  	 NOT NULL,
    label_name           VARCHAR(30)     NOT NULL,
    label_branch         VARCHAR(30)     NOT NULL,
    PRIMARY KEY (album_id, label_name, label_branch),
    FOREIGN KEY (album_id) REFERENCES album(album_id),
    FOREIGN KEY (label_name, label_branch) REFERENCES recording_label(label_name, label_branch)
);

INSERT INTO releases VALUES
    ("ABC123", "Music co", "Dunedin");
INSERT INTO releases VALUES
    ("TRA111", "Music co", "Dunedin");
INSERT INTO releases VALUES
    ("POI909", "Music co", "Christchurch");


COMMIT;
