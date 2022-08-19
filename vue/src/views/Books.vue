<template>
  <div id="booksView">
     
      <section>
         
        <section>
          <book-filter id="searchBooks"/> 
          <bookList @openBook="openBook" @addBook="newBook" @sendEmail="openEmail"/>
          <reading-list @openBook="openBook"/>
        </section>
      </section>
      

    <book-detail :book="bookToOpen"
      v-show="isBookDetailVisible"
      @close="closeModal" />

    <add-book
      v-show="isNewBookVisible"
      @close="closeModal" />

    <email
      @updateProfile="updateProfile"
      v-if="isEmailVisible"
      @close="closeModal" />

      <test :book="bookToOpen"
      v-if="isTestVisible"
      @close="closeModal" />

  </div>
</template>

<script>

import bookList from "@/components/BookList";
import bookFilter from "@/components/BookFilter";
import readingList from "@/components/ReadingList";
import bookDetail from "@/components/BookDetail";
import addBook from '@/components/AddBook';
import email from '@/components/Email';
import profileService from '@/services/ProfileService';
import test from '@/components/turnpages.vue'
export default {
  components: { 
    addBook,
    bookList,
    bookFilter,
    readingList,
    bookDetail ,
  //  profile,
    email,
    test
  },

  methods: {
    openBook(event, book) {
      this.bookToOpen = book;
      this.isBookDetailVisible = true;
    },

    openTest(event, book) {
      this.bookToOpen = book;
      this.isTestVisible = true;
    },

    closeModal() {
      this.isBookDetailVisible = false;
      this.isNewBookVisible = false;
      this.isEmailVisible = false;
      this.isTestVisible = false;
    },

    newBook(){
      this.isNewBookVisible = true;
    },

    openEmail(){
      this.isEmailVisible = true;
    },

    updateProfile(){
      profileService.getProfile(this.$store.state.user.id).then(response => {
            if (response.status === 200 && response.data.firstName){
                this.$store.commit('SET_PROFILE',response.data);
            }
        })
    }
  },

  data(){
    return {
      isBookDetailVisible: false,
      isNewBookVisible: false,
      isEmailVisible: false,
      isTestVisible: false,
      bookToOpen: {}
    }
  }
};
</script>

<style>

#searchBooks{
  display: flex;
  align-items: flex-start;
  gap: 5px;
}

#booksView{
  display: flex;
  align-items: start;
  justify-content: space-evenly;
  gap: 50px;
}

#booksView > section{
  display: flex;
  flex-direction: row;
  gap: 20px;
  align-items: center;
}

#booksView > section > section{
  display: flex;
  gap:50px;
  margin-right: 30px;
  justify-content: space-around;
  align-items: flex-start;
}




</style>