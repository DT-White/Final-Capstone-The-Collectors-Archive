<template>
  <div @click="close" class="modal-backdrop">
    <div
      class="modal"
      @click.stop
      v-bind:class="{
        purpleOpen: book.color == 'purple',
        blueOpen: book.color == 'blue',
        orangeOpen: book.color == 'orange',
        redOpen: book.color == 'red',
        greenOpen: book.color == 'green',
      }"
    >
      <section id="titleAuthorIsbnPublishingDate" class="left-page page">
        <img
          id="cover"
          :src="
            book.coverImageUrl ? book.coverImageUrl : '@/resources/no-image'
          "
          alt="Book cover image"
        />
        <h2 id="bookTitle">{{ book.title ? book.title : "title" }}</h2>
        <span id="author">Author(s): </span>
        <h3 id="bookAuthor">{{ book.author ? book.author : "author" }}</h3>
        <span id="ISBN">ISBN: </span>
        {{ book.isbn ? book.isbn : "isbn" }}
        <span id="publishingDate">Publishing Date: </span>
        {{ book.publishingDate ? book.publishingDate : "publishing date" }}
      </section>

      <section class="right-page page">
        <p id="summaryTitle">Summary</p>
        <p id="bookSummary">
          {{ book.summary ? book.summary : "summary" }}
        </p>
      </section>
    <!-- <p v-for="genre in book.genres" :key="genre.id">{{genre}}</p> -->
    </div>
  </div>
</template>

<script>
export default {
  name: "Modal",
  props: {
    book: {},
  },
  methods: {
    close() {
      this.$emit("close");
    },
  },
};
</script>

<style>
/* .modal-backdrop {
  position: fixed;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  background-color: rgba(0, 0, 0, 0.3);
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
}

.modal {
  background: #ffffff;
  box-shadow: 2px 2px 20px 1px;
  overflow-x: auto;
  display: flex;
  height: 500px;
  width: 600px;
  border-style: solid;
  border-width: 5px 12px 5px 12px;
  border-radius: 10px;
  justify-content: center;
  margin-right: 0;
}

.page {
  width: 50%;
}

#titleAuthorIsbnPublishingDate {
  flex-direction: column;
}

.left-page {
  border-right: rgb(141, 141, 141);
  border-style: hidden;
  /* border-width: 0px 1px 0px 0px; 
  /* border-width: 20px 5px 20px 5px; 
  box-shadow: 5px 0px 40px #1d1611;
  display: flex;
  justify-content: center;
  align-items: center;
}

.right-page {
  border-right: rgb(141, 141, 141);
  border-style: hidden;
  border-width: 0px 0px 0px 1px;
  box-shadow: -5px 0px 40px #1d1611;
  justify-content: center;
  align-items: center;
  
}

#cover {   
  object-fit: contain;
  height: 50%;
  width: auto;
}

#bookTitle {
  text-align: center;
}

#author {
  text-decoration: underline;
}

#ISBN {
  text-decoration: underline;
}

#publishingDate {
  text-decoration: underline;
}

#summaryTitle {
  text-align: center;
  font-size: 20px;
  font-style: italic;
}

#bookSummary {
  padding-left: 7px;
  padding-right: 7px;
}

.redOpen {
  border-color: #791c1c;
}

.orangeOpen {
  border-color: #ac6027;
}

.greenOpen {
  border-color: #253f1a;
}

.blueOpen {
  border-color: #17305f;
}

.purpleOpen {
  border-color: #662358;
} */
</style>
