<template>
  <div @click="close" class="modal-backdrop">
    <div id="email" class="modal" @click.stop>
        <form id="email-form" ref="form" @submit.prevent="sendEmail">
            <!-- <label for="to_name">Friend's name: </label> -->
            <input placeholder="Friend's name" v-model="template_parameters.to_name" required id="to_name" type="text" name="to_name">
            <!-- <label for="to_email">Friend's email: </label> -->
            <input placeholder="Friend's email" v-model="template_parameters.to_email" required id="to_email" type="email" name="to_email">
            <!-- <label for="message">Add a custom message: (optional) </label> -->
            <textarea placeholder="Custom message (optional)" v-model="template_parameters.message" id="message" name="message"></textarea>
            <input type="submit" value="Send">
        </form>
    </div>
  </div>
</template>


<script>
import emailjs from '@emailjs/browser';

export default {
    data(){
        return {
           
        }
    },

    computed:{
      template_parameters(){
        return {
          to_name:"",
                to_email:"",
                message:"Check out this cool book collection website I found!",
                from_name:`${this.$store.state.profile.firstName} ${this.$store.state.profile.lastName}`,
                url:`http://localhost:8081/friends/${this.$store.state.profile.userId}`,
        }
      }
    },


  methods: {
    sendEmail() {
      emailjs.send('service_8ig4zv7', 'template_syk0dbf', this.template_parameters, 'OYzdFR24KOaNNkJiz')
        .then((result) => {
            console.log('SUCCESS!', result.text);
        }, (error) => {
            console.log('FAILED...', error.text);
        });
        this.close();
    },
    close() {
      this.$emit("close");
    },
  },

  created(){
        if (!this.$store.state.profile.firstName){
            this.$emit('updateProfile');
        }
  }
}
</script>

<style>

#email{
    border-style: none;
    width: 400px;
    height: 300px;
}

#email-form{
    display: flex;
    flex-direction: column;
    margin: 20px;
    width: 90%;
    gap: 10px;
}

#email-form textarea {
    width: 355px !important;
    height: 150px !important;
}

/* .iconEmail {
  background: url("../../resources/email3.png");
  background-repeat: no-repeat;
  height: 25px;
  width: 25px;
  border: 2px solid transparent;
  border-radius: 50%;
  margin: 5px;
  cursor: pointer;
  position: relative;
  display: inline-block;
} */

#email-icon{
  height: 25px;
  width: 25px;
  margin-top: 5px;
  cursor: pointer;
}

</style>