<template>
  <div id="app">
    <div id="appheader">
      <div id="logoAndSearch">
        <img
          id="logoImage"
          @click="goToHome"
          src="../resources/logo12.jpg"
          alt=""
        />
        <!-- <book-filter id="searchBooks"/> -->
      </div>

      <h1 id="header"
          @click="goToHome">The Collector's Archive</h1>
      <div id="nav" v-if="$store.state.token != ''">
        <!-- <button id="buttons">
          <router-link
            v-bind:to="{ name: 'books' }"
            v-if="$store.state.token != ''"
            >Home</router-link
          >
        </button>

        <button id="buttons">
          <router-link
            v-bind:to="{ name: 'logout' }"
            v-if="$store.state.token != ''"
            >Logout</router-link
          >
        </button> -->

        <profile />
      </div>
    </div>
    <div id="main-page">
      <router-view />
    </div>
  </div>
</template>
<script>
import profile from "@/components/Profile";
// import bookFilter from "@/components/BookFilter";

export default {
  components: { profile },
  methods: {
    goToBooksPage() {
      return this.$router.push("/books");
    },


    goToHome() {
        return this.$router.push({ name: "books" });
      },
    },
  
};
</script>

<style>
@import url("https://fonts.googleapis.com/css2?family=Alumni+Sans+Collegiate+One&family=Fredoka+One&display=swap");

#logoAndSearch {
  display: grid;
  grid-template-columns: 1;
  grid-template-rows: 1;
}

html {
  height: 90%;
}

body {
  background-image: url("../resources/background3.jpg");
  background-position: center center;
  background-size: 100% 100%;
  min-height: 100%;
  backdrop-filter: blur(2px);
  margin: 0;
  padding: 8px;
}

/* div#profile-marker {
  background-color: ivory !important;
    display: flex;
    flex-direction: column;
    justify-content: center;
    padding-left:50px;
    height: 200px;
    width: 200px;
} */

div#app {
  display: flex;
  flex-direction: column;
}
div#appheader {
  display: flex;
  justify-content: space-between;
}

h1#header {
  position: absolute;
  display: flex;
  padding-left: 25%;
  text-align: center;
  font-family: "Fredoka One", cursive;
  font-size: 70px;
  color: white;
  font-weight: 500;
  cursor: pointer;
}
img#logoImage {
  height: 200px;
  border-radius: 100px;
  justify-content: flex-start;
  cursor: pointer;
}
div#nav {
  display: flex;
  justify-content: flex-end;
}
a {
  text-decoration: none;
}
a:visited {
  color: black;
}
button#buttons {
  border-radius: 14%;
  height: 25px;
}

.tooltip {
  position: relative;
  display: inline-block;
}

.icon .tooltiptext {
  visibility: hidden;
  width: 120px;
  background-color: black;
  color: #fff;
  text-align: center;
  border-radius: 6px;
  padding: 5px 0;

  /* Position the tooltip */
  position: absolute;
  z-index: 1;
}

.icon:hover .tooltiptext {
  visibility: visible;
}

</style>
