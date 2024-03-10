DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `RegisterProdukt`(
    IN p_Provision DECIMAL(10,2),
    IN p_Kategori VARCHAR(45),
    IN p_LeverantörID INT
)
BEGIN
    
    IF NOT EXISTS (SELECT LeverantörID FROM leverantör WHERE LeverantörID = p_LeverantörID) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The specified LeverantID does not exist.';
    ELSE
        INSERT INTO projektarbete4.produkt (Provision, Kategori, Leverantör_LeverantörID)
		VALUES (p_Provision, p_Kategori, p_LeverantörID);
    END IF;
    
END $$
DELIMITER ;