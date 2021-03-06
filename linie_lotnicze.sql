-- MySQL Script generated by MySQL Workbench

SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;

-- -----------------------------------------------------
-- Table `Klasy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Klasy` ;

CREATE TABLE IF NOT EXISTS `Klasy` (
  `Klasy_id` INT NOT NULL AUTO_INCREMENT,
  `klasa` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Klasy_id`));

-- -----------------------------------------------------
-- Table `Typy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Typy` ;

CREATE TABLE IF NOT EXISTS `Typy` (
  `Typy_id` INT NOT NULL AUTO_INCREMENT,
  `producent` VARCHAR(45) NULL,
  `model` VARCHAR(45) NULL,
  `typ_napędu` VARCHAR(45) NULL,
  PRIMARY KEY (`Typy_id`));

-- -----------------------------------------------------
-- Table `Samoloty`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Samoloty` ;

CREATE TABLE IF NOT EXISTS `Samoloty` (
  `Samoloty_id` INT NOT NULL AUTO_INCREMENT,
  `Typy_id` INT NOT NULL,
  `masa_cargo` INT NOT NULL,
  `zasięg` INT NOT NULL,
  `prędkość_przelotowa` INT NULL,
  `przebieg` INT NULL,
  `data_produkcji` DATE NOT NULL,
  `spalanie` INT NOT NULL,
  `czy_dostępny` TINYINT NOT NULL,
  PRIMARY KEY (`Samoloty_id`, `Typy_id`),
  CONSTRAINT `fk_Samoloty_Typy1`
    FOREIGN KEY (`Typy_id`)
    REFERENCES `Typy` (`Typy_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table `Samoloty_Miejsca`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Samoloty_Miejsca` ;

CREATE TABLE IF NOT EXISTS `Samoloty_Miejsca` (
  `Samoloty_Miejsca_id` INT NOT NULL AUTO_INCREMENT,
  `Samoloty_id` INT NOT NULL,
  `Klasy_id` INT NOT NULL,
  `liczba_miejsc` INT NOT NULL,
  PRIMARY KEY (`Samoloty_Miejsca_id`, `Klasy_id`, `Samoloty_id`),
  CONSTRAINT `fk_Samoloty_Miejsca_Klasy1`
    FOREIGN KEY (`Klasy_id`)
    REFERENCES `Klasy` (`Klasy_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Samoloty_Miejsca_Samoloty1`
    FOREIGN KEY (`Samoloty_id`)
    REFERENCES `Samoloty` (`Samoloty_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table `Stanowiska`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Stanowiska` ;

CREATE TABLE IF NOT EXISTS `Stanowiska` (
  `Stanowiska_id` INT NOT NULL AUTO_INCREMENT,
  `stanowisko` VARCHAR(45) NOT NULL,
  `pensja_podstawowa` INT NOT NULL,
  PRIMARY KEY (`Stanowiska_id`));

-- -----------------------------------------------------
-- Table `Pracownicy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pracownicy` ;

CREATE TABLE IF NOT EXISTS `Pracownicy` (
  `Pracownicy_id` INT NOT NULL AUTO_INCREMENT,
  `imię` VARCHAR(45) NULL,
  `nazwisko` VARCHAR(45) NULL,
  `Stanowiska_id` INT NOT NULL,
  PRIMARY KEY (`Pracownicy_id`, `Stanowiska_id`),
  CONSTRAINT `fk_Pracownicy_Stanowiska1`
    FOREIGN KEY (`Stanowiska_id`)
    REFERENCES `Stanowiska` (`Stanowiska_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table `Trasy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Trasy` ;

CREATE TABLE IF NOT EXISTS `Trasy` (
  `Trasy_id` INT NOT NULL AUTO_INCREMENT,
  `lotnisko_początkowe` VARCHAR(3) NOT NULL,
  `lotnisko_końcowe` VARCHAR(3) NOT NULL,
  `długość_lotu` INT NOT NULL,
  `czas_lotu` INT NOT NULL,
  PRIMARY KEY (`Trasy_id`));

-- -----------------------------------------------------
-- Table `Loty`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Loty` ;

CREATE TABLE IF NOT EXISTS `Loty` (
  `Loty_id` INT NOT NULL AUTO_INCREMENT,
  `Trasy_id` INT NOT NULL,
  `wylot` DATETIME NOT NULL,
  `Samoloty_id` INT NOT NULL,
  PRIMARY KEY (`Loty_id`, `Trasy_id`, `Samoloty_id`),
  CONSTRAINT `fk_Loty_Trasy1`
    FOREIGN KEY (`Trasy_id`)
    REFERENCES `Trasy` (`Trasy_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Loty_Samoloty1`
    FOREIGN KEY (`Samoloty_id`)
    REFERENCES `Samoloty` (`Samoloty_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table `Loty_has_Pracownicy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Loty_has_Pracownicy` ;

CREATE TABLE IF NOT EXISTS `Loty_has_Pracownicy` (
  `Loty_id` INT NOT NULL,
  `Pracownicy_id` INT NOT NULL,
  PRIMARY KEY (`Loty_id`, `Pracownicy_id`),
  CONSTRAINT `fk_Loty_has_Pracownicy_Loty1`
    FOREIGN KEY (`Loty_id`)
    REFERENCES `Loty` (`Loty_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Loty_has_Pracownicy_Pracownicy1`
    FOREIGN KEY (`Pracownicy_id`)
    REFERENCES `Pracownicy` (`Pracownicy_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table `Pasażerowie`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pasażerowie` ;

CREATE TABLE IF NOT EXISTS `Pasażerowie` (
  `Pasażerowie_id` INT NOT NULL AUTO_INCREMENT,
  `imię` VARCHAR(45) NULL,
  `nazwisko` VARCHAR(45) NULL,
  PRIMARY KEY (`Pasażerowie_id`));

-- -----------------------------------------------------
-- Table `Bilety`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Bilety` ;

CREATE TABLE IF NOT EXISTS `Bilety` (
  `Bilety_id` INT NOT NULL AUTO_INCREMENT,
  `Pasażerowie_id` INT NOT NULL,
  `Loty_id` INT NOT NULL,
  `Klasy_id` INT NOT NULL,
  `Cena` INT NOT NULL,
  PRIMARY KEY (`Bilety_id`, `Pasażerowie_id`, `Loty_id`, `Klasy_id`),
  CONSTRAINT `fk_Bilety_Pasażerowie1`
    FOREIGN KEY (`Pasażerowie_id`)
    REFERENCES `Pasażerowie` (`Pasażerowie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bilety_Loty1`
    FOREIGN KEY (`Loty_id`)
    REFERENCES `Loty` (`Loty_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bilety_Klasy1`
    FOREIGN KEY (`Klasy_id`)
    REFERENCES `Klasy` (`Klasy_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table `Ceny_lotów`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Ceny_lotów` ;

CREATE TABLE IF NOT EXISTS `Ceny_lotów` (
  `Ceny_lotów_id` INT NOT NULL AUTO_INCREMENT,
  `Loty_id` INT NOT NULL,
  `Klasy_id` INT NOT NULL,
  `cena` INT NOT NULL,
  PRIMARY KEY (`Ceny_lotów_id`),
  INDEX `fk_Ceny_lotów_Loty1_idx` (`Loty_id` ASC),
  INDEX `fk_Ceny_lotów_Klasy1_idx` (`Klasy_id` ASC),
  CONSTRAINT `fk_Ceny_lotów_Loty1`
    FOREIGN KEY (`Loty_id`)
    REFERENCES `Loty` (`Loty_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ceny_lotów_Klasy1`
    FOREIGN KEY (`Klasy_id`)
    REFERENCES `Klasy` (`Klasy_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
-- -----------------------------------------------------
-- Data for table `Klasy`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `Klasy` (`Klasy_id`, `klasa`) VALUES (1, 'Pierwsza');
INSERT INTO `Klasy` (`Klasy_id`, `klasa`) VALUES (2, 'Biznes');
INSERT INTO `Klasy` (`Klasy_id`, `klasa`) VALUES (3, 'Ekonomiczna');

COMMIT;

-- -----------------------------------------------------
-- Data for table `Typy`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `Typy` (`Typy_id`, `producent`, `model`, `typ_napędu`) VALUES (DEFAULT, 'Bombardier', 'Q400', 'turbośmigłowy');

COMMIT;

-- -----------------------------------------------------
-- Data for table `Samoloty`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `Samoloty` (`Samoloty_id`, `Typy_id`, `masa_cargo`, `zasięg`, `prędkość_przelotowa`, `przebieg`, `data_produkcji`, `spalanie`, `czy_dostępny`) VALUES (1, 1, 900, 2000, 667, 443, '2015-02-12', 148, 1);
INSERT INTO `Samoloty` (`Samoloty_id`, `Typy_id`, `masa_cargo`, `zasięg`, `prędkość_przelotowa`, `przebieg`, `data_produkcji`, `spalanie`, `czy_dostępny`) VALUES (2, 1, 1050, 2300, 667, 1205, '2014-01-28', 152, 1);
INSERT INTO `Samoloty` (`Samoloty_id`, `Typy_id`, `masa_cargo`, `zasięg`, `prędkość_przelotowa`, `przebieg`, `data_produkcji`, `spalanie`, `czy_dostępny`) VALUES (3, 1, 870, 1900, 667, 230, '2017-07-01', 146, 1);
INSERT INTO `Samoloty` (`Samoloty_id`, `Typy_id`, `masa_cargo`, `zasięg`, `prędkość_przelotowa`, `przebieg`, `data_produkcji`, `spalanie`, `czy_dostępny`) VALUES (4, 1, 900, 2000, 667, 749, '2016-04-17', 148, 1);

COMMIT;

-- -----------------------------------------------------
-- Data for table `Samoloty_Miejsca`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `Samoloty_Miejsca` (`Samoloty_Miejsca_id`, `Samoloty_id`, `Klasy_id`, `liczba_miejsc`) VALUES (DEFAULT, 1, 3, 78);
INSERT INTO `Samoloty_Miejsca` (`Samoloty_Miejsca_id`, `Samoloty_id`, `Klasy_id`, `liczba_miejsc`) VALUES (DEFAULT, 2, 3, 70);
INSERT INTO `Samoloty_Miejsca` (`Samoloty_Miejsca_id`, `Samoloty_id`, `Klasy_id`, `liczba_miejsc`) VALUES (DEFAULT, 3, 3, 78);
INSERT INTO `Samoloty_Miejsca` (`Samoloty_Miejsca_id`, `Samoloty_id`, `Klasy_id`, `liczba_miejsc`) VALUES (DEFAULT, 4, 3, 58);
INSERT INTO `Samoloty_Miejsca` (`Samoloty_Miejsca_id`, `Samoloty_id`, `Klasy_id`, `liczba_miejsc`) VALUES (DEFAULT, 4, 2, 12);

COMMIT;

-- -----------------------------------------------------
-- Data for table `Stanowiska`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `Stanowiska` (`Stanowiska_id`, `stanowisko`, `pensja_podstawowa`) VALUES (1, 'pilot', 500000);
INSERT INTO `Stanowiska` (`Stanowiska_id`, `stanowisko`, `pensja_podstawowa`) VALUES (2, 'personel pokładowy', 350000);

COMMIT;

-- -----------------------------------------------------
-- Data for table `Pracownicy`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `Pracownicy` (`Pracownicy_id`, `imię`, `nazwisko`, `Stanowiska_id`) VALUES (1, 'Gladys', 'Gardner', 1);
INSERT INTO `Pracownicy` (`Pracownicy_id`, `imię`, `nazwisko`, `Stanowiska_id`) VALUES (2, 'Juana', 'Fuller', 1);
INSERT INTO `Pracownicy` (`Pracownicy_id`, `imię`, `nazwisko`, `Stanowiska_id`) VALUES (3, 'Kelly', 'Cannon', 2);
INSERT INTO `Pracownicy` (`Pracownicy_id`, `imię`, `nazwisko`, `Stanowiska_id`) VALUES (4, 'Eileen', 'Santiago', 2);
INSERT INTO `Pracownicy` (`Pracownicy_id`, `imię`, `nazwisko`, `Stanowiska_id`) VALUES (5, 'Don', 'Chambers', 1);
INSERT INTO `Pracownicy` (`Pracownicy_id`, `imię`, `nazwisko`, `Stanowiska_id`) VALUES (6, 'Sally', 'Butler', 1);
INSERT INTO `Pracownicy` (`Pracownicy_id`, `imię`, `nazwisko`, `Stanowiska_id`) VALUES (7, 'Chester', 'Cain', 2);
INSERT INTO `Pracownicy` (`Pracownicy_id`, `imię`, `nazwisko`, `Stanowiska_id`) VALUES (8, 'Mary', 'Flowers', 2);
INSERT INTO `Pracownicy` (`Pracownicy_id`, `imię`, `nazwisko`, `Stanowiska_id`) VALUES (9, 'Ray', 'Scott', 1);
INSERT INTO `Pracownicy` (`Pracownicy_id`, `imię`, `nazwisko`, `Stanowiska_id`) VALUES (10, 'Stanley', 'Sanders', 1);
INSERT INTO `Pracownicy` (`Pracownicy_id`, `imię`, `nazwisko`, `Stanowiska_id`) VALUES (11, 'Curtis', 'Wallace', 2);
INSERT INTO `Pracownicy` (`Pracownicy_id`, `imię`, `nazwisko`, `Stanowiska_id`) VALUES (12, 'Corey', 'Patrick', 2);
INSERT INTO `Pracownicy` (`Pracownicy_id`, `imię`, `nazwisko`, `Stanowiska_id`) VALUES (13, 'Maryann', 'Webster', 1);
INSERT INTO `Pracownicy` (`Pracownicy_id`, `imię`, `nazwisko`, `Stanowiska_id`) VALUES (14, 'Dianna', 'Stephens', 1);
INSERT INTO `Pracownicy` (`Pracownicy_id`, `imię`, `nazwisko`, `Stanowiska_id`) VALUES (15, 'Marion', 'Wong', 2);
INSERT INTO `Pracownicy` (`Pracownicy_id`, `imię`, `nazwisko`, `Stanowiska_id`) VALUES (16, 'Marcos', 'Lowe', 2);

COMMIT;

-- -----------------------------------------------------
-- Data for table `Trasy`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `Trasy` (`Trasy_id`, `lotnisko_początkowe`, `lotnisko_końcowe`, `długość_lotu`, `czas_lotu`) VALUES (1, 'KRK', 'WAW', 250, 55);
INSERT INTO `Trasy` (`Trasy_id`, `lotnisko_początkowe`, `lotnisko_końcowe`, `długość_lotu`, `czas_lotu`) VALUES (2, 'WAW', 'KRK', 250, 55);
INSERT INTO `Trasy` (`Trasy_id`, `lotnisko_początkowe`, `lotnisko_końcowe`, `długość_lotu`, `czas_lotu`) VALUES (3, 'KRK', 'WRO', 235, 50);
INSERT INTO `Trasy` (`Trasy_id`, `lotnisko_początkowe`, `lotnisko_końcowe`, `długość_lotu`, `czas_lotu`) VALUES (4, 'WRO', 'KRK', 235, 50);
INSERT INTO `Trasy` (`Trasy_id`, `lotnisko_początkowe`, `lotnisko_końcowe`, `długość_lotu`, `czas_lotu`) VALUES (5, 'KRK', 'GDN', 490, 70);
INSERT INTO `Trasy` (`Trasy_id`, `lotnisko_początkowe`, `lotnisko_końcowe`, `długość_lotu`, `czas_lotu`) VALUES (6, 'GDN', 'KRK', 490, 70);

COMMIT;

-- -----------------------------------------------------
-- Data for table `Loty`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `Loty` (`Loty_id`, `Trasy_id`, `wylot`, `Samoloty_id`) VALUES (1, 1, '2019-11-01 09:00:00', 1);
INSERT INTO `Loty` (`Loty_id`, `Trasy_id`, `wylot`, `Samoloty_id`) VALUES (2, 3, '2019-11-01 09:30:00', 2);
INSERT INTO `Loty` (`Loty_id`, `Trasy_id`, `wylot`, `Samoloty_id`) VALUES (3, 5, '2019-11-01 10:05:00', 3);
INSERT INTO `Loty` (`Loty_id`, `Trasy_id`, `wylot`, `Samoloty_id`) VALUES (4, 2, '2019-11-01 09:00:00', 4);
INSERT INTO `Loty` (`Loty_id`, `Trasy_id`, `wylot`, `Samoloty_id`) VALUES (5, 2, '2019-11-01 16:50:00', 1);
INSERT INTO `Loty` (`Loty_id`, `Trasy_id`, `wylot`, `Samoloty_id`) VALUES (6, 4, '2019-11-01 18:00:00', 2);
INSERT INTO `Loty` (`Loty_id`, `Trasy_id`, `wylot`, `Samoloty_id`) VALUES (7, 6, '2019-11-01 17:30:00', 3);
INSERT INTO `Loty` (`Loty_id`, `Trasy_id`, `wylot`, `Samoloty_id`) VALUES (8, 1, '2019-11-01 16:35:00', 4);
INSERT INTO `Loty` (`Loty_id`, `Trasy_id`, `wylot`, `Samoloty_id`) VALUES (9, 1, '2019-12-01 09:00:00', 1);
INSERT INTO `Loty` (`Loty_id`, `Trasy_id`, `wylot`, `Samoloty_id`) VALUES (10, 3, '2019-12-01 09:30:00', 2);
INSERT INTO `Loty` (`Loty_id`, `Trasy_id`, `wylot`, `Samoloty_id`) VALUES (11, 5, '2019-12-01 10:05:00', 3);
INSERT INTO `Loty` (`Loty_id`, `Trasy_id`, `wylot`, `Samoloty_id`) VALUES (12, 2, '2019-12-01 09:00:00', 4);
INSERT INTO `Loty` (`Loty_id`, `Trasy_id`, `wylot`, `Samoloty_id`) VALUES (13, 2, '2019-12-01 16:50:00', 1);
INSERT INTO `Loty` (`Loty_id`, `Trasy_id`, `wylot`, `Samoloty_id`) VALUES (14, 4, '2019-12-01 18:00:00', 2);
INSERT INTO `Loty` (`Loty_id`, `Trasy_id`, `wylot`, `Samoloty_id`) VALUES (15, 6, '2019-12-01 17:30:00', 3);
INSERT INTO `Loty` (`Loty_id`, `Trasy_id`, `wylot`, `Samoloty_id`) VALUES (16, 1, '2019-12-01 16:35:00', 4);

COMMIT;

-- -----------------------------------------------------
-- Data for table `Loty_has_Pracownicy`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `Loty_has_Pracownicy` (`Loty_id`, `Pracownicy_id`) VALUES (1, 1);
INSERT INTO `Loty_has_Pracownicy` (`Loty_id`, `Pracownicy_id`) VALUES (1, 2);
INSERT INTO `Loty_has_Pracownicy` (`Loty_id`, `Pracownicy_id`) VALUES (1, 3);
INSERT INTO `Loty_has_Pracownicy` (`Loty_id`, `Pracownicy_id`) VALUES (1, 4);
INSERT INTO `Loty_has_Pracownicy` (`Loty_id`, `Pracownicy_id`) VALUES (2, 5);
INSERT INTO `Loty_has_Pracownicy` (`Loty_id`, `Pracownicy_id`) VALUES (2, 6);
INSERT INTO `Loty_has_Pracownicy` (`Loty_id`, `Pracownicy_id`) VALUES (2, 7);
INSERT INTO `Loty_has_Pracownicy` (`Loty_id`, `Pracownicy_id`) VALUES (2, 8);
INSERT INTO `Loty_has_Pracownicy` (`Loty_id`, `Pracownicy_id`) VALUES (3, 9);
INSERT INTO `Loty_has_Pracownicy` (`Loty_id`, `Pracownicy_id`) VALUES (3, 10);
INSERT INTO `Loty_has_Pracownicy` (`Loty_id`, `Pracownicy_id`) VALUES (3, 11);
INSERT INTO `Loty_has_Pracownicy` (`Loty_id`, `Pracownicy_id`) VALUES (3, 12);
INSERT INTO `Loty_has_Pracownicy` (`Loty_id`, `Pracownicy_id`) VALUES (4, 13);
INSERT INTO `Loty_has_Pracownicy` (`Loty_id`, `Pracownicy_id`) VALUES (4, 14);
INSERT INTO `Loty_has_Pracownicy` (`Loty_id`, `Pracownicy_id`) VALUES (4, 15);
INSERT INTO `Loty_has_Pracownicy` (`Loty_id`, `Pracownicy_id`) VALUES (4, 16);
INSERT INTO `Loty_has_Pracownicy` (`Loty_id`, `Pracownicy_id`) VALUES (5, 1);
INSERT INTO `Loty_has_Pracownicy` (`Loty_id`, `Pracownicy_id`) VALUES (5, 2);
INSERT INTO `Loty_has_Pracownicy` (`Loty_id`, `Pracownicy_id`) VALUES (5, 3);
INSERT INTO `Loty_has_Pracownicy` (`Loty_id`, `Pracownicy_id`) VALUES (5, 4);
INSERT INTO `Loty_has_Pracownicy` (`Loty_id`, `Pracownicy_id`) VALUES (6, 5);
INSERT INTO `Loty_has_Pracownicy` (`Loty_id`, `Pracownicy_id`) VALUES (6, 6);
INSERT INTO `Loty_has_Pracownicy` (`Loty_id`, `Pracownicy_id`) VALUES (6, 7);
INSERT INTO `Loty_has_Pracownicy` (`Loty_id`, `Pracownicy_id`) VALUES (6, 8);
INSERT INTO `Loty_has_Pracownicy` (`Loty_id`, `Pracownicy_id`) VALUES (7, 9);
INSERT INTO `Loty_has_Pracownicy` (`Loty_id`, `Pracownicy_id`) VALUES (7, 10);
INSERT INTO `Loty_has_Pracownicy` (`Loty_id`, `Pracownicy_id`) VALUES (7, 11);
INSERT INTO `Loty_has_Pracownicy` (`Loty_id`, `Pracownicy_id`) VALUES (7, 12);
INSERT INTO `Loty_has_Pracownicy` (`Loty_id`, `Pracownicy_id`) VALUES (8, 13);
INSERT INTO `Loty_has_Pracownicy` (`Loty_id`, `Pracownicy_id`) VALUES (8, 14);
INSERT INTO `Loty_has_Pracownicy` (`Loty_id`, `Pracownicy_id`) VALUES (8, 15);
INSERT INTO `Loty_has_Pracownicy` (`Loty_id`, `Pracownicy_id`) VALUES (8, 16);

COMMIT;

-- -----------------------------------------------------
-- Data for table `Pasażerowie`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `Pasażerowie` (`Pasażerowie_id`, `imię`, `nazwisko`) VALUES (1, 'Agnieszka', 'Niemieszka');
INSERT INTO `Pasażerowie` (`Pasażerowie_id`, `imię`, `nazwisko`) VALUES (2, 'Jan', 'Nowak');
INSERT INTO `Pasażerowie` (`Pasażerowie_id`, `imię`, `nazwisko`) VALUES (3, 'Katarzyna', 'Kowalska');
INSERT INTO `Pasażerowie` (`Pasażerowie_id`, `imię`, `nazwisko`) VALUES (4, 'Bożydar', 'Brzęczyszczykiewicz');
INSERT INTO `Pasażerowie` (`Pasażerowie_id`, `imię`, `nazwisko`) VALUES (5, 'Rick', 'Sanchez');
INSERT INTO `Pasażerowie` (`Pasażerowie_id`, `imię`, `nazwisko`) VALUES (6, 'Ron', 'Swanson');
INSERT INTO `Pasażerowie` (`Pasażerowie_id`, `imię`, `nazwisko`) VALUES (7, 'Leslie', 'Knope');

COMMIT;

-- -----------------------------------------------------
-- Data for table `Bilety`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `Bilety` (`Bilety_id`, `Pasażerowie_id`, `Loty_id`, `Klasy_id`, `Cena`) VALUES (DEFAULT, 1, 1, 3, 14000);
INSERT INTO `Bilety` (`Bilety_id`, `Pasażerowie_id`, `Loty_id`, `Klasy_id`, `Cena`) VALUES (DEFAULT, 1, 5, 3, 14000);
INSERT INTO `Bilety` (`Bilety_id`, `Pasażerowie_id`, `Loty_id`, `Klasy_id`, `Cena`) VALUES (DEFAULT, 2, 2, 3, 14000);
INSERT INTO `Bilety` (`Bilety_id`, `Pasażerowie_id`, `Loty_id`, `Klasy_id`, `Cena`) VALUES (DEFAULT, 3, 2, 3, 14000);
INSERT INTO `Bilety` (`Bilety_id`, `Pasażerowie_id`, `Loty_id`, `Klasy_id`, `Cena`) VALUES (DEFAULT, 3, 6, 3, 14000);
INSERT INTO `Bilety` (`Bilety_id`, `Pasażerowie_id`, `Loty_id`, `Klasy_id`, `Cena`) VALUES (DEFAULT, 4, 3, 3, 14000);
INSERT INTO `Bilety` (`Bilety_id`, `Pasażerowie_id`, `Loty_id`, `Klasy_id`, `Cena`) VALUES (DEFAULT, 4, 7, 3, 14000);
INSERT INTO `Bilety` (`Bilety_id`, `Pasażerowie_id`, `Loty_id`, `Klasy_id`, `Cena`) VALUES (DEFAULT, 5, 3, 3, 14000);
INSERT INTO `Bilety` (`Bilety_id`, `Pasażerowie_id`, `Loty_id`, `Klasy_id`, `Cena`) VALUES (DEFAULT, 5, 7, 3, 14000);
INSERT INTO `Bilety` (`Bilety_id`, `Pasażerowie_id`, `Loty_id`, `Klasy_id`, `Cena`) VALUES (DEFAULT, 6, 4, 2, 18000);
INSERT INTO `Bilety` (`Bilety_id`, `Pasażerowie_id`, `Loty_id`, `Klasy_id`, `Cena`) VALUES (DEFAULT, 6, 8, 2, 14000);
INSERT INTO `Bilety` (`Bilety_id`, `Pasażerowie_id`, `Loty_id`, `Klasy_id`, `Cena`) VALUES (DEFAULT, 7, 3, 3, 14000);
INSERT INTO `Bilety` (`Bilety_id`, `Pasażerowie_id`, `Loty_id`, `Klasy_id`, `Cena`) VALUES (DEFAULT, 7, 7, 3, 14000);
INSERT INTO `Bilety` (`Bilety_id`, `Pasażerowie_id`, `Loty_id`, `Klasy_id`, `Cena`) VALUES (DEFAULT, 4, 3, 3, 14000);
INSERT INTO `Bilety` (`Bilety_id`, `Pasażerowie_id`, `Loty_id`, `Klasy_id`, `Cena`) VALUES (DEFAULT, 5, 3, 3, 14000);

COMMIT;

-- -----------------------------------------------------
-- Data for table `Ceny_lotów`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `Ceny_lotów` (`Ceny_lotów_id`, `Loty_id`, `Klasy_id`, `cena`) VALUES (DEFAULT, 1, 3, 14000);
INSERT INTO `Ceny_lotów` (`Ceny_lotów_id`, `Loty_id`, `Klasy_id`, `cena`) VALUES (DEFAULT, 2, 3, 14000);
INSERT INTO `Ceny_lotów` (`Ceny_lotów_id`, `Loty_id`, `Klasy_id`, `cena`) VALUES (DEFAULT, 3, 3, 14000);
INSERT INTO `Ceny_lotów` (`Ceny_lotów_id`, `Loty_id`, `Klasy_id`, `cena`) VALUES (DEFAULT, 4, 3, 14000);
INSERT INTO `Ceny_lotów` (`Ceny_lotów_id`, `Loty_id`, `Klasy_id`, `cena`) VALUES (DEFAULT, 4, 2, 22000);
INSERT INTO `Ceny_lotów` (`Ceny_lotów_id`, `Loty_id`, `Klasy_id`, `cena`) VALUES (DEFAULT, 5, 3, 14000);
INSERT INTO `Ceny_lotów` (`Ceny_lotów_id`, `Loty_id`, `Klasy_id`, `cena`) VALUES (DEFAULT, 6, 3, 14000);
INSERT INTO `Ceny_lotów` (`Ceny_lotów_id`, `Loty_id`, `Klasy_id`, `cena`) VALUES (DEFAULT, 7, 3, 14000);
INSERT INTO `Ceny_lotów` (`Ceny_lotów_id`, `Loty_id`, `Klasy_id`, `cena`) VALUES (DEFAULT, 8, 3, 14000);
INSERT INTO `Ceny_lotów` (`Ceny_lotów_id`, `Loty_id`, `Klasy_id`, `cena`) VALUES (DEFAULT, 8, 2, 22000);
INSERT INTO `Ceny_lotów` (`Ceny_lotów_id`, `Loty_id`, `Klasy_id`, `cena`) VALUES (DEFAULT, 9, 3, 14000);
INSERT INTO `Ceny_lotów` (`Ceny_lotów_id`, `Loty_id`, `Klasy_id`, `cena`) VALUES (DEFAULT, 10, 3, 14000);
INSERT INTO `Ceny_lotów` (`Ceny_lotów_id`, `Loty_id`, `Klasy_id`, `cena`) VALUES (DEFAULT, 11, 3, 14000);
INSERT INTO `Ceny_lotów` (`Ceny_lotów_id`, `Loty_id`, `Klasy_id`, `cena`) VALUES (DEFAULT, 12, 3, 14000);
INSERT INTO `Ceny_lotów` (`Ceny_lotów_id`, `Loty_id`, `Klasy_id`, `cena`) VALUES (DEFAULT, 12, 2, 22000);
INSERT INTO `Ceny_lotów` (`Ceny_lotów_id`, `Loty_id`, `Klasy_id`, `cena`) VALUES (DEFAULT, 13, 3, 14000);
INSERT INTO `Ceny_lotów` (`Ceny_lotów_id`, `Loty_id`, `Klasy_id`, `cena`) VALUES (DEFAULT, 14, 3, 14000);
INSERT INTO `Ceny_lotów` (`Ceny_lotów_id`, `Loty_id`, `Klasy_id`, `cena`) VALUES (DEFAULT, 15, 3, 14000);
INSERT INTO `Ceny_lotów` (`Ceny_lotów_id`, `Loty_id`, `Klasy_id`, `cena`) VALUES (DEFAULT, 16, 3, 14000);
INSERT INTO `Ceny_lotów` (`Ceny_lotów_id`, `Loty_id`, `Klasy_id`, `cena`) VALUES (DEFAULT, 16, 2, 22000);

COMMIT;

-- -----------------------------------------------------
-- Procedury
-- -----------------------------------------------------
DROP FUNCTION IF EXISTS KWOTA;

CREATE FUNCTION KWOTA(gr INT)
	RETURNS VARCHAR(30)
	RETURN FORMAT(gr / 100, 2);

DELIMITER ;;

-- -----------------------------------------------------
-- Sprawdzająca czy liczba pasażerów klasy business przekracza 100 na 10 lotów.
-- -----------------------------------------------------

DROP PROCEDURE IF EXISTS sprawdź_klasę_biznes;;

CREATE PROCEDURE sprawdź_klasę_biznes()
BEGIN
	DECLARE ilość_lotów INT DEFAULT (SELECT COUNT(*) FROM Loty);
	DECLARE ilość_biletów INT DEFAULT (
		SELECT COUNT(*)
		FROM Bilety
		JOIN Klasy
			USING (Klasy_id)
		WHERE klasa = 'Biznes'
	);
	DECLARE współczynnik FLOAT DEFAULT (100 / 10);
	SELECT (ilość_biletów / ilość_lotów) > (100 / 10);
END;;

CALL sprawdź_klasę_biznes();;

-- -----------------------------------------------------
-- Dla pasażerów, którzy wylatali 10000 km naliczająca rabat 10%.
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS ceny_dla_pasażera;

CREATE PROCEDURE ceny_dla_pasażera(IN pasażer_id INT)
BEGIN
	DECLARE próg INT DEFAULT 10000;
	DECLARE rabat FLOAT DEFAULT 0.1;
	DECLARE mnoznik FLOAT DEFAULT 1.0;
	DECLARE wylatane_km INT DEFAULT (
		SELECT SUM(długość_lotu)
		FROM Trasy
		INNER JOIN Loty
			USING (Trasy_id)
		INNER JOIN Bilety
			USING (Loty_id)
		INNER JOIN Pasażerowie
			USING (Pasażerowie_id)
		WHERE Pasażerowie_id = pasażer_id
	);

	IF wylatane_km > próg THEN
		SET mnoznik = mnoznik - rabat;
	END IF;

	-- nagłówek
	SELECT CONCAT(imię, ' ', nazwisko) AS 'Cennik dla'
		, wylatane_km AS 'Wylatane km'
	FROM Pasażerowie
	WHERE Pasażerowie_id = pasażer_id;

	SELECT lotnisko_początkowe
		, lotnisko_końcowe
		, wylot
		, klasa
		, KWOTA(CEIL(mnoznik * cena)) AS cena
	FROM Loty
	INNER JOIN Trasy
		USING (Trasy_id)
	INNER JOIN Ceny_lotów
		USING (Loty_id)
	INNER JOIN Klasy
		USING (Klasy_id)
	WHERE wylot > NOW();
END;;

CALL ceny_dla_pasażera(2);;

-- -----------------------------------------------------
-- Dla pasażerów, którzy wylatali 10000 km w ciągu miesiąca naliczająca rabat 20%.
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS ceny_dla_pasażera2;

CREATE PROCEDURE ceny_dla_pasażera2(IN pasażer_id INT)
BEGIN
	DECLARE próg INT DEFAULT 10000;
	DECLARE rabat FLOAT DEFAULT 0.2;
	DECLARE mnoznik FLOAT DEFAULT 1.0;
	DECLARE wylatane_km INT DEFAULT (
		SELECT SUM(długość_lotu)
		FROM Trasy
		INNER JOIN Loty
			USING (Trasy_id)
		INNER JOIN Bilety
			USING (Loty_id)
		INNER JOIN Pasażerowie
			USING (Pasażerowie_id)
		WHERE Pasażerowie_id = pasażer_id
			AND wylot > NOW() - INTERVAL 30 DAY
	);

	IF wylatane_km > próg THEN
		SET mnoznik = mnoznik - rabat;
	END IF;

	-- nagłówek
	SELECT CONCAT(imię, ' ', nazwisko) AS 'Cennik dla'
		, wylatane_km AS 'Wylatane km'
	FROM Pasażerowie
	WHERE Pasażerowie_id = pasażer_id;

	SELECT lotnisko_początkowe
		, lotnisko_końcowe
		, wylot
		, klasa
		, KWOTA(CEIL(mnoznik * cena)) AS cena
	FROM Loty
	INNER JOIN Trasy
		USING (Trasy_id)
	INNER JOIN Ceny_lotów
		USING (Loty_id)
	INNER JOIN Klasy
		USING (Klasy_id)
	WHERE wylot > NOW();
END;;

CALL ceny_dla_pasażera2(4);;

-- -----------------------------------------------------
-- Doliczająca 1% do pensji podstawowej pilotowi za wylatanie każdych 1000 godzin lotu.
-- -----------------------------------------------------

DROP PROCEDURE IF EXISTS pokaż_pracowników;;

CREATE PROCEDURE pokaż_pracowników()
BEGIN
	SELECT imię
		, nazwisko
		, stanowisko
		, KWOTA(pensja_podstawowa) AS 'Pensja podstawowa'
		, FLOOR(SUM(czas_lotu) / 60) AS 'Wylatane godziny'
		, IF(stanowisko = 'Pilot'
			, KWOTA(pensja_podstawowa * (100 + FLOOR(SUM(czas_lotu) / 60 / 1000)) / 100)
			, KWOTA(pensja_podstawowa)
		) AS 'Pensja'
	FROM Pracownicy
	LEFT JOIN Stanowiska
		USING (Stanowiska_id)
	LEFT JOIN Loty_has_Pracownicy
		USING (Pracownicy_id)
	LEFT JOIN Loty
		USING (Loty_id)
	LEFT JOIN Trasy
		USING (Trasy_id)
	GROUP BY imię
		, nazwisko
		, stanowisko
		, pensja_podstawowa;
END;;

CALL pokaż_pracowników();;

DELIMITER ;

-- -----------------------------------------------------
-- Przenieś przyszłe loty w przyszłość
-- -----------------------------------------------------
UPDATE Loty
SET wylot = wylot + INTERVAL 2 MONTH
WHERE wylot BETWEEN '2019-12-01' AND '2019-12-02';

-- -----------------------------------------------------
-- funkcja wybierająca kapitana z najmniejszą liczbą godzin
-- -----------------------------------------------------

DROP FUNCTION IF EXISTS wylatane_minuty;

CREATE FUNCTION wylatane_minuty(id INT)
RETURNS INT
DETERMINISTIC
READS SQL DATA
	RETURN (
		SELECT
			SUM(czas_lotu)
		FROM Pracownicy
		LEFT JOIN Loty_has_Pracownicy
			USING (Pracownicy_id)
		LEFT JOIN Loty
			USING (Loty_id)
		LEFT JOIN Trasy
			USING (Trasy_id)
		WHERE Pracownicy_id = id
			AND wylot < NOW()
	);

DROP FUNCTION IF EXISTS wybierz_kapitana;

CREATE FUNCTION wybierz_kapitana()
RETURNS INT
DETERMINISTIC
READS SQL DATA
	RETURN(
		SELECT Pracownicy_id
		FROM Pracownicy
		WHERE Stanowiska_id = (
			SELECT Stanowiska_id
			FROM Stanowiska
			WHERE stanowisko = 'Pilot'
		)
		ORDER BY wylatane_minuty(Pracownicy_id) ASC
		LIMIT 1
	);

SELECT imię, nazwisko FROM Pracownicy WHERE Pracownicy_id = wybierz_kapitana();

-- -----------------------------------------------------
-- funkcja licząca zysk z lotu
-- -----------------------------------------------------

DROP FUNCTION IF EXISTS przychod_lotu;

CREATE FUNCTION przychod_lotu(id_lotu INT)
RETURNS INT
DETERMINISTIC
READS SQL DATA
	RETURN (
		SELECT SUM(cena)
		FROM Bilety
		WHERE Loty_id = id_lotu
	);

-- -----------------------------------------------------

DROP FUNCTION IF EXISTS koszt_lotu;

DELIMITER ;;

CREATE FUNCTION koszt_lotu(id_lotu INT)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
	DECLARE cena_paliwa INT DEFAULT 741;
	RETURN cena_paliwa * (
		SELECT CEIL(spalanie * (czas_lotu / 60)) AS paliwo
		FROM Loty
		INNER JOIN Samoloty
			USING (Samoloty_id)
		INNER JOIN Trasy
			USING (Trasy_id)
		WHERE Loty_id = id_lotu
	);
END;;

DELIMITER ;

SELECT Loty_id
	, wylot
	, KWOTA(koszt_lotu(Loty_id)) AS koszt
	, KWOTA(przychod_lotu(Loty_id)) AS przychód
	, KWOTA(przychod_lotu(Loty_id) - koszt_lotu(Loty_id)) AS zysk
FROM Loty
WHERE wylot < NOW();

-- -----------------------------------------------------
-- "funkcja" wypisująca wsystkich pasażerów i klasy lotu
-- -----------------------------------------------------

DROP PROCEDURE IF EXISTS pasażerowie_lotu;

CREATE PROCEDURE pasażerowie_lotu(id_lotu INT)
	SELECT imię
		, nazwisko
		, klasa
	FROM Bilety
	INNER JOIN Pasażerowie
		USING (Pasażerowie_id)
	INNER JOIN Klasy
		USING (Klasy_id)
	WHERE Loty_id = id_lotu;

CALL pasażerowie_lotu((
		SELECT Loty_id
		FROM Loty
		WHERE wylot = '2019-11-01 10:05'
));
