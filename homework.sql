
-- Utworzenie bazy (schematu) danych 

CREATE SCHEMA pracownicy;
USE pracownicy;

-- Punkt 1. utworzenie tabeli

CREATE TABLE pracownicy2 (
id INT AUTO_INCREMENT PRIMARY KEY,
imie VARCHAR(15),
nazwisko VARCHAR(15),
wyplata DECIMAL(7,2),
data_urodzenia DATE,
stanowisko VARCHAR(10)
);

-- Punkt 2. Wstawienie do tabeli 6 pracowników

INSERT INTO pracownicy2(imie, nazwisko, wyplata, data_urodzenia, stanowisko) VALUES('Jan', 'Kowalski', 6500.50 , '1990-01-02', 'księgowy');
INSERT INTO pracownicy2(imie, nazwisko, wyplata, data_urodzenia, stanowisko) VALUES('Katerzyna', 'Nowak', 16500.50 , '1995-01-02', 'prezes');
INSERT INTO pracownicy2(imie, nazwisko, wyplata, data_urodzenia, stanowisko) VALUES('Ksawery', 'Zawadzki', 2500.00 , '1998-03-02', 'handlowiec');
INSERT INTO pracownicy2(imie, nazwisko, wyplata, data_urodzenia, stanowisko) VALUES('Teodor', 'Nowakowski', 3500.00 , '1997-08-02', 'handlowiec');
INSERT INTO pracownicy2(imie, nazwisko, wyplata, data_urodzenia, stanowisko) VALUES('Malwina', 'Kowalska', 7500.00 , '1992-10-08', 'asystent');
INSERT INTO pracownicy2(imie, nazwisko, wyplata, data_urodzenia, stanowisko) VALUES('Zbigniew','Walendziak', 1500.00 , '1969-11-08', 'kierowca');
INSERT INTO pracownicy2(imie, nazwisko, wyplata, data_urodzenia, stanowisko) VALUES('Zbigniew', 'Najmłodszy', 1500.00 , '2000-11-08', 'kierowca');

-- Punkt 3. Wyświetlenie pracowników w kolejności alfabetycznej po nazwisku

SELECT * FROM pracownicy2
ORDER BY nazwisko ASC;

-- Punkt 4. pobranie pracowników , których stanowisko to 'handlowiec'

SELECT * FROM pracownicy2
WHERE stanowisko = 'handlowiec';

-- Punkt 5. pobranie pracowników, którzy mają co najmniej 30 lat

SELECT * FROM pracownicy2
WHERE extract(YEAR FROM curdate()) - extract(YEAR FROM data_urodzenia) >= 30;

-- Punkt 6. zwiększenie wypłaty pracownikom na stanowisku 'handlowiec' o 10%

UPDATE pracownicy2 SET wyplata = wyplata + wyplata*0.1
WHERE stanowisko = 'handlowiec';

-- Punkt 7. usunięcie najmłodszego pracownika

 -- DELETE FROM pracownicy2 WHERE id = (SELECT id FROM ( SELECT * FROM pracownicy2 WHERE data_urodzenia = (SELECT max(data_urodzenia) FROM pracownicy2)) AS prac) ;

DELETE FROM pracownicy2 WHERE data_urodzenia = (SELECT * FROM (SELECT max(data_urodzenia) FROM pracownicy2) AS prac);

-- Punkt 8. usunięcie tabeli pracownik

USE pracownicy;
DROP TABLE pracownicy2;

-- Punkt 9.Utworzenie tabeli stanowiska

CREATE TABLE stanowiska (
id INT AUTO_INCREMENT PRIMARY KEY,
nazwa VARCHAR(15),
opis VARCHAR(15),
wyplata DECIMAL(7,2)
);

-- Punkt 10.Utworzenie tabeli adresy

CREATE TABLE adresy (
id INT AUTO_INCREMENT PRIMARY KEY,
ulica VARCHAR(15),
numer_domu INT,
numer_mieszkania INT,
kod VARCHAR(5),
miasto VARCHAR(15)
);

