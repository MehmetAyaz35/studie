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

