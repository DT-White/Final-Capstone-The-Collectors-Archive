<template>
  <div id="search-div">
    <button id="searchBooksButton" v-on:click="showOrHideForm">
      {{ hidden === true ? "Search Books" : "Hide Search" }}
    </button>
    <form class="shelf" id="bookFilterForm" v-bind:class="{ hidden }">
      <div class="shelf-top">
        <div class="shelf-label">
          <div class="nail"></div>
          <h2>Filter Books</h2>
          <div class="nail"></div>
        </div>
      </div>
      <div id="formFields">
        <input
          id="ISBNfield"
          type="text"
          v-on:change="updateStoreFilter()"
          v-model="filter.isbn"
          placeholder="ISBN"
        />
        <p>
          <input
            type="text"
            id="title"
            v-on:change="updateStoreFilter()"
            v-model="filter.title"
            placeholder="Title"
          />
        </p>
        <input
          type="text"
          id="author"
          v-on:change="updateStoreFilter()"
          v-model="filter.author"
          placeholder="Author"
        />
        <p>
          <input
            type="text"
            v-on:change="updateStoreFilter()"
            v-model="filter.keyword"
            placeholder="Key Words separated by commas"
          />
        </p>
        <div id="filterDates">
          <p id="dateLabe">Publishing&nbsp;Date</p>
          <span>
            <p id="startDatelabel">Start Date:</p>
            <input
              type="date"
              id="startDate"
              v-on:change="updateStoreFilter()"
              v-model="filter.startDate"
            />
          </span>

          <span>
            <p id="endDateLabel">End Date:</p>
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
      </div>
    </form>
  </div>
</template>

<script>
import bookService from "@/services/BookService";

export default {
  // components: { Multiselect },
  data() {
    return {
      value: [],
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

    clearForm(){
      this.filter = {
        title: "",
        author: "",
        keyword: "",
        startDate: "",
        endDate: "",
        genres: [],
        isbn: "",
      }
        this.updateStoreFilter();
    },

    showOrHideForm(){
      this.clearForm();
      this.hidden = !this.hidden;
    },
    
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
            textField = textField + ", " + genre.name;
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
// 


<style>

#search-div{
  display: flex;
}

#formFields {
  justify-content: center;
  align-items: center;
}

#shelf-label h2 {
  font-size: 1.2rem;
  color: rgb(77, 68, 18);
  margin: 1px 3px 1px 3px;
}

h2 {
  display: block;
  font-size: 1.5em;
  margin-block-start: 0.83em;
  margin-block-end: 0.83em;
  margin-inline-start: 0px;
  margin-inline-end: 0px;
  font-weight: bold;
}

#searchBooksButton {
  margin: 0;
  width: 80px;
  height: 80px;
  background: lightgrey;
  border-radius: 50%;
  box-shadow: 0 0 25px 0 rgba(0, 0, 0, 0.4);
}

#searchBooksButton:hover {
  cursor: pointer;
}

#dateLabe {
  color: white;
  white-space: nowrap;
}

#startDatelabel {
  color: white;
}

#endDateLabel {
  color: white;
}


#ISBNfield {
  display: flex;
}

#bookFilterForm h2 {
  text-align: center;
  flex-grow: 2;
}


#shelf-top {
  background-color: #755d44;
  margin: 0px 1px 30px 1px;
  display: flex;
  justify-content: center;
  box-shadow: 0 10px 18px -12px #1d1611;
}

#shelf-label {
  background-color: rgb(211, 187, 55);
  width: 175px;
  border-radius: 10% / 50%;
  margin: 5px 5px 5px 5px;
  display: flex;
  align-items: center;
  padding: 0px 10px 0px 10px;
}

#nail {
  background-color: rgb(156, 138, 37);
  width: 5px;
  height: 5px;
  border-width: 2.5px;
  border-style: solid;
  border-color: rgb(150, 132, 35);
  border-radius: 50%;
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
  cursor: pointer;
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