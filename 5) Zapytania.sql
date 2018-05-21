
-- ZSBD: Projekt Systemu
-- Część 5 - Zapytania
--
-- Autorzy:
-- Paweł Galewicz	210182
-- Justyna Hubert	210200
-- Karol Podlewski	210294

USE hotel
GO

-- JUSTYNA --
-- MOIM ZDANIEM CAŁKIEM OK ZAPYTANIA --

--#J1 Wyświetl rezerwacje, które zaczęły się w poniedziałek, a skończyły w poniedziałek lub czwartek.
SELECT *, DATENAME (dw, poczatek_rezerwacji) AS dzien_rezerwacji, DATENAME (dw, DATEADD(day, dni, poczatek_rezerwacji)) AS dzien_konca_rezerwacji
FROM rezerwacje
WHERE (DATENAME (dw, poczatek_rezerwacji) = 'Monday') AND
(DATENAME (dw, DATEADD(day, dni, poczatek_rezerwacji)) = 'Thursday' OR DATENAME (dw, DATEADD(day, dni, poczatek_rezerwacji)) = 'Monday')

--#J2 Wyświetl ile razy był wynajmowany każdy pokój.
SELECT p.nr_pokoju, (SELECT COUNT (*) FROM byle_rezerwacje AS br WHERE br.nr_pokoju = p.nr_pokoju) +
		(SELECT COUNT (*) FROM rezerwacje AS r WHERE r.nr_pokoju = p.nr_pokoju) AS 'ilość rezerwacji'
FROM pokoje AS p
GROUP BY p.nr_pokoju

--#J3  Wyświetl nazwiska klientów i numery ich rezerwacji, które zostały zrealizowane w dniu tygodnia, w którym było najwięcej rezerwacji.
SELECT nazwisko, nr_rezerwacji 
FROM klienci AS k, rezerwacje AS r WHERE DATENAME (dw, poczatek_rezerwacji) = 
		(SELECT TOP 1 DATENAME (dw, poczatek_rezerwacji) 
		FROM rezerwacje 
		GROUP BY DATENAME (dw, poczatek_rezerwacji)
		ORDER BY COUNT (*) DESC) AND r.nr_klienta = k.nr_klienta

--#J4 Wyświetl imie, nazwisko pracowników zatrudnionych w hotelu oraz nazwiska wszystkich jego współpracowników kończących się na 'k'.
SELECT DISTINCT x.imie, x.nazwisko, y.nazwisko AS 'współpracownik', s.nazwa AS 'stanowisko'
FROM pracownicy x, pracownicy y, stanowiska s
WHERE	x.nr_stanowiska = y.nr_stanowiska AND
		x.nr_pracownika <> y.nr_pracownika AND
		x.nr_stanowiska = s.nr_stanowiska AND
		y.nr_stanowiska = s.nr_stanowiska AND
		y.nazwisko LIKE '%k'

--#J5 Dla każdego stanowiska wyświetl liczbę pracowników mających więcej niż 50 lat oraz sumę ich pensji. Rezultat zapytania umieść w jednym ciągu.
SELECT CONCAT( nazwa, ' liczba pracowników: ', COUNT (*), ' suma pensji: ', SUM(placa) )
FROM pracownicy as p, stanowiska as s 
WHERE p.nr_stanowiska = s.nr_stanowiska  
AND ((YEAR(GETDATE()) - YEAR(data_urodzenia))) > 50
GROUP BY nazwa 



-- KAROL --

-- #K1 Wybierz klientów, którzy pochodzą z Łodzi bądź Warszawy, a pokoje które będą wynajmowali kosztują więcej niż 900, mimo, że wcześniej nie wynajmowali takich pokojów
SELECT DISTINCT k.imie, k.nazwisko, k.nr_klienta FROM klienci AS k, miasta AS m, rezerwacje AS r, pokoje AS p
WHERE k.miasto = m.nr_miasta AND (m.nazwa = 'Łódź' or m.nazwa = 'Warszawa') AND k.nr_klienta = r.nr_klienta
AND r.nr_pokoju = p.nr_pokoju AND p.cena > 900 AND k.nr_klienta IN
(	SELECT DISTINCT kk.nr_klienta FROM klienci AS kk, byle_rezerwacje AS bb, pokoje AS pp
	WHERE kk.nr_klienta = bb.nr_klienta AND bb.nr_pokoju = pp.nr_pokoju AND pp.cena <= 900)

