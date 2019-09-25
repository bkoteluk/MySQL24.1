
-- Utworzenie bazy (schematu) danych 

CREATE SCHEMA pracownicy;
USE pracownicy;

-- Punkt 1. utworzenie tabeli

CREATE TABLE pracownik2 (
id INT AUTO_INCREMENT PRIMARY KEY,
imie VARCHAR(15),
nazwisko VARCHAR(15),
wyplata DECIMAL(7,2),
data_urodzenia DATE,
stanowisko VARCHAR(10)
);

-- Punkt 2. Wstawienie do tabeli 6 pracowników

INSERT INTO pracownik SET imie = 'Jan', nazwisko = 'Kowalski', wyplata = 6500.50 , data_urodzenia = '1990-01-02', stanowisko = 'księgowy';
INSERT INTO pracownik SET imie = 'Katerzyna', nazwisko = 'Nowak', wyplata = 16500.50 , data_urodzenia = '1995-01-02', stanowisko = 'prezes';
INSERT INTO pracownik SET imie = 'Ksawery', nazwisko = 'Zawadzki', wyplata = 2500.00 , data_urodzenia = '1998-03-02', stanowisko = 'handlowiec';
INSERT INTO pracownik SET imie = 'Teodor', nazwisko = 'Nowakowski', wyplata = 3500.00 , data_urodzenia = '1997-08-02', stanowisko = 'handlowiec';
INSERT INTO pracownik SET imie = 'Malwina', nazwisko = 'Kowalska', wyplata = 7500.00 , data_urodzenia = '1992-10-08', stanowisko = 'asystent';
INSERT INTO pracownik SET imie = 'Zbigniew', nazwisko = 'Walendziak', wyplata = 1500.00 , data_urodzenia = '1969-11-08', stanowisko = 'kierowca';
INSERT INTO pracownik SET imie = 'Zbigniew', nazwisko = 'Najmłodszy', wyplata = 1500.00 , data_urodzenia = '2000-11-08', stanowisko = 'kierowca';

-- Punkt 3. Wyświetlenie pracowników w kolejności alfabetycznej po nazwisku

SELECT * FROM pracownik
ORDER BY nazwisko ASC;

-- Punkt 4. pobranie pracowników , których stanowisko to 'handlowiec'

SELECT * FROM pracownik
WHERE stanowisko = 'handlowiec';

-- Punkt 5. pobranie pracowników, którzy mają co najmniej 30 lat

SELECT * FROM pracownik
WHERE (SELECT extract(YEAR FROM curdate())) - (SELECT extract(YEAR FROM data_urodzenia)) >= 30;

-- Punkt 6. zwiększenie wypłaty pracownikom na stanowisku 'handlowiec' o 10%

UPDATE pracownik SET wyplata = wyplata + wyplata*0.1
WHERE stanowisko = 'handlowiec';

-- Punkt 7. usunięcie najmłodszego pracownika

-- SELECT id FROM ( SELECT * FROM pracownik WHERE data_urodzenia = (SELECT max(data_urodzenia) FROM pracownik)) AS prac;

DELETE FROM pracownik
WHERE id = (SELECT id FROM ( SELECT * FROM pracownik WHERE data_urodzenia = (SELECT max(data_urodzenia) FROM pracownik)) AS prac) ;


-- Punkt 8. usunięcie tabeli pracownik

USE pracownicy;
DROP TABLE pracownik;

-- Punkt 9.Utworzenie tabeli stanowisko

CREATE TABLE stanowisko (
sta_id INT AUTO_INCREMENT PRIMARY KEY,
sta_nazwa VARCHAR(15),
sta_opis VARCHAR(15),
sta_wyplata DECIMAL(7,2)
);

-- Punkt 10.Utworzenie tabeli adres

CREATE TABLE adres (
adr_id INT AUTO_INCREMENT PRIMARY KEY,
adr_ul VARCHAR(15),
adr_numer_domu INT,
adr_numer_mieszkania INT,
adr_kod VARCHAR(5),
adr_miasto VARCHAR(15)
);

-- Punkt 11.Utworzenie tabeli pracownik

