<template>
  <div id="bookList" v-if="books.length>0">
    <div  v-bind:key="currentBook.isbn" v-for="currentBook in books">
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
      books: [],
    };
  },
  created() {
    bookService.getBooks().then((response) => {
      if (response.status === 200) {
        this.books = response.data;
      }
    });
  },
};
</script>

<style>
#bookList > div{
    display: flex;
    justify-content: space-around;
    background-color:salmon;
    
}

#divider{
    background-color: black;
    width: 3px;
    
}


</style>