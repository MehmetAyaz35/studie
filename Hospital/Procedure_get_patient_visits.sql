Delimiter $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_patient_visits`(IN p_patientID INT)
BEGIN
    SELECT *
    FROM besök
    WHERE PatientID = p_patientID;
END $$

Delimiter ;