<template>
  <div id="app">
    <div id="appheader">
      <img id="logoImage" src="../resources/logo6.jpg" alt="" />
      <h1 id="header">The Collector's Archive</h1>
      <div id="nav" v-if="$store.state.token != ''">
        <button id="buttons">
          <router-link
            v-bind:to="{ name: 'books' }"
            v-if="$store.state.token != ''"
            >Home</router-link
          >
        </button>
        &nbsp;|&nbsp;
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
</style>