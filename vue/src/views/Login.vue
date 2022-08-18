<template>
  <div id="login" class="text-center">
    
    <form class="form-signin" @submit.prevent="login">
      <h1 class="h3 mb-3 font-weight-normal">Login</h1>
      <div
        class="alert alert-danger"
        role="alert"
        v-if="invalidCredentials"
      >Invalid username and password!</div>
      <div
        class="alert alert-success"
        role="alert"
        v-if="this.$route.query.registration"
      >Thank you for registering, please sign in.</div>
      <!-- <label for="username" class="sr-only">Username</label> -->
      <input
        type="text"
        id="username"
        class="form-control"
        placeholder="Username"
        v-model="user.username"
        required
        autofocus
      />
      <!-- <label for="password" class="sr-only">Password</label> -->
      <input
        type="password"
        id="password"
        class="form-control"
        placeholder="Password"
        v-model="user.password"
        required
      />
      <router-link :to="{ name: 'register' }">Need an account?</router-link>
      <button type="submit">Sign in</button>
    </form>
  </div>
</template>

<script>
import authService from "../services/AuthService";
import profileService from '../services/ProfileService';


export default {
  name: "login",
  components: {},
 
  data() {
    return {
      user: {
        username: "",
        password: ""
      },
      invalidCredentials: false
    };
  },
  methods: {
    login() {
      authService
        .login(this.user)
        .then(response => {
          if (response.status == 200) {
            this.$store.commit("SET_AUTH_TOKEN", response.data.token);
            this.$store.commit("SET_USER", response.data.user);
            let profile = {
            username:this.username
          };
          profileService.createProfile(profile).then(response => {
            if (response.status === 201){
              console.log("profile created")
            }
          })
          this.$router.push("/books");
          }
        })
        .catch(error => {
          const response = error.response;

          if (response.status === 401) {
            this.invalidCredentials = true;
          }
        });
    }
  }
};
</script>

<style>
div#login {
  margin: 0;
  padding: 0;
  font-family: sans-serif;
  background: url('../../resources/upload.png');
}

.form-signin {
  width:300px;
  padding: 30px;
  position: absolute;
  top: 55%;
  left: 50%;
  transform: translate(-50%,-50%);
  text-align: center;
  background-color: lightgray;
  border-radius: 20px;
}

.form-signin h1{
  color: black;
  text-transform: uppercase;
  font-weight: 600;
  
}
 .form-signin input[type=text], .form-signin input[type=password] {
  border: 0;
  background: none;
  display: block;
  margin: 20px auto;
  text-align: center;
  border: 3px solid blue;
  padding: 14px 10px;
  width: 220px;
  outline: none;
  color: black;
  border-radius: 24px;
  transition:0.25px;
}
.form-signin input[type=text]:focus, .form-signin input[type=password]:focus {
  width:270px;
  border-color: #ffc400ec;
}

.form-signin button[type=submit] {
  border: 0;
  background: white;
  display: block;
  margin: 20px auto;
  text-align: center;
  border: 3px solid #ffc400ec;
  padding: 14px 10px;
  outline: none;
  color: gray;
  border-radius: 24px;
  transition:0.25px;
  cursor: pointer;
}

.form-signin button[type=submit]:hover {
  background: #ffc400ec;
  color: black;
}

router-link {
border: 3px solid #ffc400ec;
}
</style>