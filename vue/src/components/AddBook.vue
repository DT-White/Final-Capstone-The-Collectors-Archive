<template>
  <form v-on:click="showError = false">
    <span>
      <input
        type="text"
        id="isbn"
        v-model="book.isbn"
        placeholder="Enter ISBN to autofill"
      />
      <button v-on:click.prevent="getBookFromGoogle">Autofill</button>
    </span>
    <isbn-not-found v-if="showError" />

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
      v-model="book.keyword"
      placeholder="Key Words separated by commas"
    />

    <input
      type="text"
      id="coverUrl"
      v-model="book.coverImageUrl"
      placeholder="Cover Image Url"
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
    <button v-on:click.prevent="createBook" type="submit">Add Book</button>
  </form>
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
      showError: false,

      book: {
        title: "",
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
       
      }
    };
  },
  methods: {
    createBook() {
      let newBook = {
        title: this.book.title,
        author: this.book.author,
        isbn: this.book.isbn,
        keyword: this.book.keyword,
        summary: this.book.summary,
        publishingDate: this.book.publishingDate,
        coverImageUrl: this.book.coverImageUrl,
        genres: this.book.genres.filter(g => g.selected).map((g) => g.name)
      }
      bookService.createBook(newBook).then((response) => {
        if (response.status === 201) {
          alert("Book Added");
        }
      });
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
          this.book.summary = response.description;
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
          this.book.genres.find(
            (genre) => genre.name === "Nonfiction"
          ).selected = false;
        } else if (genre.name === "Nonfiction") {
          this.book.genres.find(
            (genre) => genre.name === "Fiction"
          ).selected = false;
          this.book.genres.find(
            (genre) => genre.name === "Science Fiction"
          ).selected = false;
          this.book.genres.find(
            (genre) => genre.name === "Fantasy"
          ).selected = false;
        } else if (genre.name === "Fantasy") {
          this.book.genres.find(
            (genre) => genre.name === "Nonfiction"
          ).selected = false;
          this.book.genres.find(
            (genre) => genre.name === "Fiction"
          ).selected = true;
        } else if (genre.name === "Science Fiction") {
          this.book.genres.find(
            (genre) => genre.name === "Nonfiction"
          ).selected = false;
          this.book.genres.find(
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
  /* border: 1px;
  border-style: solid;
  border-color: rgb(109, 106, 106); */
  min-width: 225px;
  max-width: 500px;
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