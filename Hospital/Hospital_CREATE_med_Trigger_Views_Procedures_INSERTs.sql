-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema hospital
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hospital
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hospital` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `hospital` ;

-- -----------------------------------------------------
-- Table `hospital`.`patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`patient` (
  `PatientID` INT NOT NULL AUTO_INCREMENT,
  `Förnamn` VARCHAR(50) NULL DEFAULT NULL,
  `Efternamn` VARCHAR(50) NULL DEFAULT NULL,
  `Ålder` INT NULL DEFAULT NULL,
  `Kön` VARCHAR(10) NULL DEFAULT NULL,
  `Telefonnummer` VARCHAR(15) NULL DEFAULT NULL,
  `Adress` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`PatientID`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `hospital`.`läkare`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`läkare` (
  `LäkareID` INT NOT NULL AUTO_INCREMENT,
  `Förnamn` VARCHAR(50) NULL DEFAULT NULL,
  `Efternamn` VARCHAR(50) NULL DEFAULT NULL,
  `Specialitet` VARCHAR(50) NULL DEFAULT NULL,
  `Kön` VARCHAR(10) NULL DEFAULT NULL,
  `Telefonnummer` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`LäkareID`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `hospital`.`poliklinik`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`poliklinik` (
  `PoliklinikID` INT NOT NULL AUTO_INCREMENT,
  `Namn` VARCHAR(100) NULL DEFAULT NULL,
  `Plats` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`PoliklinikID`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `hospital`.`besök`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`besök` (
  `BesöksID` INT NOT NULL AUTO_INCREMENT,
  `PatientID` INT NOT NULL,
  `LäkareID` INT NULL DEFAULT NULL,
  `PoliklinikID` INT NULL DEFAULT NULL,
  `Besöksdatum` DATETIME NOT NULL,
  `Diagnos` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`BesöksID`),
  INDEX `LäkareID` (`LäkareID` ASC) VISIBLE,
  INDEX `PoliklinikID` (`PoliklinikID` ASC) VISIBLE,
  INDEX `besök_ibfk_1` (`PatientID` ASC) VISIBLE,
  CONSTRAINT `besök_ibfk_1`
    FOREIGN KEY (`PatientID`)
    REFERENCES `hospital`.`patient` (`PatientID`),
  CONSTRAINT `besök_ibfk_2`
    FOREIGN KEY (`LäkareID`)
    REFERENCES `hospital`.`läkare` (`LäkareID`),
  CONSTRAINT `besök_ibfk_3`
    FOREIGN KEY (`PoliklinikID`)
    REFERENCES `hospital`.`poliklinik` (`PoliklinikID`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `hospital`.`latest_visit_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`latest_visit_info` (
  `PatientID` INT NOT NULL,
  `LatestVisitDate` DATETIME NULL DEFAULT NULL,
  `LatestDiagnosis` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`PatientID`),
  CONSTRAINT `latest_visit_info_ibfk_1`
    FOREIGN KEY (`PatientID`)
    REFERENCES `hospital`.`patient` (`PatientID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- Lägg till patienter
INSERT INTO patient (Förnamn, Efternamn, Ålder, Kön, Telefonnummer, Adress) VALUES 
('Anna', 'Andersson', 35, 'Kvinna', '0701234567', 'Gata 1, Stad'),
('Erik', 'Bengtsson', 42, 'Man', '0723456789', 'Gata 2, Stad'),
('Maria', 'Carlsson', 28, 'Kvinna', '0765432109', 'Gata 3, Stad');

-- Lägg till läkare
INSERT INTO läkare (Förnamn, Efternamn, Specialitet, Kön, Telefonnummer) VALUES 
('Johan', 'Lindgren', 'Ortopedi', 'Man', '0701112233'),
('Sara', 'Svensson', 'Allmänmedicin', 'Kvinna', '0723344556'),
('Anders', 'Gustafsson', 'Neurologi', 'Man', '0745566778');

-- Lägg till polikliniker
INSERT INTO poliklinik (Namn, Plats) VALUES 
('Ortopedikliniken', 'Sjukhuset Stad'),
('Allmänmedicinkliniken', 'Sjukhuset Stad'),
('Neurologikliniken', 'Sjukhuset Stad');

-- Lägg till besök
INSERT INTO besök (PatientID, LäkareID, PoliklinikID, Besöksdatum, Diagnos) VALUES 
(1, 1, 1, '2024-02-28', 'Benfraktur'),
(2, 2, 2, '2024-02-29', 'Förkylning'),
(3, 3, 3, '2024-03-01', 'Huvudvärk');




Delimiter $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_visit`(IN p_patientID INT, IN p_läkareID INT, IN p_poliklinikID INT, IN p_besöksdatum DATE, IN p_diagnos VARCHAR(100))
BEGIN
    INSERT INTO besök (PatientID, LäkareID, PoliklinikID, Besöksdatum, Diagnos)
    VALUES (p_patientID, p_läkareID, p_poliklinikID, p_besöksdatum, p_diagnos);
END $$
Delimiter ;

Delimiter $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddNewPatient`(
    IN p_Förnamn VARCHAR(50),
    IN p_Efternamn VARCHAR(50),
    IN p_Ålder INT,
    IN p_Kön VARCHAR(10),
    IN p_Telefonnummer VARCHAR(15),
    IN p_Adress VARCHAR(100)
)
BEGIN
    INSERT INTO patient (Förnamn, Efternamn, Ålder, Kön, Telefonnummer, Adress)
    VALUES (p_Förnamn, p_Efternamn, p_Ålder, p_Kön, p_Telefonnummer, p_Adress);
END $$

Delimiter ;

Delimiter $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_patient_visits`(IN p_patientID INT)
BEGIN
    SELECT *
    FROM besök
    WHERE PatientID = p_patientID;
END $$

Delimiter ;

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

Delimiter $$
CREATE DEFINER=`root`@`localhost` TRIGGER `UpdateLatestVisitInfo` AFTER INSERT ON `besök` FOR EACH ROW BEGIN
    UPDATE latest_visit_info lvi
    SET 
        lvi.LatestVisitDate = NEW.Besöksdatum,
        lvi.LatestDiagnosis = NEW.Diagnos
    WHERE 
        lvi.PatientID = NEW.PatientID;
END $$

Delimiter ;

Delimiter $$

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `latestvisitinfo` AS
    SELECT 
        `p`.`PatientID` AS `PatientID`,
        `b`.Besöksdatum AS LatestVisitDate,
        b.Diagnos AS LatestDiagnosis
    FROM
        (patient p
        LEFT JOIN besök b ON ((`p`.PatientID = `b`.PatientID)))
    ORDER BY `b`.Besöksdatum DESC
$$ Delimiter ;
    

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `patient_count_per_doctor` AS 
select `läkare`.`LäkareID` AS `LäkareID`,`läkare`.`Förnamn` AS `Förnamn`,`läkare`.`Efternamn` AS `Efternamn`,count(`besök`.`PatientID`) AS `Antal_patienter` 
from (`läkare` left join `besök` on((`läkare`.`LäkareID` = `besök`.`LäkareID`))) 
group by `läkare`.`LäkareID`
