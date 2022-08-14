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
     <section>
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