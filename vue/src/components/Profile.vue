<template>
  <div id="profile-page" @mouseenter="showOptions = false" @mouseleave="showOptions = true">
    <section class="portrait-wall">
      <div class="portrait" >
        <img
          :src="pictureAddress"
          alt="Profile picture"
          class="profile-picture"
          v-show="!isWebcamVisible"
        />
        <webcam id="webcam"
          v-if="isWebcamVisible"
          :isCameraOpen="isWebcamVisible"
          @photoTaken="useWebcamPhoto"
        />
        <input
          type="file"
          id="selectedFile"
          ref="selectedFile"
          v-if="isEditing"
          style="display: none"
          accept="image/*"
          @change="onFileChange"
        />
        <div id="image-icons">
          <img
            src="../../resources/upload.png"
            alt="Upload icon"
            class="confirm-btn btn"
            @click="$refs.selectedFile.click()"
            v-if="isEditing"
          />
          <img
            src="../../resources/camera.png"
            alt="Camera icon"
            class="confirm-btn btn"
            @click="isWebcamVisible = true"
            v-if="isEditing"
          />
        </div>
      </div>
      <div class="profileDropdownWrap" v-show="!showOptions || isEditing">
        <div class="profileDropdown">
          <div class="user-info">
            <div class="plaque">
              <h2 v-if="!isEditing">
                {{ profile.firstName }} {{ profile.lastName }}
              </h2>
              <input
                type="text"
                v-model="profile.firstName"
                v-if="isEditing"
                placeholder="First name"
              />
              <input
                type="text"
                v-model="profile.lastName"
                v-if="isEditing"
                placeholder="Last name"
              />
              <h3 v-if="!isEditing">{{ profile.email }}</h3>
              <input
                type="text"
                v-model="profile.email"
                v-if="isEditing"
                placeholder="Email address"
              />
              <div id="edit-icons">
                <img
                  src="../../resources/edit.png"
                  alt="Edit icon"
                  class="edit-btn btn"
                  @click="isEditing = !isEditing"
                  v-if="!isEditing"
                />
                <img
                  src="../../resources/confirm.png"
                  alt="Confirm icon"
                  class="confirm-btn btn"
                  @click="saveProfileChanges"
                  v-if="isEditing"
                />
                <img
                  src="../../resources/cancel.png"
                  alt="Cancel icon"
                  class="cancel-btn btn"
                  @click="cancelEdit"
                  v-if="isEditing"
                />
              </div>
            </div>
          </div>
          <hr />

          <router-link to="/friends" class="submenu-link">
            <img src="../../resources/friends.png" alt="" />
            <p>Friend's List</p>
            <!-- <span>></span> -->
          </router-link>
          <router-link v-bind:to="{ name: 'logout' }" class="submenu-link">
            <img src="../../resources/logput.png" alt="" />
            <p>Logout</p>
            <!-- <span>></span> -->
          </router-link>
        </div>
      </div>
    </section>
  </div>
</template>

