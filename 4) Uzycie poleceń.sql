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
