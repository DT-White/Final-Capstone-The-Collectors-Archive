<template>
  <div id="app">
    <img id="logoImage" src="../resources/logo.jpg" alt=""/>
    <h1 id="header">The Collector's Archive</h1>
    <div id="nav" v-if="$store.state.token != ''">
      <button id="buttons"><router-link v-bind:to="{ name: 'books' }" v-if="$store.state.token != ''">Home</router-link></button>
      &nbsp;|&nbsp;
      <button id="buttons"><router-link
        v-bind:to="{ name: 'logout' }"
        v-if="$store.state.token != ''"
        >Logout</router-link
      ></button>
    </div>
    <router-view />
  </div>
</template>

<style>
div#app{
 display: flex;
}
h1#header {
  text-align: center;
}

img#logoImage{
  height: 200px;
  border-radius: 100px;
  justify-content: flex-start;
  
}

div#nav{
  justify-content: flex-end;
}
a {
  text-decoration: none;
}
a:visited {
  color: black
}
button#buttons{
  border-radius: 14%;
  height: 25px;

}
</style>
