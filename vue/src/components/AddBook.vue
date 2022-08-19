<template>
  <div @click="close" class="modal-backdrop">
    <form id="addBookForm" v-on:click="showError = false">
      <div class="modal orangeOpen" @click.stop>
        <section class="left-page page">
          <!-- <p id="isbnField">
            <input
              type="text"
              id="isbn"
              v-model="book.isbn"
              placeholder="Enter ISBN to autofill"
            />
            <button id="isbnButton" v-on:click.prevent="getBookFromGoogle">
              Autofill
            </button>
          </p>
          <isbn-not-found v-if="showError" /> -->
        </section>
        <!-- <p>
        <span id="textField">
        <input type="text" id="title" v-model="book.title" placeholder="Title" />
         </span>
        </p>
        
        <p>
        <span id="authorField">
        <input
          type="text"
          id="author"
          v-model="book.author"
          placeholder="Author"
        />
        </span>
        </p>

        <p>
        <span id="summaryField">
        <textarea
          rows="4"
          id="summary"
          v-model="book.summary"
          placeholder="Summary"
        />
        </span>
        </p>

        <p>
        <span id="keywordsField">
        <input
          type="text"
          id="keyWords"
          v-model="book.keyword"
          placeholder="Key Words separated by commas"
        />
        </span>
        </p>

        <p>
        <span id="coverImageField">
        <input
          type="text"
          id="coverUrl"
          v-model="book.coverImageUrl"
          placeholder="Cover Image Url"
        />
        </span>
        </p> -->
        
        <section class="right-page page">
          <p id="toAddABook"> </p>
          <p id="isbnField">
            <input
              type="text"
              id="isbn"
              v-model="book.isbn"
              placeholder="Enter ISBN to autofill"
            />
            <button id="isbnButton" v-on:click.prevent="getBookFromGoogle">
              Autofill
            </button>
          <isbn-not-found v-if="showError" />
          </p>

          <p id="textField">
            <input
              type="text"
              id="title"
              v-model="book.title"
              placeholder="Title"
            />
          </p>

          <p id="authorField">
            <input
              type="text"
              id="author"
              v-model="book.author"
              placeholder="Author"
            />
          </p>

          <p id="summaryField">
            <textarea
              rows="4"
              id="summary"
              v-model="book.summary"
              placeholder="Summary"
            />
          </p>

          <p id="keywordsField">
            <input
              type="text"
              id="keyWords"
              v-model="book.keyword"
              placeholder="Key Words separated by commas"
            />
          </p>

          <p id="coverImageField">
            <input
              type="text"
              id="coverUrl"
              v-model="book.coverImageUrl"
              placeholder="Cover Image Url"
            />
          </p>

          <p id="dateField">
            <span id="dateLabel">Publishing Date: </span>
            <input
              type="date"
              id="date"
              v-model="book.publishingDate"
              placeholder="Publishing Date"
            />
          </p>

          <span id="genreField">
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
                  v-on:click="showGenres = !showGenres"
                />
                <span id="downArrow" v-on:click="showGenres = !showGenres">{{
                  showGenres ? "&blacktriangle;" : "&blacktriangledown;"
                }}</span>
              </div>
              <div
                class="genreList"
                v-for="genre in $store.state.genres"
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
          </span>

          <p id="submitButton">
            <button v-on:click.prevent="createBook" type="submit">
              Submit
            </button>
          </p>
        </section>
      </div>
    </form>
  </div>
</template>

