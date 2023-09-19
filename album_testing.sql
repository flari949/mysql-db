INSERT INTO song VALUES
    ('0');
INSERT INTO song VALUES
    ('1');
INSERT INTO song VALUES
    ('2');


INSERT INTO album VALUES
    ('123456789', 'bops1', '2000-01-01');
INSERT INTO album VALUES
    ('111111111', 'bops2', '2005-01-01');


INSERT INTO album_songs VALUES
    ('123456789', '0');
INSERT INTO album_songs VALUES
    ('123456789', '1');
INSERT INTO album_songs VALUES
    ('123456789', '2');
INSERT INTO album_songs VALUES
    ('111111111', '1');


INSERT INTO recording_label VALUES
    ('Best_records_co', 'Dunedin');

INSERT INTO recording_label VALUES
    ('Best_records_co', 'Wellington');


INSERT INTO releases VALUES
    ('Best_records_co', 'Dunedin', '123456789');
INSERT INTO releases VALUES
    ('Best_records_co', 'Wellington', '111111111');


-- SELECT * FROM releases WHERE label_branch='Dunedin';
SELECT * FROM album WHERE album_id='123456789';