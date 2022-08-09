<template>
  <form id="bookFilterForm">
    <h2>Filter Books</h2>

    <input
      type="text"
      v-model="book.isbn"
      placeholder="Enter ISBN to autofill"
    />

    <input type="text" id="title" v-model="book.title" placeholder="Title" />
    <input type="text" id="author" v-model="book.author" placeholder="Author" />

    <input
      type="text"
      v-model="book.keyword"
      placeholder="Key Words separated by commas"
    />

    <div id="filterDates">
      <p id="dateLabel">Publishing Date</p>
      <span>
          <p>From:</p>
        <input type="date" id="startDate" v-model="book.publishingDate" />
      </span>

      <span>
          <p>To:</p>
        <input type="date" id="endDate" v-model="book.publishingDate" />
      </span>
    </div>

    <div id="genres">
      <div
        v-on:click="toggleSelected(genre)"
        v-for="genre in book.genres"
        v-bind:key="genre.id"
        v-bind:class="{ selected: genre.selected }"
      >
        {{ genre.name }}
      </div>
    </div>
  </form>
</template>

<script>
export default {
  data() {
    return {
      book: [],
    };
  },
};
</script>

<style>

#bookFilterForm {
  display: flex;
  width: 200px;
  background-color: skyblue;
  flex-direction: column;
  padding: 10px;
    gap: 10px;
}


#filterDates > span{
    display: flex;
    height: 20px;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 10px;
}

#filterDates > p {
height: 20px;
width: 50px;
margin-left: 23%;
}

#filterDates span p{
    font-family:sans-serif;
    font-size: .8rem;
}

</style>