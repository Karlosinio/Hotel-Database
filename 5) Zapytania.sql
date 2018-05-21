
-- ZSBD: Projekt Systemu
-- Część 5 - Zapytania
--
-- Autorzy:
-- Paweł Galewicz	210182
-- Justyna Hubert	210200
-- Karol Podlewski	210294

USE hotel
GO


--#1 Wyświetl rezerwacje, które zaczęły się w poniedziałek, a skończyły w poniedziałek lub wtorek.
SELECT *, DATENAME (dw, poczatek_rezerwacji) AS dzien_rezerwacji, DATENAME (dw, koniec_rezerwacji) AS dzien_konca_rezerwacji
FROM byle_rezerwacje
WHERE (DATENAME (dw, poczatek_rezerwacji) = 'Monday') AND
(DATENAME (dw, koniec_rezerwacji) = 'Monday' OR DATENAME (dw, koniec_rezerwacji) = 'Tuesday')

--#2 Wyświetl ile razy był wynajmowany każdy pokój.
SELECT p.nr_pokoju, (SELECT COUNT (*) FROM byle_rezerwacje AS br WHERE br.nr_pokoju = p.nr_pokoju) +
		(SELECT COUNT (*) FROM rezerwacje AS r WHERE r.nr_pokoju = p.nr_pokoju) AS 'ilość rezerwacji'
FROM pokoje AS p
GROUP BY p.nr_pokoju

--#3  Wyświetl nazwiska klientów i numery ich rezerwacji, które zostały zrealizowane w dniu tygodnia, w którym było najwięcej rezerwacji.
SELECT nazwisko, nr_rezerwacji 
FROM klienci AS k, rezerwacje AS r WHERE DATENAME (dw, poczatek_rezerwacji) = 
		(SELECT TOP 1 DATENAME (dw, poczatek_rezerwacji) 
		FROM rezerwacje 
		GROUP BY DATENAME (dw, poczatek_rezerwacji)
		ORDER BY COUNT (*) DESC) AND r.nr_klienta = k.nr_klienta

--#4 Wyświetl imie, nazwisko pracowników zatrudnionych w hotelu oraz nazwiska wszystkich jego współpracowników kończących się na 'k'.
SELECT DISTINCT x.imie, x.nazwisko, y.nazwisko AS 'współpracownik', s.nazwa AS 'stanowisko'
FROM pracownicy x, pracownicy y, stanowiska s
WHERE	x.nr_stanowiska = y.nr_stanowiska AND
		x.nr_pracownika <> y.nr_pracownika AND
		x.nr_stanowiska = s.nr_stanowiska AND
		y.nr_stanowiska = s.nr_stanowiska AND
		y.nazwisko LIKE '%k'

--#5 Dla każdego stanowiska wyświetl liczbę pracowników mających więcej niż 50 lat oraz sumę ich pensji. Rezultat zapytania umieść w jednym ciągu.
SELECT CONCAT( nazwa, ' liczba pracowników: ', COUNT (*), ' suma pensji: ', SUM(placa) )
FROM pracownicy as p, stanowiska as s 
WHERE p.nr_stanowiska = s.nr_stanowiska  
AND ((YEAR(GETDATE()) - YEAR(data_urodzenia))) > 50
GROUP BY nazwa 


-- #6 Wybierz klientów, którzy pochodzą z Poznania bądź Gdanska, a pokoje które będą wynajmowali kosztują więcej niż 900, mimo, że wcześniej nie wynajmowali takich pokojów
SELECT DISTINCT k.imie, k.nazwisko, k.nr_klienta FROM klienci AS k, miasta AS m, rezerwacje AS r, pokoje AS p
WHERE k.miasto = m.nr_miasta AND (m.nazwa = 'Poznan' or m.nazwa = 'Gdansk') AND k.nr_klienta = r.nr_klienta
AND r.nr_pokoju = p.nr_pokoju AND p.cena > 800 AND k.nr_klienta IN
(	SELECT DISTINCT kk.nr_klienta FROM klienci AS kk, byle_rezerwacje AS bb, pokoje AS pp
	WHERE kk.nr_klienta = bb.nr_klienta AND bb.nr_pokoju = pp.nr_pokoju AND pp.cena <= 800)