<script>
import googleService from "@/services/GoogleService";
import isbnNotFound from "@/components/IsbnNotFound";
import bookService from "@/services/BookService";
export default {
  components: {
    isbnNotFound,
  },

  data() {
    return {
      showGenres: false,

      showError: false,

      book: {
        title: "",
        genres: [],
      },
    };
  },

  computed: {
    genreTextField() {
      let textField = "";
      this.$store.state.genres.forEach((genre) => {
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

    bookColor() {
      return this.setBookColor(this.book);
    },
  },

  created() {
    bookService.getGenres().then((response) => {
      if (response.status === 200) {
        let genreList = [];
        for (let genre of response.data) {
          genreList.push({ name: genre, selected: false });
        }
        this.$store.commit("GET_GENRE_LIST", genreList);
      }
    });
  },

  methods: {
    close() {
      this.$emit("close");
    },

    createBook() {
      let newBook = {
        title: this.book.title,
        author: this.book.author,
        isbn: this.book.isbn,
        keyword: this.book.keyword,
        summary: this.book.summary,
        publishingDate: this.book.publishingDate,
        coverImageUrl: this.book.coverImageUrl,
        color: this.setBookColor(this.book),
        genres: this.$store.state.genres
          .filter((g) => g.selected)
          .map((g) => g.name),
      };
      console.log(newBook);
      bookService.createBook(newBook).then((response) => {
        if (response.status === 201) {
          this.showAddBook = false;
          this.$store.commit("ADD_BOOK", newBook);
          this.book = { genres: [] };
          this.close();
        }
      });
    },

    setBookColor(book) {
      let color;
      switch (book.isbn % 5) {
        case 0:
          color = "purple";
          break;
        case 1:
          color = "orange";
          break;
        case 2:
          color = "blue";
          break;
        case 3:
          color = "green";
          break;
        case 4:
          color = "red";
          break;
      }
      return color;
    },

    getBookFromGoogle() {
      googleService.getBook(this.book.isbn).then((response) => {
        if (!response.data.items) {
          this.showError = true;
        } else {
          response = response.data.items[0].volumeInfo;
          this.book.title = response.title;
          this.book.author =
            response.authors.length > 1
              ? response.authors.join(", ")
              : response.authors[0];
          this.book.summary = response.description.substring(0, 2000);
          this.book.coverImageUrl = response.imageLinks.thumbnail;
          this.book.publishingDate = response.publishedDate;
          for (let category of response.categories) {
            for (let genre of this.book.genres) {
              if (genre.name === category) {
                genre.selected = true;
              }
            }
          }
        }
      });
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
    },
  },
};
</script>

<style>
#addBookForm > * {
  display: flex;
  justify-content: center;
  width: 600px;
  height: 500px;
}

#toAddABook {
  text-align: center;
  font-weight: bold;
  font-size: 22px;
}

#isbnField {
  display: flex;
  justify-content: center;
}

#textField {
  display: flex;
  justify-content: center;
}

#authorField {
  display: flex;
  justify-content: center;
}

#summaryField {
  display: flex;
  justify-content: center;
}

#keywordsField {
  display: flex;
  justify-content: center;
}

#coverImageField {
  display: flex;
  justify-content: center;
}

#dateField {
  display: flex;
  justify-content: center;
}

#genreField {
  display: flex;
  justify-content: center;
}

#submitButton {
  display: flex;
  justify-content: center;
}

.left-page {
  border-right: rgb(141, 141, 141);
  border-style: hidden;
  border-width: 0px 1px 0px 0px; 
  border-width: 20px 5px 20px 5px; 
  box-shadow: 5px 0px 40px #1d1611;
  display: flex;
  justify-content: center;
  align-items: center;
}

.right-page {
  border-right: rgb(141, 141, 141);
  border-style: hidden;
  border-width: 0px 0px 0px 1px;
  box-shadow: -5px 0px 40px #1d1611;
  justify-content: center;
  align-items: center;
}

.page {
  width: 50%;
}


/*
#addBookForm  input {
  width: 98%;
  max-width: 500px;
  margin-bottom: 8px;
  margin-top: 5px;
  justify-content: space-between;
}

input textarea {
  border: none;
}

textarea {
  width: 98%;
  max-width: 500px;
}

#addBookForm {
  background-color: #c8daaa;
  width: 60%;
  border-style: inset;
}

#addBookForm span {
  align-items: center;
  justify-content: space-between;
  display: flex;
  min-width: 225px;
  max-width: 500px;
}

textarea {
  max-width: 98%;
}

#date {
  width: 60%;
}

#dateLabel {
  color: black;
  height: 75%;
  padding: 3px;
  margin: 0;
  font-size: 0.85rem;
  min-width: 105px;
  font-family: sans-serif;
}

#dateLabel:hover {
  cursor: default;
}

.genres {
  display: flex;
  gap: 5px;
  align-items: center;
  justify-content: space-around;
  width: 60%;
  flex-wrap: wrap;
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
  max-width: 97%;
  max-height: 40px;
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
*/
/* .icon {
  background: url("../../resources/newBook2.jpg");
  background-repeat: no-repeat;
  height: 25px;
  width: 25px;
  border: 2px solid black;
  border-radius: 50%;
  margin: 5px;
  cursor: pointer;
  position: relative;
  display: inline-block;
} */

#plus{
  height: 20px;
  margin-top: 5px;
  cursor: pointer;
}
/*
.icon .tooltiptext {
  visibility: hidden;
  width: 120px;
  background-color: black;
  color: #fff;
  text-align: center;
  border-radius: 6px;
  padding: 5px 0;
  top: -5px;
  left: 105%;
  position: absolute;
  z-index: 1;
}

.icon:hover .tooltiptext {
  visibility: visible;
}

.icon .tooltiptext::after {
  content: " ";
  position: absolute;
  top: 50%;
  right: 100%; /* To the left of the tooltip 
  margin-top: -5px;
  border-width: 5px;
  border-style: solid;
  border-color: transparent black transparent transparent;
} */

.multi-selector {
  width: max-content;
  max-height: 20vh;
  overflow: scroll;
  
}

.select-field {
  /* position: absolute; */
  width: max-content;
  height: 20px;
  cursor: pointer;
}
</style>