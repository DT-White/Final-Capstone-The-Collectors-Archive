package com.techelevator.dao;

import com.techelevator.model.Book;

import java.util.List;

public interface BookDao {

    Book getBook(long isbn);
    List<Book> getBookList(String username);
    Book addBook(Book book, String username);
    void deleteBook(int bookId);
    List<String> getGenreListByBookId(int bookId);
    void addGenres(int bookId);
    List<String> getAllGenres();
    List<Book> getUserReadingList(String username);
    void addBookToReadingList(String username, Book book);
    void removeBookFromReadingList(String username, int bookId);



}
