# Position,offender,Wikipedia-entry,Crime,Sentence,Image,Creation,Updated
CREATE TABLE gits (
position TINYINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
offender varchar(40),
wiki varchar(100),
crime varchar(500),
punishment varchar(200),
image varchar(200),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
