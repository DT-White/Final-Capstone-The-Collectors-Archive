<template>
  <div>
    <button v-on:click="hidden = !hidden">
      {{ hidden === true ? "Search Books" : "Hide Search" }}
    </button>
    <form id="bookFilterForm" v-bind:class="{ hidden }">
      <h2>Filter Books</h2>

      <input
        type="text"
        v-on:change="updateStoreFilter()"
        v-model="filter.isbn"
        placeholder="ISBN"
      />

      <input
        type="text"
        id="title"
        v-on:change="updateStoreFilter()"
        v-model="filter.title"
        placeholder="Title"
      />
      <input
        type="text"
        id="author"
        v-on:change="updateStoreFilter()"
        v-model="filter.author"
        placeholder="Author"
      />

      <input
        type="text"
        v-on:change="updateStoreFilter()"
        v-model="filter.keyword"
        placeholder="Key Words separated by commas"
      />

      <div id="filterDates">
        <p id="dateLabel">Publishing Date</p>
        <span>
          <p>Start Date:</p>
          <input
            type="date"
            id="startDate"
            v-on:change="updateStoreFilter()"
            v-model="filter.startDate"
          />
        </span>

        <span>
          <p>End Date:</p>
          <input
            type="date"
            id="endDate"
            v-on:change="updateStoreFilter()"
            v-model="filter.endDate"
          />
        </span>
      </div>

      <div class="multi-selector">
        <div class="select-field">
          <input
            type="text"
            name="genreName"
            placeholder="Select Genres"
            id="genreName"
            class="input-select"
            disabled
            v-model="genreTextField"
          />
          <span class="downArrow" v-on:click="showGenres = !showGenres">{{
            showGenres ? "&blacktriangle;" : "&blacktriangledown;"
          }}</span>
        </div>
        <div
          class="genreList"
          v-for="genre in filter.genres"
          v-show="showGenres"
          v-bind:key="genre.id"
          v-bind:class="{ selected: genre.selected }"
        >
          <label for="genreName" class="genreOption">
            <input
              type="checkbox"
              v-on:click="toggleSelected(genre)"
              name="genreName"
              id="genreName"
            />
            {{ genre.name }}
          </label>
        </div>
      </div>
    </form>
  </div>
</template>

<script>
import bookService from "@/services/BookService";

export default {
  data() {
    return {
      filter: {
        title: "",
        author: "",
        keyword: "",
        startDate: "",
        endDate: "",
        genres: [],
        isbn: "",
      },
      hidden: true,
      showGenres: false,
      //textField: "",
    };
  },
  methods: {
    updateStoreFilter() {
      this.$store.commit("SET_STORE_FILTER", this.filter);
    },

    toggleSelected(genre) {
      if (genre.selected) {
        genre.selected = false;
      } else {
        genre.selected = true;
        if (genre.name === "Fiction") {
          this.$store.state.genres.find(
            (genre) => genre.name === "Nonfiction"
          ).selected = false;
        } else if (genre.name === "Nonfiction") {
          this.$store.state.genres.find(
            (genre) => genre.name === "Fiction"
          ).selected = false;
          this.$store.state.genres.find(
            (genre) => genre.name === "Science Fiction"
          ).selected = false;
          this.$store.state.genres.find(
            (genre) => genre.name === "Fantasy"
          ).selected = false;
        } else if (genre.name === "Fantasy") {
          this.$store.state.genres.find(
            (genre) => genre.name === "Nonfiction"
          ).selected = false;
          this.$store.state.genres.find(
            (genre) => genre.name === "Fiction"
          ).selected = true;
        } else if (genre.name === "Science Fiction") {
          this.$store.state.genres.find(
            (genre) => genre.name === "Nonfiction"
          ).selected = false;
          this.$store.state.genres.find(
            (genre) => genre.name === "Fiction"
          ).selected = true;
        }
      }
      this.updateStoreFilter();
    },
  },

  computed: {
    
    genreTextField() {
      let textField = "";
      this.filter.genres.forEach((genre) => {
        if (genre.selected === true) {
          if (textField === "") {
            textField = genre.name;
          } else {
            textField =textField + ", " + genre.name
          }
        }
      });

      return textField;
    },
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
  min-width: 200px;
  max-width: 200px;
  background-color: #c8daaa;
  flex-direction: column;
  padding: 10px;
  gap: 10px;
  max-height: auto;
  border-style: inset;
}

#filterDates > span {
  display: flex;
  height: 20px;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 10px;
  width: 98%;
}

#filterDates > p {
  height: 20px;
  width: 50px;
  margin-left: 23%;
  font-weight: 700;
}

#filterDates span p {
  font-family: sans-serif;
  font-size: 0.8rem;
  font-weight: 700;
}



#bookFilterForm.hidden {
  display: none;
}

.input-select {
  outline: none;
  border: none;
  background: white;
}

.multi-selector {
  width: max-content;
}

.select-field {
  border: 1px solid black;
}

.select-field,
.genreList,
.genreName {
  width: 100%;
  background-color: white;
  padding: 0.3rem;
}

.genreList {
  box-shadow: 0 30px 60px rgb(0, 0, 0, 0.2);
}

.genreOption {
  display: block;
}

.downArrow {
  font-size: 1.2rem;
  display: inline-block;
  cursor: pointer;
  transition: 0.2s linear;
}

.downArrow .showGenres {
  transform: rotate(180deg);
}

.genreOption:hover {
  background-color: aliceblue;
}
</style>