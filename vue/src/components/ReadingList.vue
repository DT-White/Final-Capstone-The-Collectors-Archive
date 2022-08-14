<template>
  <div id="readingList" droppable @drop="onDrop($event)"
  class="drop-zone"
  @dragover.prevent
  @dragenter.prevent>
    <span class="shelf topShelf">
      <h2>Reading List</h2>
    </span>
    <section id="books">
      <span class="pillar"></span>
      <div v-bind:key="currentBook.isbn" v-for="currentBook in booksList" draggable @dragstart="startDrag($event, currentBook)"
        v-bind:class="{purple: currentBook.color == 'purple',
        blue: currentBook.color == 'blue',
        orange: currentBook.color == 'orange',
        red: currentBook.color == 'red',
        green: currentBook.color == 'green'}"
        v-show="!currentBook.hide">
        <h2>{{ currentBook.title }}</h2>
        <div id="divider"></div>
        <h3>{{ currentBook.author }}</h3>
      </div>
      <span class="pillar"></span>
    </section>
      <span class="shelf">
    </span>
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
#readingList{
    background-color:transparent;
}

#readingList h2 {
  text-align: center;
  flex-grow: 2;
}

#readingList {
  display: flex;
  flex-direction: column;
  align-items: center;
}

#readingList > div {
  padding-left: 10px;
  padding-right: 20px;
  display: flex;
  justify-content: space-around;
  background-color: seagreen;
  border-radius: 2px;
  max-width: 98%;
}

#readingList > div:nth-child(5n) {
  background: linear-gradient(#662358, #a37399 55%, #662358);
  min-width: 95%;
}

#readingList > div:nth-child(5n + 1) {
  background: linear-gradient(#ac6027, #ffcba3 55%, #ac6027);
  min-width: 90%;
}

#readingList > div:first-child {
  background: linear-gradient(#b96c30, #ffcba3 55%, #ac6027);
  min-width: 90%;
}

#readingList > div:nth-child(5n + 2) {
  background: linear-gradient(#17305f, #829cce 55%, #132850);
  min-width: 85%;
  color: #fdfdfd;
}
#readingList > div:nth-child(5n + 3) {
  background: linear-gradient(#253f1a, #8bc473 55%, #253f1a);
  min-width: 95%;
  color: #ffffff;
}
#readingList > div:nth-child(5n + 4) {
  background: linear-gradient(#791c1c, #b66a6a 55%, #791c1c);
  min-width: 92%;
  color: #ffffff;
}

#divider {
  background-color: black;
  width: 4px;
  margin-left: 20px;
  margin-right: 20px;
}


</style>