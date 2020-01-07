-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Czas generowania: 07 Sty 2020, 20:59
-- Wersja serwera: 5.7.26-29-log
-- Wersja PHP: 5.6.40

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `31971658_magazyn`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `Dostawca`
--

CREATE TABLE `Dostawca` (
  `id` int(11) NOT NULL,
  `NazwaDostawcy` varchar(100) NOT NULL,
  `Ulica` varchar(100) NOT NULL,
  `NrBudynku` varchar(20) NOT NULL,
  `Miasto` varchar(100) NOT NULL,
  `KodPocztowy` varchar(6) NOT NULL,
  `NIP` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `Dostawca`
--

INSERT INTO `Dostawca` (`id`, `NazwaDostawcy`, `Ulica`, `NrBudynku`, `Miasto`, `KodPocztowy`, `NIP`) VALUES
(1, 'Taylors Trading', 'plac Świętego Józefa', '12', 'Kalisz', '62-800', '5522446688'),
(2, 'Rekman', 'Jana Pawła', '12/B', 'Sieradz', '98-300', '5566223388'),
(3, 'Competec', 'Al. WOjska POlskiego', '150/J', 'Kalisz', '62-800', '1002005588'),
(4, 'Nowex', 'Poznańska', '25/30', 'Kalisz', '62-800', '5002205544'),
(5, 'Arteesoft', 'ul Straoprzygodzka', '220/20', 'Ostrów Wielkopolski', '62-500', '3005006699');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `JednostkaMiary`
--

CREATE TABLE `JednostkaMiary` (
  `id` int(11) NOT NULL,
  `Nazwa` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `JednostkaMiary`
--

INSERT INTO `JednostkaMiary` (`id`, `Nazwa`) VALUES
(1, 'szt'),
(2, 'metr');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `PZ`
--

CREATE TABLE `PZ` (
  `id` int(11) NOT NULL,
  `NumerPZ` varchar(50) NOT NULL,
  `IdDostawca` int(11) NOT NULL,
  `NazwaDostawcy` varchar(50) NOT NULL,
  `Miasto` varchar(50) NOT NULL,
  `Ulica` varchar(50) NOT NULL,
  `NrBudynku` varchar(20) NOT NULL,
  `KodPocztowy` varchar(6) NOT NULL,
  `NIP` varchar(10) NOT NULL,
  `DataDostawy` timestamp NOT NULL,
  `KwotaLaczna` decimal(10,2) NOT NULL DEFAULT '0.00',
  `IsDone` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `PZ`
--

INSERT INTO `PZ` (`id`, `NumerPZ`, `IdDostawca`, `NazwaDostawcy`, `Miasto`, `Ulica`, `NrBudynku`, `KodPocztowy`, `NIP`, `DataDostawy`, `KwotaLaczna`, `IsDone`) VALUES
(1, 'PZ 1/2020/01/07', 2, 'Rekman', 'Sieradz', 'Jana Pawła', '12/B', '98-300', '5566223388', '2020-01-07 19:58:00', '1300.00', 1);

--
-- Wyzwalacze `PZ`
--
DELIMITER $$
CREATE TRIGGER `tr_PZ_a_U` AFTER UPDATE ON `PZ` FOR EACH ROW BEGIN
DECLARE done BOOLEAN DEFAULT FALSE;
DECLARE il DOUBLE;
DECLARE idT INT;
DECLARE cur1 CURSOR FOR SELECT Ilosc FROM PZTowar WHERE IdPZ = NEW.id;
DECLARE cur2 CURSOR FOR SELECT IdTowar FROM PZTowar WHERE IdPZ = NEW.id;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

IF NEW.IsDone = true THEN

OPEN cur1;
OPEN cur2;

read_loop: LOOP
FETCH cur1 INTO il;
FETCH cur2 INTO idT;
IF done THEN
	LEAVE read_loop;
END IF;
SET @StanM = (SELECT StanMagazynowy FROM Towar WHERE id = idT);
SET @StanD = (SELECT StanDysponowany FROM Towar WHERE id = idT);

UPDATE `Towar` 
SET `StanMagazynowy`= (SELECT @StanM) + il,
	`StanDysponowany`= (SELECT @StanD) + il
WHERE id = idT;

END LOOP;

CLOSE cur1;
CLOSE cur2;

END IF;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `PZTowar`
--

CREATE TABLE `PZTowar` (
  `id` int(11) NOT NULL,
  `IdPZ` int(11) NOT NULL,
  `IdTowar` int(11) NOT NULL,
  `Ilosc` double NOT NULL,
  `CenaKupna` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `PZTowar`
--

INSERT INTO `PZTowar` (`id`, `IdPZ`, `IdTowar`, `Ilosc`, `CenaKupna`) VALUES
(1, 1, 1, 100, '13.00');

--
-- Wyzwalacze `PZTowar`
--
DELIMITER $$
CREATE TRIGGER `tr_PZTowar_a_D` AFTER DELETE ON `PZTowar` FOR EACH ROW BEGIN 

SET @vCurrentKW = (SELECT KwotaLaczna FROM PZ WHERE id = OLD.IdPZ);
SET @vKw = OLD.CenaKupna * OLD.Ilosc;
SET @vNewKW = (SELECT @vCurrentKW) - (SELECT @vKw);

IF (SELECT @vNewKW) < 0 THEN
SET @vNewKW = 0;
END IF;

UPDATE `PZ` 
SET `KwotaLaczna`= (SELECT @vNewKW)
WHERE id = OLD.IdPZ;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_PZTowar_a_I` AFTER INSERT ON `PZTowar` FOR EACH ROW BEGIN 

SET @vCurrentKW = (SELECT KwotaLaczna FROM PZ WHERE id = NEW.IdPZ);
SET @vKw = NEW.CenaKupna * NEW.Ilosc;

UPDATE `PZ` 
SET `KwotaLaczna`= (SELECT @vCurrentKW) + (SELECT @vKw)
WHERE id = NEW.IdPZ;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_PZTowar_a_U` AFTER UPDATE ON `PZTowar` FOR EACH ROW BEGIN 

SET @vCurrentKW = (SELECT KwotaLaczna FROM PZ WHERE id = NEW.IdPZ);
SET @vOldKW = OLD.CenaKupna * OLD.Ilosc;
SET @vKw = NEW.CenaKupna * NEW.Ilosc;
SET @vNewKW = (SELECT @vCurrentKW) + (SELECT @vKw) - (SELECT @vOldKW);

IF (SELECT @vNewKW) < 0 THEN
SET @vNewKW = 0;
END IF;

UPDATE `PZ` 
SET `KwotaLaczna`= (SELECT @vNewKW)
WHERE id = NEW.IdPZ;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `Ranga`
--

CREATE TABLE `Ranga` (
  `id` int(11) NOT NULL,
  `NazwaRangi` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `Ranga`
--

INSERT INTO `Ranga` (`id`, `NazwaRangi`) VALUES
(1, 'admin'),
(2, 'klient'),
(3, 'pracownik');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `Status`
--

CREATE TABLE `Status` (
  `id` int(11) NOT NULL,
  `NazwaStatusu` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `Status`
--

INSERT INTO `Status` (`id`, `NazwaStatusu`) VALUES
(1, 'nowe'),
(2, 'zaakceptowane'),
(3, 'pakowane'),
(4, 'przygotowane do wysyĹki'),
(5, 'wysĹane'),
(6, 'anulowane');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `Towar`
--

CREATE TABLE `Towar` (
  `id` int(11) NOT NULL,
  `Nazwa` varchar(100) NOT NULL,
  `CenaSprzedazy` decimal(10,2) NOT NULL,
  `IdJednostkaMiary` int(11) NOT NULL,
  `ProcentVat` double NOT NULL,
  `Dzial` varchar(50) NOT NULL,
  `Regal` varchar(50) NOT NULL,
  `Polka` varchar(50) NOT NULL,
  `StanMagazynowy` double NOT NULL,
  `StanMax` double NOT NULL,
  `StanMin` double NOT NULL,
  `StanDysponowany` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `Towar`
--

INSERT INTO `Towar` (`id`, `Nazwa`, `CenaSprzedazy`, `IdJednostkaMiary`, `ProcentVat`, `Dzial`, `Regal`, `Polka`, `StanMagazynowy`, `StanMax`, `StanMin`, `StanDysponowany`) VALUES
(1, 'RÄKAWICE SILICON/POLIESTER MECHANIK CXS', '15.00', 1, 23, 'bhp', '23', '10', 100, 40, 5, 100),
(2, 'BEZRÄKAWNIK ARDON 4TECH', '44.00', 1, 23, 'bhp', '25', '11', 0, 20, 5, 0),
(3, 'BLUZA ROBOCZA SIRIUS LUCIUS JASNOSZARA', '55.00', 1, 23, 'bhp', '24', '10', 0, 30, 10, 0),
(4, 'BUTY GUMOFILCE Z NATURALNEJ', '34.00', 1, 23, 'bhp', '15', '5', 0, 25, 5, 0),
(5, 'KOSZULA FLANELOWA TOM', '34.00', 1, 23, 'bhp', '13', '3', 0, 50, 10, 0),
(6, 'KOSZULA DĹUGI RÄKAW SIRIUS', '44.00', 1, 23, 'bhp', '25', '10', 0, 30, 5, 0),
(7, 'SPODNIE OGRODNICZKI SIRIUS', '77.00', 1, 23, 'bhp', '12', '2', 0, 50, 10, 0),
(8, 'OKULARY OCHRONNE JSP DO KASKU', '17.00', 1, 23, 'bhp', '12', '11', 0, 20, 5, 0),
(9, 'HEĹM OCHRONNY JSP EVO8', '33.00', 1, 23, 'bhp', '02', '11', 0, 20, 5, 0),
(10, 'PRZECIWHAĹASOWE NAUSZNIKI 3M PELTOR', '11.00', 1, 23, 'bhp', '13', '11', 0, 20, 5, 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `Uzytkownik`
--

CREATE TABLE `Uzytkownik` (
  `id` int(11) NOT NULL,
  `Imie` varchar(100) NOT NULL,
  `Nazwisko` varchar(100) NOT NULL,
  `Ulica` varchar(100) NOT NULL,
  `NrDomu` varchar(10) NOT NULL,
  `NrLokalu` varchar(10) DEFAULT NULL,
  `Miasto` varchar(100) NOT NULL,
  `KodPocztowy` varchar(6) NOT NULL,
  `Telefon` varchar(9) NOT NULL,
  `IdRanga` int(11) NOT NULL,
  `Login` varchar(30) NOT NULL,
  `Haslo` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `Uzytkownik`
--

INSERT INTO `Uzytkownik` (`id`, `Imie`, `Nazwisko`, `Ulica`, `NrDomu`, `NrLokalu`, `Miasto`, `KodPocztowy`, `Telefon`, `IdRanga`, `Login`, `Haslo`) VALUES
(1, 'Aneta', 'Zając', 'Kwiatowa', '12', '15', 'Sieradz', '98-300', '456123654', 1, 'zajaca', '123'),
(2, 'Alicja', 'Kot', 'Lipowa', '33', '15', 'Sieradz', '98-300', '456123000', 2, 'zajaca', '123'),
(3, 'Jan', 'Kowal', 'Motylkowa', '13', '15', 'Sieradz', '98-300', '555666777', 2, 'kowala', '123'),
(4, 'Leon', 'Wilk', 'Wyzwolenia', '5', '10', 'Kalisz', '68-300', '222333111', 2, 'wilkl', '123'),
(5, 'Ada', 'Mul', 'Nikla', '20', '1', 'Kalisz', '68-300', '888666999', 3, 'mula', '123');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `WZ`
--

CREATE TABLE `WZ` (
  `id` int(11) NOT NULL,
  `NumerWZ` varchar(100) NOT NULL,
  `IdZamowienie` int(11) NOT NULL,
  `DataWydania` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `WZTowar`
--

CREATE TABLE `WZTowar` (
  `id` int(11) NOT NULL,
  `IdWZ` int(11) NOT NULL,
  `IdZamowienieTowar` int(11) NOT NULL,
  `Ilosc` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `Zamowienie`
--

CREATE TABLE `Zamowienie` (
  `id` int(11) NOT NULL,
  `IdUzytkownik` int(11) NOT NULL,
  `DataZamowienia` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `DataWydania` timestamp NULL DEFAULT NULL,
  `IdStatus` int(11) NOT NULL,
  `KwotaLaczna` decimal(10,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `Zamowienie`
--

INSERT INTO `Zamowienie` (`id`, `IdUzytkownik`, `DataZamowienia`, `DataWydania`, `IdStatus`, `KwotaLaczna`) VALUES
(1, 2, '2020-01-03 16:59:56', NULL, 1, '0.00'),
(2, 2, '2020-01-03 17:01:20', NULL, 1, '0.00'),
(3, 3, '2020-01-03 17:01:20', NULL, 1, '0.00'),
(4, 4, '2020-01-03 17:01:20', NULL, 1, '0.00'),
(5, 2, '2020-01-03 17:01:20', NULL, 1, '0.00'),
(6, 3, '2020-01-03 17:01:20', NULL, 1, '0.00'),
(7, 3, '2020-01-03 17:01:20', NULL, 1, '0.00');

--
-- Wyzwalacze `Zamowienie`
--
DELIMITER $$
CREATE TRIGGER `tr_Zamowienie_a_U` AFTER UPDATE ON `Zamowienie` FOR EACH ROW BEGIN
DECLARE done BOOLEAN DEFAULT FALSE;
DECLARE il DOUBLE;
DECLARE idT INT;
DECLARE cur1 CURSOR FOR SELECT Ilosc FROM ZamowienieTowar WHERE IdZamowienie = NEW.id;
DECLARE cur2 CURSOR FOR SELECT IdTowar FROM ZamowienieTowar WHERE IdZamowienie = NEW.id;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

IF NEW.IdStatus = 5 THEN

OPEN cur1;
OPEN cur2;

read_loop: LOOP
FETCH cur1 INTO il;
FETCH cur2 INTO idT;
IF done THEN
	LEAVE read_loop;
END IF;
SET @StanM = (SELECT StanMagazynowy FROM Towar WHERE id = idT);
UPDATE `Towar` 
SET `StanMagazynowy`= (SELECT @StanM) - il
WHERE id = idT;

END LOOP;

CLOSE cur1;
CLOSE cur2;

END IF;

IF NEW.IdStatus = 6 THEN

OPEN cur1;
OPEN cur2;

read_loop: LOOP
FETCH cur1 INTO il;
FETCH cur2 INTO idT;
IF done THEN
	LEAVE read_loop;
END IF;
SET @StanD = (SELECT StanDysponowany FROM Towar WHERE id = idT);
UPDATE `Towar` 
SET `StanDysponowany`= (SELECT @StanD) + il
WHERE id = idT;

END LOOP;

CLOSE cur1;
CLOSE cur2;

END IF;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `ZamowienieTowar`
--

CREATE TABLE `ZamowienieTowar` (
  `id` int(11) NOT NULL,
  `IdZamowienie` int(11) NOT NULL,
  `IdTowar` int(11) NOT NULL,
  `CenaSprzedazy` decimal(10,2) NOT NULL,
  `Ilosc` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Wyzwalacze `ZamowienieTowar`
--
DELIMITER $$
CREATE TRIGGER `tr_ZamowienieTowar_a_D` AFTER DELETE ON `ZamowienieTowar` FOR EACH ROW BEGIN 

SET @vCurrentKW = (SELECT KwotaLaczna FROM Zamowienie WHERE id = OLD.IdZamowienie);
SET @vKw = OLD.CenaSprzedazy * OLD.Ilosc;
SET @vNewKW = (SELECT @vCurrentKW) - (SELECT @vKw);

IF (SELECT @vNewKW) < 0 THEN
SET @vNewKW = 0;
END IF;

UPDATE `Zamowienie` 
SET `KwotaLaczna`= (SELECT @vNewKW)
WHERE id = OLD.IdZamowienie;

SET @vCurrentStanDysponowany = (SELECT StanDysponowany FROM Towar WHERE id = OLD.IdTowar);
SET @vIlosc = OLD.Ilosc;
IF OLD.Ilosc < 0 THEN
SET @vIlosc = 0;
END IF;

UPDATE `Towar`
SET `StanDysponowany` = (SELECT @vCurrentStanDysponowany) + (SELECT @vIlosc)
WHERE id = OLD.IdTowar;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_ZamowienieTowar_a_I` AFTER INSERT ON `ZamowienieTowar` FOR EACH ROW BEGIN 

SET @vCurrentKW = (SELECT KwotaLaczna FROM Zamowienie WHERE id = NEW.IdZamowienie);
SET @vKw = NEW.CenaSprzedazy * NEW.Ilosc;

UPDATE `Zamowienie` 
SET `KwotaLaczna`= (SELECT @vCurrentKW) + (SELECT @vKw)
WHERE id = NEW.IdZamowienie;

SET @vCurrentStanDysponowany = (SELECT StanDysponowany FROM Towar WHERE id = NEW.IdTowar);
SET @vIlosc = NEW.Ilosc;
IF NEW.Ilosc < 0 THEN
SET @vIlosc = 0;
END IF;

UPDATE `Towar`
SET `StanDysponowany` = (SELECT @vCurrentStanDysponowany) - (SELECT @vIlosc)
WHERE id = NEW.IdTowar;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_ZamowienieTowar_a_U` AFTER UPDATE ON `ZamowienieTowar` FOR EACH ROW BEGIN 

SET @vCurrentKW = (SELECT KwotaLaczna FROM Zamowienie WHERE id = NEW.IdZamowienie);
SET @vOldKW = OLD.CenaSprzedazy * OLD.Ilosc;
SET @vKw = NEW.CenaSprzedazy * NEW.Ilosc;
SET @vNewKW = (SELECT @vCurrentKW) + (SELECT @vKw) - (SELECT @vOldKW);

IF (SELECT @vNewKW) < 0 THEN
SET @vNewKW = 0;
END IF;

UPDATE `Zamowienie` 
SET `KwotaLaczna`= (SELECT @vNewKW)
WHERE id = NEW.IdZamowienie;

END
$$
DELIMITER ;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `Dostawca`
--
ALTER TABLE `Dostawca`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `JednostkaMiary`
--
ALTER TABLE `JednostkaMiary`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `PZ`
--
ALTER TABLE `PZ`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_IdDostawca` (`IdDostawca`);

--
-- Indeksy dla tabeli `PZTowar`
--
ALTER TABLE `PZTowar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_IdPZ` (`IdPZ`),
  ADD KEY `FK_IdTowar` (`IdTowar`);

--
-- Indeksy dla tabeli `Ranga`
--
ALTER TABLE `Ranga`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `Status`
--
ALTER TABLE `Status`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `Towar`
--
ALTER TABLE `Towar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_IdJednostkaMiary` (`IdJednostkaMiary`);

--
-- Indeksy dla tabeli `Uzytkownik`
--
ALTER TABLE `Uzytkownik`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_IdRanga` (`IdRanga`);

--
-- Indeksy dla tabeli `WZ`
--
ALTER TABLE `WZ`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `NumerWZ` (`NumerWZ`),
  ADD KEY `FK_IdZamowienieee` (`IdZamowienie`);

--
-- Indeksy dla tabeli `WZTowar`
--
ALTER TABLE `WZTowar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_IdZamowienieTowar` (`IdZamowienieTowar`),
  ADD KEY `FK_IdWZ` (`IdWZ`);

--
-- Indeksy dla tabeli `Zamowienie`
--
ALTER TABLE `Zamowienie`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_IdStatus` (`IdStatus`),
  ADD KEY `FK_IdUzytkownik` (`IdUzytkownik`);

--
-- Indeksy dla tabeli `ZamowienieTowar`
--
ALTER TABLE `ZamowienieTowar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_IdTowarr` (`IdTowar`),
  ADD KEY `FK_IdZamowienie` (`IdZamowienie`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT dla tabeli `Dostawca`
--
ALTER TABLE `Dostawca`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT dla tabeli `JednostkaMiary`
--
ALTER TABLE `JednostkaMiary`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT dla tabeli `PZ`
--
ALTER TABLE `PZ`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT dla tabeli `PZTowar`
--
ALTER TABLE `PZTowar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT dla tabeli `Ranga`
--
ALTER TABLE `Ranga`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT dla tabeli `Status`
--
ALTER TABLE `Status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT dla tabeli `Towar`
--
ALTER TABLE `Towar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT dla tabeli `Uzytkownik`
--
ALTER TABLE `Uzytkownik`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT dla tabeli `WZ`
--
ALTER TABLE `WZ`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `WZTowar`
--
ALTER TABLE `WZTowar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT dla tabeli `Zamowienie`
--
ALTER TABLE `Zamowienie`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT dla tabeli `ZamowienieTowar`
--
ALTER TABLE `ZamowienieTowar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `PZ`
--
ALTER TABLE `PZ`
  ADD CONSTRAINT `FK_IdDostawca` FOREIGN KEY (`IdDostawca`) REFERENCES `Dostawca` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ograniczenia dla tabeli `PZTowar`
--
ALTER TABLE `PZTowar`
  ADD CONSTRAINT `FK_IdPZ` FOREIGN KEY (`IdPZ`) REFERENCES `PZ` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_IdTowar` FOREIGN KEY (`IdTowar`) REFERENCES `Towar` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ograniczenia dla tabeli `Towar`
--
ALTER TABLE `Towar`
  ADD CONSTRAINT `FK_IdJednostkaMiary` FOREIGN KEY (`IdJednostkaMiary`) REFERENCES `JednostkaMiary` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ograniczenia dla tabeli `Uzytkownik`
--
ALTER TABLE `Uzytkownik`
  ADD CONSTRAINT `FK_IdRanga` FOREIGN KEY (`IdRanga`) REFERENCES `Ranga` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ograniczenia dla tabeli `WZ`
--
ALTER TABLE `WZ`
  ADD CONSTRAINT `FK_IdZamowienieee` FOREIGN KEY (`IdZamowienie`) REFERENCES `Zamowienie` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ograniczenia dla tabeli `WZTowar`
--
ALTER TABLE `WZTowar`
  ADD CONSTRAINT `FK_IdWZ` FOREIGN KEY (`IdWZ`) REFERENCES `WZ` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_IdZamowienieTowar` FOREIGN KEY (`IdZamowienieTowar`) REFERENCES `ZamowienieTowar` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ograniczenia dla tabeli `Zamowienie`
--
ALTER TABLE `Zamowienie`
  ADD CONSTRAINT `FK_IdStatus` FOREIGN KEY (`IdStatus`) REFERENCES `Status` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_IdUzytkownik` FOREIGN KEY (`IdUzytkownik`) REFERENCES `Uzytkownik` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ograniczenia dla tabeli `ZamowienieTowar`
--
ALTER TABLE `ZamowienieTowar`
  ADD CONSTRAINT `FK_IdTowarr` FOREIGN KEY (`IdTowar`) REFERENCES `Towar` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_IdZamowienie` FOREIGN KEY (`IdZamowienie`) REFERENCES `Zamowienie` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
