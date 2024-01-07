const questions = [
    {
      questionText: "Who was the first President of the United States?",
      questionInputType: "radio",
      questionInnerHTML: `
        <label>
          <input type="radio" name="question" class="right" id="0">
          George Washington
        </label>
        <label>
          <input type="radio" name="question" class="wrong" id="1">
          Thomas Jefferson
        </label>
        <label>
          <input type="radio" name="question" class="wrong" id="2">
          John Adams
        </label>
        <label>
          <input type="radio" name="question" class="wrong" id="3">
          Abraham Lincoln
        </label>
      `,
    },
    {
      questionText: "What ancient civilization built the pyramids? (2 words)",
      questionInputType: "text",
      questionAnswer: "ancient egypt",
    },
    {
      questionText: "Which country was divided by the Berlin Wall during the Cold War?",
      questionInputType: "radio",
      questionInnerHTML: `
        <label>
          <input type="radio" name="question" class="right" id="0">
          Germany
        </label>
        <label>
          <input type="radio" name="question" class="wrong" id="1">
          France
        </label>
        <label>
          <input type="radio" name="question" class="wrong" id="2">
          Russia
        </label>
        <label>
          <input type="radio" name="question" class="wrong" id="3">
          Italy
        </label>
      `,
    },
    {
      questionText: "What event marked the beginning of World War II? (2 words)",
      questionInputType: "text",
      questionAnswer: "german invasion",
    },
    {
      questionText: "Who wrote the Declaration of Independence for the United States? (2 words)",
      questionInputType: "text",
      questionAnswer: "thomas jefferson",
    },
    {
      questionText: "Which war is also known as the Great War?",
      questionInputType: "radio",
      questionInnerHTML: `
        <label>
          <input type="radio" name="question" class="right" id="0">
          World War I
        </label>
        <label>
          <input type="radio" name="question" class="wrong" id="1">
          World War II
        </label>
        <label>
          <input type="radio" name="question" class="wrong" id="2">
          Korean War
        </label>
        <label>
          <input type="radio" name="question" class="wrong" id="3">
          Vietnam War
        </label>
      `,
    },
    {
      questionText: "What ancient city was known for its Hanging Gardens?",
      questionInputType: "text",
      questionAnswer: "babylon",
    },
    {
      questionText: "Who was the leader of the civil rights movement in the United States?",
      questionInputType: "text",
      questionAnswer: "martin luther king",
    },
    {
      questionText: "Which European explorer reached the Americas in 1492?",
      questionInputType: "radio",
      questionInnerHTML: `
        <label>
          <input type="radio" name="question" class="right" id="0">
          Christopher Columbus
        </label>
        <label>
          <input type="radio" name="question" class="wrong" id="1">
          Ferdinand Magellan
        </label>
        <label>
          <input type="radio" name="question" class="wrong" id="2">
          Vasco da Gama
        </label>
        <label>
          <input type="radio" name="question" class="wrong" id="3">
          Marco Polo
        </label>
      `,
    },
    {
      questionText: "What treaty ended World War I? (3 worlds)",
      questionInputType: "text",
      questionAnswer: "treaty of versailles",
    },
  ];
  