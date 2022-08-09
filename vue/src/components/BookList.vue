<template>
  <div id="bookList" v-if="this.books.length > 0">
    <div v-bind:key="currentBook.isbn" v-for="currentBook in booksList">
      <h2>{{ currentBook.title }}</h2>
      <div id="divider"></div>
      <h3>{{ currentBook.author }}</h3>
    </div>
  </div>
</template>

<script>
import bookService from "@/services/BookService";
export default {
  data() {
    return {
      books: []
    };
  },
  computed:{
      booksList(){
           return this.$store.state.books
           .filter((book) => {
               return book.title.toLowerCase().includes(this.$store.state.storeFilter.title.toLowerCase())
               && book.author.toLowerCase().includes(this.$store.state.storeFilter.author.toLowerCase())
               && (book.isbn == this.$store.state.storeFilter.isbn || !this.$store.state.storeFilter.isbn)
               && (Date.parse(book.publishingDate) > Date.parse(this.$store.state.storeFilter.startDate) || !this.$store.state.storeFilter.startDate)
               && (Date.parse(book.publishingDate) < Date.parse(this.$store.state.storeFilter.endDate) || !this.$store.state.storeFilter.endDate)
               
        })
      }
  },
  created() {
    bookService.getBooks().then((response) => {
      if (response.status === 200) {
        this.$store.commit("GET_BOOK_LIST", response.data);
        this.books = response.data
      }
    });
  },
  methods:{
      updateBooks(){
          this.books = this.$store.state.filtered;
      }
  },
  
};
</script>

<style>
#bookList > div {
  display: flex;
  justify-content: space-around;
  background-color: seagreen;
}

#divider {
  background-color: black;
  width: 3px;
}
</style>