﻿-- ZSBD: Projekt Systemu
-- Część 3 - Dane
--
-- Autorzy:
-- Paweł Galewicz	210182
-- Justyna Hubert	210200
-- Karol Podlewski	210294

use hotel
go


insert into miasta (nazwa)
values ('Warszawa'),
('Lodz'),
('Krakow'),
('Poznan'),
('Gdansk'),
('Wroclaw'),
('Torun'),
('Zamosc'),
('Lublin'),
('Szczecin');

select * from miasta
go

insert into pokoje (nr_pokoju, ilosc_osob, cena, czy_wanna, czy_sejf)
values ('100', '2', '800', '0', '1'),
('101', '4', '500', '1', '0'),
('102', '4', '700', '1', '1'),
('103', '2', '1000', '0', '0'),
('104', '3', '900', '0', '1'),
('105', '3', '600', '1', '0'),
('106', '1', '700', '0', '1'),
('107', '1', '500', '0', '1'),
('108', '3', '700', '1', '1'),
('109', '1', '900', '0', '1'),
('200', '1', '1000', '1', '1'),
('201', '3', '1000', '1', '0'),
('202', '2', '800', '0', '1'),
('203', '3', '800', '1', '1'),
('204', '2', '1000', '1', '1'),
('205', '1', '900', '0', '1'),
('206', '4', '600', '0', '0'),
('207', '4', '700', '0', '0'),
('208', '1', '700', '0', '1'),
('209', '4', '600', '0', '1'),
('300', '2', '900', '0', '0'),
('301', '3', '600', '1', '0'),
('302', '1', '600', '0', '0'),
('303', '4', '800', '0', '0'),
('304', '2', '800', '0', '0'),
('305', '4', '1000', '1', '0'),
('306', '2', '800', '1', '1'),
('307', '3', '800', '0', '1'),
('308', '4', '800', '0', '0'),
('309', '1', '500', '0', '1');

select * from pokoje
go


insert into klienci (imie, nazwisko, miasto, adres, telefon, data_urodzenia, typ)
values ('Izabela', 'Kołodziej', '3', 'Grzegorzowska 33', '523584547', '1995/7/10', '3'),
('Krzysztof', 'Andrzejewski', '5', 'Rafałowska 56', '584894914', '1948/11/7', '3'),
('Czesław', 'Duda', '7', 'Adamowska 81', '528246425', '1941/1/19', '2'),
('Damian', 'Walczak', '6', 'Michałowska 115', '521333565', '1971/2/3', '2'),
('Paulina', 'Krawczyk', '2', 'Danielowska 85', '562714483', '1967/3/17', '3'),
('Sylwia', 'Andrzejewski', '6', 'Romanowska 87', '546629341', '1957/9/6', '2'),
('Andrzej', 'Sadowski', '1', 'Adamowska 74', '575547128', '1968/12/13', '1'),
('Ryszard', 'Jasiński', '8', 'Józefowska 96', '589797817', '1967/6/6', '3'),
('Marcin', 'Wasilewski', '1', 'Marekowska 109', '556578799', '1986/5/12', '2'),
('Sławomir', 'Michalak', '5', 'Czesławowska 4', '543329255', '1959/8/1', '2'),
('Mieczysław', 'Maciejewski', '7', 'Jerzyowska 54', '589372555', '1984/5/8', '2'),
('Alicja', 'Adamczyk', '6', 'Stanisławowska 32', '526469147', '1969/3/1', '1'),
('Iwona', 'Adamski', '3', 'Mirosławowska 10', '564646831', '1953/9/10', '3'),
('Józef', 'Rutkowski', '9', 'Tadeuszowska 133', '522266575', '1999/1/18', '3'),
('Artur', 'Nowakowski', '2', 'Tadeuszowska 39', '519741244', '1951/1/5', '2'),
('Piotr', 'Borkowski', '4', 'Tomaszowska 32', '536928663', '1973/5/5', '3'),
('Maria', 'Rutkowski', '7', 'Romanowska 16', '529533628', '1951/11/6', '2'),
('Krystyna', 'Krajewski', '5', 'Kamilowska 19', '549372563', '1946/3/18', '2'),
('Maciej', 'Król', '4', 'Czesławowska 74', '567467168', '1996/12/6', '1'),
('Agnieszka', 'Majewski', '10', 'Januszowska 21', '512189785', '1946/5/25', '3'),
('Renata', 'Górski', '10', 'Rafałowska 38', '515996338', '1968/8/18', '2'),
('Marianna', 'Walczak', '7', 'Władysławowska 59', '553853779', '1982/8/30', '1'),
('Ryszard', 'Głowacki', '3', 'Przemysławowska 108', '599395413', '1995/4/15', '1'),
('Daniel', 'Baran', '6', 'Dariuszowska 24', '528477335', '1977/7/17', '3'),
('Stanisław', 'Marciniak', '4', 'Marianowska 43', '585629369', '1961/6/29', '2'),
('Agnieszka', 'Sokołowski', '4', 'Zbigniewowska 59', '562945919', '1960/8/8', '1'),
('Dawid', 'Szulc', '6', 'Wojciechowska 89', '552595834', '1984/12/29', '2'),
('Patrycja', 'Zalewski', '4', 'Mariuszowska 73', '521528289', '1951/2/27', '3'),
('Janina', 'Wiśniewski', '6', 'Damianowska 40', '518546418', '1970/11/16', '3'),
('Stanisław', 'Król', '8', 'Jerzyowska 39', '585312875', '1985/5/20', '1'),
('Alicja', 'Stępień', '10', 'Piotrowska 45', '574475556', '1972/9/30', '3'),
('Marianna', 'Szymczak', '3', 'Sebastianowska 38', '574983874', '1941/2/2', '2'),
('Wanda', 'Majewski', '9', 'Janowska 45', '599326176', '1990/3/2', '3'),
('Izabela', 'Baran', '9', 'Kazimierzowska 55', '517842922', '1999/7/30', '2'),
('Genowefa', 'Sadowski', '2', 'Edwardowska 24', '569169912', '1974/9/1', '1'),
('Marcin', 'Tomaszewski', '10', 'Mariuszowska 23', '547683628', '1967/6/5', '1'),
('Jarosław', 'Górski', '7', 'Mateuszowska 76', '511489432', '1988/8/23', '2'),
('Halina', 'Michalak', '1', 'Dariuszowska 136', '539435584', '1994/8/2', '3'),
('Stanisław', 'Rutkowski', '4', 'Pawełowska 130', '569864313', '1962/7/22', '3'),
('Krzysztof', 'Sokołowski', '4', 'Dariuszowska 123', '537213872', '1963/9/14', '3');


