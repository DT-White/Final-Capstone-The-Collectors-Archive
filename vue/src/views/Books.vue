<template>
  <div id="booksView">
      <book-filter/>
      <section>
        <add-book />
        <section>
          <bookList />
          <reading-list/>
        </section>
      </section>
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
  align-items: start;
  gap: 50px;
}

#booksView > section{
  display: flex;
  flex-direction: column;
}

#booksView > section > section{
  display: flex;
  gap: 50px;
}


</style>