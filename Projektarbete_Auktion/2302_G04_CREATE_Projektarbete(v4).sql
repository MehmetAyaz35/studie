-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema projektarbete4
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema projektarbete4
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `projektarbete4` DEFAULT CHARACTER SET utf8mb3 ;
USE `projektarbete4` ;

-- -----------------------------------------------------
-- Table `projektarbete4`.`leverantör`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projektarbete4`.`leverantör` (
  `LeverantörID` INT NOT NULL AUTO_INCREMENT,
  `Namn` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`LeverantörID`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `projektarbete4`.`produkt`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projektarbete4`.`produkt` (
  `ProduktID` INT NOT NULL AUTO_INCREMENT,
  `Provision` DECIMAL(10,2) NOT NULL,
  `Kategori` VARCHAR(45) NOT NULL,
  `Leverantör_LeverantörID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`ProduktID`),
  INDEX `fk_Product_Leverantör1_idx` (`Leverantör_LeverantörID` ASC) VISIBLE,
  CONSTRAINT `fk_Product_Leverantör1`
    FOREIGN KEY (`Leverantör_LeverantörID`)
    REFERENCES `projektarbete4`.`leverantör` (`LeverantörID`)
    ON DELETE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `projektarbete4`.`auktion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projektarbete4`.`auktion` (
  `AuktionID` INT NOT NULL AUTO_INCREMENT,
  `StartDatum` DATETIME NOT NULL,
  `SlutDatum` DATETIME NOT NULL,
  `ProduktID` INT NOT NULL,
  `Utgångspris` DECIMAL(10,2) NOT NULL,
  `Acceptpris` DECIMAL(10,2) NULL DEFAULT NULL,
  `isBid` TINYINT NOT NULL DEFAULT '0',
  `maxBid` INT NULL DEFAULT '0',
  `highestbidder` BIGINT NULL DEFAULT NULL,
  PRIMARY KEY (`AuktionID`),
  INDEX `fk_auktion_produkt1_idx` (`ProduktID` ASC) VISIBLE,
  CONSTRAINT `fk_auktion_produkt1`
    FOREIGN KEY (`ProduktID`)
    REFERENCES `projektarbete4`.`produkt` (`ProduktID`)
    ON DELETE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `projektarbete4`.`kund`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projektarbete4`.`kund` (
  `Personnummer` BIGINT NOT NULL,
  `Förnamn` VARCHAR(45) NULL DEFAULT NULL,
  `Efternamn` VARCHAR(45) NULL DEFAULT NULL,
  `Address` VARCHAR(45) NULL DEFAULT NULL,
  `Telefonnummer` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`Personnummer`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `projektarbete4`.`auktionsbud`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projektarbete4`.`auktionsbud` (
  `AuktionsbudID` INT NOT NULL AUTO_INCREMENT,
  `Bud` DECIMAL(10,2) NOT NULL,
  `Tidsstämpel` TIMESTAMP NULL DEFAULT NULL,
  `AuktionID` INT NOT NULL,
  `kund_Personnummer` BIGINT NOT NULL,
  PRIMARY KEY (`AuktionsbudID`),
  INDEX `fk_Auktionsbud_Auktion1_idx` (`AuktionID` ASC) VISIBLE,
  INDEX `fk_auktionsbud_kund1_idx` (`kund_Personnummer` ASC) VISIBLE,
  CONSTRAINT `fk_Auktionsbud_Auktion1`
    FOREIGN KEY (`AuktionID`)
    REFERENCES `projektarbete4`.`auktion` (`AuktionID`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_auktionsbud_kund1`
    FOREIGN KEY (`kund_Personnummer`)
    REFERENCES `projektarbete4`.`kund` (`Personnummer`)
    ON DELETE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `projektarbete4`.`auktionshistorik`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projektarbete4`.`auktionshistorik` (
  `Slutgiltigt pris` DECIMAL(10,2) NULL DEFAULT NULL,
  `Tidsstämpel` TIMESTAMP NULL DEFAULT NULL,
  `AuktionID` INT NOT NULL,
  `StartDatum` DATETIME NULL DEFAULT NULL,
  `SlutDatum` DATETIME NULL DEFAULT NULL,
  `ProduktID` INT NULL DEFAULT NULL,
  `Provision` DECIMAL(10,2) NULL DEFAULT NULL,
  `highestbidder` BIGINT NULL DEFAULT NULL,
  PRIMARY KEY (`AuktionID`),
  INDEX `fk_ProduktID_idx` (`ProduktID` ASC) VISIBLE,
  INDEX `fk_highestbidder_idx` (`highestbidder` ASC) VISIBLE,
  CONSTRAINT `fk_highestbidder`
    FOREIGN KEY (`highestbidder`)
    REFERENCES `projektarbete4`.`kund` (`Personnummer`),
  CONSTRAINT `fk_ProduktID`
    FOREIGN KEY (`ProduktID`)
    REFERENCES `projektarbete4`.`produkt` (`ProduktID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `projektarbete4`.`email_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projektarbete4`.`email_table` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `message` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id` (`id` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `projektarbete4`.`unsold`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projektarbete4`.`unsold` (
  `AuktionID` INT NOT NULL,
  `StartDatum` DATETIME NULL DEFAULT NULL,
  `SlutDatum` DATETIME NULL DEFAULT NULL,
  `ProduktID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`AuktionID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

USE `projektarbete4` ;

-- -----------------------------------------------------
-- Placeholder table for view `projektarbete4`.`kundlista_med_ordervärde`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projektarbete4`.`kundlista_med_ordervärde` (`Kund` INT, `Ordervärde` INT);

-- -----------------------------------------------------
-- Placeholder table for view `projektarbete4`.`pagaendeauktionersomlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projektarbete4`.`pagaendeauktionersomlist` (`AuktionID` INT, `StartDatum` INT, `SlutDatum` INT, `ProduktID` INT, `Utgångspris` INT, `Acceptpris` INT, `Högstabud` INT, `Kund` INT);

-- -----------------------------------------------------
-- Placeholder table for view `projektarbete4`.`total_provisionen_per_manad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projektarbete4`.`total_provisionen_per_manad` (`År` INT, `Månad` INT, `Total_Provision` INT);

-- -----------------------------------------------------
-- procedure RegisterProdukt
-- -----------------------------------------------------

DELIMITER $$
USE `projektarbete4`$$
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
    
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SkapaAuktion
-- -----------------------------------------------------

DELIMITER $$
USE `projektarbete4`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SkapaAuktion`(
    IN p_produktID INT,
    IN p_utgangspris DECIMAL(10,2),
    IN p_acceptpris DECIMAL(10,2),
    IN p_startdatum DATETIME,
    IN p_slutdatum DATETIME
)
BEGIN
    -- Belirli bir ürün ID'sine sahip açık artırma kaydının varlığını kontrol et
    IF NOT EXISTS (SELECT AuktionID FROM projektarbete4.auktion WHERE ProduktID = p_produktID) THEN
        -- Eğer belirli bir ürün ID'sine sahip açık artırma kaydı yoksa, yeni bir kayıt ekle
        INSERT INTO projektarbete4.auktion (ProduktID, Utgångspris, Acceptpris, StartDatum, SlutDatum)
		VALUES (p_produktID, p_utgangspris, p_acceptpris, p_startdatum, p_slutdatum);
    ELSE
        -- Eğer belirli bir ürün ID'sine sahip açık artırma kaydı varsa, hata sinyali gönder
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'An auktion with this produktID already exists.';
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure VisaAvslutadeAuktioner
-- -----------------------------------------------------

DELIMITER $$
USE `projektarbete4`$$
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
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure VisaBudhistorik
-- -----------------------------------------------------

DELIMITER $$
USE `projektarbete4`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `VisaBudhistorik`(
    IN auktionID_p INT
)
BEGIN
    -- Skapa en temporär tabell för att lagra budhistoriken
    CREATE TEMPORARY TABLE IF NOT EXISTS TempBudhistorik (
        BudID INT,
        Bud DECIMAL(10,2),
        KundPersonnummer BIGINT,
        KundFornamn VARCHAR(45),
        KundEfternamn VARCHAR(45),
        Tidsstämpel TIMESTAMP
    );

    -- Fyll temporär tabell med budhistoriken för den angivna auktionen
    INSERT INTO TempBudhistorik (BudID, Bud, KundPersonnummer, KundFornamn, KundEfternamn, Tidsstämpel)
    SELECT 
        ab.AuktionsbudID,
        ab.Bud,
        k.Personnummer,
        k.Förnamn,
        k.Efternamn,
        ab.Tidsstämpel
    FROM 
        projektarbete4.auktionsbud ab
    JOIN 
        projektarbete4.kund k ON ab.kund_Personnummer = k.Personnummer
    WHERE 
        ab.AuktionID = auktionID_p;

    -- Visa budhistoriken
    SELECT * FROM TempBudhistorik;

    -- Rensa temporär tabell
    DROP TEMPORARY TABLE IF EXISTS TempBudhistorik;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function checkForBids
-- -----------------------------------------------------

DELIMITER $$
USE `projektarbete4`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `checkForBids`(auctionid INT) RETURNS tinyint(1)
    READS SQL DATA
BEGIN
    DECLARE rows_count INT;
    
    -- Count the number of rows in auktionsbud for the given auctionid
    SELECT COUNT(*) INTO rows_count
    FROM auktionsbud
    WHERE Auktion_AuktionID = auctionid;
    
    -- Check if there are any bids
    IF rows_count > 0 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `projektarbete4`.`kundlista_med_ordervärde`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `projektarbete4`.`kundlista_med_ordervärde`;
USE `projektarbete4`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `projektarbete4`.`kundlista_med_ordervärde` AS select `projektarbete4`.`auktionshistorik`.`highestbidder` AS `Kund`,sum(`projektarbete4`.`auktionshistorik`.`Slutgiltigt pris`) AS `Ordervärde` from `projektarbete4`.`auktionshistorik` group by `projektarbete4`.`auktionshistorik`.`highestbidder`;

-- -----------------------------------------------------
-- View `projektarbete4`.`pagaendeauktionersomlist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `projektarbete4`.`pagaendeauktionersomlist`;
USE `projektarbete4`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `projektarbete4`.`pagaendeauktionersomlist` AS select `a`.`AuktionID` AS `AuktionID`,`a`.`StartDatum` AS `StartDatum`,`a`.`SlutDatum` AS `SlutDatum`,`p`.`ProduktID` AS `ProduktID`,`a`.`Utgångspris` AS `Utgångspris`,`a`.`Acceptpris` AS `Acceptpris`,ifnull(max(`ab`.`Bud`),0) AS `Högstabud`,(select `projektarbete4`.`auktionsbud`.`kund_Personnummer` from `projektarbete4`.`auktionsbud` where ((`projektarbete4`.`auktionsbud`.`Bud` = max(`ab`.`Bud`)) and (`a`.`AuktionID` = `ab`.`AuktionID`)) limit 1) AS `Kund` from ((`projektarbete4`.`auktion` `a` left join `projektarbete4`.`produkt` `p` on((`a`.`ProduktID` = `p`.`ProduktID`))) left join `projektarbete4`.`auktionsbud` `ab` on((`a`.`AuktionID` = `ab`.`AuktionID`))) where (now() between `a`.`StartDatum` and `a`.`SlutDatum`) group by `a`.`AuktionID`,`a`.`StartDatum`,`a`.`SlutDatum`,`a`.`Utgångspris`,`a`.`Acceptpris`,`p`.`ProduktID`;

-- -----------------------------------------------------
-- View `projektarbete4`.`total_provisionen_per_manad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `projektarbete4`.`total_provisionen_per_manad`;
USE `projektarbete4`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `projektarbete4`.`total_provisionen_per_manad` AS select year(`ah`.`StartDatum`) AS `År`,month(`ah`.`StartDatum`) AS `Månad`,sum(`p`.`Provision`) AS `Total_Provision` from (`projektarbete4`.`auktionshistorik` `ah` join `projektarbete4`.`produkt` `p` on((`ah`.`ProduktID` = `p`.`ProduktID`))) group by year(`ah`.`StartDatum`),month(`ah`.`StartDatum`) order by `År`,`Månad`;
USE `projektarbete4`;

DELIMITER $$
USE `projektarbete4`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `projektarbete4`.`auktion_AFTER_DELETE`
AFTER DELETE ON `projektarbete4`.`auktion`
FOR EACH ROW
BEGIN

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

END$$

USE `projektarbete4`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `projektarbete4`.`auktionsbud_AFTER_INSERT`
AFTER INSERT ON `projektarbete4`.`auktionsbud`
FOR EACH ROW
BEGIN
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
   
END$$

USE `projektarbete4`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `projektarbete4`.`check_bud_limits`
BEFORE INSERT ON `projektarbete4`.`auktionsbud`
FOR EACH ROW
BEGIN
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
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;