<template>
  <div id="booksView">
      <book-filter/>
      <section>
        <add-book />
        <profile/>
        <section>
          <bookList @openBook="openBook" />
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

import bookList from "@/components/BookList";
import bookFilter from "@/components/BookFilter";
import readingList from "@/components/ReadingList";
import Modal from "@/components/BookDetail";
import profile from '@/components/Profile'
export default {
  components: { 
    
    bookList,
    bookFilter,
    readingList,
    Modal ,
    profile
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
<<<<<<< HEAD
  flex-direction: row;
=======
  flex-direction: column;
  gap: 20px;
  align-items: center;
>>>>>>> ff1888b87dfefc110e373ca607ed32dbff92cd12
}

#booksView > section > section{
  display: flex;
  gap:50px;
<<<<<<< HEAD
=======
  margin-right: 30px;
>>>>>>> ff1888b87dfefc110e373ca607ed32dbff92cd12
}




</style>