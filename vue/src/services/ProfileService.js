import axios from 'axios';

export default{
    getProfile(userId){
        return axios.get(`/profiles/${userId}`);
    },

    updateProfile(profile){
        return axios.put('/profiles', profile);
    }
}