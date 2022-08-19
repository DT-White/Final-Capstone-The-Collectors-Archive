<template>
  <div id="friendsList">
    <friends-Book-List :profile="this.profile" @openBook="openBook"/>
    <Modal :book="bookToOpen" v-show="isModalVisible" @close="closeModal" />
  </div>
</template>

<script>
import friendsBookList from "@/components/BookList";
import Modal from "@/components/BookDetail";
import profileService from "@/services/ProfileService";

export default {
  name:'friendsCollection',
  components: {
    friendsBookList,
    Modal,
  },

  created() {
    profileService.getFriendProfile(this.$route.params.id).then((response) => {
        if(response.status === 200) {
          this.profile = response.data
        }
      })
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
      bookToOpen: {},
      profile: {}
    }
  }
};
</script>

<style>
span.icon {
  display: hidden;
}

div#main
div#friendsList {
  max-width: 50vw;
  display: flex;
  justify-content: center;
  flex-direction: column;
}
</style>