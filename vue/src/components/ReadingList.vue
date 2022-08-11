<template>
  <div id="readingList" droppable @drop="onDrop($event, 1)">
    <h2>Reading List</h2>
    <div v-bind:key="currentBook.isbn" v-for="currentBook in booksList" draggable @dragstart="startDrag($event, item)">
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

#shelf {
  border-top: 22px solid #755D44;
  max-width: 90%;
  border-radius: 50%;
  box-shadow: 5px 10px 18px #1d1611;
}

</style>