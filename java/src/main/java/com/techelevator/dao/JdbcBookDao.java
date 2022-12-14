package com.techelevator.dao;

import com.techelevator.model.Book;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;




@Component
public class JdbcBookDao implements BookDao {

    private final JdbcTemplate jdbcTemplate;
    private final UserDao userDao;

    public JdbcBookDao(JdbcTemplate jdbcTemplate, UserDao userDao) {
        this.jdbcTemplate = jdbcTemplate;
        this.userDao = userDao;
    }


    @Override
    public Book getBook(long isbn) {

        Book book = null;

        String sql = "select book_id, title, author, isbn, bestseller, summary, keyword, publishing_date, cover_image_url, date_added " +
                "from books " +
                "where isbn = ?";

        SqlRowSet rowSet = jdbcTemplate.queryForRowSet(sql, isbn);

        if (rowSet.next()) {
            book = mapRowToBook(rowSet);
        }

        return book;
    }

    @Override
    public List<Book> getBookList(String username) {

        List<Book> bookList = new ArrayList<>();
        int userId = userDao.findIdByUsername(username);
        String sql = "SELECT books.book_id, title, author, isbn, bestseller, summary, keyword, publishing_date, cover_image_url, date_added FROM books " +
                "JOIN user_collection on books.book_id = user_collection.book_id " +
                "JOIN users on user_collection.user_id = users.user_id " +
                "where users.user_id = ? " +
                "order by book_id desc";

        SqlRowSet rowSet = jdbcTemplate.queryForRowSet(sql, userId);

        while(rowSet.next()) {
            bookList.add(mapRowToBook(rowSet));
        }

       // userDao.updateTimeAccessed(username);
        return bookList;
    }

    @Override
    public Book addBook(Book book, String username) {
        if(getBook(book.getIsbn()) == null) {
            String sql = "insert into books (book_id, title, author, isbn, bestseller, summary, keyword, publishing_date, cover_image_url, date_added) " +
                    "values (default, ?, ?, ?, ?, ?, ?, ?, ?, current_timestamp) returning book_id";
            Integer id = jdbcTemplate.queryForObject(sql, Integer.class, book.getTitle(), book.getAuthor(), book.getIsbn(), book.isBestSeller(), book.getSummary(), book.getKeyword(), book.getPublishingDate(), book.getCoverImageUrl());
            int userId = userDao.findIdByUsername(username);
            String sql2 = "INSERT INTO user_collection (book_id, user_id) " +
                    "values (?,?)";
            jdbcTemplate.update(sql2, id, userId);
            book.setBookId(id);
            List<String> genres = book.getGenres();
            for (String genre : genres) {
                int genreId = getGenreId(genre);
                String sql3 = "insert into book_genre (book_id, genre_id) " +
                        "values (?, ?)";
                jdbcTemplate.update(sql3, id, genreId);
            }
        } else {
            book = getBook(book.getIsbn());
            int userId = userDao.findIdByUsername(username);
            String sql2 = "INSERT INTO user_collection (book_id, user_id) " +
                    "values (?,?)";
            jdbcTemplate.update(sql2, book.getBookId(), userId);
        }
        return book;
    }

    @Override
    public void deleteBook(int bookId) {

        String sql = "delete from books where book_id = ?";

        jdbcTemplate.update(sql, bookId);

    }

    @Override
    public List<String> getGenreListByBookId(int bookId) {

        List<String> genres = new ArrayList<>();

        String sql = "select genres.genre_id, genre_name " +
                "from genres " +
                "join book_genre on genres.genre_id = book_genre.genre_id " +
                "where book_id = ?";

        SqlRowSet rowSet = jdbcTemplate.queryForRowSet(sql, bookId);

        while(rowSet.next()) {
            genres.add(rowSet.getString("genre_name"));
        }

        return genres;
    }

    private Integer getGenreId(String genreName) {

        String sql = "select genre_id from genres where genre_name = ?";

        return jdbcTemplate.queryForObject(sql, Integer.class, genreName);

    }

