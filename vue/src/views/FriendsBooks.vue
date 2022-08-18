<template>
  <div id="friendsList">
    <book-List></book-List>
    <Modal :book="bookToOpen" v-show="isModalVisible" @close="closeModal" />
  </div>
</template>

<script>
import bookList from "@/components/BookList";
import Modal from "@/components/BookDetail";
export default {
  components: {
    bookList,
    Modal,
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
</style>