<script>
import profileService from "@/services/ProfileService";
import webcam from "@/components/Webcam";

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
  components: {
    webcam,
  },

  computed: {
    fileName() {
      return `user${this.$store.state.user.id}-profile-picture`;
    },
    storageRef() {
      return ref(storage, this.fileName);
    },
    pictureAddress() {
      return this.webcamPicture
        ? URL.createObjectURL(this.webcamPicture)
        : this.updatingPicture
        ? URL.createObjectURL(this.updatingPicture)
        : this.profile.profilePictureUrl
        ? this.profile.profilePictureUrl
        : require("../../resources/default-user.png");
    },
  },

  data() {
    return {
      isEditing: true,
      isBookDetailVisible: false,
      isWebcamVisible: false,
      showOptions: true,
      profile: {
        profilePictureUrl: "",
        firstName: "",
        lastName: "",
        email: "",
      },
      bookToOpen: {},
      updatingPicture: null,
      webcamPicture: null,
    };
  },

  methods: {
    openBook(event, book) {
      this.bookToOpen = book;
      this.isBookDetailVisible = true;
    },

    closeBook() {
      this.isBookDetailVisible = false;
    },

    useWebcamPhoto(event, url) {
      fetch(url)
        .then((r) => r.blob())
        .then((blob) => {
          this.webcamPicture = blob;
          this.isWebcamVisible = false;
        });
    },

    cancelEdit() {
      this.isEditing = false;
      this.updatingPicture = null;
      this.webcamPicture = null;
      this.isWebcamVisible = false;
    },

    uploadProfilePicture(file) {
      uploadBytes(this.storageRef, file).then((snapshot) => {
        console.log(snapshot);
      });
    },

    saveProfileChanges() {
      if (this.updatingPicture || this.webcamPicture) {
        this.uploadProfilePicture(
          this.webcamPicture ? this.webcamPicture : this.updatingPicture
        );
      }
      getDownloadURL(ref(storage, this.fileName)).then((url) => {
        this.profile.profilePictureUrl = url;
        let profile = {
          userId: this.$store.state.user.id,
          firstName: this.profile.firstName,
          lastName: this.profile.lastName,
          email: this.profile.email,
          profilePictureUrl: url,
        };
        console.log(profile);
        this.isEditing = false;
        this.updatingPicture = null;
        this.webcamPicture = null;
        profileService.updateProfile(profile).then((response) => {
          if (response.status === 200) {
            console.log("Profile updated");
          }
        });
      });
    },

    onFileChange(e) {
      var files = e.target.files || e.dataTransfer.files;
      if (!files.length) {
        return;
      }
      this.updatingPicture = files[0];
    },
   updateStoreProfile(){
       this.$store.commit('SET_PROFILE', this.profile)
   }
  },
    
    created(){
        profileService.getProfile(this.$store.state.user.id).then(response => {
            if (response.status === 200 && response.data.firstName){
                this.profile = response.data;
                this.isEditing = false;
            }
        })
    },
};
</script>

<style>
.submenu-link {
  display: flex;
  align-items: center;
  text-decoration: none;
  color: #525252;
  margin: 12px 0;
}

.submenu-link p {
  width: 100%;
}

.submenu-link img {
  width: 40px;
  border-radius: 50%;
  padding: 8px;
  margin-right: 15px;
}

.submenu-link:hover p {
  font-weight: 600;
}

.profileDropdownWrap {
  top: 100%;
  right: 10%;
  max-height: 400px;
  overflow: hidden;
  z-index: 999;
}

.profileDropdown {
  background: lightgray;
  padding: 20px;
  left: 86.5%;
  position: absolute;
}

.portrait-wall {
  display: flex;
  align-items: center;
  flex-direction: column;
  gap: 20px;
}

.user-info {
  display: flex;
  align-items: center;
}

.portrait {
  /* border-color: rgb(211, 187, 55); */
  border-color: #ffde59;
  background-color: rgb(231, 229, 213);
  border-width: 20px;
  border-style: solid;
  width: 150px;
  height: 110px;
  display: flex;
  justify-content: center;
  align-items: space-between;
  flex-direction: column;
  position: relative;
  border-radius: 50%;
  box-shadow: 0px 5px 12px #8b824a;
  cursor: pointer;
}

.portrait > img {
  width: auto;
  height: auto;
  max-width: 150px;
  max-height: 200px;
  border-radius: 47%;
  display: block;
  height: 110px
}
#image-icons {
  top: 0;
  position: absolute;
}

#edit-icons {
  display: flex;
  justify-content: flex-end;
  margin-top: 5px;
  width: 100%;
}

.plaque {
  background-color: rgb(151, 65, 32);
  border-radius: 10px;
  padding: 10px 10px 5px 10px;
  display: flex;
  flex-direction: column;
  align-items: center;
  color: cornsilk;
  box-shadow: 0px 5px 12px rgb(110, 64, 47);
}

.plaque h2 {
  line-height: 0px;
  font-size: 20px;
  margin-top: 10px;
}

.plaque h3 {
  line-height: 0px;
  font-size: 18px;
  margin-top: 10px;
  margin-bottom: 10px;
}

.btn {
  width: 20px;
  height: 20px;
}

.btn:hover {
  cursor: pointer;
}

</style>