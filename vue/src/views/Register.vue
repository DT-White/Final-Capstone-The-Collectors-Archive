<template>
  <div id="register" class="text-center">
    <form class="form-register" @submit.prevent="register">
      <h1 class="h3 mb-3 font-weight-normal">Create Account</h1>
      <div class="alert alert-danger" role="alert" v-if="registrationErrors">
        {{ registrationErrorMsg }}
      </div>
      <label for="username" class="sr-only">Username</label>
      <input
        type="text"
        id="username"
        class="form-control"
        placeholder="Username"
        v-model="user.username"
        required
        autofocus
      />
      <label for="password" class="sr-only">Password</label>
      <input
        type="password"
        id="password"
        class="form-control"
        placeholder="Password"
        v-model="user.password"
        required
      />
      <input
        type="password"
        id="confirmPassword"
        class="form-control"
        placeholder="Confirm Password"
        v-model="user.confirmPassword"
        required
      />
      <router-link :to="{ name: 'login' }">Have an account?</router-link>
      <button class="btn btn-lg btn-primary btn-block" type="submit">
        Create Account
      </button>
    </form>
  </div>
</template>

<script>
import authService from '../services/AuthService';
export default {
  name: 'register',
  data() {
    return {
      user: {
        username: '',
        password: '',
        confirmPassword: '',
        role: 'user',
      },
      registrationErrors: false,
      registrationErrorMsg: 'There were problems registering this user.',
    };
  },
  methods: {
    register() {
      if (this.user.password != this.user.confirmPassword) {
        this.registrationErrors = true;
        this.registrationErrorMsg = 'Password & Confirm Password do not match.';
      } else {
        authService
          .register(this.user)
          .then((response) => {
            if (response.status == 201) {
              this.$router.push({
                path: '/login',
                query: { registration: 'success' },
              });
            }
          })
          .catch((error) => {
            const response = error.response;
            this.registrationErrors = true;
            if (response.status === 400) {
              this.registrationErrorMsg = 'Bad Request: Validation Errors';
            }
          });
      }
    },
    clearErrors() {
      this.registrationErrors = false;
      this.registrationErrorMsg = 'There were problems registering this user.';
    },
  },
};
</script>

<style>
div#register {
  top: 0;
  padding-top:35%;
  font-family: sans-serif;
}

.form-register {
  margin-block: 50px;
  width:300px;
  padding: 30px;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%,-50%);
  text-align: center;
  background: lightgrey;
  border-radius: 15px;
}

.form-register h1{
  font-family: sans-serif;
  color: balck;
  text-transform: uppercase;
  font-weight: 600;
}

.form-register input[type=text], .form-register input[type=password] {
  border: 0;
  background: white;
  display: block;
  margin: 20px auto;
  text-align: center;
  border: 3px solid blue;
  padding: 14px 10px;
  width: 220px;
  outline: none;
  color: rgb(17, 17, 17);
  border-radius: 24px;
  transition:0.25px;
}

.form-register input[type=text]:focus, .form-register input[type=password]:focus {
  width:270px;
  border-color: #ffc400ec;
}

.form-register button[type=submit] {
  border: 0;
  width:50%;
  background: white;
  display: block;
  margin: 20px auto;
  text-align: center;
  border: 3px solid #ffc400ec;
  padding-top:10px ;
  padding-bottom: 22px;
  outline: none;
  color: gray;
  border-radius: 24px;
  transition:0.25px;
  cursor: pointer;
}

.form-register button[type=submit]:hover {
  background: #ffc400ec;
  color: black;
}
</style>


