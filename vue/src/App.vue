<template>
  <div id="app">
    <div id="appheader">
        <div id="logoAndSearch">
        <img id="logoImage" src="../resources/logo12.jpg" alt="" />
        <book-filter id="searchBooks"/>
        </div>
        
      <h1 id="header">The Collector's Archive</h1>
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
        <profile/>
      </div>
    </div>
    <router-view />
  </div>
</template>
<script>
import profile from '@/components/Profile';
import bookFilter from "@/components/BookFilter";


export default {
  components: { profile,
                bookFilter
               
},
  
}
</script>

<style>
@import url("https://fonts.googleapis.com/css2?family=Alumni+Sans+Collegiate+One&family=Fredoka+One&display=swap");

#logoAndSearch {
  display: grid;
  grid-template-columns: 1;
  grid-template-rows: 1;
}

body {
  background-image: url("../resources/testBackground5.jpg");
  background-position: center center;
  background-size: cover;
  min-height: 100%;
  

}

div#app {
  display: flex;
  flex-direction: column;
}
div#appheader {
  display: flex;
  justify-content: space-between;
}
h1#header {
  text-align: center;
  font-family: "Fredoka One", cursive;
  font-size: 70px;
  color: white;
}
img#logoImage {
  height: 200px;
  border-radius: 100px;
  justify-content: flex-start;
}
div#nav {
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
