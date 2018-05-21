-- ZSBD: Projekt Systemu
-- Część 4 - Zapytania
--
-- Autorzy:
-- Paweł Galewicz	210182
-- Justyna Hubert	210200
-- Karol Podlewski	210294

USE hotel
GO

-- Procedura #1 - poprawia rejestracje, ktore nie byly poprawnie zarejestwoane (zbyt duza liczba osob) oraz drukuje komunikat, które z nich są niepoprawne

EXEC poprawnosc_rejestracji_osoby
