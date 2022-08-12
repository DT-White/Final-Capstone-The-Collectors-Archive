<template>
  <div @click="close" class="modal-backdrop">
    <div class="modal">
     <section>
         <h2>{{book.title}}</h2>
     </section>
     <section>

     </section>
    
    </div>
  </div>
</template>

<script>
  export default {
    name: 'Modal',
    props: {
        book: {
            default: {
                author:"Kim E. Nielsen",
                bestSeller:false,
                bookId:7,
                color:"blue",
                coverImageUrl:"http://books.google.com/books/content?id=_q9KEAAAQBAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api",
                dateAdded:"2022-08-12T13:13:16.76802",
                genres:[],
                isbn:9780807022047,
                keyword:"disablility",
                publishingDate:"2013-10-01",
                summary:"The first book to cover the entirety of disability history, from pre-1492 to the present Disability is not only the story of someone we love or the scholars that reconstruct and reinterpret US history from diverse perspectives.",
                title:"A Disability History of the United States"
            }
        }
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
  }
  .modal > section:last-child{
      border-left: rgb(141, 141, 141);
      border-style:hidden;
      border-width: 0px 0px 0px 1px;
      box-shadow: -5px 0px 40px #1d1611;
  }

  .modal-header,
  .modal-footer {
    padding: 15px;
    display: flex;
  }

  .modal-header {
    position: relative;
    border-bottom: 1px solid #eeeeee;
    color: #4AAE9B;
    justify-content: space-between;
  }

  .modal-footer {
    border-top: 1px solid #eeeeee;
    flex-direction: column;
    justify-content: flex-end;
  }

  .modal-body {
    position: relative;
    padding: 20px 10px;
  }

  .btn-close {
    position: absolute;
    top: 0;
    right: 0;
    border: none;
    font-size: 20px;
    padding: 10px;
    cursor: pointer;
    font-weight: bold;
    color: #4AAE9B;
    background: transparent;
  }

  .btn-green {
    color: white;
    background: #4AAE9B;
    border: 1px solid #4AAE9B;
    border-radius: 2px;
  }
</style>