    private List<String> getListOfBookGenres(int bookId) {

        List<String> genres = new ArrayList<>();

        String sql = "select genre_name " +
                "from genres " +
                "join book_genre on genres.genre_id = book_genre.genre_id " +
                "where book_id = ?";

        SqlRowSet rowSet = jdbcTemplate.queryForRowSet(sql, bookId);

        while(rowSet.next()) {
            genres.add(rowSet.getString("genre_name"));
        }

        return genres;
    }

    @Override
    public void addGenres(int bookId) {

        List<String> allGenres = getAllGenres();

        List<String> bookGenres = getGenreListByBookId(bookId);
        for(String genre: allGenres) {
            if (bookGenres.contains(genre)) {
               int genreId = getGenreId(genre);

                String sql = "insert into book_genre (book_id, genre_id) " +
                        "values (?, ?)";

                jdbcTemplate.update(sql, bookId, genreId);
            }
        }
    }

    @Override
    public List<String> getAllGenres() {

        List<String> genres = new ArrayList<>();

        String sql = "select genre_id, genre_name from genres";

        SqlRowSet rowSet = jdbcTemplate.queryForRowSet(sql);

        while(rowSet.next()) {
            genres.add(rowSet.getString("genre_name"));

        }
        return genres;
    }

    @Override
    public List<Book> getUserReadingList(String username) {

        List<Book> books = new ArrayList<>();

        String sql = "select books.book_id, title, author, isbn, bestseller, summary, keyword, publishing_date, cover_image_url, date_added " +
                "from books " +
                "join reading_list on reading_list.book_id = books.book_id " +
                "join users on users.user_id = reading_list.user_id " +
                "where username = ? order by books.book_id desc";

        SqlRowSet rowSet = jdbcTemplate.queryForRowSet(sql, username);

        while(rowSet.next()) {
            books.add(mapRowToBook(rowSet));
        }

        return books;
    }

    @Override
    public void addBookToReadingList(String username, Book book) {

        String sql = "insert into reading_list (user_id, book_id) " +
                "values (?, ?)";

        int userId = userDao.findIdByUsername(username);

        jdbcTemplate.update(sql, userId, book.getBookId());
    }

    @Override
    public void removeBookFromReadingList(String username, int bookId) {
        String sql = "delete from reading_list where user_id = ? and book_id = ?";
        int userId = userDao.findIdByUsername(username);
        jdbcTemplate.update(sql, userId, bookId);
    }

    @Override
    public List<Book> getFriendBookList(int userId) {
        List<Book> friendBookList = new ArrayList<>();
        String sql = "SELECT books.book_id, title, author, isbn, bestseller, summary, keyword, publishing_date, cover_image_url, date_added FROM books " +
                "JOIN user_collection on books.book_id = user_collection.book_id " +
                "JOIN users on user_collection.user_id = users.user_id " +
                "where users.user_id = ? " +
                "order by book_id desc";

        SqlRowSet rowSet = jdbcTemplate.queryForRowSet(sql, userId);
        while(rowSet.next()){
            friendBookList.add(mapRowToBook(rowSet));
        }

        return friendBookList;
    }

    private Book mapRowToBook(SqlRowSet rowSet) {

        Book book = new Book();

        book.setBookId(rowSet.getInt("book_id"));
        book.setTitle(rowSet.getString("title"));
        book.setAuthor(rowSet.getString("author"));
        book.setIsbn(rowSet.getLong("isbn"));
        book.setBestSeller(rowSet.getBoolean("bestseller"));
        book.setSummary(rowSet.getString("summary"));
        book.setKeyword((rowSet.getString("keyword")));
        if (rowSet.getDate("publishing_date") != null) {
            book.setPublishingDate(rowSet.getDate("publishing_date").toLocalDate());
        }
        if (rowSet.getTimestamp("date_added") != null) {
            book.setDateAdded(rowSet.getTimestamp("date_added").toLocalDateTime());
        }
        book.setCoverImageUrl(rowSet.getString("cover_image_url"));
        book.setGenres(getListOfBookGenres(rowSet.getInt("book_id")));
        return book;
    }






}
