const questions = [ // This array is an array of objects, objects are questions in this case.
                    // Some properties of objects in this array are: questionText, questionInputType, questionInnerHTML, questionAnswer

                    // Explanation of propertios of the objects, realize some of the objects have questionInnerHTML and some have questionAnswer

                    // questionText: We use this property to set the text of the question (in the HTML this is: #questionDescription)

                    // questionInputType: We use this property to detect which input type the question has, in this project there are 2:
                    // (input type radio and input type text), later in logicApplication.js ln: 137 and 146, we use this
                    // property to decide which format we should use.

                    // questionInnerHTML: This property exists only for input type radio questions, since it's complicated to add each radio separately,
                    // we take advantage of innerHTML property of DOM objects by assigning them this property (which includes everything we need
                    // for the logic process.)

                    // questionAnswer: This property exists only for input type text questions, we use this property
                    // to compare users' input with the correct answer for the question in logicApplication.js lines: 118-129.
    {
        questionText: "If 3x-7=8, what is x?",
        questionInputType: "radio",
        questionInnerHTML: `
        <label>
        <input type="radio" name="question" class="right" id="0">
        5
        </label>
        <label>
        <input type="radio" name="question" class="wrong" id="1">
        6
        </label>
        <label>
        <input type="radio" name="question" class="wrong" id="2">
        7
        </label>
        <label>
        <input type="radio" name="question" class="wrong" id="3">
        8
        </label>
    `
    },
    {
        questionText: "What is the sum of every even number from 0 to 10?",
        questionInputType: "text",
        questionAnswer: 30
    },
    {
        questionInputType: "radio",
        questionText: "5x = 100",
        questionInnerHTML: `
        <label>
        <input type="radio" name="question" class="wrong" id="0">
        10
        </label>
        <label>
        <input type="radio" name="question" class="wrong" id="1">
        15
        </label>
        <label>
        <input type="radio" name="question" class="right" id="2">
        20
        </label>
        <label>
        <input type="radio" name="question" class="wrong" id="3">
        25
        </label>
    `
    },
    
    {
        questionInputType: "text",
        questionText: "Factorize the quadratic expression(don't use whitespaces and *):<br>x<sup>2</sup> - 5x + 6",
        questionAnswer:"(x-2)(x-3)"
    },

    {
        questionInputType: "radio",
        questionText: "x=20, 3x=?",
        questionInnerHTML: `
        <label>
        <input type="radio" name="question" class="wrong" id="0">
        100
        </label>
        <label>
        <input type="radio" name="question" class="wrong" id="1">
        80
        </label>
        <label>
        <input type="radio" name="question" class="right" id="2">
        60
        </label>
        <label>
        <input type="radio" name="question" class="wrong" id="3">
        40
        </label>
    `
    },
    {
        questionInputType: "text",
        questionText: "Solve for x:<br>3x - 7 = 2x + 10",
        questionAnswer:17
    },

    {
        questionInputType: "radio",
        questionText: "2x=14, which option is equal to 49?",
        questionInnerHTML:`
        <label>
        <input type="radio" name="question" class="wrong" id="0">
        9x
        </label>
        <label>
        <input type="radio" name="question" class="right" id="1">
        7x
        </label>
        <label>
        <input type="radio" name="question" class="wrong" id="2">
        5x
        </label>
        <label>
        <input type="radio" name="question" class="wrong" id="3">
        3x
        </label>
    `

    },
    {
        questionInputType: "text",
        questionText: "Simplify the expression (don't use whitespaces):<br>4(x + 2) - 2(3x - 1)",
        questionAnswer:"-2x+10"

    },

    {
        questionInputType: "radio",
        questionText: "a+b= 15, a-b = 11, a*b?",
        questionInnerHTML:`
        <label>
        <input type="radio" name="question" class="wrong" id="0">
        15
        </label>
        <label>
        <input type="radio" name="question" class="right" id="1">
        26
        </label>
        <label>
        <input type="radio" name="question" class="wrong" id="2">
        62
        </label>
        <label>
        <input type="radio" name="question" class="wrong" id="3">
        81
        </label>
    `

    },

    {
        questionInputType: "radio",
        questionText: "a and b are positive integers, a+b=10, a*b = 9, what is |a-b|?",
        questionInnerHTML:`
        <label>
        <input type="radio" name="question" class="wrong" id="0">
        0
        </label>
        <label>
        <input type="radio" name="question" class="wrong" id="1">
        1
        </label>
        <label>
        <input type="radio" name="question" class="wrong" id="2">
        4
        </label>
        <label>
        <input type="radio" name="question" class="right" id="3">
        8
        </label>
    `
    },

];