-- Punkt 11.Utworzenie tabeli pracownicy

CREATE TABLE pracownicy (
id INT AUTO_INCREMENT PRIMARY KEY,
imie VARCHAR(15),
nazwisko VARCHAR(15),
adres_id INT,
stanowisko_id INT
);

-- Punkt 12. Dodanie danych testowych

-- tabela stanowiska
INSERT INTO stanowiska(nazwa, opis, wyplata) VALUES ('ACCOUNTS', 'Księgowość', 3500);
INSERT INTO stanowiska(nazwa, opis, wyplata) VALUES ('IT', 'Informatyka', 13500);
INSERT INTO stanowiska(nazwa, opis, wyplata) VALUES ('MARKETING', 'Dział handlu', 7500);
INSERT INTO stanowiska(nazwa, opis, wyplata) VALUES ('MANAGEMENT', 'Zarząd/dyrekcja', 17500);

-- tabela adresy
INSERT INTO adresy(ulica, numer_domu, numer_mieszkania, kod, miasto) VALUES ('Wiejska', 1, 12, 12345, 'Warszawa');
INSERT INTO adresy(ulica, numer_domu, numer_mieszkania, kod, miasto) VALUES ('Strzelecka', 123, 15, 78900, 'Opole');
INSERT INTO adresy(ulica, numer_domu, numer_mieszkania, kod, miasto) VALUES ('Strzegomska', 45, 15, 56678, 'Wrocław');
INSERT INTO adresy(ulica, numer_domu, numer_mieszkania, kod, miasto) VALUES ('Podwale', 12, 1, 56678, 'Wrocław');
INSERT INTO adresy(ulica, numer_domu, numer_mieszkania, kod, miasto) VALUES ('Podwale', 12, 4, 56678, 'Wrocław');
INSERT INTO adresy(ulica, numer_domu, numer_mieszkania, kod, miasto) VALUES ('Wrosławska', 9, 2, 34678, 'Legnica');

-- tabela pracownik
INSERT INTO pracownicy(imie, nazwisko, adres_id, stanowisko_id) VALUES ('Jan', 'Kowalski', 1, 1);
INSERT INTO pracownicy(imie, nazwisko, adres_id, stanowisko_id) VALUES ('Katerzyna', 'Nowak', 2, 2);
INSERT INTO pracownicy(imie, nazwisko, adres_id, stanowisko_id) VALUES ('Ksawery', 'Zawadzki', 3, 2);
INSERT INTO pracownicy(imie, nazwisko, adres_id, stanowisko_id) VALUES ('Teodor', 'Nowakowski', 4, 1);
INSERT INTO pracownicy(imie, nazwisko, adres_id, stanowisko_id) VALUES ('Malwina', 'Kowalska', 1, 4);
INSERT INTO pracownicy(imie, nazwisko, adres_id, stanowisko_id) VALUES ('Zbigniew', 'Walendziak', 5, 3);
INSERT INTO pracownicy(imie, nazwisko, adres_id, stanowisko_id) VALUES ('Teresa', 'Markowska', 6, 3);

-- Punkt 13. Pełne dane o pracowniku

SELECT p.imie, p.nazwisko, s.nazwa, s.wyplata, a.ulica, a.numer_domu, a.numer_mieszkania, a.miasto, a.kod 
FROM pracownicy p 
JOIN adresy a ON p.adres_id = a.id
JOIN stanowiska s ON p.stanowisko_id = s.id;

-- Punkt 14. Suma wypłat pracowników w firmie

SELECT SUM(s.wyplata) FROM pracownicy p
JOIN stanowiska s ON p.stanowisko_id = s.id; 

-- Punkt 15. Pracownicy zamieszkali pod wskazanym kodem pocztowm (56678)

SELECT * FROM pracownicy p
JOIN adresy a ON p.adres_id = a.id
WHERE a.kod = '56678'