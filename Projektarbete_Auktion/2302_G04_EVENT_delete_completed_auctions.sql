Delimiter $$

CREATE DEFINER=`root`@`localhost` EVENT `delete_completed_auctions` 
ON SCHEDULE EVERY 1 SECOND 
ON COMPLETION NOT PRESERVE ENABLE 
DO 
BEGIN 
SET SQL_SAFE_UPDATES = 0; 
DELETE FROM auktion WHERE SlutDatum < CURRENT_TIMESTAMP(); 
SET SQL_SAFE_UPDATES = 1; 
END $$

Delimiter ;