CREATE TABLE pracownik (
prac_id INT AUTO_INCREMENT PRIMARY KEY,
prac_imie VARCHAR(15),
prac_nazwisko VARCHAR(15),
prac_adr_id INT,
prac_sta_id INT
);

-- Punkt 12. Dodanie danych testowych

-- tabela stanowisko
INSERT INTO stanowisko(sta_nazwa, sta_opis, sta_wyplata) VALUES ('ACCOUNTS', 'Księgowość', 3500);
INSERT INTO stanowisko(sta_nazwa, sta_opis, sta_wyplata) VALUES ('IT', 'Informatyka', 13500);
INSERT INTO stanowisko(sta_nazwa, sta_opis, sta_wyplata) VALUES ('MARKETING', 'Dział handlu', 7500);
INSERT INTO stanowisko(sta_nazwa, sta_opis, sta_wyplata) VALUES ('MANAGEMENT', 'Zarząd/dyrekcja', 17500);

-- tabela adres
INSERT INTO adres(adr_ul, adr_numer_domu, adr_numer_mieszkania, adr_kod, adr_miasto) VALUES ('Wiejska', 1, 12, 12345, 'Warszawa');
INSERT INTO adres(adr_ul, adr_numer_domu, adr_numer_mieszkania, adr_kod, adr_miasto) VALUES ('Strzelecka', 123, 15, 78900, 'Opole');
INSERT INTO adres(adr_ul, adr_numer_domu, adr_numer_mieszkania, adr_kod, adr_miasto) VALUES ('Strzegomska', 45, 15, 56678, 'Wrocław');
INSERT INTO adres(adr_ul, adr_numer_domu, adr_numer_mieszkania, adr_kod, adr_miasto) VALUES ('Podwale', 12, 1, 56678, 'Wrocław');
INSERT INTO adres(adr_ul, adr_numer_domu, adr_numer_mieszkania, adr_kod, adr_miasto) VALUES ('Podwale', 12, 4, 56678, 'Wrocław');
INSERT INTO adres(adr_ul, adr_numer_domu, adr_numer_mieszkania, adr_kod, adr_miasto) VALUES ('Wrosławska', 9, 2, 34678, 'Legnica');

-- tabela pracownik
INSERT INTO pracownik(prac_imie, prac_nazwisko, prac_adr_id, prac_sta_id) VALUES ('Jan', 'Kowalski', 1, 1);
INSERT INTO pracownik SET prac_imie = 'Katerzyna', prac_nazwisko = 'Nowak', prac_adr_id = 2, prac_sta_id = 2;
INSERT INTO pracownik SET prac_imie = 'Ksawery', prac_nazwisko = 'Zawadzki', prac_adr_id = 3, prac_sta_id = 2;
INSERT INTO pracownik SET prac_imie = 'Teodor', prac_nazwisko = 'Nowakowski', prac_adr_id = 4, prac_sta_id = 1;
INSERT INTO pracownik SET prac_imie = 'Malwina', prac_nazwisko = 'Kowalska',prac_adr_id = 1, prac_sta_id = 4;
INSERT INTO pracownik SET prac_imie = 'Zbigniew', prac_nazwisko = 'Walendziak', prac_adr_id = 5, prac_sta_id = 3;
INSERT INTO pracownik SET prac_imie = 'Teresa', prac_nazwisko = 'Markowska', prac_adr_id = 6, prac_sta_id = 3;

-- Punkt 13. Pełne dane o pracowniku

SELECT p.prac_imie, p.prac_nazwisko, s.sta_nazwa, s.sta_wyplata, a.adr_ul, a.adr_numer_domu, a.adr_numer_mieszkania, a.adr_miasto, a.adr_kod 
FROM pracownik p 
JOIN adres a ON p.prac_adr_id = a.adr_id
JOIN stanowisko s ON p.prac_sta_id = s.sta_id;

-- Punkt 14. Suma wypłat pracowników w firmie

SELECT SUM(s.sta_wyplata) FROM pracownik p
JOIN stanowisko s ON p.prac_sta_id = s.sta_id; 

-- Punkt 15. Pracownicy zamieszkali pod wskazanym kodem pocztowm (56678)

SELECT * FROM pracownik p
JOIN adres a ON p.prac_adr_id = a.adr_id
WHERE a.adr_kod = '56678'