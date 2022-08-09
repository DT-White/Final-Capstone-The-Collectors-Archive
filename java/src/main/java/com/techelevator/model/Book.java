package com.techelevator.model;

import java.time.LocalDate;
import java.util.List;

public class Book {

    private int bookId;
    private String title;
    private String author;
    private boolean bestSeller;
    private long isbn;
    private String summary;
    private String keyword;
    private LocalDate publishingDate;
    private String coverImageUrl;
    private List<String> genres;


    public Book() {}


    public Book(int bookId, String title, String author, boolean bestSeller, long isbn, String summary, String keywords, LocalDate publishingDate, String coverImageUrl, List<String> genres) {
        this.bookId = bookId;
        this.title = title;
        this.author = author;
        this.bestSeller = bestSeller;
        this.isbn = isbn;
        this.summary = summary;
        this.keyword = keywords;
        this.publishingDate = publishingDate;
        this.coverImageUrl = coverImageUrl;
        this.genres = genres;
    }

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public boolean isBestSeller() {
        return bestSeller;
    }

    public void setBestSeller(boolean bestSeller) {
        this.bestSeller = bestSeller;
    }

    public long getIsbn() {
        return isbn;
    }

    public void setIsbn(long isbn) {
        this.isbn = isbn;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public LocalDate getPublishingDate() {
        return publishingDate;
    }

    public void setPublishingDate(LocalDate publishingDate) {
        this.publishingDate = publishingDate;
    }

    public String getCoverImageUrl() {
        return coverImageUrl;
    }

    public void setCoverImageUrl(String coverImageUrl) {
        this.coverImageUrl = coverImageUrl;
    }

    public List<String> getGenres() {
        return genres;
    }

    public void setGenres(List<String> genres) {
        this.genres = genres;
    }
}
