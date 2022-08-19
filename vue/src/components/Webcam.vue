<template>
  <div id="webcam" class="web-camera-container">

    <div v-show="isCameraOpen && isLoading" class="camera-loading">
      <ul class="loader-circle">
        <li></li>
        <li></li>
        <li></li>
      </ul>
    </div>

    <div
      v-if="isCameraOpen"
      v-show="!isLoading"
      class="camera-box"
      :class="{ flash: isShotPhoto }"
    >
      <div class="camera-shutter" :class="{ flash: isShotPhoto }"></div>

      <video
        v-show="!isPhotoTaken"
        id="video"
        ref="camera"
        autoplay
      ></video>

      <canvas
        v-show="isPhotoTaken"
        id="photoTaken"
        ref="canvas"
      ></canvas>
    </div>

    <div v-if="isCameraOpen && !isLoading && !isPhotoTaken" class="camera-shoot">
      <button type="button" class="button" @click="takePhoto">
        <img
          src="https://img.icons8.com/material-outlined/50/000000/camera--v2.png"
        />
      </button>
    </div>
    <div id="photo-confirm-icons">
      <img src="../../resources/confirm.png" alt="Confirm icon" class="confirm-btn btn" @click="confirmPhoto" v-if="isPhotoTaken">
      <img src="../../resources/retake.png" alt="Retake icon" class="confirm-btn btn" @click="isPhotoTaken = !isPhotoTaken" v-if="isPhotoTaken">
    </div>
<!-- 
    <div v-show="true" class="camera-download">
      <a
        id="downloadPhoto"
        download="my-photo.jpg"
        class="button"
        role="button"
        @click="downloadImage"
      >
        Download
      </a>
    </div> -->
  </div>
</template>

<script>
export default {

  props: [
    'isCameraOpen'
  ],

  data() {
    return {
      isPhotoTaken: false,
      isShotPhoto: false,
      isLoading: false,
      link: "#",
      image: null
    };
  },

  created(){
    this.createCameraElement()
  },

  beforeDestroy(){
    this.stopCameraStream()
  },

  methods: {
    toggleCamera() {
      if (this.isCameraOpen) {
        this.isPhotoTaken = false;
        this.isShotPhoto = false;
        this.stopCameraStream();
      } else {
        this.createCameraElement();
      }
    },

    createCameraElement() {
      this.isLoading = true;

      const constraints = (window.constraints = {
        audio: false,
        video: true,
      });

      navigator.mediaDevices
        .getUserMedia(constraints)
        .then((stream) => {
          this.isLoading = false;
          this.$refs.camera.srcObject = stream;
        })
        .catch((error) => {
          this.isLoading = false;
          alert(error);
        });
    },

    stopCameraStream() {
      let tracks = this.$refs.camera.srcObject.getTracks();

      tracks.forEach((track) => {
        track.stop();
      });
    },

    takePhoto() {
      if (!this.isPhotoTaken) {
        this.isShotPhoto = true;
        this.isPhotoTaken = true;
        const FLASH_TIMEOUT = 50;

        setTimeout(() => {
          this.isShotPhoto = false;
        }, FLASH_TIMEOUT);
        const context = this.$refs.canvas.getContext("2d");
        const cam = this.$refs.camera;
        context.drawImage(cam, 0, 0, cam.videoWidth, cam.videoHeight, 0, 0, 300, 150);
      }
    },

    confirmPhoto(event) {const url = document
        .getElementById("photoTaken")
        .toDataURL("image/jpeg")
      this.$emit('photoTaken', event, url);
      this.stopCameraStream();
    },
  },
};
</script>

<style>
body {
  display: flex;
  justify-content: center;
}

.web-camera-container {
  margin-top: 2rem;
  margin-bottom: 2rem;
  padding: 2rem;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  border-radius: 4px;
  width: 80px;
  height: 100px;
}

.camera-box .camera-shutter {
  opacity: 0;
  width: 80px;
  height: auto;
  background-color: #fff;
  position: absolute;
}
.camera-box .flash {
  opacity: 1;
}

.camera-shoot {
  margin: 1rem 0;
}
.camera-shoot button {
  height: 30px;
  width: 30px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 100%;
  top: 130px;
  left: 60px;
  position: absolute;
  z-index: 1000;
}
.camera-shoot img {
  height: 20px;
  object-fit: cover;
}

.camera-loading {
  overflow: hidden;
  height: 100%;
  position: absolute;
  width: 100%;
  min-height: 150px;
  margin: 3rem 0 0 -1.2rem;
}
.camera-loading ul {
  height: 100%;
  position: absolute;
  width: 100%;
  z-index: 999999;
  margin: 0;
}

.loader-circle {
  display: block;
  height: 14px;
  margin: 0 auto;
  top: 50%;
  left: 100%;
  transform: translateY(-50%);
  transform: translateX(-50%);
  position: absolute;
  width: 100%;
  padding: 0;
}
.loader-circle li {
  display: block;
  float: left;
  width: 10px;
  height: 10px;
  line-height: 10px;
  padding: 0;
  position: relative;
  margin: 0 0 0 4px;
  background: #999;
  animation: preload 1s infinite;
  top: -50%;
  border-radius: 100%;
}
.loader-circle li:nth-child(2) {
  animation-delay: 0.2s;
}

.loader-circle li:nth-child(3) {
  animation-delay: 0.4s;
}

#photoTaken, #video {
  /* width: 150px;
  height: 200px; */
  margin-left: 5px;
   width: 150px;
  height: auto;
  max-width: 150px;
  max-height: 200px;
  border-radius: 50%;
  display: block;
  height: 100vh;
  margin-top: 30px;
}

#video{
  width: 150px;
  height: 150px;
  object-fit: cover;

}



#photoTaken{
  left: -4px;
  top: -29px;
  overflow: hidden;
  position: absolute;
  object-fit:fill;
  width: 150px;
  height: 110px;
}

#photo-confirm-icons{
  top: 120px;
  left: 55px;
  position: absolute;
}

@keyframes preload {
  0% {
    opacity: 1;
  }
  50% {
    opacity: 0.4;
  }
  100% {
    opacity: 1;
  }
}
</style>