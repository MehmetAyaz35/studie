function addSection(){   // called by finishQuiz
    document.body.appendChild(sect3);
    sect3.appendChild(nav);
    nav.appendChild(ul);
    ul.appendChild(li0);
    ul.appendChild(li1);
    ul.appendChild(li2);
    ul.appendChild(li3);
}

function removeSection(){   // called by restartQuiz
    li3.remove();
    li2.remove();
    li1.remove();
    li0.remove();
    ul.remove();
    nav.remove();
    sect3.remove();
}

function questionValidator(){ // this function detects whether the current question is of input type radio or text, then applies validation logic.
    if(questions[questionNumber-1].questionInputType=="radio"){ // If the question is input type radio, code is executed 
        for (let i = 0; i < 4; i++) {
            let btn = document.getElementById(`${i}`); // each radio question has 4 inputs with ids: 0,1,2,3. So `${i}` will check all of them
            if(btn.classList.contains("right")){ // check if button element's classlist contains "right", execute code
                btn.addEventListener('change', function (){ // add change event listener to button, i.e if the button is not selected, selecting it will count as change and vice versa
                    btn.parentNode.classList.add("greenbg"); // add "greenbg" class to button element's parent element
                    score++; // increment score
                    for (let j = 0; j < 4; j++) { // execute code below 4 times
                        let btnDisabler = document.getElementById(`${j}`); // create a new variable btnDisabler to adjust in next line
                        btnDisabler.disabled = true; // disable button element so that the user can't change multiple buttons
                    }
                    submit.disabled = true; // disable submit button
                    console.log(`score is ${score}`);
                })
            }
            else if(btn.classList.contains("wrong")){ // check if button element's classlist contains "wrong", execute code 
                btn.addEventListener('change', function (){
                    btn.parentNode.classList.add("redbg"); // add "redbg" class to button element's parent element
                for (let k = 0; k < 4; k++) {
                    let btnDisabler2 = document.getElementById(`${k}`);
                    btnDisabler2.disabled=true;
                }
                submit.disabled = true; // disable submit button
                console.log(`score is ${score}`);
            })
        }
        }
    }
    if(questions[questionNumber-1].questionInputType=="text"){ // If the question is of input type text, code is executed 
        let answer = document.getElementById("questionInput"); // get element#questionInput and assign it to answer
        answer.addEventListener("keydown", function(event) {
        if (event.key === "Enter") {
            if (answer.value.toLowerCase() == questions[questionNumber-1].questionAnswer){
                score++;
                answer.classList.add("greenbg");
            }
            else{
                answer.classList.add("redbg");
            }
            console.log(`score is ${score}`);
            answer.disabled = true;
            submit.disabled = true;
        }
        })
    }
    
}

function submitQuestion(){  // this function is called when user clicks submit button
    if(questions[questionNumber-1].questionInputType=="text"){
        let answer = document.getElementById("questionInput");           //i created questionInput in line 92
        if (answer.value == questions[questionNumber-1].questionAnswer){
            score++;
            answer.classList.add("greenbg");
            answer.disabled = true;
        }
        else{
            answer.classList.add("redbg");
            answer.disabled = true;
        }
    }
    submit.disabled = true; // Disable the submit button
    console.log(`score is ${score}`);
}

function nextQuestion(){  // this function is called when user clicks next button
    if(submit.disabled){
        if(questions[questionNumber].questionInputType=="text"){
            questionDescription.innerHTML = questions[questionNumber].questionText;
            answersHolder.innerHTML="";
            var questionInput = document.createElement("input");           
            questionInput.id="questionInput";
            questionInput.type = questions[questionNumber].questionInputType;
            questionInput.placeholder="Enter your answer here";
            answersHolder.appendChild(questionInput);
        }
        else if(questions[questionNumber].questionInputType=="radio"){
            questionDescription.innerHTML = questions[questionNumber].questionText;
            answersHolder.innerHTML = questions[questionNumber].questionInnerHTML;
        }
        submit.disabled = false;
        questionNumber++;
        qnumber.textContent= "Question " + questionNumber;
        console.log(`Q ${questionNumber}`);
    }
    else{
        alert("submit your answer before going to next question");
    }

    if(questionNumber==questions.length){   
        nextButton.remove();
        div1.appendChild(finishButton);    
    }
    questionValidator();
}

function finishQuiz(){   // this function is called when user clicks finish button
    if(submit.disabled){
        sect1.remove();
        sect2.remove();
        document.body.appendChild(finishDiv);
        finishPara.innerHTML = `Congratulations, you finished the quiz with a score of <b>${score}</b> out of <b>10</b>`;
        finishDiv.appendChild(finishPara);
        finishDiv.appendChild(restartButton);
        questionNumber = 1;
        addSection();  // add navigation list  (file; elementCreator.js)
        
    }
    else{
        alert("submit your answer before finishing the quiz");
    }
}

function restartQuiz(){  // this function is called when user clicks finish button
    score = 0;
    questionNumber = 1;
    console.log(questionNumber);
    restartButton.remove();
    finishPara.remove();
    finishDiv.remove();
    finishButton.remove();

    document.body.appendChild(sect1);
    document.body.appendChild(sect2);
    sect1.appendChild(header1);
    sect1.appendChild(maindesc);
    sect2.appendChild(qnumber);
    sect2.appendChild(div1);
    div1.appendChild(questionDescription);
    div1.appendChild(answersHolder);
    div1.appendChild(submit);
    div1.appendChild(nextButton);
    answersHolder.innerHTML = questions[questionNumber-1].questionInnerHTML;
    submit.disabled=false;
    qnumber.textContent=`Question ${questionNumber}`;
    questionDescription.innerHTML = questions[questionNumber-1].questionText;
    questionValidator();
    removeSection();   // remove navigation list 
}

// the "change" event is an event that occurs when the value of an <input>, <select>, or <textarea> element has been changed by the user.
// event.target.value;   Access the value property of the element that triggered the event
