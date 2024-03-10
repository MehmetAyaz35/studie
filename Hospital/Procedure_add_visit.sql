Delimiter $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_visit`(IN p_patientID INT, IN p_läkareID INT, IN p_poliklinikID INT, IN p_besöksdatum DATE, IN p_diagnos VARCHAR(100))
BEGIN
    INSERT INTO besök (PatientID, LäkareID, PoliklinikID, Besöksdatum, Diagnos)
    VALUES (p_patientID, p_läkareID, p_poliklinikID, p_besöksdatum, p_diagnos);
END $$
Delimiter ;
