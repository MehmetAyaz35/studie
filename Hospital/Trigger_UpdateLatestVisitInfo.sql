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