<template>
  <div id="app">
    <div id="appheader">
        <img id="logoImage" src="../resources/logo12.jpg" alt="" />
      <h1 id="header">The Collector's Archive</h1>
      <div id="nav" v-if="$store.state.token != ''">
        <button id="buttons">
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
        </button>
      </div>
    </div>
    <router-view />
  </div>
</template>
<style>
@import url("https://fonts.googleapis.com/css2?family=Alumni+Sans+Collegiate+One&family=Fredoka+One&display=swap");

body {
  background-image: url("");
  background-position: bottom right;
  background-size: 10px 20px;
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
