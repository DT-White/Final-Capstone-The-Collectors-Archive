<template>
  <div class="cover">
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
        <label for="page-1" class="modal__page modal__page--1">
          <img
            id="cover"
            :src="
              book.coverImageUrl ? book.coverImageUrl : '@/resources/no-image'
            "
            alt="Book cover image"
          />
        </label>
        <label for="page-2" class="modal__page modal__page--4">
          <div class="page__content__page--4">
            {{ book.summary ? book.summary : "summary" }}
          </div>
          <div class="page__number">3</div>
        </label>
        <!-- resets the page -->
        <input type="radio" name="page" id="page-1" />
        <!-- Goes to next page -->
        <input type="radio" name="page" id="page-2" />
        <label class="modal__page modal__page--2">
          <div class="modal__page-front">
            <div class="page_content">
              <h1 class="page__content-title">
                {{ book.title ? book.title : "title" }}
              </h1>
              <h2 class="page__content-author">
                {{ book.author ? book.author : "author" }}
              </h2>
              <p class="page_contents-isbn">
                Isbn(13):{{ book.isbn ? book.isbn : "isbn" }}
              </p>
              <p class="page_content-publishingDate">
               Date Published: {{
                  book.publishingDate ? book.publishingDate : "publishing date"
                }}
              </p>
              Genres:
              <p
                class="page_content__genre"
                v-for="genre in book.genres"
                :key="genre.id"
              >
               {{ genre }}
              </p>
            </div>
          </div>
          <!-- <div class="modal__page-between">show me tomato</div> -->
          <div class="modal__page-back">
            {{ book.summary ? book.summary : "summary" }}
            <!-- <div class="page__content"> -->
              <div class="page__number">2</div>
            <!-- </div> -->
          </div>
        </label>
      </div>
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
<style scoped>
@import url("https://fonts.googleapis.com/css?family=Cormorant+Garamond:300,400,600%7CTulpen+One&display=swap");
:root {
  --body-bg: #FAFAFA;
  --page-bg: #F5F5F5;
  --dark-text: #2A2935;
  --baseline: 12px;
  --book-title: "Tulpen One", sans-serif;
  --title: "Cormorant Garamond", serif;
  --body: "Cormorant Garamond", serif;
  --base-size: var(--baseline) * 1.2;
}
.modal-backdrop {
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  background-color: rgba(0, 0, 0, 0.3);
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
  width: 100%;
}
* {
  box-sizing: border-box;
}
/* body {
  background-color: var(--body-bg);
  height: 100vh;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
} */
.modal {
  overflow: hidden;
  background: #FFFFFF;
  box-shadow: 2px 2px 20px 1px;
  overflow-x: auto;
  display: flex;
  height: 75%;
  width: 50%;
  border-color: red;
  border-style: solid;
  border-width: 2px 8px 2px 8px;
  border-radius: 5px;
  perspective: 1200px;
}
.modal > label {
  width: 50%;
}
.modal > label:first-child {
  border-right: rgb(141, 141, 141);
  border-style: hidden;
  border-width: 0px 1px 0px 0px;
  box-shadow: 5px 0px 40px #1D1611;
  display: flex;
  justify-content: center;
  align-items: center;
}
.modal > label:last-child {
  border-right: rgb(141, 141, 141);
  border-style: hidden;
  border-width: 0px 0px 0px 1px;
  box-shadow: -5px 0px 40px #1D1611;
  position: absolute;
}
#cover {
  height: 100%;
  width: 100%;
}
.redOpen {
  border-color: #791C1C;
}
.orangeOpen {
  border-color: #AC6027;
}
.greenOpen {
  border-color: #253F1A;
}
.blueOpen {
  border-color: #17305F;
}
.purpleOpen {
  border-color: #662358;
}
.modal__page {
  position: relative;
  max-width: 100%;
  max-height: fit-content;
  display: flex;
  transform: rotateY(0deg);
  transition: transform 0.9s cubic-bezier(0.645, 0.045, 0.355, 1);
  transform-origin: 0% 0%;
  background-color:white;
}
.modal__page--1 {
  cursor: pointer;
  overflow: hidden;
}
.modal:nth-of-type(1) {
  background-image: linear-gradient(
    -90deg,
    rgba(227, 227, 227, 1) 0%,
    rgba(247, 247, 247, 0) 18%
  );
}
.modal__page--1 img {
  width: auto;
  height: auto;
}
.modal__page--2 {
  height:100%;
  position: absolute;
  right: 0;
  pointer-events: none;
  transform-style: preserve-3d;
  background-image: linear-gradient(
    90deg,
    rgba(227, 227, 227, 1) 0%,
    rgba(247, 247, 247, 0) 18%
  );
}
.modal__page--4 {
  cursor: pointer;
  padding: 0 calc(var(--baseline) * 3);
}
.modal__page-front {
  text-overflow: var(--page-bg);
  position: relative;
  right:0;
  max-width: 100%;
  max-height: 100%;
  padding: 0 calc(var(--baseline) * 1.8);
  transform: rotateY(0deg) translateZ(1px);
  background-image: linear-gradient(to left, teal 90%, rgba(0, 0, 0, 0.486));
}
.modal__page-back {
  background-image: linear-gradient(to right,blue 90%, rgba(0, 0, 0, 0.486));
  position: absolute;
  top:0;
  bottom:0;
  left:0;
  right:0;
  padding: 0 calc(var(--baseline) * 1.8);
  transform: rotateY(180deg) translateZ(1px);
  padding-top: 20px;
}
.page__content__page--4 {
  height: 100%;
  width: 100%;
  position: relative;
  padding-top: 20px;
}
.page__content-table {
  width: 50%;
  margin-top: calc(var(--baseline) * 2);
}
.page__number {
  position: absolute;
  bottom: var(--baseline);
  width: calc(50% - (var(--baseline) * 2));
  font-family: var(--title);
  font-size: calc(var(--base-size) * 0.67);
  text-align: center;
}
input[type="radio"] {
  display: none;
}
input[type="radio"]:checked + .modal__page {
  transition: transform 0.9s cubic-bezier(0.645, 0.045, 0.355, 1);
  transform: rotateY(-180deg);
}
</style>