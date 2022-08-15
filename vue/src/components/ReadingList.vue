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
    <section id="books">
      <div v-bind:key="currentBook.isbn" v-for="currentBook in booksList" draggable 
        @dragstart="startDrag($event, currentBook)"
        @dblclick="$emit('openBook',$event, currentBook)"
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
      return this.$store.state.readingList;
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
          switch (book.bookId % 5){
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
  },
}
</script>

<style>


</style>