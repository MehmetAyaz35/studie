INSERT INTO leverantör(`Namn`) VALUES ('A');
INSERT INTO leverantör(`Namn`) VALUES ('B');

INSERT INTO kund(`Personnummer`, `Förnamn`, `Efternamn`, `Address`, `Telefonnummer`)
VALUES  (1234567890,'Mehmet','Ayaz','Stockholm','076-111-1111'),
		(2345678901,'David','Challma','Stockholm','076-222-2222'),
		(3456789012,'John','Bueno','Stockholm','076-333-3333');
        
call projektarbete4.RegisterProdukt(200, 'Elektronik', 1);
call projektarbete4.RegisterProdukt(1500, 'Fordon', 1);
call projektarbete4.RegisterProdukt(1500, 'Tillbehör', 2);
call projektarbete4.RegisterProdukt(600, 'Konst', 2);


call projektarbete4.SkapaAuktion(1, 500, 600, '2024-02-29', '2024-03-19 11:30:00');
call projektarbete4.SkapaAuktion(2, 6000, 7000, '2024-02-29', '2024-03-20 12:30:00');
call projektarbete4.SkapaAuktion(3, 6500, 7500, '2024-02-29', '2024-03-21 13:30:00');
call projektarbete4.SkapaAuktion(4, 3000, 4000, '2024-02-29', '2024-03-22 14:30:00');

insert into auktionsbud (Bud, Tidsstämpel, AuktionID, kund_Personnummer)
Values (520, now(), 1, 1234567890);
insert into auktionsbud (Bud, Tidsstämpel, AuktionID, kund_Personnummer)
Values (530, now(), 1, 2345678901);
insert into auktionsbud (Bud, Tidsstämpel, AuktionID, kund_Personnummer)
Values (560, now(), 1, 3456789012);

insert into auktionsbud (Bud, Tidsstämpel, AuktionID, kund_Personnummer)
Values (6200, now(), 2, 2345678901);
insert into auktionsbud (Bud, Tidsstämpel, AuktionID, kund_Personnummer)
Values (7000, now(), 2, 1234567890);

insert into auktionsbud (Bud, Tidsstämpel, AuktionID, kund_Personnummer)
Values (6500, now(), 3, 2345678901);
insert into auktionsbud (Bud, Tidsstämpel, AuktionID, kund_Personnummer)
Values (7000, now(), 3, 3456789012);
insert into auktionsbud (Bud, Tidsstämpel, AuktionID, kund_Personnummer)
Values (7300, now(), 3, 2345678901);


