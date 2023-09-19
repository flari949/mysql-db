-- Active: 1683086309443@@127.0.0.1@42333@company
DROP TABLE IF EXISTS recording_label;
DROP TABLE IF EXISTS album;


CREATE TABLE album
  (album_id			  VARCHAR(15)  		PRIMARY KEY,
   title      		VARCHAR(15)			NOT NULL,
   release_date		DATE 				    NOT NULL,
   label_name     VARCHAR(30)     NOT NULL,
   label_branch   VARCHAR(30)     NOT NULL,
   FOREIGN KEY (label_name, label_branch) REFERENCES recording_label(label_name, label_branch)
   );
   


CREATE TABLE recording_label
  (label_name		  VARCHAR(30) 		NOT NULL,
   label_branch		VARCHAR(30) 		NOT NULL,
   PRIMARY KEY (label_name, label_branch)
   );
   
   

COMMIT;
