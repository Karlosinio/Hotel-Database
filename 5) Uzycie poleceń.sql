-- ZSBD: Projekt Systemu
-- Część 4 - Zapytania
--
-- Autorzy:
-- Paweł Galewicz	210182
-- Justyna Hubert	210200
-- Karol Podlewski	210294

USE hotel
GO


-- #1 Wyswietl wszystkich klientów.
SELECT * 
FROM klienci

-- #2 Wyświetl imiona i nazwiska klientów, których nazwisko kończy się na "ki". 
SELECT imie, nazwisko
FROM klienci
WHERE nazwisko LIKE '%ki'

-- #3 Wyswietl numery pokojow, w których znajduje się sejf oraz cena jest wieksza od 850.
SELECT DISTINCT nr_pokoju
FROM pokoje WHERE czy_sejf = 0 AND cena > 850

-- #4 Wyświetl pracowników, którzy pracują na stanowisku kucharza.
SELECT DISTINCT nr_pracownika, imie, nazwisko 
FROM pracownicy as p, stanowiska as s WHERE s.nr_stanowiska = p.nr_stanowiska AND s.nazwa = 'Kucharz'

-- #5 Wyświetl pracowników zarabiających powyżej średniej płacy w hotelu.
SELECT nr_pracownika, imie, nazwisko, nazwa
FROM pracownicy AS p, stanowiska AS s
WHERE p.nr_stanowiska = s.nr_stanowiska AND p.placa > (SELECT AVG(placa) FROM pracownicy)
GROUP BY nr_pracownika, imie, nazwisko, nazwa, placa

-- #6 Wyświetl nazwiska dwóch najlepiej zarabiających pracowników.
SELECT TOP 3 placa, nazwisko FROM pracownicy
ORDER BY placa DESC

-- #7 Wyswietl i uporządkuj malejąco wiek pracowników.
SELECT DISTINCT nr_pracownika, nazwisko, ((YEAR(GETDATE()) - YEAR(data_urodzenia))) AS "wiek"
FROM pracownicy ORDER BY wiek desc

-- #8 Wyświetl numery rezerwacj, dla klientów drugiego typu. Rezultat przedstaw w postaci jednego ciągu.
SELECT CONCAT (nr_rezerwacji, ' ', nazwisko) AS 'rezerwacje klientow'
FROM rezerwacje as r, klienci as k WHERE r.nr_klienta = k.nr_klienta AND k.typ = 2 

-- #9 Wyświetl imie, nazwisko pracowników zatrudnionych na stanowisku sprzątaczki oraz nazwiska wszystkich pracowników, którzy pracują z nim na tym samym stanowisku.
SELECT DISTINCT x.imie, x.nazwisko, y.nazwisko AS 'współpracownik'
FROM pracownicy x, pracownicy y, stanowiska s
WHERE	x.nr_stanowiska=y.nr_stanowiska AND
		x.nr_pracownika <> y.nr_pracownika AND
		x.nr_stanowiska=s.nr_stanowiska AND s.nazwa = 'Sprzataczka'

-- #10  Wyświetl nazwiska klientów i numery ich rezerwacji, które zostały zrealizowane w dniu tygodnia, w którym było najwięcej rezerwacji.
SELECT nazwisko, nr_rezerwacji 
FROM klienci AS k, rezerwacje AS r WHERE DATENAME (dw, poczatek_rezerwacji) = 
		(SELECT TOP 1 DATENAME (dw, poczatek_rezerwacji) 
		FROM rezerwacje 
		GROUP BY DATENAME (dw, poczatek_rezerwacji)
		ORDER BY COUNT (*) DESC) AND r.nr_klienta = k.nr_klienta

-- #11 Dla każdego stanowiska wyświetl liczbę pracowników. 
SELECT nazwa, COUNT (*) AS 'ilość pracowników'
FROM pracownicy as p, stanowiska as s WHERE p.nr_stanowiska = s.nr_stanowiska GROUP BY nazwa 

-- #12 Wyświetl podstawowe informacje na temat pokoju oraz rezerwacji dokonanych w pierwszym tygodniu miesiąca.
SELECT p.nr_pokoju, ilosc_osob, cena, nr_rezerwacji, poczatek_rezerwacji
FROM rezerwacje AS r, pokoje as p WHERE r.nr_pokoju = p.nr_pokoju AND DATENAME (dd, poczatek_rezerwacji) < 7

	--SPRAWDZIC
-- #13 Wyświetl ile razy był wynajmowany każdy pokój.
SELECT p.nr_pokoju, (SELECT COUNT (*) FROM byle_rezerwacje AS br WHERE br.nr_pokoju = p.nr_pokoju) +
		(SELECT COUNT (*) FROM rezerwacje AS r WHERE r.nr_pokoju = p.nr_pokoju) AS 'ilość rezerwacji'
FROM pokoje AS p
GROUP BY p.nr_pokoju

-- #14 Wyświetl datę końcową obecnych rezerwacji.
SELECT *, DATEADD(day, dni, poczatek_rezerwacji) AS 'koniec rezerwacji'
FROM rezerwacje

-- #15 Wyświetl zyski z obecnych rezerwacji. 
SELECT  nr_rezerwacji,cena * dni AS 'zysk'
FROM rezerwacje AS r, pokoje AS p WHERE p.nr_pokoju = r.nr_pokoju
GROUP BY nr_rezerwacji, cena, dni


-- #16 Wyswielt
SELECT *, dbo.cena_rezerwacji(nr_rezerwacji) as 'cena_rezerwacji' FROM rezerwacje


-- #17 Zaktualizuj rejestracje (popraw ilosci osob)
SELECT * FROM rezerwacje
EXEC poprawnosc_rejestracji
SELECT * FROM rezerwacje