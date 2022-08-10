BEGIN TRANSACTION;




DROP table if exists reading_list;
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
	date_added timestamp not null
	);
	
Create table reading_list (
	user_id bigint not null references users (user_id),
	book_id bigint not null references books (book_id)
	
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
Insert into genres (genre_name) Values ('Science Fiction');
Insert into genres (genre_name) Values ('Nonfiction');
Insert into genres (genre_name) Values ('Young Adult');
Insert into genres (genre_name) Values ('Comedy');


Insert into books (title, author, isbn, bestseller, summary, keyword, publishing_date, cover_image_url, date_added)
values ('The Haunting of Hill House', 'Shirley Jackson', '9780143122357', 'false', 'Part of a new six-volume series of the best in classic horror, selected by Academy Award-winning director of The Shape of Water Guillermo del Toro Filmmaker and longtime horror literature fan Guillermo del Toro serves as the curator for the Penguin Horror series, a new collection of classic tales and poems by masters of the genre. Included here are some of del Toro’s favorites, from Mary Shelley’s Frankenstein and Ray Russell’s short story “Sardonicus,” considered by Stephen King to be “perhaps the finest example of the modern Gothic ever written,” to Shirley Jackson’s The Haunting of Hill House and stories by Ray Bradbury, Joyce Carol Oates, Ted Klein, and Robert E. Howard. Featuring original cover art by Penguin Art Director Paul Buckley, these stunningly creepy deluxe hardcovers will be perfect additions to the shelves of horror, sci-fi, fantasy, and paranormal aficionados everywhere. The Haunting of Hill House The classic supernatural thriller by an author who helped define the genre. First published in 1959, Shirley Jackson''s The Haunting of Hill House has been hailed as a perfect work of unnerving terror. It is the story of four seekers who arrive at a notoriously unfriendly pile called Hill House: Dr. Montague, an occult scholar looking for solid evidence of a “haunting;'' Theodora, his lighthearted assistant; Eleanor, a friendless, fragile young woman well acquainted with poltergeists; and Luke, the future heir of Hill House. At first, their stay seems destined to be merely a spooky encounter with inexplicable phenomena. But Hill House is gathering its powers—and soon it will choose one of them to make its own.', 'haunting, paranormal, house, poltergeists, spooky', '2013-10-01', 'http://books.google.com/books/content?id=SR-MDQAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', current_timestamp);
Insert into book_genre (book_id, genre_id)
values (1, 1), (1, 4);

Insert into books (title, author, isbn, bestseller, summary, keyword, publishing_date, cover_image_url, date_added)
values ('The New Neighbor', 'Karen Cleveland', '9780593358023', false, 'A CIA analyst with an empty nest, a broken marriage, and nothing to lose risks her life to crack an unsolvable case in this utterly gripping thriller from the New York Times bestselling author of Need to Know Use the children. This is the phrase picked up in a Chinese intelligence intercept, the one that convinced CIA analyst Beth Bradford to take on the case that would haunt her ever since. She will not rest until she tracks down the Neighbor, a highly dangerous recruiting agent who preys on high-value, vulnerable intelligence targets in hopes they might betray their own country. But Beth''s life''s work has come at the expense of her family, and things are beginning to fall apart. She dropped off her youngest at college and her husband has moved out, the consequence of years of neglecting their marriage. And then, the CIA moves her off the impossible Chinese counterintelligence assignment that she''s given her life to. She can''t make her kids young again. She can''t convince her husband they share something they don''t. But this case is different. It''s something she can change. She''ll find the information she''s looking for, one way or another, because she''s close to finding the Neighbor. She can feel it. She has to be. Because right now, she has nothing else. And the Neighbor might be right under her nose.', 'CIA, spy, neighbor', '2022-07-26', 'http://books.google.com/books/content?id=foJ3EAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', current_timestamp);
Insert into book_genre (book_id, genre_id)
values (2, 3), (2, 2), (2, 1);

Insert into books (title, author, isbn, bestseller, summary, keyword, publishing_date, cover_image_url, date_added)
values ('The Da Vinci Code', 'Dan Brown', '9780307474278', 'true', 'Harvard symbologist Robert Langdon and French cryptologist Sophie Neveu work to solve the murder of an elderly curator of the Louvre, a case which leads to clues hidden in the works of Da Vinci and a centuries-old secret society.', 'religion, conspiracy, Leonardo Da Vinci, detective, mystery', '03-31-2009', 'http://books.google.com/books/content?id=YuDl2Wl651AC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', current_timestamp);
Insert into book_genre (book_id, genre_id)
values (3, 3), (3, 2), (3, 1);

Insert into books (title, author, isbn, bestseller, summary, keyword, publishing_date, cover_image_url, date_added)
values ('Where the Crawdads Sing', 'Delia Owens', '9780735219090', 'true', '#1 NEW YORK TIMES BESTSELLING PHENOMENON—NOW A MAJOR MOTION PICTURE! More than 15 million copies sold worldwide A Reese’s Book Club Pick A Business Insider Defining Book of the Decade “I can''t even express how much I love this book! I didn''t want this story to end!”—Reese Witherspoon “Painfully beautiful.”—The New York Times Book Review For years, rumors of the “Marsh Girl” have haunted Barkley Cove, a quiet town on the North Carolina coast. So in late 1969, when handsome Chase Andrews is found dead, the locals immediately suspect Kya Clark, the so-called Marsh Girl. But Kya is not what they say. Sensitive and intelligent, she has survived for years alone in the marsh that she calls home, finding friends in the gulls and lessons in the sand. Then the time comes when she yearns to be touched and loved. When two young men from town become intrigued by her wild beauty, Kya opens herself to a new life—until the unthinkable happens. Where the Crawdads Sing is at once an exquisite ode to the natural world, a heartbreaking coming-of-age story, and a surprising tale of possible murder. Owens reminds us that we are forever shaped by the children we once were, and that we are all subject to the beautiful and violent secrets that nature keeps.', 'coming of age, North Carolina, mystery, crime, murder, romance', '2018-08-14', 'http://books.google.com/books/content?id=ey5lDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', current_timestamp);
Insert into book_genre (book_id, genre_id)
values (4, 1), (4, 2), (4, 11), (4, 6);

Insert into books (title, author, isbn, bestseller, summary, keyword, publishing_date, cover_image_url, date_added)
values ('Tangerine', 'Edward Bloor', '9780152057800', 'true', 'Twelve-year-old Paul, who lives in the shadow of his football hero brother Erik, fights for the right to play soccer despite his near blindness and slowly begins to remember the incident that damaged his eyesight. An ALA Best Book for Young Adults. Reprint. Jr Lib Guild.', 'coming of age, courage, Florida, harassment, bullies', '2006-09-01', 'http://books.google.com/books/content?id=C4BhbzcOIAMC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', current_timestamp);
Insert into book_genre (book_id, genre_id)
values (5, 11), (5, 1);

Insert into books (title, author, isbn, bestseller, summary, keyword, publishing_date, cover_image_url, date_added)
values ('Trouble Don''t Last', 'Shelley Pearsall', '9780440418115', 'false', 'Dragged from his bed one night by a fellow slave, eleven-year-old Samuel finds himself on an unexpected, dangerous, and frightening journey north along the Underground Railroad on his way to find freedom in Canada. Reprint.', 'slavery, Underground Railroad, freedom, Kentucky', '2003-12-09', 'http://books.google.com/books/content?id=mPRqMFmGtIUC&printsec=frontcover&img=1&zoom=1&source=gbs_api', current_timestamp);
Insert into book_genre (book_id, genre_id)
values (6, 1), (6, 5);

Insert into reading_list (user_id, book_id)
values (1, 2), (1, 5), (1, 1), (1, 6);
	
COMMIT TRANSACTION;
