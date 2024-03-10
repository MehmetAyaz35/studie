DELIMITER $$

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
END $$

DELIMITER ;