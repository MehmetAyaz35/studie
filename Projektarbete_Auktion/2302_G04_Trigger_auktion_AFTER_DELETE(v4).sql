DELIMITER $$

CREATE DEFINER=`root`@`localhost` TRIGGER `auktion_AFTER_DELETE` AFTER DELETE ON `auktion` FOR EACH ROW BEGIN

declare provision_p DECIMAL(10,2);
select Provision into provision_p from produkt where ProduktID = old.ProduktID;

IF old.isBid = 1 THEN
        INSERT INTO auktionshistorik (`Slutgiltigt pris`, Tidsstämpel, AuktionID, StartDatum, SlutDatum, Provision, ProduktID, highestbidder)
        VALUES (old.maxBid, CURRENT_TIMESTAMP, old.AuktionID, old.StartDatum, old.SlutDatum, provision_p, old.ProduktID, old.highestbidder);
    ELSE
        -- If there are no bids, mark the item as unsold
        INSERT INTO unsold (AuktionID, StartDatum, SlutDatum, ProduktID) 
        VALUES (OLD.AuktionID, OLD.StartDatum, OLD.SlutDatum, Old.ProduktID);
        -- Notify via email that the product has not been sold
        INSERT INTO email_table (message) 
        VALUES (CONCAT('Product with AuctionID ', OLD.AuktionID, ' has not been sold.'));
    END IF;

END $$

DELIMITER ;