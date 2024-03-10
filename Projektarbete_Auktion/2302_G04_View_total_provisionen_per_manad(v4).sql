CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `total_provisionen_per_manad` AS
    SELECT 
        YEAR(`ah`.`StartDatum`) AS År,
        MONTH(ah.StartDatum) AS Månad,
        SUM(`p`.Provision) AS Total_Provision
    FROM
        (auktionshistorik ah
        JOIN produkt p ON ((ah.ProduktID = `p`.ProduktID)))
    GROUP BY YEAR(ah.StartDatum) , MONTH(ah.StartDatum)
    ORDER BY År , Månad