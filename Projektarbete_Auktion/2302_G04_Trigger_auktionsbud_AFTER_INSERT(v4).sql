DELIMITER $$

CREATE DEFINER=`root`@`localhost` TRIGGER `auktionsbud_AFTER_INSERT` AFTER INSERT ON `auktionsbud` FOR EACH ROW BEGIN
	DECLARE max_bid INT;
	DECLARE end_date TIMESTAMP;
    DECLARE accept_price DECIMAL(10,2);
    
	UPDATE auktion 
    SET highestbidder = NEW.kund_Personnummer 
    WHERE auktionID = NEW.auktionID AND (highestbidder IS NULL OR NEW.bud > maxBid);
    
    select maxBid into max_bid from auktion where AuktionID = new.AuktionID;
    select SlutDatum into end_date from auktion where AuktionID = new.AuktionID;
    select Acceptpris into accept_price from auktion where AuktionID = new.AuktionID;
    update auktion set isBid = 1 where AuktionID = new.AuktionID; 
    
    if new.Bud = accept_price then
    update auktion set maxBid = new.Bud where AuktionID = new.AuktionID; 
    update auktion set Slutdatum = current_timestamp where AuktionID = new.AuktionID;
    end if;
    
    -- If the new bid is higher than the current maximum bid value, it updates the maximum bid value in the auktion table with the new bid value.
    if new.Bud > max_bid then
    update auktion set maxBid = new.Bud where AuktionID = new.AuktionID; 
    end if;
   
END $$

DELIMITER ;