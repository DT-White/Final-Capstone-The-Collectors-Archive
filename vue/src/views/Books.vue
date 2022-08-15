<template>
  <div id="booksView">
      <book-filter/>
      <section>
        <add-book />
        <section>
          <bookList @openBook="openBook"/>
          <reading-list @openBook="openBook"/>
        </section>
      </section>

    <Modal :book="bookToOpen"
      v-show="isModalVisible"
      @close="closeModal"
    />
  </div>
</template>

<script>
import addBook from "@/components/AddBook";
import bookList from "@/components/BookList";
import bookFilter from "@/components/BookFilter";
import readingList from "@/components/ReadingList";
import Modal from "@/components/BookDetail"
export default {
  components: { 
    addBook,
    bookList,
    bookFilter,
    readingList,
    Modal 
  },

  methods: {
    openBook(event, book) {
        this.bookToOpen = book;
        this.isModalVisible = true;
      },
      closeModal() {
        this.isModalVisible = false;
      }
  },

  data(){
    return {
      isModalVisible: false,
      bookToOpen: {}
    }
  }
};
</script>

<style>

#booksView{
  display: flex;
  align-items: start;
  gap: 50px;
}

#booksView > section{
  display: flex;
  flex-direction: row;
}

#booksView > section > section{
  display: flex;
  gap:50px;
  margin-right: 30px;
}


</style>