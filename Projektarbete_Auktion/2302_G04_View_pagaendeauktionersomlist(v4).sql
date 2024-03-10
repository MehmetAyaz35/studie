CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `pagaendeauktionersomlist` AS
    SELECT 
        `a`.`AuktionID` AS `AuktionID`,
        `a`.`StartDatum` AS `StartDatum`,
        `a`.`SlutDatum` AS `SlutDatum`,
        `p`.`ProduktID` AS `ProduktID`,
        `a`.Utgångspris AS Utgångspris,
        `a`.Acceptpris AS Acceptpris,
        IFNULL(MAX(ab.Bud), 0) AS Högstabud,
        (SELECT 
                auktionsbud.kund_Personnummer
            FROM
                auktionsbud
            WHERE
                ((auktionsbud.Bud = MAX(ab.Bud))
                    AND (a.AuktionID = ab.AuktionID))
            LIMIT 1) AS Kund
    FROM
        ((auktion a
        LEFT JOIN produkt p ON ((a.ProduktID = p.ProduktID)))
        LEFT JOIN auktionsbud ab ON ((a.AuktionID = ab.AuktionID)))
    WHERE
        (NOW() BETWEEN a.StartDatum AND a.SlutDatum)
    GROUP BY a.AuktionID , a.StartDatum , a.SlutDatum , a.Utgångspris , a.Acceptpris , p.ProduktID