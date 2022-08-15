<template>
<div id="profile-page">
    <section>
        <div id="profile">
            <div id="picture-div">
                <img :src="pictureAddress" alt="Profile picture" class="profile-picture">
                <input type="file" id="selectedFile" v-if="isEditing" style="display: none;" accept="image/*" @change="onFileChange">
                <input type="button" value="Browse" onclick="document.getElementById('selectedFile').click();" v-if="isEditing"/>
            </div>
            <section>
                <h2 v-if="!isEditing">{{profile.firstName}} {{profile.lastName}}</h2>
                <input type="text" v-model="profile.firstName" v-if="isEditing" placeholder="First name">
                <input type="text" v-model="profile.lastName" v-if="isEditing" placeholder="Last name">
                <h3 v-if="!isEditing">{{profile.email}}</h3>
                <input type="text" v-model="profile.email" v-if="isEditing" placeholder="Email address">
            </section>
        </div>
        <img src="../../resources/edit.png" alt="Edit icon" class="edit-btn btn" @click="isEditing = !isEditing" v-if="!isEditing">
        <div id='two-buttons'>
            <img src="../../resources/confirm.png" alt="Confirm icon" class="confirm-btn btn" @click="saveProfileChanges" v-if="isEditing">
            <img src="../../resources/cancel.png" alt="Cancel icon" class="cancel-btn btn" @click="cancelEdit" v-if="isEditing">
        </div>
    </section>
    <library @openBook="openBook"/>
    <Modal :book="bookToOpen"
      v-show="isModalVisible"
      @close="closeModal"
    />
</div>
</template>

<script>
import profileService from '@/services/ProfileService';
import library from '@/components/BookList';
import Modal from "@/components/BookDetail"

// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getStorage, ref, uploadBytes, getDownloadURL } from "firebase/storage";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyCVMxFMtlKIQiUk9FQrcrWBLcsc-64HdIY",
  authDomain: "collectors-archive.firebaseapp.com",
  projectId: "collectors-archive",
  storageBucket: "collectors-archive.appspot.com",
  messagingSenderId: "1036160046347",
  appId: "1:1036160046347:web:f4250540befbf068023e0e",
};

// Initialize Firebase
const firebaseApp = initializeApp(firebaseConfig);

// Initialize Cloud Storage and get a reference to the service
const storage = getStorage(firebaseApp, "gs://collectors-archive.appspot.com");

// Create a storage reference from our storage service




export default {
    components:{
        library,
        Modal
    },

    computed:{
        fileName(){
            return `user${this.profile.userId}-profile-picture`;
        },
        storageRef(){
            return ref(storage, this.fileName);
        },
        pictureAddress(){
            return this.updatingPicture ? URL.createObjectURL(this.updatingPicture) : this.profile.profilePictureUrl ? this.profile.profilePictureUrl : require('../../resources/default-user.png')
        }
    },

    data(){
        return{
            isEditing:true,
            isModalVisible: false,
            profile:{
                profilePictureUrl:"",
                firstName:"",
                lastName:"",
                email:""
            },
            bookToOpen: {},
            updatingPicture: null
        }
    },

    methods: {
    openBook(event, book) {
        this.bookToOpen = book;
        this.isModalVisible = true;
    },

    closeModal() {
      this.isModalVisible = false;
    },

    cancelEdit(){
        this.isEditing = false;
        this.updatingPicture = null;
        profileService.getProfile(this.$store.state.user.id).then(response => {
            if (response.status === 200){
                this.profile = response.data;
            }
        })
    },

    uploadProfilePicture(file){
        uploadBytes(this.storageRef, file).then((snapshot) => {
        console.log(snapshot);
        });
    },

    saveProfileChanges(){
        this.uploadProfilePicture(this.updatingPicture);
        getDownloadURL(ref(storage, this.fileName)).then((url) => {
                this.profile.profilePictureUrl = url;
                let profile = {
                userId:this.profile.userId,
                firstName:this.profile.firstName,
                lastName:this.profile.lastName,
                email:this.profile.email,
                profilePictureUrl:url
            }
            console.log(profile);
            this.isEditing = false;
            this.updatingPicture = null;
            profileService.updateProfile(profile).then(response => {
                if (response.status === 200){
                    console.log("Profile updated")
                }
            })
        });
    },

    onFileChange(e) {
        var files = e.target.files || e.dataTransfer.files;
        if (!files.length){
            return;
        }
        this.updatingPicture = files[0];
    },
   
    },
    created(){
        profileService.getProfile(this.$store.state.user.id).then(response => {
            if (response.status === 200 && response.data){
                this.profile = response.data;
                this.isEditing = false;
            }
        })
    },
}
</script>

<style>

#picture-div{
    display: flex;
    flex-direction: column;
}

input[type="button"]{
    margin-top: -22px;
}

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

#profile-page > section{
    display: flex;
}

#profile{
    display: flex;
    background-color: cadetblue;
    padding: 10px;
    gap:10px
}

#profile section{
    display: flex;
    flex-direction: column;
    justify-content: space-around;
    padding-top: 20px;
}

#profile h2{
    line-height: 12px;
}

#profile h3{
    line-height: 12px;
}

.edit-btn{
    width: 20px;
    height: 20px;
    background-color: cadetblue;
    margin-left: -30px;
    margin-top: 10px;
}

.confirm-btn{
    width: 20px;
    height: 20px;
    background-color: cadetblue;
}

.cancel-btn{
    width: 20px;
    height: 20px;
    background-color: cadetblue;
}

#two-buttons{
    margin-top: 10px;
    margin-left: -55px;
    display: flex;
    gap: 5px;
}

.btn:hover{
    cursor: pointer;
}

</style>