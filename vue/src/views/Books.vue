<template>
  <div id="booksView">
      <book-filter/>
      <section>
        <add-book />
        <bookList />
      </section>
      <reading-list/>
  </div>
</template>

<script>
import addBook from "@/components/AddBook";
import bookList from "@/components/BookList";
import bookFilter from "@/components/BookFilter";
import readingList from "@/components/ReadingList";
export default {
  components: { addBook, bookList, bookFilter, readingList },
};
</script>

<style>

#booksView{
  display: flex;
  gap:10px;
}


</style>