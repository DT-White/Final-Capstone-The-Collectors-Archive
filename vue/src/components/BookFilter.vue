<template>
  <form id="bookFilterForm">
    <h2>Filter Books</h2>

    <input
      type="text"
      v-model="filter.isbn"
      placeholder="ISBN"
    />

    <input type="text" id="title" v-model="filter.title" placeholder="Title" />
    <input
      type="text"
      id="author"
      v-model="filter.author"
      placeholder="Author"
    />

    <input
      type="text"
      v-model="filter.keyword"
      placeholder="Key Words separated by commas"
    />

    <div id="filterDates">
      <p id="dateLabel">Publishing Date</p>
      <span>
        <p>From:</p>
        <input type="date" id="startDate" v-model="filter.startDate" />
      </span>

      <span>
        <p>To:</p>
        <input type="date" id="endDate" v-model="filter.endDate" />
      </span>
    </div>

    <div class="genres" id="filterGenres">
      <div
        v-on:click="toggleSelected(genre)"
        v-for="genre in filter.genres"
        v-bind:key="genre.id"
        v-bind:class="{ selected: genre.selected }"
      >
        {{ genre.name }}
      </div>
    </div>
  </form>
</template>

<script>
import bookService from "@/services/BookService";
export default {
  data() {
    return {
      filter: {
        genres: [],
      },
    };
  },
  created() {
    bookService.getGenres().then((response) => {
      if (response.status === 200) {
        for (let genre of response.data) {
          this.filter.genres.push({ name: genre, selected: false });
        }
      }
    });
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

#filterDates > span {
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

#filterDates span p {
  font-family: sans-serif;
  font-size: 0.8rem;
}

#filterGenres{
    width:100%
}

#filterGenres div{
    width: 60px;
}


</style>