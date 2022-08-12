<template>
  <div id="bookList" v-if="this.books.length > 0">
    <div v-bind:key="currentBook.isbn" v-for="currentBook in booksList">
      <h2>{{ currentBook.title }}</h2>
      <div id="divider"></div>
      <h3>{{ currentBook.author }}</h3>
    </div>
      <div id="shelf">
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
  computed: {
    booksList() {
      return this.$store.state.books.filter((book) => {
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
    bookService.getBooks().then((response) => {
      if (response.status === 200) {
        this.$store.commit("GET_BOOK_LIST", response.data);
        this.books = response.data;
      }
    });
  },
  methods: {
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
};
</script>

<style>
body {
  background-color: white;
  display: block;
  background-repeat: no-repeat;
  background-size: cover;
  background-position: center;
}



#bookList h2 {
  text-align: center;
  flex-grow: 2;
  
}

#bookList {
  display: flex;
  flex-direction: column;
  align-items: center;
  
}

#bookList > div {
  padding-left: 10px;
  padding-right: 20px;
  display: flex;
  justify-content: space-around;
  background-color: seagreen;
  border-radius: 2px;
  max-width: 98%;
  
}

#bookList > div:nth-child(5n) {
  background: linear-gradient(#662358, #a37399 55%, #662358);
  min-width: 95%;

  
}

#bookList > div:nth-child(5n + 1) {
  background: linear-gradient(#ac6027, #ffcba3 55%, #ac6027);
  min-width: 90%;
  
}

#bookList > div:first-child {
  background: linear-gradient(#b96c30, #ffcba3 55%, #ac6027);
  min-width: 90%;
  
}

#bookList > div:nth-child(5n + 2) {
  background: linear-gradient(#17305f, #829cce 55%, #132850);
  min-width: 85%;
  color: #fdfdfd;
  
}
#bookList > div:nth-child(5n + 3) {
  background: linear-gradient(#253f1a, #8bc473 55%, #253f1a);
  min-width: 95%;
  color: #ffffff;
}
#bookList > div:nth-child(5n + 4) {
  background: linear-gradient(#791c1c, #b66a6a 55%, #791c1c);
  min-width: 92%;
  color: #ffffff;
  
}

#divider {
  background-color: black;
  width: 4px;
  margin-left: 20px;
  margin-right: 20px;
  background-image: ;
}

#shelf {
  border-top: 22px solid #755D44;
  max-width: 90%;
  border-radius: 50%;
  box-shadow: 5px 10px 18px #1d1611;
}
</style>