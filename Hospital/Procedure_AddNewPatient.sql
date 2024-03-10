Delimiter $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddNewPatient`(
    IN p_Förnamn VARCHAR(50),
    IN p_Efternamn VARCHAR(50),
    IN p_Ålder INT,
    IN p_Kön VARCHAR(10),
    IN p_Telefonnummer VARCHAR(15),
    IN p_Adress VARCHAR(100)
)
BEGIN
    INSERT INTO patient (Förnamn, Efternamn, Ålder, Kön, Telefonnummer, Adress)
    VALUES (p_Förnamn, p_Efternamn, p_Ålder, p_Kön, p_Telefonnummer, p_Adress);
END $$

Delimiter ;