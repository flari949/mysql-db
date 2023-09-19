CREATE TABLE song(
    track_id INTEGER PRIMARY KEY,
    song_name VARCHAR(200),
    -- num_artists AS SUM(COUNT(lead_artist_id), COUNT(feature_artist_id)), --this may cause issues
    num_artists INT DEFAULT 1, -- Default set to 1 as requires at least one artist (lead artist) 
    date_released DATE NOT NULL,
    lead_artist_id INTEGER NOT NULL,
    album_id INTEGER NOT NULL, 
    FOREIGN KEY (lead_artist_id) REFERENCES artist(artist_id),
    FOREIGN KEY (album_id) REFERENCES album(album_id)
);

CREATE TABLE pop(
    track_id INTEGER NOT NULL,
    bpm INTEGER,
    FOREIGN KEY (track_id) REFERENCES song(track_id)
);

CREATE TABLE rock(
    track_id INTEGER NOT NULL,
    vocals BOOLEAN,
    FOREIGN KEY (track_id) REFERENCES song(track_id)
);

CREATE TABLE jazz(
    track_id INTEGER NOT NULL,
    jazz_style VARCHAR(200), 
    FOREIGN KEY (track_id) REFERENCES song(track_id)
);

---------------------------------------------------------------------------------

CREATE TABLE features_on (
  track_id INT NOT NULL,
  artist_id INT NOT NULL,
  PRIMARY KEY (track_id, artist_id),
  FOREIGN KEY (track_id) REFERENCES song(track_id),
  FOREIGN KEY (artist_id) REFERENCES artist(artist_id)
);

CREATE TABLE playlist_songs (
  playlist_id INT NOT NULL,
  track_id INT NOT NULL,
  PRIMARY KEY (playlist_id, track_id),
  FOREIGN KEY (playlist_id) REFERENCES playlist(playlist_id),
  FOREIGN KEY (track_id) REFERENCES song(track_id)
);

CREATE TABLE writes (
  writer_id INT NOT NULL,
  track_id INT NOT NULL,
  PRIMARY KEY (writer_id, track_id),
  FOREIGN KEY (writer_id) REFERENCES writer(writer_id),
  FOREIGN KEY (track_id) REFERENCES song(track_id)
);


-- -------------------------------------------------------------------------------- --
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