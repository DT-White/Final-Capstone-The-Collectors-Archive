BEGIN TRANSACTION;


DROP table if exists time_accessed;
DROP table if exists user_collection;
DROP table if exists reading_list;
drop table if exists profiles;
DROP table if exists friends;
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
INSERT INTO users (username,password_hash,role) VALUES ('Mohamed','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('Benita','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('Derek','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('Nick','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');


Create table time_accessed (
	user_id bigint not null references users (user_id),
	time_update timestamp not null
);

Create table friends (
	first_user bigint not null references users (user_id),
	second_user bigint not null references users (user_id),
	Constraint pk_friends primary key (first_user, second_user)
);

create table profiles (
	profile_id serial primary key,
	first_name varchar(16),
	last_name varchar(16),
	email varchar(32),
	profile_picture_url varchar(1024),
	user_id bigint not null unique references users (user_id)
);


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
	
Create table user_collection (
	book_id bigint not null references books (book_id),
	user_id bigint not null references users (user_id),
	Constraint pk_user_collection primary key (book_id, user_id)
);
	
Create table reading_list (
	user_id bigint not null references users (user_id),
	book_id bigint not null references books (book_id),
	Constraint pk_book_user primary key (book_id, user_id)
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

Insert into books (title, author, isbn, bestseller, summary, keyword, publishing_date, cover_image_url, date_added)
values ('Harry Potter and the Sorcerer''s Stone', 'J. K. Rowling', '9780590353427', 'true', 'Rescued from the outrageous neglect of his aunt and uncle, a young boy with a great destiny proves his worth while attending Hogwarts School for Witchcraft and Wizardry.', 'magic, wizard, harry, bravery, hogwarts', '1997-06-26', 'http://books.google.com/books/content?id=fo4rzdaHDAwC&printsec=frontcover&img=1&zoom=1&source=gbs_api', current_timestamp);
Insert into book_genre (book_id, genre_id)
values (7, 1), (7, 8);

Insert into books (title, author, isbn, bestseller, summary, keyword, publishing_date, cover_image_url, date_added)
values ('Harry Potter and the Chamber of Secrets', 'J. K. Rowling', '9780439064866', 'true', 'Between the new spirit spooking his school and the mysterious forces that turn students into stone, Harry has a lot on his mind as he begins his second year at Hogwarts School of Witchcraft and Wizardry.', 'magic, wizard, harry, bravery, hogwarts', '1998-07-02', 'http://books.google.com/books/content?id=Bikg274Y4Q0C&printsec=frontcover&img=1&zoom=1&source=gbs_api', current_timestamp);
Insert into book_genre (book_id, genre_id)
values (8, 1), (8, 8);

Insert into books (title, author, isbn, bestseller, summary, keyword, publishing_date, cover_image_url, date_added)
values ('Harry Potter and the Prisoner of Azkaban', 'J. K. Rowling', '9780747546290', 'true', 'When Harry and his best friends go back for their third year at Hogwarts, the atmosphere is tense. There''s an escaped mass-murderer on the loose and the sinister prison guards of Azkaban have been called in to guard the school. Lessons, however, must go on and there are lots of new subjects in third year - Care of Magical Creatures and Divination among others - to take Harry''s mind off things!', 'magic, wizard, harry, bravery, hogwarts', '1999-07-08', 'http://books.google.com/books/content?id=nfRhQgAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api', current_timestamp);
Insert into book_genre (book_id, genre_id)
values (9, 1), (9, 8);

Insert into books (title, author, isbn, bestseller, summary, keyword, publishing_date, cover_image_url, date_added)
values ('Harry Potter and the Goblet of Fire', 'J. K. Rowling', '9780747546245', 'true', 'The summer holidays are dragging on and Harry Potter can''t wait for the start of the school year. It is his fourth year at Hogwarts School of Witchcraft and Wizardry and there are spells to be learnt and (unluckily) Potions and Divination lessons to be attended. But Harry can''t know that the atmosphere is darkening around him, and his worst enemy is preparing a fate that it seems will be inescapable . . . With characteristic wit, fast-paced humour and marvellous emotional depth, J.K. Rowling has proved herself yet again to be a master story-teller.', 'magic, wizard, harry, bravery, hogwarts, goblet, tournament', '2000-07-08', 'http://books.google.com/books/content?id=5eSxngEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api', current_timestamp);
Insert into book_genre (book_id, genre_id)
values (10, 1), (10, 8);

Insert into books (title, author, isbn, bestseller, summary, keyword, publishing_date, cover_image_url, date_added)
values('Harry Potter and the Order of the Phoenix', 'J.K Rowling', '9780439358064', 'true', 'Collects the complete series that relates the adventures of young Harry Potter, who attends Hogwarts School of Witchcraft and Wizardry, where he and others of his kind learn their craft.','magic, wizard, harry, bravery, hogwarts', '2003-06-21', 'http://books.google.com/books/content?id=qH7vyQEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api', current_timestamp);
Insert into book_genre (book_id, genre_id)
values (11, 1), (11, 8);

Insert into books (title, author, isbn, bestseller, summary, keyword, publishing_date, cover_image_url, date_added)
values('Harry Potter and the Half-blood Prince', 'J.K Rowling', '9780747581086', 'true', 'Harry has yet again spent the summer holidays at the Dursleys''. He has had plenty to think about, though - from the death of his beloved godfather Sirius Black, to the terrifying chase through the Ministry of Magic by the Death Eaters, to the fierce duel he witnessed between Professor Dumbledore and Lord Voldemort. It is the middle of the summer, but there is an unseasonal mist pressing against the windowpanes. Harry is waiting nervously for a visit from Professor Dumbledore himself. He can''t quite believe that Professor Dumbledore will actually appear at the Dursleys'' of all places. Why is the Professor coming to visit him now? What is it that cannot wait until Harry returns to Hogwarts in a few weeks'' time? Harry''s sixth year at Hogwarts has already got off to an unusual start, as the worlds of Muggle and magic start to intertwine J.K. Rowling charts Harry Potter''s adventures in his sixth year at Hogwarts with a mix of detail and humour that is unsurpassed, pace that is breathless and above all a flair that is magical','magic, wizard, harry, bravery, hogwarts', '2005-07-16', 'http://books.google.com/books/content?id=3IbqPgAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api', current_timestamp);
Insert into book_genre (book_id, genre_id)
values (12, 1), (12, 8);

Insert into books (title, author, isbn, bestseller, summary, keyword, publishing_date, cover_image_url, date_added)
values('Harry Potter and the Deathly Hallows', 'J.K Rowling', '9780545010221', 'true', 'The seventh and final book of the blockbuster Harry Potter series follows the wizard''s last year at Hogwarts School of Witchcraft and Wizardry. 12,000,000 first printing.','magic, wizard, harry, bravery, hogwarts', '2007-07-14', 'http://books.google.com/books/content?id=GZAoAQAAIAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api', current_timestamp);
Insert into book_genre (book_id, genre_id)
values (13, 1), (13, 8);

Insert into books (title, author, isbn, bestseller, summary, keyword, publishing_date, cover_image_url, date_added)
values('The Diary of a Young Girl', 'Anne Frank', '9780553296983', 'true', 'A young girl''s journal records her family''s struggles during two years of hiding from the Nazis in war-torn Holland.','holocaust, Nazis, concentration camp, world war two', '1947-06-25', 'http://books.google.com/books/content?id=ZEy6im49l08C&printsec=frontcover&img=1&zoom=1&source=gbs_api', current_timestamp);
Insert into book_genre (book_id, genre_id)
values (14, 10), (14, 5);

Insert into books (title, author, isbn, bestseller, summary, keyword, publishing_date, cover_image_url, date_added)
values('The Naturals', 'Jennifer Lynn Barnes', '9781423168232', 'false', 'Seventeen-year-old Cassie is a natural at reading people. Piecing together the tiniest details, she can tell you who you are and what you want. But, it''s not a skill that she''s ever taken seriously. That is, until the FBI come knocking: they''ve begun a classified program that uses exceptional teenagers to crack infamous cold cases, and they need Cassie. What Cassie doesn''t realize is that there''s more at risk than a few unsolved homicides-especially when she''s sent to live with a group of teens whose gifts are as unusual as her own. Soon, it becomes clear that no one in the Naturals program is what they seem. And when a new killer strikes, danger looms close. Caught in a lethal game of cat and mouse with a killer, the Naturals are going to have to use all of their gifts just to survive. Think The Mentalist meets Pretty Little Liars','crime, mystery, cold cases', '2013-11-05', 'http://books.google.com/books/content?id=IGNCmQEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api', current_timestamp);
Insert into book_genre (book_id, genre_id)
values (15, 2), (15, 3), (15, 6), (15, 11);

Insert into books (title, author, isbn, bestseller, summary, keyword, publishing_date, cover_image_url, date_added)
values('Neuromancer', 'William Gibson', '9780441569595', 'true', 'Case, a burned out computer whiz, is asked to steal a security code that is locked in the most heavily guarded databank in the solar system','computer whiz, mission', '1984-07-01', 'http://books.google.com/books/content?id=958sAQAAIAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api', current_timestamp);
Insert into book_genre (book_id, genre_id)
values (16, 9), (16, 1);

Insert into books (title, author, isbn, bestseller, summary, keyword, publishing_date, cover_image_url, date_added)
values('A Hell Called Ohio', 'John Hamilton', '9780991337941', 'false', 'John Hamilton’s novel follows factory worker Warrell Swanson through the depressed town of Defiance, Ohio as he comprehends the arrival of new love, personal loss, and the limitations of an identity based on work. Swanson suffers an injury on the factory line and looks for new ways to kill time. He and his best friend Mario drink at the local tavern, which quickly leads to an unwanted fling with his fiery ex-girlfriend, Rochelle. Escaping the resulting malaise and the late summer heat at the local library, Warrell falls in love with Emily, Defiance’s new bright and beautiful librarian. But the lofty summer days turn overcast and the rains that every year threaten floods begin heavily to fall. A sudden death demands emotional truth and healing, but Emily is concerned by the indecision of her future. With their lives on divergent paths and his growing dispassion for the factory life, Warrell battles the indefinable pressures of nothingness in hopes that he can scrape up enough meaning to escape Defiance for good.','Ohio, romance, factory worker', '2013-09-10', 'http://books.google.com/books/content?id=5mL4lwEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api', current_timestamp);
Insert into book_genre (book_id, genre_id)
values (17, 1), (17, 6);

Insert into books (title, author, isbn, bestseller, summary, keyword, publishing_date, cover_image_url, date_added)
values('The Whiskey Rebels', 'David Liss', '9780812974539', 'false', 'Ethan Saunders, a former spy for George Washington, is recruited by Alexander Hamilton to find his ex-fiancee''s missing husband. Meanwhile, Joan Maycott and her veteran husband, amid hardship and deprivation on the western Pennsylvania frontier, find unlikely friendship and a chance for prosperity with a new method of distilling whiskey. The Maycotts'' success however attracts the brutal attention of men in Hamilton''s orbit, men who threaten to destroy all Joan holds dear. As their causes intertwine, Joanand Saunders--both patriots in their own way--find themselves on opposing sides of a daring scheme that will forever change their lives and their new country.', 'spy, Pennsylvania, distilery', '2009-06-16', 'http://books.google.com/books/content?id=yFMOh-knRw4C&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', current_timestamp);
Insert into book_genre (book_id, genre_id)
values (18, 7), (18, 3);


Insert into time_accessed (user_id, time_update)
values (1, current_timestamp), (2, current_timestamp);

insert into profiles (user_id, first_name, last_name, profile_picture_url, email)
values (1, 'John', 'Doe', 'https://www.nicepng.com/png/detail/8-88271_madagascar-penguin-png-image-penguins-of-madagascar.png', 'john@gmail.com');

insert into profiles (user_id, first_name, last_name, profile_picture_url, email)
values (3, 'Mohamed', 'A', 'https://firebasestorage.googleapis.com/v0/b/collectors-archive.appspot.com/o/user3-profile-picture?alt=media&token=0d21e608-6fef-4ee4-bd20-05f1ab2ae993', 'ma@TE.com');

insert into profiles (user_id, first_name, last_name, profile_picture_url, email)
values (4, 'Benita', 'Nou', 'https://firebasestorage.googleapis.com/v0/b/collectors-archive.appspot.com/o/user4-profile-picture?alt=media&token=1ad2241f-d89d-4729-a64e-14b10bf766bc', 'bn@TE.com');

insert into profiles (user_id, first_name, last_name, profile_picture_url, email)
values (5, 'Derek', 'White', 'https://firebasestorage.googleapis.com/v0/b/collectors-archive.appspot.com/o/user5-profile-picture?alt=media&token=d70b484b-98ae-49e1-a342-7f4ca57944db', 'dw@TE.com');

insert into profiles (user_id, first_name, last_name, profile_picture_url, email)
values (6, 'Nick', 'Paat', 'https://firebasestorage.googleapis.com/v0/b/collectors-archive.appspot.com/o/user6-profile-picture?alt=media&token=d6441ca7-960c-4135-8661-4fbff80bffd5', 'np@TE.com');

INSERT INTO friends (first_user, second_user)
Values  (1,4), (4,1), (1,5), (5,1), (1,6), (6,1), (3,4), (4,3), (3,5), (5,3), (3,6), (6,3), (4,6), (6,4);

INSERT INTO user_collection (book_id, user_id) 
values(2,1), (3,1), (6,1);

INSERT into user_collection (book_id, user_id) 
values (15, 1), (12, 1), (1, 1), (16, 1);

INSERT into user_collection (book_id, user_id) 
values (7, 3), (8, 3), (9, 3), (10, 3), (11, 3), (12, 3), (13, 3), (18, 3), (14, 3);

INSERT into user_collection (book_id, user_id) 
values (18, 4), (17, 4), (16,4), (15,4), (14,4), (1,4), (2,4), (3,4);

INSERT into user_collection (book_id, user_id) 
values (4, 5), (5, 5), (6,5), (15,5), (10,5), (1,5);

INSERT into user_collection (book_id, user_id) 
values (14, 6), (15, 6), (16,6), (17,6), (18,6), (5,6);

COMMIT TRANSACTION;

