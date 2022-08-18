<template>
  <div id="friendsList">
    <friends-Book-List  @openBook="openBook"/>
    <Modal :book="bookToOpen" v-show="isModalVisible" @close="closeModal" />
  </div>
</template>

<script>
import friendsBookList from "@/components/BookList";
import Modal from "@/components/BookDetail";


export default {
  name:'friendsCollection',
  components: {
    friendsBookList,
    Modal,
  },


  computed: {
  

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
span.icon {
  display: hidden;
}

div#friendsList {
  max-width: 50vw;
  display: flex;
  justify-content: center;
  
}
</style>