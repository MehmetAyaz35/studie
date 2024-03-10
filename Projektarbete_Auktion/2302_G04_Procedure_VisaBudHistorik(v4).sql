DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `VisaBudhistorik`(
    IN auktionID_p INT
)
BEGIN
    -- Skapa en temporär tabell för att lagra budhistoriken
    CREATE TEMPORARY TABLE IF NOT EXISTS TempBudhistorik (
        BudID INT,
        Bud DECIMAL(10,2),
        KundPersonnummer BIGINT,
        KundFornamn VARCHAR(45),
        KundEfternamn VARCHAR(45),
        Tidsstämpel TIMESTAMP
    );

    -- Fyll temporär tabell med budhistoriken för den angivna auktionen
    INSERT INTO TempBudhistorik (BudID, Bud, KundPersonnummer, KundFornamn, KundEfternamn, Tidsstämpel)
    SELECT 
        ab.AuktionsbudID,
        ab.Bud,
        k.Personnummer,
        k.Förnamn,
        k.Efternamn,
        ab.Tidsstämpel
    FROM 
        projektarbete4.auktionsbud ab
    JOIN 
        projektarbete4.kund k ON ab.kund_Personnummer = k.Personnummer
    WHERE 
        ab.AuktionID = auktionID_p;

    -- Visa budhistoriken
    SELECT * FROM TempBudhistorik;

    -- Rensa temporär tabell
    DROP TEMPORARY TABLE IF EXISTS TempBudhistorik;
END $$

DELIMITER ;