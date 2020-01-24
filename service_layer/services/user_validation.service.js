"use strict";
var fs = require('fs');
var firebase = require('firebase')



var firebaseConfig = {
    /*  serviceAccount: "./crossplatform-e3724db7ad8e.json",
      apiKey: "AIzaSyCN8JWCxd8uItbuI29raUTeHxBzaijIcCA",
      authDomain: "crossplatform-b527e.firebaseapp.com",
      databaseURL: "https://crossplatform-b527e.firebaseio.com",
      projectId: "crossplatform-b527e",
      storageBucket: "crossplatform-b527e.appspot.com",
      messagingSenderId: "893106616972",
      appId: "1:893106616972:web:e9d7c7f3eeb9aec11099a9"*/
    apiKey: "AIzaSyCN8JWCxd8uItbuI29raUTeHxBzaijIcCA",
    authDomain: "crossplatform-b527e.firebaseapp.com",
    databaseURL: "https://crossplatform-b527e.firebaseio.com",
    projectId: "crossplatform-b527e",
    storageBucket: "crossplatform-b527e.appspot.com",
    messagingSenderId: "893106616972",
    appId: "1:893106616972:web:0c3ce733827b6d231099a9"
};
// Initialize Firebase
firebase.initializeApp(firebaseConfig);

module.exports = {
    name: "userValidation",

    /**
     * Service settings
     */
    settings: {

        validUserList: {}

    },

    /**
     * Service dependencies
     */
    dependencies: [],

    /**
     * Actions
     */
    actions: {

        validate: {
            params: {
                username: "string",
                password: "string"
            },
            handler(ctx) {
                return this.validateUser(ctx);
            }
        },

        signup: {
            params: {
                username: "string",
                password: "string"
            },
            handler(ctx) {
                return this.signupUser(ctx);
            }
        },
        signout: {
            handler() {
                return this.signoutUser();
            }
        },
        currentUser: {
            handler() {
                return this.currentUser();
            }
        },

    },

    /**
     * Events
     */
    events: {

    },

    /**
     * Methods
     */
    methods: {

        currentUser() {
            return new Promise(function(resolve) {
                resolve({ userid: firebase.auth().currentUser.uid });
            });
        },

        signoutUser() {
            return new Promise(function(resolve) {
                firebase.auth().signOut().then(function() {
                    resolve({ valid: true });
                }).catch(function(error) {
                    // An error happened.
                    resolve({ valid: false });
                });
            });
        },
        signupUser(ctx) {

            return new Promise(function(resolve) {
                firebase.auth().createUserWithEmailAndPassword(ctx.params.username, ctx.params.password).then(function() {
                    resolve({ valid: true, userid: firebase.auth().currentUser.uid });
                }).catch(function(error) {
                    resolve({ valid: false });
                    // An error happened.
                });
            });
        },

        // private funtions are delcared here
        validateUser(ctx) {
            return new Promise(function(resolve) {
                /* firebase.auth().createUserWithEmailAndPassword("test5@gmail.com", "aaaaaa").then(function() {
                     resolve({ valid: true, userid: firebase.auth().currentUser.uid });
                 }).catch(function(error) {
                     resolve({ valid: false });
                     // An error happened.
                 });*/

                firebase.auth()
                    .signInWithEmailAndPassword(ctx.params.username, ctx.params.password)
                    .then(() => {
                        resolve({ valid: true, userid: firebase.auth().currentUser.uid });
                    }).catch((err) => {
                        resolve({ valid: false });
                    })

                /*  firebase.auth().signInWithEmailAndPassword("test5@gmail.com", "aaaaaa").then(function() {
                      resolve({ valid: true, userid: firebase.auth().currentUser.uid });
                  }).catch(function(error) {
                      // Handle Errors here.
                      var errorCode = error.code;
                      var errorMessage = error.message;
                      resolve({ valid: false });
                      // ...
                  });*/


            });
            /* return new Promise(function(resolve) {
                 if (error != null) {
                     resolve({ valid: false });
                 } else {
                     resolve({ valid: true });

                 }
             });*/




            // Validate from the Pre-loaded users
            /* if (THIS.settings.validUserList.hasOwnProperty(ctx.params.username)) {
    
                    let password = THIS.settings.validUserList[ctx.params.username];
                    password == ctx.params.password ? resolve({ valid: true }) : resolve({ valid: false });
                } else {
                    resolve({ valid: false })
                }*/
            //    });
        },

        updateMessage() {
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
            let THIS = this;
            return new Promise(function(resolve) {
                resolve({ valid: true })
            });
        }

    },

    /**
     * Service created lifecycle event handler
     */
    created() {


        this.settings.validUserList = JSON.parse(fs.readFileSync('./users.json', 'utf8'));

    },

    /**
     * Service started lifecycle event handler
     */
    started() {

    },

    /**
     * Service stopped lifecycle event handler
     */
    stopped() {

    }
};