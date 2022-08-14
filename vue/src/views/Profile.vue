<template>
<div id="profile-page">
    <div id="profile">
        <img :src="profile.profilePictureUrl" alt="Profile picture" class="profile-picture">
        <section>
            <h2>{{profile.firstName}} {{profile.lastName}}</h2>
            <h3>{{profile.email}}</h3>
        </section>
    </div>
    <reading-list/>
</div>
</template>

<script>
import profileService from '@/services/ProfileService';
import readingList from '@/components/ReadingList'

export default {
    components:{
        readingList
    },
    data(){
        return{
            profile:{},
        }
    },
    created(){
        profileService.getProfile(this.$store.state.user.id).then(response => {
            if (response.status === 200){
                this.profile = response.data;
            }
        })
    }
}
</script>

<style>
.profile-picture{
    width:100px;
    height: auto;
}

#profile-page{
    display: flex;
    justify-content: center;
    align-items: flex-start;
    flex-direction: column;
    padding-left:50px;
}

#profile{
    display: flex;
    background-color: cadetblue;
    padding: 10px;
    gap:10px
}

</style>