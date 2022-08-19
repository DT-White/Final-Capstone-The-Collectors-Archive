<template>
  <div id="bookList"  droppable 
  @drop="onDrop($event)" 
  class="drop-zone bookList"
  @dragover.prevent
  @dragenter.prevent>
    <div class="shelf">
      <!-- <div class="line"> -->
      <div class="shelf-top">
        <span v-show="this.$route.path == '/books'" class="iconEmail icon" v-on:click="$emit('sendEmail', $event)">
          <img id="email-icon" src="../../resources/email.png" alt="Plus icon">
          <span class="tooltiptext">SHARE YOUR LIBRARY</span>
        </span>
        <div class="shelf-label">
          <div class="nail"></div>
            <h2 v-if="this.$route.path != '/books'">{{this.profile.firstName.toUpperCase()}}'S </h2>
            <h2 >LIBRARY</h2>
          <div class="nail"></div>
        </div>
        <span v-show="showPlus" class="icon" v-on:click="handlePlusButton">
          <img id="plus" src="../../resources/plus.png" alt="Plus icon">
          <span class="tooltiptext">{{this.$route.path == '/books' ? 'ADD A BOOK' : 'ADD TO FRIENDS LIST'}}</span>
        </span>
        
      <!-- </div> -->
      </div>
    <section class="books" >
      
      <div v-bind:key="currentBook.bookId"  v-for="currentBook in booksList" draggable 
        @dragstart="startDrag($event, currentBook)"
        v-show="!checkForBookInReadingList(currentBook) " 
        @click="$emit('openBook',$event, currentBook)"
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
  props: {
    profile:{}
    },
  components: {  },
  data() {
    return {
      books: [],
      user: [],
      draggingBook: null,
      showPlus: true
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
    if(this.$route.path == "/books") {
    bookService.getBooks().then((response) => {
      if (response.status === 200) {
        const books = this.setBookColors(response.data);
        this.$store.commit("GET_BOOK_LIST", books);
        this.books = books;
      }
    });
    } else {
      bookService.getFriendBookList(this.$route.params.id).then((response) => {
      if (response.status === 200) {
        const books = this.setBookColors(response.data);
        this.$store.commit("GET_BOOK_LIST", books);
        this.books = books;
      }
    });
    }
  },


  methods: {
   
   handlePlusButton(event){
     if (this.$route.path == '/books'){
       this.$emit('addBook', event)
     } else{
       this.showPlus = false;
     }
   },

    setBookColors(books){
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
  border-width:0px 25px 25px 25px;
  border-color:#4e3823;
  border-style: solid;
  box-shadow: 0px 10px 18px #1d1611;
  background: linear-gradient(#3a291a 10%, #4e3823 20%, #3a291a);
  border-radius: 5px;
  
}


.shelf-top{
  background-color: #4e3823;
  margin: 0px 1px 30px 1px;
  display: flex;
  justify-content: center;
  box-shadow: 0 10px 18px -12px #1d1611;
  align-items: center;
}

.shelf-label{
  
  background-color: rgb(211, 187, 55);
  width: max-content;
  border-radius: 10% / 50%;
  margin: 5px 5px 5px 5px;
  display: flex;
  align-items: center;
  padding: 0px 10px 0px 10px;
}

.shelf-label h2{
  
  font-size: 1.2rem;
  color: rgb(77, 68, 18);
  margin:1px 3px 1px 3px;
}

.nail{
  background-color: rgb(156, 138, 37);
  width: 5px;
  height: 5px;
  border-width: 2.5px;
  border-style: solid;
  border-color: rgb(150, 132, 35);;
  border-radius: 50%;
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
  margin-left: -20px;
  margin-right: -20px;
}

.bookList h2 {
  text-align: center;
  flex-grow: 2;
  
}

.books {
  
  display: flex;
  flex-direction: column;
  align-items: center;
  padding-left:10px;
  padding-right:10px;
}

.books > div {
  
  padding-left: 10px;
  padding-right: 20px;
  display: flex;
  justify-content: space-around;
  background-color: seagreen;
  border-radius: 2px;
  max-width: 98%;
  cursor: pointer;
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

img {
  height: 40px;
}



</style>