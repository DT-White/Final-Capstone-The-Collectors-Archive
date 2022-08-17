<template>
  <div id="booksView">
      <book-filter/>
      <section>
        <profile/>
        <section>
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

  </div>
</template>

<script>

import bookList from "@/components/BookList";
import bookFilter from "@/components/BookFilter";
import readingList from "@/components/ReadingList";
import bookDetail from "@/components/BookDetail";
import profile from '@/components/Profile';
import addBook from '@/components/AddBook';
import email from '@/components/Email';
import profileService from '@/services/ProfileService'

export default {
  components: { 
    addBook,
    bookList,
    bookFilter,
    readingList,
    bookDetail ,
    profile,
    email,
  },

  methods: {
    openBook(event, book) {
      this.bookToOpen = book;
      this.isBookDetailVisible = true;
    },
    closeModal() {
      this.isBookDetailVisible = false;
      this.isNewBookVisible = false;
      this.isEmailVisible = false;
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
  flex-direction: column;
  gap: 20px;
  align-items: center;
}

#booksView > section > section{
  display: flex;
  gap:50px;
  margin-right: 30px;
}




</style>