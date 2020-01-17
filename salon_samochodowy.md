/*

TODO:

- 3 wyzwalacze dla każdej tabeli dla każdego polecenia

# Salon samochodowy

```mysql*/

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;

-- -------------------------------------
DROP TABLE IF EXISTS Zamówienia_samochody;
DROP TABLE IF EXISTS Zamówienia;
DROP TABLE IF EXISTS Klienci;
DROP TABLE IF EXISTS Samochody;
DROP TABLE IF EXISTS Marki;
DROP TABLE IF EXISTS Modele;

-- -------------------------------------
CREATE TABLE Marki (
	Marka_id INT PRIMARY KEY AUTO_INCREMENT,
	Marka VARCHAR(50) NOT NULL
);

-- -------------------------------------
CREATE TABLE Modele (
	Model_id INT PRIMARY KEY AUTO_INCREMENT,
	Model VARCHAR(50) NOT NULL,
	Marka_id INT NOT NULL,

	FOREIGN KEY (Marka_id)
		REFERENCES Marki (Marka_id)
);

-- -------------------------------------
CREATE TABLE Samochody (
	Samochód_id INT PRIMARY KEY AUTO_INCREMENT,
	Model_id INT NOT NULL,
	Kolor VARCHAR(120) NOT NULL,
	Cena INT NOT NULL,

	FOREIGN KEY (Model_id)
		REFERENCES Modele (Model_id)
);

-- -------------------------------------
CREATE TABLE Klienci (
	Klient_id INT PRIMARY KEY AUTO_INCREMENT,
	Klient VARCHAR(255) NOT NULL,
	Telefon VARCHAR(15)
);

-- -------------------------------------
CREATE TABLE Zamówienia (
	Zamówienie_id INT PRIMARY KEY AUTO_INCREMENT,
	Klient_id INT,
	Data_zamówienia DATETIME NOT NULL,
	Data_płatności DATETIME,
	Data_odbioru DATETIME,

	FOREIGN KEY (Klient_id)
		REFERENCES Klienci (Klient_id)
);

-- -------------------------------------
CREATE TABLE Zamówienia_samochody (
	Zamówienie_id INT,
	Ilość INT NOT NULL,
	Samochód_id INT,

	FOREIGN KEY (Zamówienie_id)
		REFERENCES Zamówienia (Zamówienie_id),
	FOREIGN KEY (Samochód_id)
		REFERENCES Samochody (Samochód_id)
);

-- -------------------------------------
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -------------------------------------
START TRANSACTION;
INSERT INTO Marki VALUES (1, 'Usunięta Marka');
INSERT INTO Modele VALUES (1, 'Usunięty Model', 1);
INSERT INTO Klienci VALUES (1, 'Usunięty Klient', DEFAULT);
COMMIT;

-- -------------------------------------
DELIMITER ;;

CREATE TRIGGER Marki_Insert_Trigger BEFORE INSERT ON Marki
FOR EACH ROW
BEGIN
	SET NEW.Marka = TRIM(NEW.Marka);
END;;

CREATE TRIGGER Marki_Update_Trigger BEFORE UPDATE ON Marki
FOR EACH ROW
BEGIN
	SET NEW.Marka = TRIM(NEW.Marka);
END;;

CREATE TRIGGER Marki_Delete_Trigger BEFORE DELETE ON Marki
FOR EACH ROW
BEGIN
	UPDATE Modele
		SET Marka_id = 1
		WHERE Marka_id = OLD.Marka_id;
END;;

CREATE TRIGGER Modele_Insert_Trigger BEFORE INSERT ON Modele
FOR EACH ROW
BEGIN
	SET NEW.Model = TRIM(NEW.Model);
END;;

CREATE TRIGGER Modele_Update_Trigger BEFORE UPDATE ON Modele
FOR EACH ROW
BEGIN
	SET NEW.Model = TRIM(NEW.Model);
END;;

CREATE TRIGGER Modele_Delete_Trigger BEFORE DELETE ON Modele
FOR EACH ROW
BEGIN
	UPDATE Samochody
		SET Model_id = 1
		WHERE Model_id = OLD.Model_id;
END;;

CREATE TRIGGER Samochody_Insert_Trigger BEFORE INSERT ON Samochody
FOR EACH ROW
BEGIN
	IF NEW.Cena < 0 THEN
		SET NEW.Cena = 0;
	END IF;
END;;

CREATE TRIGGER Samochody_Update_Trigger BEFORE UPDATE ON Samochody
FOR EACH ROW
BEGIN
	IF NEW.Cena < 0 THEN
		SET NEW.Cena = 0;
	END IF;
END;;

CREATE TRIGGER Samochody_Delete_Trigger BEFORE DELETE ON Samochody
FOR EACH ROW
BEGIN
	DELETE FROM Zamówienia_samochody
		WHERE Samochód_id = OLD.Samochód_id;
END;;

CREATE TRIGGER Klienci_Insert_Trigger BEFORE INSERT ON Klienci
FOR EACH ROW
BEGIN
	IF NEW.Telefon NOT LIKE '+%' THEN
		SET NEW.Telefon = CONCAT('+48', NEW.Telefon);
	END IF;
END;;

CREATE TRIGGER Klienci_Update_Trigger BEFORE UPDATE ON Klienci
FOR EACH ROW
BEGIN
	IF NEW.Telefon NOT LIKE '+%' THEN
		SET NEW.Telefon = CONCAT('+48', NEW.Telefon);
	END IF;
