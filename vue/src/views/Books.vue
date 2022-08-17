<template>
  <div id="booksView">
      <book-filter/>
      <section>
        <profile/>
        <section>
          <bookList @openBook="openBook" @addBook="newBook"/>
          <reading-list @openBook="openBook"/>
        </section>
      </section>

    <book-detail :book="bookToOpen"
      v-show="isBookDetailVisible"
      @close="closeModal" />

    <add-book
      v-show="isNewBookVisible"
      @close="closeModal" />

  </div>
</template>

<script>

import bookList from "@/components/BookList";
import bookFilter from "@/components/BookFilter";
import readingList from "@/components/ReadingList";
import bookDetail from "@/components/BookDetail";
import profile from '@/components/Profile';
import addBook from '@/components/AddBook';

export default {
  components: { 
    addBook,
    bookList,
    bookFilter,
    readingList,
    bookDetail ,
    profile,
  },

  methods: {
    openBook(event, book) {
      this.bookToOpen = book;
      this.isBookDetailVisible = true;
    },
    closeModal() {
      this.isBookDetailVisible = false;
      this.isNewBookVisible = false;
    },

    newBook(){
      this.isNewBookVisible = true;
    }
  },

  data(){
    return {
      isBookDetailVisible: false,
      isNewBookVisible: false,
      bookToOpen: {}
    }
  }
};
</script>

<style>

#booksView{
  display: flex;
  align-items: start;
  gap: 50px;
}

#booksView > section{
  display: flex;
  flex-direction: column;
  gap: 20px;
  align-items: center;
}

#booksView > section > section{
  display: flex;
  gap:50px;
  margin-right: 30px;
}




</style>