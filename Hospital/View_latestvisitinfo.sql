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