package com.techelevator.controller;

import com.techelevator.dao.BookDao;
import com.techelevator.model.Book;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class BookController {

    private BookDao bookDao;

    public BookController(BookDao bookDao) {
        this.bookDao = bookDao;
    }


    @RequestMapping(path = "/books/{Id}", method = RequestMethod.GET)
    public Book getBookById(@PathVariable("Id") int bookId) {
        return bookDao.getBook(bookId);
    }

    @RequestMapping(path = "/books", method = RequestMethod.GET)
    public List<Book> getBookList() {
        return bookDao.getBookList();
    }

    @RequestMapping(path = "/books", method = RequestMethod.POST)
    public Book addBook(@RequestBody Book book) {
        return bookDao.addBook(book);
    }

    @RequestMapping(path = "/books/{id}", method = RequestMethod.DELETE)
    public void deleteBook(@PathVariable("id") int bookId) {
        bookDao.deleteBook(bookId);
    }

    @RequestMapping(path = "/genres/{id}", method = RequestMethod.GET)
    public List<String> getGenreListByBookId(@PathVariable("id") int bookId) {
        return bookDao.getGenreListByBookId(bookId);
    }

    @RequestMapping(path = "/genres/{id}", method = RequestMethod.POST)
    public void addGenres(@PathVariable("id") int bookId) {
        bookDao.addGenres(bookId);
    }

    @RequestMapping(path = "/genres", method = RequestMethod.GET)
    public List<String> genres() {
        return bookDao.getAllGenres();
    }


}
