import axios from 'axios';

export default{
    getProfile(){
        return axios.get('/profile');
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
    },

    getFriendProfile(friendId){
        return axios.get(`/profile/${friendId}`)
    }
}