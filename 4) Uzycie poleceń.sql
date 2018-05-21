-- ZSBD: Projekt Systemu
-- Część 4 - Zapytania
--
-- Autorzy:
-- Paweł Galewicz	210182
-- Justyna Hubert	210200
-- Karol Podlewski	210294

USE hotel
GO

-- Proceudra #1 - przenosi archwailne rezerwacje do tabeli byle_rezerwacje

EXEC rezerwacje_archiwalne

-- Proceudra #2 - usuwa konkretnego (wskazanego przez numer przy wywolaniu) pracownika z tabeli pracownicy

EXEC usun_pracownika 10
EXEC usun_pracownika 12
EXEC usun_pracownika 14

-- Procedura #3 - poprawia rejestracje, ktore nie byly poprawnie zarejestwoane (zbyt duza liczba osob) oraz drukuje komunikat, które z nich są niepoprawne
EXEC poprawnosc_rejestracji

--Procedura #4 - najczesciej rezerwowany pokoj na danym pietrze
EXEC najczestszy_pokoj 2

-- Procedura #5 - oplaty dla pracownikow w danym miesiacu z danego roku
EXEC oplaty '2018', 'Styczen'


-- Funkcja #1 - oblicza cenę danej rezerwacji
SELECT *, dbo.cena_rezerwacji(nr_rezerwacji) as 'cena_rezerwacji' FROM rezerwacje

-- Funkcja #2 - sprawdzenie czy pokoj jest wolny w danym czasie
SELECT nr_pokoju, dbo.dostepnosc_pokoju(nr_pokoju, '2018/8/8', 15) AS 'Czy dostepny w terminie 08-23.08.2018)' FROM pokoje WHERE nr_pokoju LIKE '3%'
