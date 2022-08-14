<template>
  <div id="bookList" v-if="this.books.length > 0" droppable 
  @drop="onDrop($event)" 
  class="drop-zone"
  @dragover.prevent
  @dragenter.prevent>
    <div class="shelf">
      <span class="shelf-label">
        <h2>Library</h2>
      </span>
    <section id="books" >
      
      <div v-bind:key="currentBook.bookId"  v-for="currentBook in booksList" draggable 
        @dragstart="startDrag($event, currentBook)"
        v-show="!checkForBookInReadingList(currentBook) " 
        @dblclick="$emit('openBook',$event, currentBook)"
        v-bind:class="{new_book: isNewBook(currentBook), 
        purple: currentBook.color == 'purple',
        blue: currentBook.color == 'blue',
        orange: currentBook.color == 'orange',
        red: currentBook.color == 'red',
        green: currentBook.color == 'green'}">
        <img id="newSticker" v-if="isNewBook(currentBook)" src="../../resources/new_icon.jpg"/>
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
  data() {
    return {
      books: [],
      draggingBook: null,
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
        const books = this.setBookColors(response.data);
        this.$store.commit("GET_BOOK_LIST", books);
        this.books = books;
      }
    });
  },


  methods: {
    setBookColors(books){
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
      return books;
    },

    isDragging(book){
      return this.draggingBook && this.draggingBook.isbn === book.isbn;
    },

    isNewBook(book) {
      return book.dateAdded > this.$store.state.user.timeAccessed
    },
    updateStoreReadingList(){
      bookService.getReadingList().then((response) => {
      if (response.status === 200) {
        const books = this.setBookColors(response.data);
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
      this.draggingBook = book;
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
      this.draggingBook = null;
    },
  },
};
</script>

<style>

.shelf{
  border-width:25px;
  border-color:#755D44;
  border-style: solid;
  box-shadow: 0px 10px 18px #1d1611;
}

#bookList{
  
}

body {
  background-color: white;
  display: block;
  background-repeat: no-repeat;
  background-size: cover;
  background-position: center;
}

img#newSticker {
  height: 80px;
}

#bookList h2 {
  text-align: center;
  flex-grow: 2;
  
}

#books {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding-left:10px;
  padding-right:10px;
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
}



.shelf-label{
  width:auto;
  background-color:grey;
  height:30px;
  margin-bottom:20px;
}

.shelf-label h2{
  margin:1px 3px 1px 3px;
}

.topShelf{
  margin-bottom: 50px;
}

img {
  height: 40px;
}



</style>