END;;

CREATE TRIGGER Klienci_Delete_Trigger BEFORE DELETE ON Klienci
FOR EACH ROW
BEGIN
	UPDATE Zamówienia
		SET Klient_id = 1
		WHERE Klient_id = OLD.Klient_id;
END;;

CREATE TRIGGER Zamówienia_Insert_Trigger BEFORE INSERT ON Zamówienia
FOR EACH ROW
BEGIN
	SET NEW.Data_zamówienia = NOW();
END;;

CREATE TRIGGER Zamówienia_Update_Trigger BEFORE UPDATE ON Zamówienia
FOR EACH ROW
BEGIN
END;;

CREATE TRIGGER Zamówienia_Delete_Trigger BEFORE DELETE ON Zamówienia
FOR EACH ROW
BEGIN
	DELETE FROM Zamówienia
		WHERE Zamówienie_id = OLD.Zamówienie_id;
END;;

CREATE TRIGGER Zamówienia_samochody_Insert_Trigger BEFORE INSERT ON Zamówienia_samochody
FOR EACH ROW
BEGIN
	IF NEW.Ilość < 1 THEN
		SET NEW.Ilość = 1;
	END IF;
END;;

CREATE TRIGGER Zamówienia_samochody_Update_Trigger BEFORE UPDATE ON Zamówienia_samochody
FOR EACH ROW
BEGIN
	IF NEW.Ilość < 1 THEN
		SET NEW.Ilość = 1;
	END IF;
END;;

CREATE TRIGGER Zamówienia_samochody_Delete_Trigger BEFORE DELETE ON Zamówienia_samochody
FOR EACH ROW
BEGIN
	SET @wartosc = @wartosc + (
		SELECT Cena
			FROM Samochody
			WHERE Samochód_id = OLD.Samochód_id
	);
END;;

DELIMITER ;

-- -------------------------------------

DROP PROCEDURE IF EXISTS dodaj_samochód;

DELIMITER ;;

CREATE PROCEDURE dodaj_samochód(
	var_marka VARCHAR(50),
	var_model VARCHAR(50),
	var_kolor VARCHAR(120),
	var_cena INT
)
BEGIN
	DECLARE id_marki INT;
	DECLARE id_modelu INT;

	START TRANSACTION;

	SET id_marki = (
		SELECT Marka_id
			FROM Marki
			WHERE var_marka = Marka
	);
	IF id_marki IS NULL THEN
		INSERT INTO Marki(Marka)
			VALUES (var_marka);
		SET id_marki = (SELECT LAST_INSERT_ID());
	END IF;

	SET id_modelu = (
		SELECT Model_id
			FROM Modele
			WHERE var_model = Model
				AND id_marki = Marka_id
	);
	IF id_modelu IS NULL THEN
		INSERT INTO Modele(Marka_id, Model)
			VALUES (id_marki, var_model);
		SET id_modelu = (SELECT LAST_INSERT_ID());
	END IF;

	INSERT INTO Samochody (Model_id, Kolor, Cena)
		VALUES (id_modelu, var_kolor, var_cena);

	COMMIT;
END;;

DELIMITER ;

-- -------------------------------------
DROP PROCEDURE IF EXISTS wypisz_samochody;

CREATE PROCEDURE wypisz_samochody()
SELECT Marka
	, Model
	, Kolor
	, Cena
	FROM Samochody
	JOIN Modele USING (Model_id)
	JOIN Marki USING (Marka_id);

CALL wypisz_samochody();

DROP PROCEDURE IF EXISTS wypisz_zamówienia;

CREATE PROCEDURE wypisz_zamówienia()
SELECT Marka
	, Model
	, Kolor
	, Cena
	, Ilość
	, Klient
	, Data_zamówienia
	FROM Zamówienia
	JOIN Klienci USING (Klient_id)
	JOIN Zamówienia_samochody USING (Zamówienie_id)
	JOIN Samochody USING (Samochód_id)
	JOIN Modele USING (Model_id)
	JOIN Marki USING (Marka_id);

-- -------------------------------------
CALL dodaj_samochód('Ford', 'Fiesta ST', 'Electric Orange', 84357);
CALL dodaj_samochód('   McLaren', '   720S', 'Red Rose', 1723394);
CALL dodaj_samochód('Maserati', 'Quattroporte   ', 'Silver', 2304931);
CALL dodaj_samochód('Ford   ', 'Focus ST', 'Electric Orange', -84357);

START TRANSACTION;

INSERT
	INTO Klienci (Klient, Telefon)
	VALUES
		('Jan Kowalski', '122000000');
INSERT
	INTO Zamówienia (Klient_id)
	VALUES
		(2);

INSERT
	INTO Zamówienia_samochody (Zamówienie_id, Ilość, Samochód_id)
	VALUES (1, 1, 2);

COMMIT;

CALL wypisz_samochody();

-- -------------------------------------
SELECT 'Modyfikacja';
UPDATE Modele
	SET Model = '  Focus RS  '
	WHERE Model = 'Focus ST';
CALL wypisz_samochody();

-- --------------------------------------
SELECT 'Usuwanie';
DELETE FROM Marki WHERE Marka = 'Ford';
CALL wypisz_samochody();
DELETE FROM Modele WHERE Model = 'Quattroporte';
CALL wypisz_samochody();

-- --------------------------------------
CALL wypisz_zamówienia();
