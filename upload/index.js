var files = [];
var fileReaders = [];
var imageLinksArray = [];
var galnumber;

const imgdiv = document.getElementById('imagesdiv');
const selbtn = document.getElementById('selimgsbtn');
const addbtn = document.getElementById('addprodbtn');
const proglab = document.getElementById('loadlab');
const backbtn = document.getElementById('backbutton');
const dropdown = document.getElementById('drop-select');

//const link = document.getElementById("datadiv");

const _name = ['Arte Vive', 'Andando pela Natureza', 'Devaneios do artista', 'Selvas de Pedra',
'Trabalhadores da Praia'];

const name = ['artevive', 'natureza', 'devaneios', 'selvapedra', 'trabalhadores'];

/*
const _name = ['Arte Vive', 'Andando pela Natureza', 'Devaneios do artista', 'Selvas de Pedra',
'Trabalhadores da Praia', 'Teste'];

const name = ['artevive', 'natureza', 'devaneios', 'selvapedra', 'trabalhadores', 'teste'];
*/

for (let i = 0; i < name.length; i++) {
    var opt = document.createElement('option');
    opt.id = 'opt'
    opt.textContent = _name[i];
    opt.value = name[i];
    dropdown.append(opt);
}

function OpenFileDialog() {
    let inp = document.createElement('input');
    inp.type = 'file';
    inp.multiple = 'multiple';

    inp.onchange = (e) => {
        AssignImgsToFilesArray(e.target.files);
        CreateImgTags();
    }

    inp.click();
}

function AssignImgsToFilesArray(thefiles) {
    let num = files.length + thefiles.length;

    for (let i = 0; i < num; i++) {
        files.push(thefiles[i]);
    }

    alert('Foram selecionadas ' + files.length + " imagens.");
}

function CreateImgTags(e) {
    imgdiv.innerHTML = '';
    imgdiv.classList.add('imagesDivStyle');

    for (let i = 0; i < files.length; i++) {
        fileReaders[i] = new FileReader();

        fileReaders[i].onload = function () {
            var img = document.createElement('img');
            img.id = 'imgNo' + i;
            img.classList.add('imgs');
            img.src = fileReaders[i].result;
            imgdiv.append(img);
        }

        fileReaders[i].readAsDataURL(files[i]);
    }
} //Shows the images in the screen

function getImageUploadProgress() {
    return "Images Uploaded " + imageLinksArray.length + ' of ' + files.length;
}

function isAllImagesUploaded() {
    return imageLinksArray.length == files.length;
}

selbtn.addEventListener('click', OpenFileDialog);
addbtn.addEventListener('click', uploadAllImages);

function uploadAllImages() {

    for (let i = 0; i < files.length; i++) {
        uploadAnImage(files[i], i);
    }
}

function getShortTitle() {
    let namey = dropdown.selectedOptions[0].value;
    return namey.replace(/[^a-zA-Z0-9]/g, "");
}

function RestoreBack() {
    selbtn.disabled = true;
    addbtn.disabled = true;
}

function uploadAnImage(imgToUpload, imgNo) {

    const metadata = {
        contentType: imgToUpload.type
    };

    const storage = getStorage();

    const imageAddress = "theImages/" + getShortTitle() + "/img#" + (imgNo + 1);

    const storageRef = sRef(storage, imageAddress);

    const uploadTask = uploadBytesResumable(storageRef, imgToUpload, metadata);

    uploadTask.on('state_changed', (snapshot) => {
        proglab.innerHTML = getImageUploadProgress();
    },

        (error) => { alert("Erro no upload das imagens") },

        () => {
            getDownloadURL(uploadTask.snapshot.ref).then((downloadURL) => {
                imageLinksArray.push(downloadURL);

                if (isAllImagesUploaded()) {
                    proglab.innerHTML = "Todas as imagens foram adicionadas";
                    let links = document.createElement('a');
                    links.textContent = imageLinksArray;
                    //link.append(links);

                    uploadAProduct();
                }
            })
        },
    )
}

backbtn.addEventListener('click', (e) => {
    imgdiv.innerHTML = '';
    files = [];
    fileReaders = [];
    imageLinksArray = [];
    selbtn.disabled = false;
    addbtn.disabled = false;
    proglab.innerHTML = "Inserir Imagens";
    imgdiv.classList.remove('imagesDivStyle')
})

// Import the functions you need from the SDKs you need

// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// const firebaseConfig = {
//     apiKey: "AIzaSyAny_6AT2YAYjPttmne0jygcqOWtu23lvA",
//     authDomain: "danielolifotografias.firebaseapp.com",
//     databaseURL: "https://danielolifotografias-default-rtdb.firebaseio.com",
//     projectId: "danielolifotografias",
//     storageBucket: "danielolifotografias.appspot.com",
//     messagingSenderId: "1084089897568",
//     appId: "1:1084089897568:web:35fcfd9ddedf03620ae905"
// };

// Initialize Firebase
// const app = initializeApp(firebaseConfig);

// Initialize Database
// import { getDatabase, ref } from "https://www.gstatic.com/firebasejs/9.13.0/firebase-database.js";

/*import { getFirestore, collection } from "https://www.gstatic.com/firebasejs/9.13.0/firebase-firestore.js";
const db = getFirestore(app);*/

// // Initialize Storage
// import { getDownloadURL, getStorage, ref as sRef, uploadBytesResumable } from "https://www.gstatic.com/firebasejs/9.13.0/firebase-storage.js";

// const dbRef = ref(getDatabase(app));

const sqlite3 = require('sqlite3').verbose();

const db = new sqlite3.Database(':memory:');

// Dados do array para criar a tabela
const dataArray = [
    imageLinksArray,
];

// Abrir o banco de dados
db.serialize(() => {
  // Criar uma tabela chamada "itens"
  db.run('CREATE TABLE itens (name TEXT)');

  // Inserir os dados do array na tabela
  const insertStmt = db.prepare('INSERT INTO itens VALUES (?, ?)');
  dataArray.forEach((data) => {
    insertStmt.run(data.id, data.name);
  });
  insertStmt.finalize();

  // Selecionar todos os registros da tabela
  db.all('SELECT * FROM itens', (err, rows) => {
    if (err) {
      console.error(err.message);
    } else {
      // Exibir os registros no console
      rows.forEach((row) => {
        console.log(`ID: ${row.id}, Name: ${row.name}`);
      });
    }
  });
});

// Fechar o banco de dados
db.close();


async function uploadAProduct() {


    alert("As imagens foram adicionadas com sucesso!");
    RestoreBack();
}

