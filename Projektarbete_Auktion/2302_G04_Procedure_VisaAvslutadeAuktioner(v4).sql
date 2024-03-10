DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `VisaAvslutadeAuktioner`(
    IN startdatum_param DATETIME,
    IN slutdatum_param DATETIME
)
BEGIN
    CREATE TEMPORARY TABLE IF NOT EXISTS TempAvslutadeAuktioner (
        AuktionID INT,
        StartDatum DATETIME,
        SlutDatum DATETIME,
        Provision DECIMAL(10,2)
    );

    INSERT INTO TempAvslutadeAuktioner (AuktionID, StartDatum, SlutDatum, Provision)
    SELECT 
        ah.AuktionID,
        ah.StartDatum,
        ah.SlutDatum,
        ah.Provision
    FROM 
        projektarbete4.auktionshistorik ah
    WHERE 
        ah.SlutDatum BETWEEN startdatum_param AND slutdatum_param;
        
         INSERT INTO TempAvslutadeAuktioner (AuktionID, StartDatum, SlutDatum)
    SELECT 
        us.AuktionID,
        us.StartDatum,
        us.SlutDatum
    FROM 
        projektarbete4.unsold us
    WHERE 
        us.SlutDatum BETWEEN startdatum_param AND slutdatum_param;
        
    SELECT * FROM TempAvslutadeAuktioner;

    DROP TEMPORARY TABLE IF EXISTS TempAvslutadeAuktioner;
END $$

DELIMITER ;