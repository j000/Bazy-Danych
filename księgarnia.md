/*

# Księgarnia

Baza danych księgarni internetowej.

-- -----------------------------------------------------------------------------

### Stanowiska ###

| Stanowiska_id | nazwa           | pensja |
|--------------:|-----------------|-------:|
|             1 | kierownik       | 500000 |
|             2 | Wsparcie IT     | 320000 |
|             3 | Obsługa klienta | 240000 |

### Pracownicy ###

| id | imie   | nazwisko | Stanowiska_id |
|---:|--------|----------|--------------:|
|  1 | Nick   | Offerman |             1 |
|  2 | Amy    | Poehler  |             3 |
|  3 | Aubrey | Plaza    |             2 |
|  4 | Chris  | Pratt    |             2 |
|  5 | Aziz   | Ansari   |             3 |
|  6 | Jim    | O'Heir   |             3 |

-- -----------------------------------------------------------------------------

### Autorzy

| Autor_id | Autor                     |
|---------:|---------------------------|
|        1 | Joanne Rowling            |
|        2 | John Ronald Reuel Tolkien |

### Książki

| Książka_id | Autor_id | Tytuł                              | Cena | RokWydania |
|-----------:|---------:|------------------------------------|-----:|-----------:|
|          1 |        1 | Harry Potter i Kamień Filozoficzny | 3000 |            |
|          2 |        1 | Harry Potter i Komnata Tajemnic    | 3000 |            |
|          3 |        1 | Harry Potter i więzień Azkabanu    | 3000 |            |
|          4 |        1 | Harry Potter i Czara Ognia         | 3000 |            |
|          5 |        1 | Harry Potter i Zakon Feniksa       | 3000 |            |
|          6 |        1 | Harry Potter i Książę Półkrwi      | 3000 |            |
|          7 |        1 | Harry Potter i Insygnia Śmierci    | 3000 |            |

-- -----------------------------------------------------------------------------

### Klienci

| Klienci_id | Nazwa |
|-----------:|-------|

### Adresy

| Adres_id | Klienci_id | Adres |
|---------:|-----------:|-------|

-- -----------------------------------------------------------------------------

### Zamówienia

| Zamówienia_id | Klienci_id | DataZamówienia | DataPłatności | DataWysyłki | Adresy_id |
|--------------:|-----------:|---------------:|--------------:|------------:|-----------|

### Zamówienia_Książki

| Zamówienia_id | Książka_id | Liczba | Cena |
|--------------:|-----------:|-------:|-----:|

-- -----------------------------------------------------------------------------

### Dostawcy

| Dostawcy_id | Nazwa | Telefon |
|------------:|-------|---------|

### Dostawy

| Dostawy_id | Dostawcy_id | DataDostawy |
|-----------:|------------:|------------:|

### Dostawy_Książki

| Dostawy_id | Książka_id | Liczba | Cena |
|-----------:|-----------:|-------:|-----:|

-- -----------------------------------------------------------------------------

```mysql*/
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Table `Stanowiska`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Stanowiska` ;

CREATE TABLE IF NOT EXISTS `Stanowiska` (
  `Stanowiska_id` INT NOT NULL AUTO_INCREMENT,
  `nazwa` VARCHAR(45) NOT NULL,
  `pensja` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Stanowiska_id`));


-- -----------------------------------------------------
-- Table `Pracownicy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pracownicy` ;

