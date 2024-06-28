importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-messaging-compat.js");

firebase.initializeApp({
    apiKey: "AIzaSyDejU9euNTGJ0EqtuJ2hJGBhgNi2qw05W4",
    authDomain: "destinymatch-70b72.firebaseapp.com",
    databaseURL: "https://destinymatch-70b72-default-rtdb.asia-southeast1.firebasedatabase.app",
    projectId: "destinymatch-70b72",
    storageBucket: "destinymatch-70b72.appspot.com",
    messagingSenderId: "980721620844",
    appId: "1:980721620844:web:cd02b21c40935f6f340549",
    measurementId: "G-CNRJQBN4MS"
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});