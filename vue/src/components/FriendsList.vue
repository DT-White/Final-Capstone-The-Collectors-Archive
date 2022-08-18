<template>
  <div id="friendsList">
    
    <div class="individualFriend" v-for="currentFriend in profiles" v-bind:key="currentFriend.profileId" v-on:click="goToFriendsPage(currentFriend.userId)">
        <div class="portrait">
          <img :src=currentFriend.profilePictureUrl alt="" />
        </div>
        <div class="userInfo">
          <div class="plaque">
            <h2>{{currentFriend.firstName}} {{currentFriend.lastName}}</h2>
          </div>
        </div>        
    </div>
    
  </div>
</template>

<script>
import profileService from "@/services/ProfileService";

export default {
  data() {
    return {
      profiles: [],
    };
  },

  created() {
    profileService.getFriendsProfiles().then((response) => {
      if (response.status === 200) {
        this.profiles = response.data;
      }
    });
  },

  methods: {
    goToFriendsPage(friendId){
      return this.$router.push({path: `/friends/${friendId}`})
    }
  }
};
</script>

<style>
div#friendsList {
  display: flex;
  flex-direction: row;
  justify-content: space-around;
}

#individualFriend {
  padding: 100px;
}

</style>