select * from klienci
go


insert into stanowiska (nazwa, placa_minimalna)
values ('Barista', '4000'),
('Barman', '5000'),
('Concierge', '8000'),
('Kelner', '3000'),
('Kucharz', '6000'),
('Konserwator', '7000'),
('Pokojowka', '3000'),
('Sprzataczka', '3500'),
('Operator windy', '4500'),
('Recepjonista', '4000'),
('Dyrektor hotelu', '18000'),
('Kierownik lokalu gastronomicznego', '11000'),
('Specjalista ds. rezerwacji', '13000');

select * from stanowiska
go

insert into pracownicy (imie, nazwisko, miasto, adres, telefon, data_urodzenia, data_zatrudnienia, nr_stanowiska, placa)
values ('Sebastian', 'Wójcik', '7', 'Mieczysławowska 33', '522625836', '1952/7/16', '2012/7/14', '4', '7000'),
('Agnieszka', 'Ziółkowski', '7', 'Jacekowska 96', '547855741', '1960/6/2', '2015/6/20', '9', '4000'),
('Wanda', 'Szymański', '7', 'Wiesławowska 44', '528663782', '1943/6/1', '2013/7/14', '6', '7000'),
('Dariusz', 'Wójcik', '8', 'Michałowska 27', '547484124', '1991/5/10', '2013/10/30', '8', '9000'),
('Danuta', 'Mazur', '8', 'Zbigniewowska 11', '511574255', '1975/4/25', '2004/1/26', '7', '7000'),
('Grażyna', 'Sawicki', '7', 'Pawełowska 133', '571929796', '1955/1/16', '2005/7/10', '8', '8000'),
('Aleksandra', 'Szymański', '7', 'Dariuszowska 140', '539357485', '1986/11/7', '2002/3/2', '2', '6000'),
('Wiesława', 'Kwiatkowski', '7', 'Dariuszowska 38', '574767589', '1967/1/5', '2014/5/16', '1', '10000'),
('Małgorzata', 'Kaźmierczak', '8', 'Krzysztofowska 127', '597699391', '1961/3/22', '2003/12/30', '6', '14000'),
('Marzena', 'Kowalski', '7', 'Jerzyowska 136', '542617526', '1962/12/5', '2012/6/11', '4', '4000'),
('Grzegorz', 'Ostrowski', '8', 'Maciejowska 91', '572178236', '1960/4/20', '2003/3/24', '5', '1000'),
('Sebastian', 'Wojciechowski', '7', 'Andrzejowska 4', '585813773', '1999/1/8', '2010/7/7', '3', '8000'),
('Dariusz', 'Kwiatkowski', '8', 'Sebastianowska 24', '543867217', '1947/8/21', '2002/3/12', '2', '5000'),
('Urszula', 'Wójcik', '8', 'Jacekowska 39', '516529962', '1956/8/13', '2003/8/13', '7', '3000'),
('Rafał', 'Majewski', '7', 'Danielowska 39', '593899179', '1946/5/2', '2004/10/21', '7', '6000'),
('Agnieszka', 'Górski', '7', 'Marekowska 18', '535553553', '1971/10/8', '2001/3/11', '9', '12000'),
('Natalia', 'Sadowski', '8', 'Mirosławowska 111', '555926834', '1981/11/10', '2002/6/16', '7', '6000'),
('Jadwiga', 'Ostrowski', '8', 'Dariuszowska 26', '571152243', '1966/10/20', '2010/7/13', '4', '7000'),
('Stanisława', 'Gajewski', '8', 'Piotrowska 30', '511751869', '1942/11/16', '2014/9/16', '10', '6000'),
('Tadeusz', 'Pawlak', '7', 'Jarosławowska 150', '512196754', '1956/3/4', '2014/12/25', '1', '5000'),
('Paweł', 'Dyrektorowicz', '2', 'Pawełowska 69', '555403187', '1997/10/21', '2010/10/21', '11', '22000'),
('Justyna', 'Kierownikowicz', '2', 'Justynowska 32', '577843621', '1997/10/26', '2010/10/26', '12', '18000'),
('Karol', 'Rezerwaczowicz', '2', 'Karolowska 8', '518126408', '1997/8/18', '2010/11/18', '13', '15000');

