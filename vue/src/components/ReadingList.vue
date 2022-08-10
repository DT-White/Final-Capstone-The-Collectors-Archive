<template>
  <div id="readingList" droppable @drop="onDrop($event, 1)">
    <h2>Reading List</h2>
    <div v-bind:key="currentBook.isbn" v-for="currentBook in booksList" draggable @dragstart="startDrag($event, item)">
      <h2>{{ currentBook.title }}</h2>
      <div id="divider"></div>
      <h3>{{ currentBook.author }}</h3>
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
    bookService.getReadingList().then((response) => {
      if (response.status === 200) {
        this.$store.commit("GET_READING_LIST", response.data);
        this.books = response.data;
      }
    });
  },
  methods: {
    startDrag(evt, item) {
      evt.dataTransfer.dropEffect = 'move'
      evt.dataTransfer.effectAllowed = 'move'
      evt.dataTransfer.setData('itemID', item.id)
    },
    onDrop(evt, list) {
      const itemID = evt.dataTransfer.getData('itemID')
      const item = this.items.find((item) => item.id == itemID)
      item.list = list
    },
  },
}
</script>

<style>
#readingList{
    background-color: rgb(88, 22, 22);
}
</style>