CREATE TABLE IF NOT EXISTS `Pracownicy` (
  `Pracownicy_id` INT NOT NULL AUTO_INCREMENT,
  `Imię` VARCHAR(45) NULL,
  `Nazwisko` VARCHAR(45) NULL,
  `Stanowiska_id` INT NOT NULL,
  PRIMARY KEY (`Pracownicy_id`),
  CONSTRAINT `fk_Pracownicy_Stanowiska`
    FOREIGN KEY (`Stanowiska_id`)
    REFERENCES `Stanowiska` (`Stanowiska_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `Autorzy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Autorzy` ;

CREATE TABLE IF NOT EXISTS `Autorzy` (
  `Autorzy_id` INT NOT NULL AUTO_INCREMENT,
  `Autor` VARCHAR(120) NULL,
  PRIMARY KEY (`Autorzy_id`));


-- -----------------------------------------------------
-- Table `Książki`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Książki` ;

CREATE TABLE IF NOT EXISTS `Książki` (
  `Książka_id` INT NOT NULL AUTO_INCREMENT,
  `Autorzy_id` INT NOT NULL,
  `Tytuł` VARCHAR(45) NULL,
  `Cena` INT NOT NULL,
  `RokWydania` YEAR(4) NULL,
  PRIMARY KEY (`Książka_id`),
  CONSTRAINT `fk_Książki_Autorzy1`
    FOREIGN KEY (`Autorzy_id`)
    REFERENCES `Autorzy` (`Autorzy_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `Klienci`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Klienci` ;

CREATE TABLE IF NOT EXISTS `Klienci` (
  `Klienci_id` INT NOT NULL AUTO_INCREMENT,
  `Nazwa` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Klienci_id`));


-- -----------------------------------------------------
-- Table `Zamówienia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Zamówienia` ;

CREATE TABLE IF NOT EXISTS `Zamówienia` (
  `Zamówienia_id` INT NOT NULL AUTO_INCREMENT,
  `Klienci_id` INT NOT NULL,
  `DataZamówienia` DATETIME NOT NULL,
  `DataPłatności` DATETIME,
  `DataWysyłki` DATETIME,
  `Adresy_id` INT NOT NULL,
  PRIMARY KEY (`Zamówienia_id`),
  CONSTRAINT `fk_Zamówienia_Klienci1`
    FOREIGN KEY (`Klienci_id`)
    REFERENCES `Klienci` (`Klienci_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `Zamówienia_Książki`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Zamówienia_Książki` ;

CREATE TABLE IF NOT EXISTS `Zamówienia_Książki` (
  `Zamówienia_Książki_id` INT NOT NULL AUTO_INCREMENT,
  `Zamówienia_id` INT NOT NULL,
  `Książka_id` INT NOT NULL,
  `Liczba` INT NULL,
  `Cena` INT NULL,
  PRIMARY KEY (`Zamówienia_Książki_id`),
  CONSTRAINT `fk_Zamówienia_Książki_Zamówienia1`
    FOREIGN KEY (`Zamówienia_id`)
    REFERENCES `Zamówienia` (`Zamówienia_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Zamówienia_Książki_Książki1`
    FOREIGN KEY (`Książka_id`)
    REFERENCES `Książki` (`Książka_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `Dostawcy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Dostawcy` ;

CREATE TABLE IF NOT EXISTS `Dostawcy` (
  `Dostawcy_id` INT NOT NULL AUTO_INCREMENT,
  `Nazwa` VARCHAR(45) NOT NULL,
  `Telefon` VARCHAR(15) NULL,
  PRIMARY KEY (`Dostawcy_id`));


-- -----------------------------------------------------
-- Table `Dostawy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Dostawy` ;

CREATE TABLE IF NOT EXISTS `Dostawy` (
  `Dostawy_id` INT NOT NULL AUTO_INCREMENT,
  `Dostawcy_id` INT NOT NULL,
  `DataDostawy` DATETIME NOT NULL,
  PRIMARY KEY (`Dostawy_id`),
  CONSTRAINT `fk_Dostawy_Dostawcy1`
    FOREIGN KEY (`Dostawcy_id`)
    REFERENCES `Dostawcy` (`Dostawcy_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `Dostawy_Książki`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Dostawy_Książki` ;

CREATE TABLE IF NOT EXISTS `Dostawy_Książki` (
  `Dostawy_id` INT NOT NULL AUTO_INCREMENT,
  `Książka_id` INT NOT NULL,
  `Liczba` INT NOT NULL DEFAULT 0,
  `Cena` INT NOT NULL DEFAULT 0,
  CONSTRAINT `fk_Dostawy_has_Książki_Dostawy1`
    FOREIGN KEY (`Dostawy_id`)
    REFERENCES `Dostawy` (`Dostawy_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Dostawy_has_Książki_Książki1`
    FOREIGN KEY (`Książka_id`)
    REFERENCES `Książki` (`Książka_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `Adresy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Adresy` ;

CREATE TABLE IF NOT EXISTS `Adresy` (
  `Adresy_id` INT NOT NULL AUTO_INCREMENT,
  `Adres` VARCHAR(100) NOT NULL,
  `Klienci_id` INT NOT NULL,
  PRIMARY KEY (`Adresy_id`),
  CONSTRAINT `fk_Adresy_Klienci1`
    FOREIGN KEY (`Klienci_id`)
    REFERENCES `Klienci` (`Klienci_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `Stanowiska`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `Stanowiska` (`Stanowiska_id`, `nazwa`, `pensja`)
VALUES
(1, 'Kierownik', '500000'),
(2, 'Wsparcie IT', '320000'),
(3, 'Obsługa klienta', '240000');

COMMIT;

-- -----------------------------------------------------
-- Data for table `Pracownicy`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `Pracownicy` (`Pracownicy_id`, `Imię`, `Nazwisko`, `Stanowiska_id`)
VALUES
(1, 'Nick', 'Offerman', 1),
(2, 'Amy', 'Poehler', 3),
(3, 'Aubrey', 'Plaza', 2),
(4, 'Chris', 'Pratt', 2),
(5, 'Aziz', 'Ansari', 3),
(6, 'Jim', 'O\'Heir', 3);

COMMIT;

-- -----------------------------------------------------
-- Helper procedure
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS dodaj_książkę;

DELIMITER //
CREATE PROCEDURE dodaj_książkę(
	var_autor VARCHAR(120),
	var_tytuł VARCHAR(45),
	var_cena INT
)
BEGIN
	START TRANSACTION;
	INSERT IGNORE INTO Autorzy (Autor) VALUES (var_autor);
	SELECT @autor_id := LAST_INSERT_ID();

	INSERT INTO Książki (Autorzy_id, Tytuł, Cena)
	VALUES (@autor_id, var_tytuł, var_cena);
	COMMIT;
END//
DELIMITER ;

-- -----------------------------------------------------------------------------
CALL dodaj_książkę(
	'John Ronald Reuel Tolkien',
	'Władca Pierścieni: Drużyna Pierścienia',
	6000
);

CALL dodaj_książkę(
	'John Ronald Reuel Tolkien',
	'Władca Pierścieni: Dwie wieże',
	6000
);

CALL dodaj_książkę(
	'John Ronald Reuel Tolkien',
	'Władca Pierścieni: Powrót króla',
	6000
);

CALL dodaj_książkę(
	'Joanne Rowling',
	'Harry Potter i Kamień Filozoficzny',
	3000
);

CALL dodaj_książkę(
	'Joanne Rowling',
	'Harry Potter i Komnata Tajemnic',
	3000
);

CALL dodaj_książkę(
	'Joanne Rowling',
	'Harry Potter i więzień Azkabanu',
	3000
);

CALL dodaj_książkę(
	'Joanne Rowling',
	'Harry Potter i Czara Ognia',
	3000
);

CALL dodaj_książkę(
	'Joanne Rowling',
	'Harry Potter i Zakon Feniksa',
	3000
);

CALL dodaj_książkę(
	'Joanne Rowling',
	'Harry Potter i Książę Półkrwi',
	3000
);

CALL dodaj_książkę(
	'Joanne Rowling',
	'Harry Potter i Insygnia Śmierci',
	3000
);

-- -----------------------------------------------------------------------------
START TRANSACTION;

INSERT INTO Dostawcy (Dostawcy_id, Nazwa)
VALUES (1, 'Pan Mietek');

COMMIT;

-- -----------------------------------------------------------------------------
START TRANSACTION;

INSERT INTO Dostawy (Dostawcy_id, DataDostawy)
VALUES (1, '2019-12-02');

COMMIT;
-- -----------------------------------------------------------------------------
CALL dodaj_książkę(
	'Tadeusz Dołęga-Mostowicz',
	'Kariera Nikodema Dyzmy',
	10000
);

CALL dodaj_książkę(
	'Tadeusz Dołęga-Mostowicz',
	'Profesor Wilczur',
	1500
);

CALL dodaj_książkę(
	'Henryk Sienkiewicz',
	'Potop',
	5000
);

START TRANSACTION;

INSERT IGNORE INTO Klienci
VALUES (DEFAULT, '"Abc" Jan Kowalski');
SELECT @Klient := LAST_INSERT_ID();
INSERT IGNORE INTO Adresy
VALUES (DEFAULT, @Klient, 'Grudziąc ul. Jakas 23');
SELECT @Adres := LAST_INSERT_ID();

INSERT INTO Zamówienia
VALUES (DEFAULT, @Klient, NOW(), NULL, NULL, @Adres);
SELECT @Zamówienie := LAST_INSERT_ID();

INSERT INTO Zamówienia_Książki
VALUES (
	DEFAULT,
	@Zamówienie,
	(SELECT Książka_id FROM Książki WHERE Tytuł = 'Kariera Nikodema Dyzmy'),
	30,
	10000
), (
	DEFAULT,
	@Zamówienie,
	(SELECT Książka_id FROM Książki WHERE Tytuł = 'Potop'),
	10,
	20000
);

COMMIT;

START TRANSACTION;

INSERT IGNORE INTO Klienci
VALUES (DEFAULT, '"ksiegaz" Piotr Nowak');
SELECT @Klient := LAST_INSERT_ID();
INSERT IGNORE INTO Adresy
VALUES (DEFAULT, @Klient, 'Kraków ul. Inna 37');
SELECT @Adres := LAST_INSERT_ID();

INSERT INTO Zamówienia
VALUES (DEFAULT, @Klient, NOW(), NULL, NULL, @Adres);
SELECT @Zamówienie := LAST_INSERT_ID();

INSERT INTO Zamówienia_Książki
VALUES (
	DEFAULT,
	@Zamówienie,
	(SELECT Książka_id FROM Książki WHERE Tytuł = 'Profesor Wilczur'),
	40,
	1500
), (
	DEFAULT,
	@Zamówienie,
	(SELECT Książka_id FROM Książki WHERE Tytuł = 'Potop'),
	10,
	500
);

COMMIT;

SELECT * FROM Książki LEFT JOIN Autorzy USING(Autorzy_id);
