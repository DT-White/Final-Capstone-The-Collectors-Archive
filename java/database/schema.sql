BEGIN TRANSACTION;



DROP TABLE IF EXISTS users;
DROP SEQUENCE IF EXISTS seq_user_id;
DROP table if exists book_genre;
DROP table if exists books;
DROP table if exists genres;


CREATE SEQUENCE seq_user_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;


CREATE TABLE users (
	user_id int DEFAULT nextval('seq_user_id'::regclass) NOT NULL,
	username varchar(50) NOT NULL UNIQUE,
	password_hash varchar(200) NOT NULL,
	role varchar(50) NOT NULL,
	CONSTRAINT PK_user PRIMARY KEY (user_id)
);

INSERT INTO users (username,password_hash,role) VALUES ('user','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('admin','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_ADMIN');

Create table books (
	book_id serial primary key,
	title varchar(128) not null,
	author varchar(64) not null,
	isbn bigint not null unique,
	bestseller boolean,
	summary varchar(2048) not null,
	keyword varchar(512),
	publishing_date date not null,
	cover_image_url varchar(128),
	genres_of_book varchar(512)
	);

Create table genres (
	genre_id serial primary key,
	genre_name varchar(32) not null
);

Create table book_genre (
	book_id bigint not null references books (book_id),
	genre_id bigint not null references genres (genre_id),
	Constraint pk_book_genre primary key (book_id, genre_id)
);
	
Insert into genres (genre_name) Values ('Fiction');
Insert into genres (genre_name) Values ('Mystery');
Insert into genres (genre_name) Values ('Thriller');
Insert into genres (genre_name) Values ('Horror');
Insert into genres (genre_name) Values ('Historical');
Insert into genres (genre_name) Values ('Romance');
Insert into genres (genre_name) Values ('Western');
Insert into genres (genre_name) Values ('Fantasy');
Insert into genres (genre_name) Values ('Science-Fiction');
Insert into genres (genre_name) Values ('Nonfiction');
Insert into genres (genre_name) Values ('Young-Adult');
Insert into genres (genre_name) Values ('Comedy');


	
COMMIT TRANSACTION;
