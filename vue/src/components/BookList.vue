<template>
  <div id="bookList" v-if="this.books.length > 0" droppable @drop="onDrop($event)" 
  class="drop-zone"
  @dragover.prevent
  @dragenter.prevent>
    
    <section id="books">
      <span class="shelf topShelf">
        <h2>Library</h2>
      </span>
      <div v-bind:key="currentBook.isbn"  v-for="currentBook in booksList" draggable @dragstart="startDrag($event, currentBook)"
        v-show="!checkForBookInReadingList(currentBook)"
        v-bind:class="{new_book: isNewBook(currentBook), 
        purple: currentBook.color == 'purple',
        blue: currentBook.color == 'blue',
        orange: currentBook.color == 'orange',
        red: currentBook.color == 'red',
        green: currentBook.color == 'green'}">
        <img v-if="isNewBook(currentBook)" src="data:image/png;base64,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"/>
        <h2>{{ currentBook.title }}</h2>
        <div id="divider"></div>
        <h3>{{ currentBook.author }}</h3>
      </div>
      <span class="shelf">
    </span>
    
    </section>
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
        this.$store.commit("GET_BOOK_LIST", books);
        this.books = books;
      }
    });
  },

  methods: {
    isNewBook(book) {
      return book.dateAdded > this.$store.state.user.timeAccessed
    },
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

    checkForBookInReadingList(book){
      let bookInList = false;
      for (let currentBook of this.$store.state.readingList){
        if (currentBook.isbn === book.isbn){
          bookInList = true;
        }
      }
      return bookInList;
    },

    startDrag(evt, book) {
      evt.dataTransfer.dropEffect = 'move'
      evt.dataTransfer.effectAllowed = 'move'
      evt.dataTransfer.setData('bookId', book.bookId)
      evt.dataTransfer.setData('fromList', "library")
    },
    onDrop(evt) {
      const bookId = evt.dataTransfer.getData('bookId')
      const fromList = evt.dataTransfer.getData('fromList')
      if (fromList !== "library"){
        bookService.removeBookFromReadingList(bookId).then(response => {
          if (response.status === 204){
            this.updateStoreReadingList();
          }
        })
      }
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

#books {
  display: flex;
  flex-direction: column;
  align-items: center;
  
}

#books > div {
  padding-left: 10px;
  padding-right: 20px;
  display: flex;
  justify-content: space-around;
  background-color: seagreen;
  border-radius: 2px;
  max-width: 98%;
  
}

.purple {
  background: linear-gradient(#662358, #a37399 55%, #662358);
  width: 95%;

  
}

.orange {
  background: linear-gradient(#ac6027, #ffcba3 55%, #ac6027);
  width: 90%;
  
}


.blue {
  background: linear-gradient(#17305f, #829cce 55%, #132850);
  width: 85%;
  color: #fdfdfd;
  
}
.green {
  background: linear-gradient(#253f1a, #8bc473 55%, #253f1a);
  width: 95%;
  color: #ffffff;
}
.red {
  background: linear-gradient(#791c1c, #b66a6a 55%, #791c1c);
  width: 92%;
  color: #ffffff;
  
}

#divider {
  background-color: black;
  width: 4px;
  margin-left: 20px;
  margin-right: 20px;
  background-image: ;
}



.shelf {
  background-color: #946d3e;
background-image: url("https://www.transparenttextures.com/patterns/retina-wood.png");
  height: 22px;
  width: 110%;
  box-shadow: 5px 10px 18px #1d1611;
  display: flex;
  justify-content: center;
  align-items: center;
}

.topShelf{
  margin-bottom: 50px;
}

img {
  height: 40px;
 

  
}
</style>