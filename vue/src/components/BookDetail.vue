
<template>
    <div @click="close" class="modal-backdrop" @mouseenter="page3Flipped = false">
        <div class="book" @click.stop >
            <div class="back"
                v-bind:class="{
                purpleCover: book.color == 'purple',
                blueCover: book.color == 'blue',
                orangeCover: book.color == 'orange',
                redCover: book.color == 'red',
                greenCover: book.color == 'green',
                }"
            ></div>
            <div class="page4 " >
                <p id="bookSummary">
                {{ summary2 }}
                </p>
            </div>
            <div class="page3 "
            :class="{flipped: page3Flipped}">
                <p id="bookSummary">
                {{ summary2 }}
                </p>
            </div>
            <div class="page2" :class="{clickable: summary2, flipped: page3Flipped}"  >
                <p id="summaryTitle">Summary</p>
                <p id="bookSummary">
                {{ summary1 }}
                </p>
            </div>
            <!-- <div class="page1 "
            :class="{flipped: !page3Flipped, covered: !page3Flipped}">
                <p id="bookSummary">
                {{ summary2 }}
                </p>
            </div> -->
            <div class="page1" :class="{covered:page3Flipped}">
                <h2 id="bookTitle">{{ book.title ? book.title : "title" }}</h2>
                <div id="author">Author(s): 
                <h3 id="bookAuthor">{{ book.author ? book.author : "author" }}</h3></div>
                <div id="ISBN">ISBN: 
                {{ book.isbn ? book.isbn : "isbn" }}</div>
                <div id="publishingDate">Publishing Date: 
                {{ book.publishingDate ? book.publishingDate : "publishing date" }}</div>
            </div>
            <div class="page0"
                v-bind:class="{
                purpleCover: book.color == 'purple',
                blueCover: book.color == 'blue',
                orangeCover: book.color == 'orange',
                redCover: book.color == 'red',
                greenCover: book.color == 'green',
                }"
            ></div>
            <div class="front"
                v-bind:class="{
                purpleCover: book.color == 'purple',
                blueCover: book.color == 'blue',
                orangeCover: book.color == 'orange',
                redCover: book.color == 'red',
                greenCover: book.color == 'green',
                }"
            >
                <img :src="book.coverImageUrl" alt="">
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

  data(){
    return {
      page3Flipped:false
    }
  },

  computed:{
      summary1(){
          let text = ""
          if (this.book.summary){
            text = this.book.summary.substring(0,700);
            if (this.summary2){
                text += ' . . . '
            }
            }
          return text;
      },
      summary2(){
          let text = "";
          if (this.book.summary){
            if (this.book.summary.length > 700){
                text = this.book.summary.substring(701,1400);
            }
            if (this.summary3){
                text += ' . . . '
            }
          }
          return text;
      },
      summary3(){
          let text = "";
          if (this.book.summary){
            if (this.book.summary.length > 1400){
                text = this.book.summary.substring(1401);
            }
          }
          return text;
      }
  },

  methods: {
    close() {
      this.$emit("close");
    },
  },
};
</script>
<style>
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
  position: fixed;
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

#titleAuthorIsbnPublishingDate {
  flex-direction: column;
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

.book {
  transform-style: preserve-3d;
  position: relative;
  height: 500px;
  backface-visibility: visible;
}


.front, .back, .page1, .page2, .page0, .page3, .page4 {
  transform-style: preserve-3d;
  position: absolute;
  width: 300px;
  height: 500px;
  top: 0; left: 0;
  transform-origin: left center;
  transition: transform .5s ease-in-out, box-shadow .35s ease-in-out, display .5s ease-in-out;
  margin: 0;
  padding: 0;
}

.front, .back {
  background-color: navy;
}

.front{
    display: flex;
    justify-content: center;
    align-items: center;;
}

.front img {
    width: 90%;
    height: 90%;
    border-radius: 5px;
}

.orangeCover{
    background-color: #AC6027;
}

.redCover{
    background-color: #791c1c;
}

.blueCover{
    background-color: #17305f;
}

.greenCover{
    background-color: #253f1a;
}

.purpleCover{
    background-color: #662358;
}

.front, .page1, .page0 {
  border-bottom-right-radius: .5em;
  border-top-right-radius: .5em;
}

.back, .page2 {
  border-bottom-right-radius: .5em;
  border-top-right-radius: .5em;
}

.page1, .page2 { 
  background: #efefef;
}

.page1{
  border-color: rgb(141, 141, 141);
  border-style: solid;
  border-width: 0px 0px 0px 1px;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  width: 299px;
}

.page1 > *{
    transform: scale(-1,1);
    
}

.book:hover .front {
  transform: rotateY(-160deg) scale(1.1);
  box-shadow: 0 1em 3em 0 rgba(0, 0, 0, .2);
}

.book:hover .page1 {
  transform: rotateY(-150deg) scale(1.1,1.1);
  box-shadow: 5px 0px 25px 1px #33302d;
}

.book:hover .page2 {
  transform: rotateY(-30deg) scale(1.1);
  box-shadow: 5px 0px 25px 1px #33302d;
}

.book:hover .page0 {
  transform: rotateY(-159deg) scale(1.1);
}

.book:hover .back {
  transform: rotateY(-20deg) scale(1.1);
}

.flipped{
  transform: rotateY(-90deg) scale(-1,1) !important;
}

.covered{
  display: none;
}

.clickable{
    cursor: pointer;
}

#bookSummary{
    line-height: 1.5rem;
}
</style>