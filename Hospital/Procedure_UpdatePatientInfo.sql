Delimiter $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdatePatientInfo`(
    IN p_PatientID INT,
    IN p_Förnamn VARCHAR(50),
    IN p_Efternamn VARCHAR(50),
    IN p_Ålder INT,
    IN p_Kön VARCHAR(10),
    IN p_Telefonnummer VARCHAR(15),
    IN p_Adress VARCHAR(100)
)
BEGIN
    UPDATE patient
    SET 
        Förnamn = p_Förnamn,
        Efternamn = p_Efternamn,
        Ålder = p_Ålder,
        Kön = p_Kön,
        Telefonnummer = p_Telefonnummer,
        Adress = p_Adress
    WHERE PatientID = p_PatientID;
END $$

Delimiter ;