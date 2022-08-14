<template>
  <div @click="close" class="modal-backdrop">
    <div class="modal"
    @click.stop
    v-bind:class="{ 
        purpleOpen: book.color == 'purple',
        blueOpen: book.color == 'blue',
        orangeOpen: book.color == 'orange',
        redOpen: book.color == 'red',
        greenOpen: book.color == 'green'}">
     <section>
         <img id="cover" :src="book.coverImageUrl ? book.coverImageUrl : '@/resources/no-image'" alt="Book cover image">
     </section>


     <section for="page-1" class="book_page book_page--1">
        <h2>{{book.title ? book.title : 'title'}}</h2>
        <h3>{{book.author ? book.author : 'author'}}</h3>
        <p>
            {{book.isbn ? book.isbn : 'isbn'}}
        </p>
        <p>
            {{book.summary ? book.summary : 'summary'}}
        </p>
        <p>
            {{book.publishingDate ? book.publishingDate : 'publishing date'}}
        </p>
        <p v-for="genre in book.genres" :key="genre.id">{{genre}}</p>
     </section>
     <section for="page-2" class="book_page book_page--4">
       <div class="page_content">
         <h1 class="page_content-title">I</h1>
         <div class="page_content-blockquote">
           <p class ="page_content-blockquote-text">comment comment</p>
            <p class="page__content-blockquote-text">comment comment</p>
            <p class="page__content-blockquote-text">comment comment</p>
            <span class="page__content-blockquote-reference">Encyclopedia Galactica*</span>
      </div>
      <div class="page__content-text">
        <p class="page__content-blockquote-text">comment comment</p>
        <p class="page__content-blockquote-text">comment comment</p>
        <p class="page__content-blockquote-text">comment comment</p>
       </div>
       <div class="page_number">3</div>
     </section>
      <input type="radio" name="page" id="page-1"/>

       <input type="radio" name="page" id="page-2"/>

        <label class="book__page book__page--2">
    <div class="book__page-front">
      <div class="page__content">
        <h1 class="page__content-book-title">Foundation</h1>
        <h2 class="page__content-author">Isaac Asimov</h2>
        
        <p class="page__content-credits">
          Introduction by 
          <span>Paul Krugman</span>
        </p>
        
        <p class="page__content-credits">
          Illustrations by 
          <span>Alex Wells</span>
        </p>
        
        <div class="page__content-copyright">
          <p>The Folio Society</p>
          <p>London - MMXII</p>
        </div>
      </div>
    </div>
    <div class="book__page-back">
      <div class="page__content">
        <h1 class="page__content-title">Contents</h1>
        <table class="page__content-table">
          <tr>
            <td align="left">Part I</td><td align="left">The Psycohistorians</td><td align="right">3</td>
          </tr>
          <tr>
            <td align="left">Part II</td><td align="left">The Encyclopedists</td><td align="right">43</td>
          </tr>
          <tr>
            <td align="left">Part III</td><td align="left">The Mayors</td><td align="right">87</td>
          </tr>
          <tr>
            <td align="left">Part IV</td><td align="left">The Traders</td><td align="right">147</td>
          </tr>
          <tr>
            <td align="left">Part V</td><td align="left">The Merchant Princes</td><td align="right">173</td>
          </tr>
        </table>
        
        <div class="page__number">2</div>
      </div>
    </div>
  </label>
    </div>
  </div>
  

</template>

<script>
  export default {
    name: 'Modal',
    props: {
        book: {}
    },
    methods: {
      close() {
        this.$emit('close');
      },
    },
  };
</script>

<style>
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
  }

  .modal {
    background: #FFFFFF;
    box-shadow: 2px 2px 20px 1px;
    overflow-x: auto;
    display: flex;
    height: 65%;
    width: 60%;
    border-color:red;
    border-style: solid;
    border-width: 2px 8px 2px 8px;
    border-radius: 5px;
  }

  .modal > section{
      width: 50%;
  }

  .modal > section:first-child{
      border-right: rgb(141, 141, 141);
      border-style: hidden;
      border-width: 0px 1px 0px 0px;
      box-shadow: 5px 0px 40px #1d1611;
      display: flex;
      justify-content: center;
      align-items: center;
  }

    .modal > section:last-child{
      border-right: rgb(141, 141, 141);
      border-style: hidden;
      border-width: 0px 0px 0px 1px;
      box-shadow: -5px 0px 40px #1d1611;
  }

  #cover{
      height: 90%;
      max-width: 90%;
      object-fit: contain;
  }

  .redOpen{
      border-color:#791c1c;
  }

  .orangeOpen{
      border-color:#ac6027;
  }

  .greenOpen{
      border-color:#253f1a;
  }

  .blueOpen{
      border-color:#17305f;
  }

  .purpleOpen{
      border-color:#662358;
  }
</style>
