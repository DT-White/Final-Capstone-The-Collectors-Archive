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
    public Book getBook(int bookId) {

        Book book = null;

        String sql = "select book_id, title, author, isbn, bestseller, summary, keyword, publishing_date, cover_image_url " +
                "from books " +
                "where book_id = ?";

        SqlRowSet rowSet = jdbcTemplate.queryForRowSet(sql, bookId);

        if (rowSet.next()) {
            book = mapRowToBook(rowSet);
        }

        return book;
    }

    @Override
    public List<Book> getBookList() {

        List<Book> bookList = new ArrayList<>();

        String sql = "select book_id, title, author, isbn, bestseller, summary, keyword, publishing_date, cover_image_url " +
                "from books order by book_id desc";

        SqlRowSet rowSet = jdbcTemplate.queryForRowSet(sql);

        while(rowSet.next()) {
            bookList.add(mapRowToBook(rowSet));
        }

        return bookList;
    }

    @Override
    public Book addBook(Book book) {

        String sql = "insert into books (book_id, title, author, isbn, bestseller, summary, keyword, publishing_date, cover_image_url) " +
                "values (default, ?, ?, ?, ?, ?, ?, ?, ?) returning book_id";

        Integer id = jdbcTemplate.queryForObject(sql, Integer.class, book.getTitle(), book.getAuthor(), book.getIsbn(), book.isBestSeller(), book.getSummary(), book.getKeyword(), book.getPublishingDate(), book.getCoverImageUrl());

        book.setBookId(id);

       List<String> genres = book.getGenres();

        for(String genre: genres) {

                int genreId = getGenreId(genre);

                String sql2 = "insert into book_genre (book_id, genre_id) " +
                        "values (?, ?)";

                jdbcTemplate.update(sql2, id, genreId);
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

        String sql = "select title " +
                "from books " +
                "join reading_list on reading_list.book_id = books.book_id " +
                "where username = ?";

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
        book.setCoverImageUrl(rowSet.getString("cover_image_url"));
        book.setGenres(getListOfBookGenres(rowSet.getInt("book_id")));
        return book;
    }






}
