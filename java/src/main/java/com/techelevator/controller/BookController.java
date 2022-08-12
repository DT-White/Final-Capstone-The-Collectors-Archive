package com.techelevator.controller;

import com.techelevator.dao.BookDao;
import com.techelevator.model.Book;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;

@CrossOrigin
@RestController
public class BookController {

    private BookDao bookDao;

    public BookController(BookDao bookDao) {
        this.bookDao = bookDao;
    }

    @ResponseStatus(HttpStatus.OK)
    @RequestMapping(path = "/books/{Id}", method = RequestMethod.GET)
    public Book getBookById(@PathVariable("Id") int bookId) {
        return bookDao.getBook(bookId);
    }

    @ResponseStatus(HttpStatus.OK)
    @RequestMapping(path = "/books", method = RequestMethod.GET)
    public List<Book> getBookList(Principal principal) {
        return bookDao.getBookList(principal.getName());
    }

    @ResponseStatus(HttpStatus.CREATED)
    @RequestMapping(path = "/books", method = RequestMethod.POST)
    public Book addBook(@RequestBody Book book) {
        return bookDao.addBook(book);
    }

    @ResponseStatus(HttpStatus.NO_CONTENT)
    @RequestMapping(path = "/books/{id}", method = RequestMethod.DELETE)
    public void deleteBook(@PathVariable("id") int bookId) {
        bookDao.deleteBook(bookId);
    }

    @ResponseStatus(HttpStatus.OK)
    @RequestMapping(path = "/genres/{id}", method = RequestMethod.GET)
    public List<String> getGenreListByBookId(@PathVariable("id") int bookId) {
        return bookDao.getGenreListByBookId(bookId);
    }

    @ResponseStatus(HttpStatus.NO_CONTENT)
    @RequestMapping(path = "/genres/{id}", method = RequestMethod.POST)
    public void addGenres(@PathVariable("id") int bookId) {
        bookDao.addGenres(bookId);
    }

    @ResponseStatus(HttpStatus.OK)
    @RequestMapping(path = "/genres", method = RequestMethod.GET)
    public List<String> genres() {
        return bookDao.getAllGenres();
    }


    @ResponseStatus(HttpStatus.OK)
    @RequestMapping(path = "/reading-list", method = RequestMethod.GET)
    public List<Book> getUserReadingList(Principal principal) {
        return bookDao.getUserReadingList(principal.getName());
    }

    @ResponseStatus(HttpStatus.CREATED)
    @RequestMapping(path = "/reading-list", method = RequestMethod.POST)
    public void addBookToReadingList(Principal principal, @RequestBody Book book) {
        bookDao.addBookToReadingList(principal.getName(), book);
    }

    @ResponseStatus(HttpStatus.NO_CONTENT)
    @RequestMapping(path = "/reading-list/{id}", method = RequestMethod.DELETE)
    public void removeBookFromReadingList(Principal principal, @PathVariable int id) {
        bookDao.removeBookFromReadingList(principal.getName(), id);
    }
}