-- #7 Wybierz pokoje, które były wynajmowane tylko przez klientów 2 bądź 3 typu, ale nikt nie planuje wynajmować ich później
SELECT DISTINCT b.nr_pokoju FROM byle_rezerwacje AS b, klienci AS k
WHERE b.nr_klienta = k.nr_klienta AND (k.typ = 2 OR k.typ = 3) AND b.nr_pokoju NOT IN
(SELECT DISTINCT rr.nr_pokoju FROM rezerwacje AS RR)

-- #8 Wybierz pracowników, którzy zarabiają najwięcej na swoim stanowisku, posortuj ich alfabetycznie po stanowiskach
SELECT s.nazwa AS 'Stanowisko', p.imie, p.nazwisko, p.nr_pracownika, p.placa FROM pracownicy AS p, stanowiska AS s
WHERE p.nr_stanowiska = s.nr_stanowiska AND p.nr_pracownika IN
(SELECT TOP 1 pp.nr_pracownika FROM pracownicy AS pp WHERE p.nr_stanowiska = pp.nr_stanowiska)
ORDER BY s.nazwa

-- #9 Wybierz klientów, którzy zawsze rezerwowali pokoje z sejfem bez wanny i pochodzą z miast, z których nie pochodzą byli pracownicy
SELECT DISTINCT k.imie, k.nazwisko, k.nr_klienta, m.nazwa AS 'miasto'
FROM klienci AS k, miasta AS m, rezerwacje AS r, pokoje AS p, byle_rezerwacje AS b
WHERE ((k.nr_klienta = r.nr_klienta AND r.nr_pokoju = p.nr_pokoju AND p.czy_sejf = 1 AND p.czy_wanna = 0) 
OR (k.nr_klienta = b.nr_klienta AND b.nr_pokoju = p.nr_pokoju AND p.czy_sejf = 1 AND p.czy_wanna = 0))
AND k.miasto NOT IN (SELECT DISTINCT miasto FROM byli_pracownicy) AND k.miasto = m.nr_miasta

-- #10 Wybierz pokoje, które są zarezerowane tylko raz przez klientów niepochodzących z Łodzi bądź Warszawy, 
--		jednak wcześniej były wynajęte chociaż raz właśnie przez klientów z tych miast
SELECT DISTINCT r.nr_pokoju, COUNT (*) AS 'ilosc_rezerwacji' FROM rezerwacje AS r, klienci AS k
WHERE r.nr_klienta = k.nr_klienta AND k.miasto <> 1 AND k.miasto <> 2 AND r.nr_pokoju IN
(	SELECT DISTINCT bb.nr_pokoju FROM byle_rezerwacje AS bb, klienci AS kk, miasta AS mm
	WHERE bb.nr_klienta = kk.nr_klienta AND kk.miasto = mm.nr_miasta AND (mm.nr_miasta = 1 OR mm.nr_miasta = 2))
GROUP BY r.nr_pokoju
HAVING COUNT (*) = 1


-- #11 liczba klientow danego typu
select typ, count(typ) as 'liczba klientów' from klienci
group by typ

-- #12 dane klienta ktory najwiecej zaplacil oraz jego ulubiony pokoj
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

-- #13 cena najdrozszego pokoju na najczesciej wybieranym pietrze
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


-- #14 Wyświetl pracowników zarabiających powyżej średniej płacy w hotelu.
SELECT nr_pracownika, imie, nazwisko, nazwa
FROM pracownicy AS p, stanowiska AS s
WHERE p.nr_stanowiska = s.nr_stanowiska AND p.placa > (SELECT AVG(placa) FROM pracownicy)
GROUP BY nr_pracownika, imie, nazwisko, nazwa, placa


-- #15 Dla każdego stanowiska wyświetl liczbę pracowników. 
SELECT nazwa, COUNT (*) AS 'ilość pracowników'
FROM pracownicy as p, stanowiska as s WHERE p.nr_stanowiska = s.nr_stanowiska GROUP BY nazwa 

