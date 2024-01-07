# Laboration 2 - Unit testing med pytest
## LÄS DETTA FÖRST
**Deadline**: 2023/11/24 - 30 minuter innan er redovisning ska er kod vara pushad till github

**Deadline Komplettering 1**: Annonseras på discord. Förvänta er 1 vecka efter originaldatum på en eftermiddag.

**Deadline Komplettering 2**: Annonseras på discord. Förvänta er cirka 2 veckor efter originaldatumet på en eftermiddag.

**Betyg**: U, G, VG - Du kan inte få VG på kompletteringar. Ni bedöms enskilt och inte kollektivt.
För att få G ska ni implementera merparten av testerna, och kunna påvisa grundläggande förståelse för python.

För att få VG ska ni implementera samtliga tester, och dessutom utnyttja en fixture och pytest-cov.
Du ska kunna påvisa en något mer djup förståelse för python, i synnerhet förståelse för klasser och pytest.

## Inlämning
Ta bort alla onödiga filer, din kod bör vara på den huvudsakliga branchen "main" eller "master".
Se till att du körde git clone på din EGEN repository för labben.
Feedback ges via en speciell branch som skapas automatiskt, mer information om detta får du av utbildaren.

## Regler
Laborationen ska göras i grupp / par om 2 personer. Ni förväntas koda tillsammans, dvs. när ni kodar ska ni fysiskt befinna er på samma plats, **eller** koda tillsammans över tex. discord med delade skärmar. Poängen är att ni båda ska vara delaktiga i processen av att lösa problemen.
Det är strikt förbjudet att utnyttja chattbottar / AI-assistans i denna laboration, såsom github copilot eller chatGPT. Ni ska tänka och problemlösa själva.

### Jobba på distans?
Ni kan utnyttja "live share" i vscode, vilket tillåter båda personerna att koda på samma projekt i vscode samtidigt.
Kolla gärna på denna video om liveshare, ifall ni vill jobba digitalt:
https://www.youtube.com/watch?v=A2ceblXTBBc&ab_channel=VisualStudioCode

## Beskrivning:
I denna laboration ska ni öva på unit tests (enhetstester) med hjälp av pytest. Idén är att vi ska skriva små, isolerade tester som säkerställer att en viss kod fungerar korrekt.

Ni har två filer i denna laboration. 

**students.py** innehåller kod för en simpel klass som heter StudentManagementSystem. 
Ni ska inte modifiera någon kod, utan istället ska ni försöka tolka koden. Längst ner i filen ser ni att jag visar hur klassen kan användas. Det är ett mindre system för att jobba med studenter, tex. lägga till studenter, ta bort eller uppdatera. Vissa metoder är kopplade till VG-nivå, vilket ni ser tydligt under metodens beskrivning.

**test_students.py** innehåller en samling enhetstester som **ej implementerats**. Ni ska med hjälp av pytest försöka implementera dessa funktioner, det ska vara simpla enhetstester för att säkerställa att metoderna från students.py fungerar. Dessa tester är ofta väldigt korta, ibland inte mer än 1 rad kod. Försök därför att inte överkomplicera det.

- Ni kommer att använda keywordet "assert" mycket
- Ni kommer att använda "with pytest.raises(NågotException): " väldigt mycket
- Ni kommer att behöva skapa instanser av StudentManagementSystem i varje metod

