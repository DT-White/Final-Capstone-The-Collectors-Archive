<template>
  <form>
    <input
      type="text"
      id="isbn"
      v-model="book.isbn"
      placeholder="Enter ISBN to autofill"
    />
    <input type="text" id="title" v-model="book.title" placeholder="Title" />
    <input type="text" id="author" v-model="book.author" placeholder="Author" />
    <textarea
      rows="4"
      id="summary"
      v-model="book.summary"
      placeholder="Summary"
    />
    <input
      type="text"
      id="keyWords"
      v-model="book.keyWords"
      placeholder="Key Words separated by commas"
    />
    <span>
      <p id="dateLabel">Publishing Date</p>
      <input
        type="date"
        id="date"
        v-model="book.publishingDate"
        placeholder="Publishing Date"
      />
    </span>
    <input
      type="text"
      id="coverUrl"
      v-model="book.coverUrl"
      placeholder="Cover Image Url"
    />
    <div id="genres">
      <div
        v-on:click="toggleSelected(genre)"
        v-for="genre in genres"
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
      book: {},
      genres: [
        { name: "Fiction", selected: false },
        { name: "Nonfiction", selected: false },
        { name: "Young Adult", selected: false },
        { name: "Science Fiction", selected: false },
        { name: "Western", selected: false },
        { name: "Mystery", selected: false },
        { name: "Romance", selected: false },
        { name: "Comedy", selected: false },
        { name: "Historical", selected: false },
        { name: "Thriller", selected: false },
        { name: "Horror", selected: false },
        { name: "Fantasy", selected: false },
      ],
    };
  },
  methods: {
    toggleSelected(genre) {
      if (genre.selected) {
        genre.selected = false;
      } else {
        genre.selected = true;
        if (genre.name === "Fiction") {
          this.genres.find(
            (genre) => genre.name === "Nonfiction"
          ).selected = false;
        } else if (genre.name === "Nonfiction") {
          this.genres.find(
            (genre) => genre.name === "Fiction"
          ).selected = false;
           this.genres.find(
            (genre) => genre.name === "Science Fiction"
          ).selected = false;
           this.genres.find(
            (genre) => genre.name === "Fantasy"
          ).selected = false;
        } else if (genre.name === "Fantasy") {
          this.genres.find(
            (genre) => genre.name === "Nonfiction"
          ).selected = false;
           this.genres.find(
            (genre) => genre.name === "Fiction"
          ).selected = true;
        } else if (genre.name === "Science Fiction") {
          this.genres.find(
            (genre) => genre.name === "Nonfiction"
          ).selected = false;
           this.genres.find(
            (genre) => genre.name === "Fiction"
          ).selected = true;
        }
      }
    },
  },
};
</script>

<style>
form > * {
  display: block;
  width: 100%;
  min-width: 220px;
}

form > input {
  width: 98%;
  max-width: 500px;
}

textarea {
  width: 98%;
  max-width: 500px;
}

form {
  width: 50%;
}

form span {
  align-items: center;
  justify-content: space-between;
  display: flex;
  border: 1px;
  border-style: solid;
  border-color: rgb(109, 106, 106);
  min-width: 225px;
  max-width: 500px;
}
#summary {
}

#date {
  width: 60%;
}

#dateLabel {
  color: rgb(109, 106, 106);
  height: 75%;
  padding: 3px;
  margin: 0;
  font-size: 0.85rem;
  min-width: 105px;
  font-family: sans-serif;
}

#genres {
  display: flex;
  gap: 5px;
  align-items: center;
  justify-content: space-around;
  width: 60%;
  flex-wrap: wrap;
}

#genres div {
  display: flex;
  justify-content: center;
  align-items: center;
  border-style: solid;
  border-color: rgb(109, 106, 106);
  border-width: 1px;
  width: 30%;
  height: 30px;
  font-size: 0.85rem;
  font-family: sans-serif;
}

#genres div:hover {
  cursor: pointer;
}

#genres div.selected {
  background-color: chartreuse;
  border-width: 2px;
}
</style>