select * from pracownicy
go



insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('12', '304', '3', '2018/7/28', '19');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('1', '107', '1', '2018/11/19', '16');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('14', '302', '4', '2018/6/23', '8');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('15', '205', '2', '2018/5/29', '15');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('15', '303', '1', '2018/8/15', '12');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('19', '200', '2', '2018/9/11', '5');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('9', '109', '2', '2018/11/21', '18');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('9', '200', '2', '2018/11/3', '14');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('2', '300', '3', '2018/5/18', '5');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('36', '305', '4', '2018/5/4', '18');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('36', '203', '4', '2018/5/27', '9');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('17', '207', '1', '2018/11/10', '15');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('4', '108', '1', '2018/7/8', '6');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('32', '109', '1', '2018/6/23', '9');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('38', '207', '3', '2018/5/12', '7');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('21', '202', '4', '2018/6/24', '5');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('17', '100', '2', '2018/9/20', '10');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('16', '107', '4', '2018/4/21', '16');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('2', '301', '2', '2018/12/3', '15');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('10', '208', '3', '2018/2/12', '20');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('29', '304', '4', '2018/12/27', '2');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('24', '200', '2', '2018/2/4', '10');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('23', '208', '1', '2018/8/23', '6');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('19', '301', '4', '2018/8/17', '7');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('25', '204', '2', '2018/10/13', '11');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('40', '204', '4', '2018/12/25', '7');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('36', '307', '3', '2018/8/26', '3');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('38', '203', '1', '2018/8/29', '17');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('5', '107', '2', '2018/5/22', '15');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('23', '205', '2', '2018/6/7', '15');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('15', '107', '1', '2018/9/2', '2');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('18', '203', '3', '2018/12/22', '11');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('29', '209', '4', '2018/8/9', '8');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('25', '109', '4', '2018/12/14', '7');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('9', '305', '3', '2018/12/12', '20');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('17', '308', '1', '2018/7/10', '18');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('8', '103', '4', '2018/11/5', '2');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('20', '204', '4', '2018/1/5', '8');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('27', '102', '1', '2018/1/7', '14');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('30', '100', '3', '2018/3/10', '16');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('4', '207', '1', '2018/2/26', '10');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('14', '301', '4', '2018/3/19', '16');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('10', '208', '2', '2018/2/22', '8');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('16', '205', '2', '2018/8/12', '9');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('36', '302', '3', '2018/3/19', '16');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('20', '201', '3', '2018/8/10', '16');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('38', '200', '4', '2018/8/18', '7');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('28', '202', '4', '2018/4/22', '6');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('27', '208', '2', '2018/3/6', '1');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('32', '305', '4', '2018/2/3', '6');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('1', '208', '3', '2018/7/17', '10');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('33', '201', '1', '2018/5/18', '7');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('24', '307', '2', '2018/8/29', '17');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('5', '309', '1', '2018/11/30', '9');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('27', '307', '4', '2018/9/5', '17');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('20', '301', '3', '2018/10/23', '20');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('12', '200', '1', '2018/8/25', '19');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('33', '101', '3', '2018/8/23', '4');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('2', '301', '2', '2018/7/20', '11');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('22', '200', '1', '2018/5/3', '10');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('31', '209', '1', '2018/5/14', '16');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('40', '208', '3', '2018/5/25', '8');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('11', '308', '3', '2018/1/3', '2');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('4', '205', '2', '2018/8/26', '9');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('2', '204', '1', '2018/10/20', '1');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('3', '201', '1', '2018/7/29', '20');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('19', '108', '4', '2018/5/17', '3');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('31', '205', '4', '2018/11/9', '9');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('29', '307', '2', '2018/7/26', '9');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('36', '108', '4', '2018/2/7', '10');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('16', '102', '4', '2018/9/21', '10');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('11', '200', '4', '2018/11/29', '18');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('23', '108', '4', '2018/10/13', '1');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('10', '202', '4', '2018/7/14', '9');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('17', '303', '1', '2018/12/14', '3');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('19', '203', '4', '2018/10/5', '20');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('29', '109', '2', '2018/9/28', '19');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('1', '107', '3', '2018/4/11', '4');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('2', '200', '2', '2018/2/4', '3');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('5', '104', '2', '2018/5/20', '16');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('11', '209', '2', '2018/3/17', '4');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('19', '205', '1', '2018/5/14', '11');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('31', '101', '2', '2018/9/15', '9');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('30', '109', '2', '2018/2/13', '18');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('37', '203', '4', '2018/9/25', '21');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('40', '306', '2', '2018/5/21', '4');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('2', '200', '3', '2018/1/8', '4');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('21', '308', '3', '2018/11/12', '1');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('29', '102', '2', '2018/7/26', '16');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('20', '204', '3', '2018/8/13', '20');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('19', '108', '3', '2018/6/5', '15');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('25', '205', '4', '2018/11/10', '7');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('24', '206', '4', '2018/5/15', '13');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('24', '200', '1', '2018/1/17', '2');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('36', '201', '1', '2018/11/17', '20');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('5', '307', '3', '2018/1/4', '17');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('39', '206', '2', '2018/5/5', '15');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('24', '102', '4', '2018/6/10', '6');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('34', '306', '4', '2018/10/4', '12');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('14', '109', '3', '2018/7/11', '21');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('12', '200', '1', '2018/12/7', '12');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('15', '305', '2', '2018/2/21', '14');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('26', '100', '4', '2018/5/21', '6');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('7', '302', '3', '2018/3/17', '2');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('33', '207', '2', '2018/6/20', '12');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('13', '307', '1', '2018/12/16', '2');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('23', '308', '3', '2018/8/11', '14');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('8', '100', '2', '2018/8/18', '5');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('39', '306', '3', '2018/12/2', '17');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('3', '304', '3', '2018/9/6', '10');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('18', '205', '3', '2018/4/25', '7');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('4', '301', '4', '2018/2/29', '15');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('33', '204', '1', '2018/3/4', '11');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('22', '106', '2', '2018/2/18', '10');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('32', '300', '1', '2018/7/4', '4');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('12', '104', '2', '2018/10/17', '3');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('24', '306', '4', '2018/8/4', '21');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('22', '207', '3', '2018/3/2', '5');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('38', '200', '2', '2018/1/15', '10');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('4', '208', '3', '2018/7/19', '14');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('39', '104', '3', '2018/12/26', '6');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('12', '205', '1', '2018/3/14', '15');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('26', '108', '4', '2018/1/5', '10');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('36', '303', '4', '2018/8/29', '9');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('26', '207', '1', '2018/8/28', '9');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('8', '109', '1', '2018/3/12', '12');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('38', '102', '1', '2018/3/10', '2');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('40', '205', '4', '2018/5/13', '17');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('8', '206', '4', '2018/11/15', '2');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('8', '105', '1', '2018/11/9', '16');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('19', '309', '4', '2018/5/9', '5');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('17', '100', '4', '2018/3/2', '15');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('21', '109', '2', '2018/11/12', '13');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('21', '308', '4', '2018/2/28', '13');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('14', '303', '2', '2018/3/20', '13');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('8', '303', '4', '2018/10/22', '1');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('8', '303', '1', '2018/10/15', '19');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('18', '200', '2', '2018/1/19', '4');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('31', '103', '2', '2018/8/24', '13');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('40', '102', '2', '2018/8/14', '17');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('11', '306', '3', '2018/12/24', '2');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('34', '300', '2', '2018/3/2', '4');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('39', '203', '4', '2018/7/17', '6');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('29', '105', '1', '2018/7/19', '7');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('20', '209', '4', '2018/11/21', '7');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('29', '304', '4', '2018/11/22', '4');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('6', '103', '2', '2018/1/5', '9');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('26', '208', '4', '2018/7/3', '4');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('28', '302', '2', '2018/11/13', '2');
insert into rezerwacje (nr_klienta, nr_pokoju, ile_osob, poczatek_rezerwacji, dni)
values ('36', '108', '4', '2018/8/16', '6');

select * from rezerwacje
go