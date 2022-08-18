<template>
  <div id="readingList" droppable @drop="onDrop($event)"
  class="drop-zone bookList"
  @dragover.prevent
  @dragenter.prevent>
  <div class="shelf" id="readingListShelf">
    <div class="shelf-top">
        <div class="shelf-label">
          <div class="nail"></div>
          <h2>READING LIST</h2>
          <div class="nail"></div>
        </div>
      </div>
    <section class="books">
      <div v-bind:key="currentBook.isbn" v-for="currentBook in booksList" draggable 
        @dragstart="startDrag($event, currentBook)"
        @click="$emit('openBook',$event, currentBook)"
        v-bind:class="{purple: currentBook.color == 'purple',
        blue: currentBook.color == 'blue',
        orange: currentBook.color == 'orange',
        red: currentBook.color == 'red',
        green: currentBook.color == 'green'}">
        <!-- v-show="!currentBook.hide"> -->
        <h2>{{ currentBook.title }}</h2>
        <div id="divider"></div>
        <h3>{{ currentBook.author }}</h3>
      </div>
    </section>
    </div>
  </div>
</template>

<script>
import bookService from "@/services/BookService";
export default {
  data(){
      return{
          books:[]
      }
  },
  computed: {
    booksList() {
      return this.$store.state.readingList.filter((book) => {
        return (
          book.title
            .toLowerCase()
            .includes(this.$store.state.storeFilter.title.toLowerCase()) &&
          book.author
            .toLowerCase()
            .includes(this.$store.state.storeFilter.author.toLowerCase()) &&
          (book.isbn == this.$store.state.storeFilter.isbn ||
            !this.$store.state.storeFilter.isbn) &&
          (Date.parse(book.publishingDate) >
            Date.parse(this.$store.state.storeFilter.startDate) ||
            !this.$store.state.storeFilter.startDate) &&
          (Date.parse(book.publishingDate) <
            Date.parse(this.$store.state.storeFilter.endDate) ||
            !this.$store.state.storeFilter.endDate) &&
          this.checkKeyWords(book) &&
          this.checkGenres(book)
        );
      });
    },
  },
  created() {
    this.updateStoreReadingList();
  },
  methods: {
    updateStoreReadingList(){
      bookService.getReadingList().then((response) => {
      if (response.status === 200) {
        const books = response.data;
        for (let book of books){
          switch (book.isbn % 5){
            case 0:
              book.color = "purple"
              break;
            case 1:
              book.color = "orange"
              break;
            case 2:
              book.color = "blue"
              break;
            case 3:
              book.color = "green"
              break;
            case 4:
              book.color = "red"
              break;
          }
        }
        this.$store.commit("GET_READING_LIST", books);
        this.books = books;
      }
    });
    },

    startDrag(evt, book) {
      evt.dataTransfer.dropEffect = 'move'
      evt.dataTransfer.effectAllowed = 'move'
      evt.dataTransfer.setData('bookId', book.bookId)
      evt.dataTransfer.setData('fromList', "readingList")
    },
    onDrop(evt) {
      const book = {bookId: evt.dataTransfer.getData('bookId')}
      const fromList = evt.dataTransfer.getData('fromList')
      if (fromList !== "readingList"){
        bookService.addBookToReadingList(book).then(response => {
          if (response.status === 201){
            this.updateStoreReadingList();
          }
        })
      }
    },
    checkKeyWords(book) {
      for (let word of this.$store.state.storeFilter.keyword.split(",")) {
        if (book.keyword){
          if (book.keyword.toLowerCase().includes(word.toLowerCase().trim())) {
            return true;
          }
        }
      }
      return false;
    },
    
    checkGenres(book) {
      let noneSelected = true;
      let matchesAll = true;
      for (let genre of this.$store.state.storeFilter.genres) {
        if (genre.selected) {
          noneSelected = false;
          if (!book.genres.includes(genre.name)) {
            matchesAll = false;
          }
        }
      }
      return noneSelected || matchesAll;
    },
  },
}
</script>

<style>


</style>