import { getAuth, signInWithEmailAndPassword } from "https://www.gstatic.com/firebasejs/9.13.0/firebase-auth.js";
import { initializeApp } from "https://www.gstatic.com/firebasejs/9.13.0/firebase-app.js";

const firebaseConfig = {
    apiKey: "AIzaSyAny_6AT2YAYjPttmne0jygcqOWtu23lvA",
    authDomain: "danielolifotografias.firebaseapp.com",
    databaseURL: "https://danielolifotografias-default-rtdb.firebaseio.com",
    projectId: "danielolifotografias",
    storageBucket: "danielolifotografias.appspot.com",
    messagingSenderId: "1084089897568",
    appId: "1:1084089897568:web:35fcfd9ddedf03620ae905"
};

const app = initializeApp(firebaseConfig);
const auth = getAuth(app);

let signin = document.getElementById('signbtn');

signin.addEventListener("click", (e) => {
    e.preventDefault();

    var email = document.getElementById("email");
    var senha = document.getElementById("senha");

    var state = 1;

    signInWithEmailAndPassword(auth, email.value, senha.value).then((userCredentials) => {
        var user = userCredentials.user;
        alert(user.email + " efetuou login com sucesso");

    }).catch((error) => {
        var errorMessage = error.message;
        alert(errorMessage);
    })
})

/*
import express from 'express'
import { generateUploadURL } from 'app2.js'

const app = express()

app.use(express.static('front'))

app.get('/s3Url', async (req, res) => {
    const url = await generateUploadURL()
    res.send({url})
})

app.listen(5501, () => console.log("listening on port 5501"))

let signin = document.getElementById('signbtn');

signin.addEventListener("click", (e) => {

    window.location.href = "upload.js";

})
*/