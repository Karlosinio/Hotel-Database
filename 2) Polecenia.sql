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
	INSERT INTO byli_pracownicy SELECT * FROM pracownicy WHERE nr_pracownika = @numer
	DELETE FROM pracownicy WHERE nr_pracownika = @numer
  END
GO


-- Procedura #3 - poprawia rejestracje, ktore nie byly poprawnie zarejestwoane (zbyt duza liczba osob) oraz drukuje komunikat, które z nich są niepoprawne
IF EXISTS (SELECT 1 FROM sysobjects WHERE NAME='poprawnosc_rejestracji')
DROP PROCEDURE poprawnosc_rejestracji_osoby
GO

CREATE PROCEDURE poprawnosc_rejestracji_osoby
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

-- Funkcja #2 - sprawdzenie czy pokoj jest wolny w danym czasie
if exists (select 1 from sysobjects where name = 'dostepnosc_pokoju')
drop function dostepnosc_pokoju
go

create function dostepnosc_pokoju(@pokoj int, @poczatek date, @ile_dni int)
returns bit
 as
  begin
	if exists 
		(
		select * from rezerwacje
		where @pokoj = nr_pokoju 
			  and
			  (
			  (@poczatek >= poczatek_rezerwacji and @poczatek <= dateadd(day, dni, poczatek_rezerwacji))
			  or
			  (dateadd(day, @ile_dni, @poczatek) >= poczatek_rezerwacji and dateadd(day, @ile_dni, @poczatek) <= dateadd(day, dni, poczatek_rezerwacji))
			  or
			  (@poczatek <= poczatek_rezerwacji and dateadd(day, @ile_dni, @poczatek) >= dateadd(day, dni, poczatek_rezerwacji))
			  )
		)
		return 0

	return 1
 end
go


-- Wyzwalacz #1 - po zarchiwizowaniu wypozyczenia sprawdzane jest, czy klient nie awansowal do nowego typu
if exists (select 1 from sysobjects where name='awans_klienta')
	drop trigger awans_klienta
go


create trigger awans_klienta
on byle_rezerwacje
after insert
as
 begin
	--------------tu mozna zmienic ilosc rezerwacji potrzebnych na awans-----------
	declare @silver int = 5
	declare @gold int = 10
	-------------------------------------------------------------------------------
	
	declare awans cursor for
	select nr_klienta from inserted
	declare @id int, @ilosc_rezerwacji int
	open awans
	fetch next from awans into @id
	while @@FETCH_STATUS = 0
	 begin
		select @ilosc_rezerwacji = count(*) from byle_rezerwacje
		where nr_klienta = @id

		if @ilosc_rezerwacji > @gold
			update klienci
			set typ = 3
			where nr_klienta = @id
		else if @ilosc_rezerwacji > @silver
			update klienci
			set typ = 2
			where nr_klienta = @id
		fetch next from awans into @id
	 end
	close awans
	deallocate awans
 end
go


-- Wyzwalacz #2 - rozpatrywanie dodawanych rezerwacji i akcetowanie tylko tych o dostepnych pokojach w zadanym czasie
if exists (select 1 from sysobjects where name='autoryzacja_rezerwacji')
	drop trigger autoryzacja_rezerwacji
go

create trigger autoryzacja_rezerwacji
on rezerwacje
instead of insert
as
 begin
	declare autoryzacja cursor for
	select nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni from inserted
	declare @klient int, @pokoj int, @ile_osob int, @poczatek_rezerwacji date, @dni int
	open autoryzacja
	fetch next from autoryzacja into @klient, @pokoj, @ile_osob, @poczatek_rezerwacji, @dni
	while @@FETCH_STATUS = 0
	 begin
		begin transaction
			if(dbo.dostepnosc_pokoju(@pokoj, @poczatek_rezerwacji, @dni) = 0)
			 begin
				print 'Err: Pokoj ' + convert(varchar(3), @pokoj)+ ' jest zajety w żądanym okresie (od ' + convert(varchar(20), @poczatek_rezerwacji) + ' do ' + convert(varchar(20), dateadd(day, @dni, @poczatek_rezerwacji)) + ')'
				rollback
			 end
			else
			 begin
				insert into rezerwacje values (@klient, @pokoj, @ile_osob, @poczatek_rezerwacji, @dni)
				commit
			 end
		fetch next from autoryzacja into @klient, @pokoj, @ile_osob, @poczatek_rezerwacji, @dni
	 end
	close autoryzacja
	deallocate autoryzacja
 end
 go



 -- Wyzwalacz #3 - podczas rezerwacji proponuje lepsze pokoje które lepiej spełniają wymagania (posiadają przynajmniej te same cechy,
IF EXISTS (SELECT 1 FROM sysobjects WHERE NAME='tansze_pokoje')
	DROP TRIGGER tansze_pokoje
GO

CREATE TRIGGER tansze_pokoje
ON rezerwacje
FOR INSERT
AS
 BEGIN
	DECLARE @nr_p INT, @il_o INT, @cena INT, @c_w BIT, @c_s BIT

	DECLARE Kursor CURSOR FOR SELECT nr_pokoju, ilosc_osob, cena, czy_wanna, czy_sejf FROM pokoje
	OPEN Kursor
	FETCH NEXT FROM Kursor INTO @nr_p, @il_o, @cena, @c_w, @c_s

	WHILE @@FETCH_STATUS = 0
	  BEGIN
		IF ((@cena <= (SELECT p.cena FROM pokoje AS p, inserted AS i WHERE i.nr_pokoju = p.nr_pokoju))
		   AND (@nr_p NOT IN (SELECT r.nr_pokoju FROM rezerwacje AS r, inserted AS i
				WHERE ((i.poczatek_rezerwacji > DATEADD(DAY, r.dni, r.poczatek_rezerwacji)) OR (DATEADD(DAY, i.dni, i.poczatek_rezerwacji) < r.poczatek_rezerwacji)))))
		  BEGIN
			DECLARE @opis VARCHAR(200) = ''

			IF (@cena < (SELECT p.cena FROM pokoje AS p, inserted AS i WHERE i.nr_pokoju = p.nr_pokoju))
				SET @opis = 'pokoj jest tanszy, '

			IF (@il_o < (SELECT p.ilosc_osob FROM pokoje AS p, inserted AS i WHERE i.nr_pokoju = p.nr_pokoju))
				SET @opis = @opis + 'miesci sie wiecej osob, '

			IF (@c_s < (SELECT p.czy_sejf FROM pokoje AS p, inserted AS i WHERE i.nr_pokoju = p.nr_pokoju))
				SET @opis = @opis + 'jest sejf, '

			IF (@c_w < (SELECT p.czy_wanna FROM pokoje AS p, inserted AS i WHERE i.nr_pokoju = p.nr_pokoju))
				SET @opis = @opis + 'jest wanna.'

			if @opis <> ''
				PRINT '   Pokoj ' + CONVERT(VARCHAR(3), @nr_p) + ' jest lepszym pokojem do wynajęcia, ponieważ: ' + @opis

		  END
			FETCH NEXT FROM Kursor INTO @nr_p, @il_o, @cena, @c_w, @c_s
	  END
	CLOSE Kursor
	DEALLOCATE Kursor
 END
GO
