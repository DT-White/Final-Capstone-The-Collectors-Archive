package com.techelevator.dao;

import com.techelevator.model.Book;

import java.util.List;

public interface BookDao {

    Book getBook(int bookId);
    List<Book> getBookList();
    Book addBook(Book book);
    void deleteBook(int bookId);
    List<String> getGenreListByBookId(int bookId);
    Integer getGenreId(String genreName);
    void addGenres(int bookId);
    List<String> getAllGenres();


}
