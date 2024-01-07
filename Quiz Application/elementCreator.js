let questionNumber = 1;
let score = 0;

const sect1 = document.getElementById("sect1"); sect1.classList.add("center");
const header1 = document.getElementById("header1"); header1.classList.add("left");
const maindesc = document.getElementById("maindesc"); maindesc.classList.add("left");

const sect2 = document.createElement("section"); sect2.id="sect2"; sect2.classList.add("center");
const qnumber = document.createElement("p"); qnumber.id="qnumber"; qnumber.textContent=`Question ${questionNumber}`; qnumber.classList.add("center");
const div1 = document.createElement("div"); div1.id="div1"; div1.classList.add("center");
const questionDescription = document.createElement("p"); questionDescription.id="qnumber";
const answersHolder = document.createElement("div"); answersHolder.id="answersHolder";
const submit = document.createElement("button"); submit.id="submit"; submit.textContent="Submit your answer!"; submit.classList.add("myButton"); submit.addEventListener('click', submitQuestion);
const nextButton = document.createElement("button"); nextButton.id="submit"; nextButton.textContent="Submit your answer!"; nextButton.classList.add("myButton"); nextButton.addEventListener("click", nextQuestion);
const finishButton = document.createElement("button"); finishButton.id="finishButton"; finishButton.textContent="Finish Test!"; finishButton.classList.add("myButton"); finishButton.addEventListener('click', finishQuiz);
const restartButton = document.createElement("button"); restartButton.id="restartButton"; restartButton.innerHTML = "Restart Quiz"; restartButton.classList.add("myButton"); restartButton.addEventListener('click', restartQuiz);
const finishDiv = document.createElement("div"); finishDiv.id="finishDiv";
const finishPara = document.createElement("div"); finishPara.id="finishPara";

const sect3 = document.createElement("section");
const nav = document.createElement("nav");
const ul = document.createElement("ul");
const li0 = document.createElement("li"); li0.id = "li0"; li0.innerHTML = `<a href="index.html"> Go to Main Page!</a>`;
const li1 = document.createElement("li"); li1.id = "li1";
const li2 = document.createElement("li"); li2.id = "li2";
const li3 = document.createElement("li"); li3.id = "li3";