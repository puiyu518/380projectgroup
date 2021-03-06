CREATE TABLE replies (
id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
username VARCHAR(50) NOT NULL,
content varchar(1000) NOT NULL,
rid INTEGER NOT NULL,
created_at TIMESTAMP NOT NULL, 
primary key (id),
FOREIGN KEY (rid) REFERENCES threads(id),
FOREIGN KEY (username) REFERENCES users(username)

);

CREATE TABLE reply_attachments (
id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
rid INTEGER,
attachmentName VARCHAR(256) NOT NULL,
mimeContentType VARCHAR(256) NOT NULL,
contents BLOB NOT NULL,
primary key (id),
FOREIGN KEY (rid) REFERENCES replies(id)

);



