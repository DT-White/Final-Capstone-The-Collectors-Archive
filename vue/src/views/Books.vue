<template>
  <div id="booksView">
      <book-filter/>
        <section>
      <add-book />
      <bookList />
      </section>

  </div>
</template>

<script>
import addBook from "@/components/AddBook";
import bookList from "@/components/BookList";
import bookFilter from "@/components/BookFilter";
export default {
  components: { addBook, bookList, bookFilter },
};
</script>

<style>

#booksView{
  display: flex;
  gap:10px;
}


</style>