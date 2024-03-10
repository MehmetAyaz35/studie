DELIMITER $$

CREATE DEFINER=`root`@`localhost` TRIGGER `check_bud_limits` BEFORE INSERT ON `auktionsbud` FOR EACH ROW BEGIN
    -- if you write word "utgångspris" for DECLARE it causes a problem. MySQL treats variable names with non-ASCII characters differently, and there could be issues with character encoding or recognition.
    -- Be careful to give a different name when declaring anything.If you write acceptpris as a declare, the code will probably not work because it will be confused with the attribute Acceptpris.
    DECLARE start_price DECIMAL(10,2);
    DECLARE accept_price DECIMAL(10,2);
    
    -- Fetching Utgångspris and Acceptpris values from related auktion
    SELECT Utgångspris, Acceptpris INTO start_price, accept_price
    FROM projektarbete4.auktion
    WHERE AuktionID = NEW.AuktionID;
    
    -- Checking if the bid is within the price limits
    IF NEW.Bud < start_price OR NEW.Bud > accept_price THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Bid is outside the price limits.';
    END IF;
END $$

DELIMITER ;