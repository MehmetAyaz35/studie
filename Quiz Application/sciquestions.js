const questions = [
    {
        questionText: "Which planet is known as the 'Red Planet'?",
        questionInputType: "radio",
        questionInnerHTML: `
        <label>
        <input type="radio" name="question" class="right" id="0">
        Mars
        </label>
        <label>
        <input type="radio" name="question" class="wrong" id="1">
        Venus
        </label>
        <label>
        <input type="radio" name="question" class="wrong" id="2">
        Jupiter
        </label>
        <label>
        <input type="radio" name="question" class="wrong" id="3">
        Saturn
        </label>
        `,
    },
    {
      questionText: "What is the chemical symbol for water?",
      questionInputType: "text",
      questionAnswer: "h2o",
    },
    {
        questionText: "What is the process by which plants make their own food?",
        questionInputType: "radio",
        questionInnerHTML: `
          <label>
            <input type="radio" name="question" class="right" id="0">
            Photosynthesis
          </label>
          <label>
            <input type="radio" name="question" class="wrong" id="1">
            Respiration
          </label>
          <label>
            <input type="radio" name="question" class="wrong" id="2">
            Transpiration
          </label>
          <label>
            <input type="radio" name="question" class="wrong" id="3">
            Fermentation
          </label>
        `,
      },
    {
      questionText: "In physics, what does E=mc^2 stand for?",
      questionInputType: "text",
      questionAnswer: "energy-mass equivalence",
    },
    {
      questionText: "What is the smallest unit of matter?",
      questionInputType: "radio",
      questionInnerHTML: `
        <label>
          <input type="radio" name="question" class="wrong" id="0">
          Proton
          </label>
          <label>
          <input type="radio" name="question" class="wrong" id="1">
          Molecule
          </label>
          <label>
          <input type="radio" name="question" class="right" id="2">
          Atom
        </label>
        <label>
          <input type="radio" name="question" class="wrong" id="3">
          Electron
        </label>
      `,
    },
    {
      questionText: "Which gas do plants absorb from the atmosphere during photosynthesis?",
      questionInputType: "radio",
      questionInnerHTML: `
        <label>
        <input type="radio" name="question" class="wrong" id="0">
        Hydrogen
          </label>
          <label>
          <input type="radio" name="question" class="wrong" id="1">
          Oxygen
          </label>
          <label>
          <input type="radio" name="question" class="wrong" id="2">
          Nitrogen
          </label>
          <label>
          <input type="radio" name="question" class="right" id="3">
          Carbon Dioxide
        </label>
      `,
    },
    {
    questionText: "What is the main component of the Earth's atmosphere?",
    questionInputType: "text",
    questionAnswer: "nitrogen",
    },
    {
        questionText: "What is the name of the phenomenon where light bends as it passes through different mediums?",
        questionInputType: "radio",
        questionInnerHTML: `
          <label>
            <input type="radio" name="question" class="right" id="0">
            Refraction
          </label>
          <label>
            <input type="radio" name="question" class="wrong" id="1">
            Reflection
          </label>
          <label>
            <input type="radio" name="question" class="wrong" id="2">
            Diffraction
          </label>
          <label>
            <input type="radio" name="question" class="wrong" id="3">
            Dispersion
          </label>
        `,
      },
    {
    questionText: "What is the largest mammal on Earth?",
    questionInputType: "text",
    questionAnswer: "blue whale",
    },
    {
    questionText: "Which scientist is known for his theory of evolution by natural selection?",
    questionInputType: "radio",
    questionInnerHTML: `
        <label>
          <input type="radio" name="question" class="wrong" id="0">
          Newton
          </label>
          <label>
          <input type="radio" name="question" class="right" id="1">
          Darwin
        </label>
        <label>
          <input type="radio" name="question" class="wrong" id="2">
          Einstein
        </label>
        <label>
          <input type="radio" name="question" class="wrong" id="3">
          Pasteur
        </label>
      `,
    },
  ];
  