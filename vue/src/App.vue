<template>
  <div id="app">
    <div id="appheader">
        <img id="logoImage" src="../resources/logo12.jpg" alt="" @click="goToBooksPage" />
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
    <div class="routerView">
    <router-view />
    </div>
  </div>
</template>
<script>
import profile from '@/components/Profile';


export default {
  components: { profile },
  methods: {
    goToBooksPage() {
      return this.$router.push('/books')
    }
  }
}
</script>

<style>
@import url("https://fonts.googleapis.com/css2?family=Alumni+Sans+Collegiate+One&family=Fredoka+One&display=swap");



body {
  background-image: url("../resources/testBackground5.jpg");
  background-position: center center;
  background-size: 100% 100%;
  min-height: 100%;
  backdrop-filter: blur(8px);

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
  cursor: pointer;
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
