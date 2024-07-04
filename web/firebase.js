// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyBv2oGTOcc6H3ccv4JEyn3Q_YQtxW7Fg74",
  authDomain: "personal-project-cd273.firebaseapp.com",
  projectId: "personal-project-cd273",
  storageBucket: "personal-project-cd273.appspot.com",
  messagingSenderId: "775719963929",
  appId: "1:775719963929:web:745e8191199b45ae43c988",
  measurementId: "G-D7M64ZXHLF"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);