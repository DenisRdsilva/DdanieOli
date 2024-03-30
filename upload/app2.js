import { getAuth, signOut } from "https://www.gstatic.com/firebasejs/9.13.0/firebase-auth.js";
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

let signout = document.getElementById('logout');

signout.addEventListener("click", (c) => {
    c.preventDefault();
    signOut(auth);
    window.location.href = "login.html";
})

/*
import aws from '/@aws-sdk/client-s3';

const util = require('util');
const { crypto } = await import('crypto');
const randomBytes = util.promisify(crypto.randomBytes)

require(dotenv).config()

const region = "us-east-1"
const bucketName = "d-oli-images"
const accessKeyId = process.env.AWS_ACCESS_KEY_ID
const secretAccessKey = process.env.SECRET_ACCESS_KEY

const s3 = new aws.S3({
    region,
    accessKeyId,
    secretAccessKey,
    signatureVersion: 'v4'
})

export async function generateUploadURL() {
    const rawBytes = await randomBytes(16)
    const imageName = rawBytes.toString('hex')

    const params = ({
        Bucket: bucketName,
        Key: imageName,
        Expires: 60
    })

    const uploadURL = await s3.getSignedURLPromise('putObject', params)
    return uploadURL
}
*/