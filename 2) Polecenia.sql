-- ZSBD: Projekt Systemu
-- Część 2 - Polecenia (Procedury, Funkcje, Wyzwalacze)
--
-- Autorzy:
-- Paweł Galewicz	210182
-- Justyna Hubert	210200
-- Karol Podlewski	210294

USE hotel
GO

-- Proceudra #1 - przenosi archwailne rezerwacje do tabeli byle_rezerwacje

IF EXISTS (SELECT 1 FROM sysobjects WHERE NAME='rezerwacje_archiwalne')
DROP PROCEDURE rezerwacje_archiwalne
GO

CREATE PROCEDURE rezerwacje_archiwalne
AS
  BEGIN 
	INSERT INTO byle_rezerwacje
	SELECT nr_rezerwacji, nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, DATEADD(DAY, dni, poczatek_rezerwacji)
	FROM rezerwacje
	WHERE DAY(GETDATE()) > DAY(poczatek_rezerwacji) + dni

	DELETE FROM rezerwacje WHERE DAY(GETDATE()) > DAY(poczatek_rezerwacji) + dni
  END
GO


-- Proceudra #2 - usuwa konkretnego (wskazanego przez numer przy wywolaniu) pracownika z tabeli pracownicy

IF EXISTS (SELECT 1 FROM sysobjects WHERE NAME='usun_pracownika')
DROP PROCEDURE usun_pracownika
GO

CREATE PROCEDURE usun_pracownika (@numer INT)
AS
  BEGIN
	UPDATE pracownicy SET data_zwolnienia = GETDATE() WHERE nr_pracownika = @numer
	DELETE FROM pracownicy WHERE nr_pracownika = @numer
  END
GO


-- Procedura #3 - poprawia rejestracje, ktore nie byly poprawnie zarejestwoane (zbyt duza liczba osob) oraz drukuje komunikat, które z nich są niepoprawne

IF EXISTS (SELECT 1 FROM sysobjects WHERE NAME='poprawnosc_rejestracji')
DROP PROCEDURE poprawnosc_rejestracji
GO

CREATE PROCEDURE poprawnosc_rejestracji
AS
 BEGIN
	DECLARE Kursor CURSOR FOR SELECT nr_rezerwacji, nr_pokoju, ile_osob FROM rezerwacje

	DECLARE @nr_r INT, @nr_p INT, @ile INT, @ilosc INT

	OPEN Kursor
	FETCH NEXT FROM Kursor INTO @nr_r, @nr_p, @ile

	WHILE @@FETCH_STATUS = 0
	  BEGIN
		SET @ilosc = (SELECT ilosc_osob FROM pokoje WHERE @nr_p = nr_pokoju)
		
		IF (@ile > @ilosc)
		  BEGIN
			PRINT 'Poprawiam ilosc osob w rezerwacji ' + CONVERT(varchar(4), @nr_r) + '(pokoj ' + CONVERT(varchar(3), @nr_p) + ' z ' + CONVERT(varchar(5), @ile)  + ' na ' + CONVERT(varchar(1), @ilosc) + ')'
			UPDATE rezerwacje SET ile_osob = @ilosc WHERE nr_rezerwacji = @nr_r
		  END
		FETCH NEXT FROM Kursor INTO @nr_r, @nr_p, @ile
	  END

	CLOSE Kursor
	DEALLOCATE Kursor
 END
GO


-- Funkcja #1 - oblicza cenę danej rezerwacji

IF EXISTS (SELECT 1 FROM sysobjects WHERE NAME='cena_rezerwacji')
DROP FUNCTION cena_rezerwacji
GO

CREATE FUNCTION cena_rezerwacji(@nr int)
RETURNS int
AS
	BEGIN
		DECLARE @suma int
		SET @suma = 0
		IF EXISTS (SELECT nr_rezerwacji FROM rezerwacje WHERE nr_rezerwacji = @nr) BEGIN
			SET @suma += ((SELECT cena FROM rezerwacje AS r , pokoje AS p WHERE r.nr_rezerwacji = @nr 
							AND r.nr_pokoju = p.nr_pokoju) *
							(SELECT dni FROM rezerwacje WHERE nr_rezerwacji = @nr))

			IF EXISTS (SELECT typ FROM klienci AS k, rezerwacje AS r WHERE typ = 2 AND r.nr_klienta = k.nr_klienta AND r.nr_rezerwacji = @nr)
				SET @suma = @suma * 0.9

			IF EXISTS (SELECT typ FROM klienci AS k, rezerwacje AS r WHERE typ = 3 AND r.nr_klienta = k.nr_klienta AND r.nr_rezerwacji = @nr)
				SET @suma = @suma * 0.8

			RETURN @suma
		END

		ELSE
			SET @suma += ((SELECT cena FROM byle_rezerwacje AS br, pokoje AS p WHERE br.nr_rezerwacji = @nr 
							AND br.nr_pokoju = p.nr_pokoju) * 
							(SELECT DATEDIFF(DAY, poczatek_rezerwacji, koniec_rezerwacji) FROM byle_rezerwacje WHERE nr_rezerwacji = @nr))

			IF EXISTS (SELECT typ FROM klienci AS k, byle_rezerwacje AS br WHERE typ = 2 AND br.nr_klienta = k.nr_klienta AND br.nr_rezerwacji = @nr)
				SET @suma = @suma * 0.9

			IF EXISTS (SELECT typ FROM klienci AS k, byle_rezerwacje AS br WHERE typ = 3 AND br.nr_klienta = k.nr_klienta AND br.nr_rezerwacji = @nr)
				SET @suma = @suma * 0.8

			RETURN @suma
		END
GO


-- Wyzwalacz #1 - podczas usuwania pracownika przenosi go do tabeli byli_pracownicy

IF EXISTS (SELECT 1 FROM sysobjects WHERE NAME='pracownik_archiwalny')
DROP TRIGGER pracownik_archiwalny
GO

CREATE TRIGGER pracownik_archiwalny
ON pracownicy
AFTER delete
AS
 BEGIN
	INSERT INTO byli_pracownicy
	SELECT * FROM deleted
 END
GO

