const topicSelector = ["math", "sci", "tech", "hist"];  // We create an array with strings inside that are identical to the ids of the div elements that we created for each (topic).html Note that we created these div elements only for this purpose 
const links = ["math.html", "sci.html", "tech.html", "hist.html"]; // We create an array of file names to later assign anchor (<a>) hrefs
const topics = ["Mathematics Quiz", "Science Quiz", "Technology Quiz", "History Quiz"]; // We create an array of topic descriptions to later assign anchor (<a>) texts
const listItems = [li1, li2, li3]; // this is an array of list items which we will later assign innerHTML property to 
// Note that the order of topics for topicSelector, links and topics is the same otherwise code below will not work (7-19)

for (let i = 0; i < topicSelector.length; i++) {  // repeat the code below topicSelector.length times
    if(document.getElementById(topicSelector[i])){ // If string in index i exists the code below will be executed (8-18)
        let removedItemDesc = topics[i]; // assign string in index i of topics to a variable to later add to the list after we remove it
        let removedItemLink = links[i]; // assign string in index i of links to a variable to later add to the list after we remove it
        topics.splice(i,1); // remove 1 item from topics starting from index i 
        links.splice(i,1); // remove 1 item from links starting from index i 
        for(let j = 0; j< listItems.length; j++){ // repeat the code below topicSelector.length times
            listItems[j].innerHTML=`<a href=${links[j]}>Go to ${topics[j]}`;  // Set innerHTML of index i in listItems equal to `<a href= to index j in links and index j in topics
        }
        topics.splice(i,0,removedItemDesc); // remove 0 item from topics starting from index i and add removedItemDesc
        links.splice(i,0,removedItemLink); // remove 0 item from links starting from index i and add removedItemLink
    }
}


document.body.addEventListener('keydown', function(event){ // If pushed enter anywhere on the page
    if(event.key==="Enter"){
        if(nextButton){ // if next button exists
        nextQuestion();
        }
        else if(finishButton){ // else if finishButton exists
        finishQuiz();
        }
        else{
        restartQuiz();
        }
    }
})



document.body.appendChild(sect2); // We add section 2 inside body
sect2.appendChild(qnumber); // Since we already have a section 2 inside the body we can now add relevant elements to section 2
sect2.appendChild(div1); // We add div1 inside section 2
div1.appendChild(questionDescription); 
div1.appendChild(answersHolder);
div1.appendChild(submit);
div1.appendChild(nextButton);
//  Deploying question 1 based on its type 
if(questions[questionNumber-1].questionInputType=="text"){  
    questionDescription.innerHTML = questions[questionNumber-1].questionText;
    answersHolder.innerHTML="";
    var questionInput = document.createElement("input");
    questionInput.id="questionInput";
    questionInput.type = questions[questionNumber-1].questionInputType;
    questionInput.placeholder="Enter your answer here";
    answersHolder.appendChild(questionInput);
}
if(questions[questionNumber-1].questionInputType=="radio"){    // else
    questionDescription.innerHTML = questions[questionNumber-1].questionText;
    answersHolder.innerHTML = questions[questionNumber-1].questionInnerHTML;
}
questionValidator(); // Function for validating both input type text and input type radio questions.
console.log(questionNumber);