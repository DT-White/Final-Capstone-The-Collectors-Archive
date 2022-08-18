<template>
  <div class="home"
    :class="{transition:transition}">
    <img @click="goToBooks" 
    src="../../resources/forward-arrow.png" alt="">
  </div>
</template>

<script>
export default {
  name: "home",
data(){
  return{
    transition:false
  }
},
created(){
  this.transition = false;
},
  methods:{
    goToBooks(){
      this.transition = true;
      return setTimeout(function() {
        return this.$router.push({name:'books'})
      }, 1000)
      
    }
  }
};
</script>
<style>

.home{
  background-image: url("../../resources/testBackground5.jpg");
  backdrop-filter: blur(0px);
  background-size: 110% 110%;
  height: 110%;
  width: 110%;
  left: -10%;
  top: -10%;
  position: absolute;
  -webkit-transition: transform 2s ease-in-out;
  transition: transform 2s ease-in-out;
}

.main-page{
  display: flex;
  justify-content: center;
  align-items: center;
}

.home img{
  position: absolute;
  left: 48.5%;
  top: 46%;
  width: 200px;
  height: 200px;
  cursor: pointer;
}

.transition:hover{
  transform: scale(10);
  -webkit-transform: scale(10);
}

</style>