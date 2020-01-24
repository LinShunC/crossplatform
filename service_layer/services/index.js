var firebase = require('firebase')


var firebaseConfig = {
    serviceAccount: "./crossplatform-e3724db7ad8e.json",
    apiKey: "AIzaSyCN8JWCxd8uItbuI29raUTeHxBzaijIcCA",
    authDomain: "crossplatform-b527e.firebaseapp.com",
    databaseURL: "https://crossplatform-b527e.firebaseio.com",
    projectId: "crossplatform-b527e",
    storageBucket: "crossplatform-b527e.appspot.com",
    messagingSenderId: "893106616972",
    appId: "1:893106616972:web:e9d7c7f3eeb9aec11099a9"
};
// Initialize Firebase
firebase.initializeApp(firebaseConfig);

var ref = firebase.database().ref();
/*ref.once("value")
    .then(function(snapshot) {
        console.log("snap.val()", snap.val());
    });*/
var messageref = ref.child("message")
messageref.push({
    name: 'chi',
    admin: true,
    count: 1,
    text: "asdas"
});