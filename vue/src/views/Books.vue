<template>
  <div id="booksView">
      <book-filter/>
      <section>
        <add-book />
        <section>
          <bookList @click="showModal($event)"/>
          <reading-list @dblclick="showModal($event)"/>
        </section>
      </section>
      <button
      type="button"
      class="btn"
      @click="showModal($event)"
    >
      Open Modal!
    </button>

    <Modal
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
    showModal(event) {
        // this.isModalVisible = true;
        console.log(event.target)
      },
      closeModal() {
        this.isModalVisible = false;
      }
  },

  data(){
    return {
      isModalVisible: false,
      bookToOpen: 0,
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
  gap: 50px;
}


</style>