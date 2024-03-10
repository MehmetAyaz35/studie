CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `patient_count_per_doctor` AS 
select `läkare`.`LäkareID` AS `LäkareID`,`läkare`.`Förnamn` AS `Förnamn`,`läkare`.`Efternamn` AS `Efternamn`,count(`besök`.`PatientID`) AS `Antal_patienter` 
from (`läkare` left join `besök` on((`läkare`.`LäkareID` = `besök`.`LäkareID`))) 
group by `läkare`.`LäkareID`