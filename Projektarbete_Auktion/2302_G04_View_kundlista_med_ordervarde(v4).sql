CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW kundlista_med_ordervarde AS
    SELECT 
        auktionshistorik.highestbidder AS Kund,
        SUM(auktionshistorik.`Slutgiltigt pris`) AS Ordervärde
    FROM
        auktionshistorik
    GROUP BY auktionshistorik.highestbidder