-- #K2 Wybierz pokoje, które były wynajmowane tylko przez klientów 2 bądź 3 typu, ale nikt nie planuje wynajmować ich później
SELECT DISTINCT b.nr_pokoju FROM byle_rezerwacje AS b, klienci AS k
WHERE b.nr_klienta = k.nr_klienta AND (k.typ = 2 OR k.typ = 3) AND b.nr_pokoju NOT IN
(SELECT DISTINCT rr.nr_pokoju FROM rezerwacje AS RR)

-- #K3 Wybierz pracowników, którzy zarabiają najwięcej na swoim stanowisku, posortuj ich alfabetycznie po stanowiskach
SELECT s.nazwa AS 'Stanowisko', p.imie, p.nazwisko, p.nr_pracownika, p.placa FROM pracownicy AS p, stanowiska AS s
WHERE p.nr_stanowiska = s.nr_stanowiska AND p.nr_pracownika IN
(SELECT TOP 1 pp.nr_pracownika FROM pracownicy AS pp WHERE p.nr_stanowiska = pp.nr_stanowiska)
ORDER BY s.nazwa

-- #K4 Wybierz klientów, którzy zawsze rezerwowali pokoje z sejfem bez wanny i pochodzą z miast, z których nie pochodzą byli pracownicy
SELECT DISTINCT k.imie, k.nazwisko, k.nr_klienta, m.nazwa AS 'miasto'
FROM klienci AS k, miasta AS m, rezerwacje AS r, pokoje AS p, byle_rezerwacje AS b
WHERE ((k.nr_klienta = r.nr_klienta AND r.nr_pokoju = p.nr_pokoju AND p.czy_sejf = 1 AND p.czy_wanna = 0) 
OR (k.nr_klienta = b.nr_klienta AND b.nr_pokoju = p.nr_pokoju AND p.czy_sejf = 1 AND p.czy_wanna = 0))
AND k.miasto NOT IN (SELECT DISTINCT miasto FROM byli_pracownicy) AND k.miasto = m.nr_miasta

-- #K5 Wybierz pokoje, które są zarezerowane tylko raz przez klientów niepochodzących z Zamościa bądź Lublina, 
--		jednak wcześniej były wynajęte chociaż raz właśnie przez klientów z województwa Lubelskiego
SELECT DISTINCT r.nr_pokoju, COUNT (*) AS 'ilosc_rezerwacji' FROM rezerwacje AS r, klienci AS k
WHERE r.nr_klienta = k.nr_klienta AND k.miasto <> 9 AND k.miasto <> 8 AND r.nr_pokoju IN
(	SELECT DISTINCT bb.nr_pokoju FROM byle_rezerwacje AS bb, klienci AS kk, miasta AS mm
	WHERE bb.nr_klienta = kk.nr_klienta AND kk.miasto = mm.nr_miasta AND (mm.nr_miasta = 8 OR mm.nr_miasta = 9))
GROUP BY r.nr_pokoju
HAVING COUNT (*) = 1

--AAAAAA

--liczba klientow danego typu
select typ, count(typ) as 'liczba klientów' from klienci
group by typ

--dane klienta ktory najwiecej zaplacil oraz jego ulubiony pokoj
select top 1 nr_klienta, klienci.imie, klienci.nazwisko, klienci.nr_klienta, klienci.typ,
	(
	select sum(dbo.cena_rezerwacji(nr_rezerwacji)) from byle_rezerwacje
	where byle_rezerwacje.nr_klienta = klienci.nr_klienta
	) as 'suma należności'
	,
	(
	select nr_pokoju from byle_rezerwacje
	where nr_klienta = 2 
	group by nr_pokoju
	having count(nr_pokoju) = 
		(
		select top 1 count(nr_pokoju) from byle_rezerwacje
		where nr_klienta = 2
		group by nr_pokoju
		)
	) as 'ulubiony pokoj'
from klienci 
order by [suma należności] desc

--cena najdrozszego pokoju na najczesciej wybieranym pietrze
select top 1 nr_pokoju, cena from pokoje
where nr_pokoju/100 = 
	(
	select nr_pokoju/100 as 'pietro' from byle_rezerwacje
	group by nr_pokoju/100
	having count(nr_pokoju) = 
		(
		select top 1 count(nr_pokoju) as 'liczba pokoi' from byle_rezerwacje
		group by nr_pokoju/100
		order by [liczba pokoi] desc
		) 
	)


--najczesciej rezerwowane pokoje na kazdym pietrze

select distinct nr_pokoju/100 as 'pietro', dbo.najczestszy_pokoj(nr_pokoju/100) as 'najczęściej wynajmowany pokój'
from pokoje p 

-- STARE ZAPYTANIA --


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