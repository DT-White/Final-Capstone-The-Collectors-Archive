import axios from 'axios';

export default{
    getProfile(userId){
        return axios.get(`/profiles/${userId}`);
    },

    updateProfile(profile){
        return axios.put('/profiles', profile);
    },

    createProfile(profile){
        return axios.post('/profiles', profile)
    },

    addFriend(friendUserId){
        return axios.post('/friends', friendUserId)
    },

    getFriendsProfiles(){
        return axios.get('/friends')
    }
}