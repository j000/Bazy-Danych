/*

### Stanowiska ###

| id | nazwa           | pensja |
|---:|-----------------|-------:|
|  1 | kierownik       | 487500 |
|  2 | Wsparcie IT     | 320000 |
|  3 | Obsługa klienta | 240000 |

### Pracownicy ###

| id | imie      | nazwisko         | Stanowiska_id |
|---:|-----------|------------------|--------------:|
|  1 | Jarosław  | Rymut            |             1 |
|  2 | Stanisław | Lem              |             2 |
|  3 | Jacek     | Dukaj            |             2 |
|  4 | Wojciech  | Orliński         |             3 |
|  5 | Adam      | Wiśniewski-Snerg |             3 |

--------------------

### Dostawcy ###

| id | nazwa                     |
|---:|---------------------------|
|  1 | Mostly garbage LLT        |
|  2 | High quality Incorporated |
|  3 | Cheap Corp                |
|  4 | ACME Corporation          |

### Produkty ###

| id | nazwa                | cena | Dostawcy_id |
|---:|----------------------|-----:|------------:|
|  1 | Chomik               |  500 |           2 |
|  2 | Karma dla papug 500g | 2700 |           1 |
|  3 | Karma dla kotów 3kg  | 1200 |           1 |
|  4 | Karma dla rybek 100g | 1300 |           1 |

--------------------

### Klienci ###

| id | nazwa                  | telefon   | email                        |
|---:|------------------------|-----------|------------------------------|
|  1 | Dzikie węże sp. z o.o. | 122000000 | dzikie@weze.pl               |
|  2 | Kocia kawiarnia        | 602900000 | kociakawiarnia@hoolimail.com |
|  3 | Jan Nowak              | 603604605 | jan.nowak@nowaki.com.pl      |

### Adresy ###

| id | adres                      | Klienci_id |
|---:|----------------------------|-----------:|
|  1 | ul. Niedostępna 6s, Kraków |          1 |
|  2 | ul. Lwia 104, Kraków       |          2 |
|  3 | ul. Rozrywka 4, Kraków     |          3 |
|  4 | ul. Fajna 8, Kraków        |          3 |

### Zamówienia ###

| id | Klienci_id | Adresy_id | czy_zapłacone | czy_wysłane |
|---:|-----------:|----------:|--------------:|------------:|
|  1 |          1 |         1 |             1 |           1 |
|  2 |          1 |         1 |             1 |           0 |
|  3 |          2 |         2 |             0 |           0 |
|  4 |          3 |         3 |             1 |           1 |
|  5 |          3 |         4 |             1 |           0 |

### Zamówienia_produkty ###

| id | Zamówienia_id | Produkty_id | ilość |
|---:|--------------:|------------:|------:|
|  1 |             1 |           1 |     5 |
|  2 |             2 |           1 |     8 |
|  3 |             3 |           3 |     1 |
|  4 |             4 |           4 |     2 |
|  5 |             4 |           2 |     1 |
|  6 |             5 |           2 |     1 |

*/

-- ------------------

    ALTER DATABASE DB_RYMUT DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci;
    USE DB_RYMUT;

    DROP TABLE IF EXISTS Pracownicy;
    DROP TABLE IF EXISTS Stanowiska;

    DROP TABLE IF EXISTS Zamówienia_produkty;
    DROP TABLE IF EXISTS Produkty;
    DROP TABLE IF EXISTS Zamówienia;
    DROP TABLE IF EXISTS Adresy;
    DROP TABLE IF EXISTS Klienci;

    CREATE TABLE Stanowiska (
        id INT AUTO_INCREMENT NOT NULL,
        nazwa VARCHAR(255) NOT NULL,

        PRIMARY KEY (id)
    );

    CREATE TABLE Pracownicy (
        id INT AUTO_INCREMENT NOT NULL,
        imie VARCHAR(255) NOT NULL,
        nazwisko VARCHAR(255) NOT NULL,
        Stanowiska_id INT NOT NULL,

        PRIMARY KEY (id),

        FOREIGN KEY (Stanowiska_id) REFERENCES Stanowiska (id)
    );

    CREATE TABLE Produkty (
        id INT AUTO_INCREMENT NOT NULL,
        nazwa VARCHAR(255) NOT NULL,
        cena INT,

        PRIMARY KEY (id)
    );

    CREATE TABLE Klienci (
        id INT AUTO_INCREMENT NOT NULL,
        nazwa VARCHAR(255) NOT NULL,
        telefon VARCHAR(255),

        PRIMARY KEY (id)
    );

    CREATE TABLE Adresy (
        id INT AUTO_INCREMENT NOT NULL,
        adres VARCHAR(255) NOT NULL,
        Klienci_id INT,

        PRIMARY KEY (id),

        FOREIGN KEY (Klienci_id) REFERENCES Klienci (id)
    );

    CREATE TABLE Zamówienia (
        id INT AUTO_INCREMENT NOT NULL,
        Klienci_id INT,
        Adresy_id INT,
        czy_zaplacone BOOL NOT NULL,
        czy_wysłane BOOL NOT NULL,

        PRIMARY KEY (id),

        FOREIGN KEY (Klienci_id) REFERENCES Klienci (id),
        FOREIGN KEY (Adresy_id) REFERENCES Adresy (id)
    );

    CREATE TABLE Zamówienia_produkty (
        id INT AUTO_INCREMENT NOT NULL,
        Zamówienia_id INT,
        Produkty_id INT,
        ilość INT,

        PRIMARY KEY (id),

        FOREIGN KEY (Zamówienia_id) REFERENCES Zamówienia (id),
        FOREIGN KEY (Produkty_id) REFERENCES Produkty (id)
    );

-- ------------------

    INSERT INTO Stanowiska VALUES
    (DEFAULT, 'kierownik'),
    (DEFAULT, 'Wsparcie IT'),
    (DEFAULT, 'Obsługa klienta');

    INSERT INTO Pracownicy VALUES
    (DEFAULT, 'Jarosław', 'Rymut', 1),
    (DEFAULT, 'Stanisław', 'Lem', 2),
    (DEFAULT, 'Jacek', 'Dukaj', 2),
    (DEFAULT, 'Wojciech', 'Orliński', 3),
    (DEFAULT, 'Adam', 'Wiśniewski-Snerg', 3);

    INSERT INTO Produkty VALUES
    (DEFAULT, 'Chomik', 500),
    (DEFAULT, 'Karma dla papug 500g', 2700),
    (DEFAULT, 'Karma dla kotów 3kg', 1200),
    (DEFAULT, 'Karma dla rybek 100g', 1300);

    INSERT INTO Klienci VALUES
    (DEFAULT, 'Dzikie węże sp. z o.o.', '122000000'),
    (DEFAULT, 'Kocia kawiarnia', '602900000'),
    (DEFAULT, 'Jan Nowak', '603604605');

    INSERT INTO Adresy VALUES
    (DEFAULT, 'ul. Niedostępna 6s, Kraków', 1),
    (DEFAULT, 'ul. Lwia 104, Kraków', 2),
    (DEFAULT, 'ul. Rozrywka 4, Kraków', 3),
    (DEFAULT, 'ul. Fajna 8, Kraków', 3);

    INSERT INTO Zamówienia VALUES
    (DEFAULT, 1, 1, TRUE, TRUE),
    (DEFAULT, 1, 1, TRUE, FALSE),
    (DEFAULT, 2, 2, FALSE, FALSE),
    (DEFAULT, 3, 3, TRUE, TRUE),
    (DEFAULT, 3, 4, TRUE, FALSE);

    INSERT INTO Zamówienia_produkty VALUES
    (DEFAULT, 1, 1, 5),
    (DEFAULT, 2, 1, 8),
    (DEFAULT, 3, 3, 1),
    (DEFAULT, 4, 4, 2),
    (DEFAULT, 4, 2, 1),
    (DEFAULT, 5, 2, 1);


-- ------------------

    ALTER TABLE Klienci ADD email VARCHAR(255);
    ALTER TABLE Stanowiska ADD pensja INT;
    -- Oczywiście, na pracowni korzystamy z archiwalnej wersji MySQL --
    -- ALTER TABLE Zamówienia RENAME COLUMN czy_zaplacone TO czy_zapłacone;
    ALTER TABLE Zamówienia CHANGE `czy_zaplacone` `czy_zapłacone` BOOL;

    UPDATE Stanowiska
    SET nazwa = 'Kierownik'
    WHERE nazwa = 'kierownik';

    UPDATE Stanowiska
    SET pensja = 487500
    WHERE nazwa = 'Kierownik';

    UPDATE Stanowiska
    SET pensja = 320000
    WHERE nazwa = 'Wsparcie IT';

    UPDATE Stanowiska
    SET pensja = 240000
    WHERE nazwa = 'Obsługa klienta';

    UPDATE Klienci
    SET email = 'dzikie@weze.pl'
    WHERE id = 1;

    UPDATE Klienci
    SET email = 'kociakawiarnia@hoolimail.com'
    WHERE id = 2;

    UPDATE Klienci
    SET email = 'jan.nowak@nowaki.com.pl'
    WHERE id = 3;

-- ------------------

    -- tanie produkty
    SELECT nazwa
        , cena/100 AS cena
    FROM Produkty
    WHERE cena < 2000
    ORDER BY cena DESC;

    -- karmy
    SELECT nazwa
        , cena/100 AS cena
    FROM Produkty
    WHERE nazwa LIKE "Karma%";

    -- kierownicy
    SELECT imie
        , nazwisko
    FROM Pracownicy
    WHERE Stanowiska_id = 1;

    -- stanowiska
    SELECT nazwa
        , pensja/100 as pensja
    FROM Stanowiska;

    -- dobrze płatne stanowiska
    SELECT nazwa
        , pensja/100 as pensja
    FROM Stanowiska
    WHERE pensja > 1000;

    -- pracownicy o nazwiku na literę L
    SELECT imie
        , nazwisko
    FROM Pracownicy
    WHERE nazwisko LIKE "L%";

    -- pracownicy z długimi nazwiskami
    SELECT imie
        , nazwisko
    FROM Pracownicy
    WHERE LENGTH(nazwisko) > 9;

    -- opłacone, niewysłane zamówenia
    SELECT Klienci_id
        , Adresy_id
    FROM Zamówienia
    WHERE czy_zapłacone AND NOT czy_wysłane;

    -- nieopłacone zamówenia
    SELECT Klienci_id
        , Adresy_id
    FROM Zamówienia
    WHERE NOT czy_zapłacone;

    -- opłacone zamówenia
    SELECT nazwa
        , telefon
        , adres
        , Zamówienia.id AS id_zamówienia
    FROM Zamówienia
    INNER JOIN Klienci
        ON Klienci_id = Klienci.id
    INNER JOIN Adresy
        ON Adresy_id = Adresy.id
    WHERE czy_zapłacone AND NOT czy_wysłane;

    -- pracownicy i ich nazwiska
    SELECT imie
        , nazwisko
        , Stanowiska.nazwa
    FROM Pracownicy
    INNER JOIN Stanowiska
        ON Stanowiska.id = Pracownicy.Stanowiska_id;

-- ------------------

/*

Proszę wyświetlić (dane nie mogą się powtarzać):

- wszystkie dane z każdej tabeli
- wszystkie firmy sprzedające karmę dla psów
- wszystkie firmy dostarczające produkty w liczbie przekraczającej 10,
- wszystkie firmy dostarczające produkty w cenie między: 100 a 1000 zł,
- wszystkie firmy sprzedające karmę dla psów oraz karmę dla kotów,
- 10 firm dostarczających największą liczbę produktów,
- 15 firm dostarczających najdroższe produkty (z pominięciem pierwszej pozycji na liście)

Proszę napisać (i wywołać) następujące procedury:

1. Procedury wyświetlające wszystkie dane z każdej tabeli
2. Procedury modyfikujące jedną dowolną daną w tabeli (dla każdej tabeli po jednej procedurze)
3. Po jednej dowolnej procedurze dla każdej tabeli

*/
    DROP TABLE IF EXISTS Dostawcy;

    CREATE TABLE Dostawcy (
        id INT AUTO_INCREMENT NOT NULL,
        nazwa VARCHAR(255) NOT NULL,

        PRIMARY KEY (id)
    );

    ALTER TABLE Produkty ADD COLUMN Dostawcy_id INT NOT NULL;

    INSERT
    INTO Dostawcy (nazwa)
    VALUES ('Mostly garbage LLT')
        , ('High quality Incorporated')
        , ('Cheap Corp')
        , ('ACME Corporation');

    UPDATE Produkty SET Dostawcy_id = 2 WHERE id = 1;
    UPDATE Produkty SET Dostawcy_id = 1 WHERE id = 2;
    UPDATE Produkty SET Dostawcy_id = 1 WHERE id = 3;
    UPDATE Produkty SET Dostawcy_id = 1 WHERE id = 4;

    ALTER TABLE Produkty ADD FOREIGN KEY (Dostawcy_id) REFERENCES Dostawcy(id);

    DELIMITER ;;

    DROP PROCEDURE IF EXISTS dostawcy;;
    CREATE PROCEDURE dostawcy(IN int_val INT)
        BEGIN
            WHILE int_val > 0 DO
                INSERT
                INTO Dostawcy (nazwa)
                VALUES (CONCAT('Firma ', LEFT(SHA(UUID()), 8)));
                SET int_val = int_val - 1;
            END WHILE;
        END;;
    CALL dostawcy(20);;
    -- DROP PROCEDURE dostawcy;;

    DROP PROCEDURE IF EXISTS produkty;;
    CREATE PROCEDURE produkty(IN int_val INT)
        BEGIN
            DECLARE dostawcy_max INT DEFAULT (SELECT COUNT(*) - 1 FROM Dostawcy);
            DECLARE zwierzeta_max INT DEFAULT 1;
            DECLARE masy_max INT DEFAULT 1;
            DECLARE fun1 INT DEFAULT 1;
            DECLARE fun2 INT DEFAULT 1;

            CREATE TEMPORARY TABLE tmp_zwierzęta (
                zwierzę VARCHAR(30)
            );
            INSERT
            INTO tmp_zwierzęta
            VALUES ('psów')
                , ('kotów')
                , ('papug')
                , ('żółwi')
                , ('rybek')
                , ('chomików')
                , ('kawii domowych');
            CREATE TEMPORARY TABLE tmp_masy (
                masa VARCHAR(10)
            );
            INSERT
            INTO tmp_masy
            VALUES ('100g')
                , ('250g')
                , ('500g')
                , ('1kg')
                , ('3kg')
                , ('5kg')
                , ('10kg')
                , ('15kg')
                , ('30kg')
                , ('50kg');

            SET zwierzeta_max = (SELECT COUNT(*) - 1 FROM tmp_zwierzęta);
            SET masy_max = (SELECT COUNT(*) - 1 FROM tmp_masy);

            WHILE int_val > 0 DO
                SET fun1 = FLOOR(RAND() * zwierzeta_max);
                SET fun2 = FLOOR(RAND() * masy_max);
                INSERT INTO
                    Produkty (nazwa, cena, Dostawcy_id)
                    VALUES (
                        CONCAT(
                            'Karma dla '
                            , (SELECT * FROM tmp_zwierzęta LIMIT fun1, 1)
                            , ' '
                            , (SELECT * FROM tmp_masy LIMIT fun2, 1)
                        ),
                        FLOOR(RAND() * 13000 + 100),
                        FLOOR(RAND() * dostawcy_max + 1)
                    );
                SET int_val = int_val - 1;
            END WHILE;

            DROP TEMPORARY TABLE tmp_zwierzęta;
            DROP TEMPORARY TABLE tmp_masy;
        END;;
    CALL produkty(400);;
    -- DROP PROCEDURE produkty;;

    DELIMITER ;

    -- Wypisanie wszystkich danych

    SELECT * FROM Stanowiska;
    SELECT * FROM Pracownicy;

    SELECT * FROM Dostawcy;
    SELECT * FROM Produkty;

    SELECT * FROM Klienci;
    SELECT * FROM Adresy;
    SELECT * FROM Zamówienia;
    SELECT * FROM Zamówienia_produkty;

    -- Wszystkie firmy sprzedające karmę dla psów

    SELECT DISTINCT Dostawcy.nazwa AS 'Dostawcy karmy dla psów'
    FROM Dostawcy
    INNER JOIN Produkty
        ON Dostawcy_id = Dostawcy.id
    WHERE Produkty.nazwa LIKE 'Karma dla psów %';

    -- Wszystkie firmy dostarczające produkty w liczbie przekraczającej 10

    SELECT nazwa AS 'Dostawcy >10 produktów'
    FROM (
        SELECT Dostawcy.nazwa AS nazwa
            , COUNT(Produkty.Dostawcy_id) AS ilość
        FROM Dostawcy
        INNER JOIN Produkty
            ON Dostawcy_id = Dostawcy.id
        GROUP BY Dostawcy.nazwa
            HAVING ilość > 10
        ORDER BY ilość DESC
    ) AS T;

    -- Wszystkie firmy dostarczające produkty w cenie między: 100 a 1000 zł --

    SELECT DISTINCT Dostawcy.nazwa AS 'Dostawcy produktów w cenie między 100 a 1000zł'
    FROM Dostawcy
    INNER JOIN Produkty
        ON Dostawcy_id = Dostawcy.id
    WHERE Produkty.cena BETWEEN 10000 AND 100000;

    -- Wszystkie firmy sprzedające karmę dla psów oraz karmę dla kotów --

    /* SET profiling = 1; */

    SELECT DISTINCT Dostawcy.nazwa AS 'Dostawcy karmy dla psów i kotów'
    FROM Dostawcy
    INNER JOIN Produkty AS p
        ON p.Dostawcy_id = Dostawcy.id
        AND p.nazwa LIKE 'Karma dla psów %'
    INNER JOIN Produkty AS p2
        ON p2.Dostawcy_id = Dostawcy.id
        AND p2.nazwa LIKE 'Karma dla kotów %';

    SELECT DISTINCT nazwa AS 'Dostawcy karmy dla psów i kotów'
    FROM Dostawcy
    WHERE id IN (
            SELECT DISTINCT Dostawcy_id
            FROM Produkty
            WHERE nazwa LIKE 'Karma dla psów %'
        )
        AND id IN (
            SELECT DISTINCT Dostawcy_id
            FROM Produkty
            WHERE nazwa LIKE 'Karma dla kotów %'
        );

    /* SET profiling = 0; SHOW PROFILES; */
    -- join jest wolniejszy

    -- 10 firm dostarczających największą liczbę produktów --

    SELECT Dostawcy.nazwa AS Dostawca
        , COUNT(Produkty.Dostawcy_id) AS 'Ilość produktów'
    FROM Dostawcy
    INNER JOIN Produkty
        ON Dostawcy_id = Dostawcy.id
    GROUP BY Dostawcy.nazwa
    ORDER BY 'Ilość produktów' DESC
    LIMIT 10;

    -- 15 firm dostarczających najdroższe produkty (z pominięciem pierwszej pozycji na liście --

    SELECT Dostawcy.nazwa AS Dostawca
        , Produkty.nazwa AS Produkt
        , Produkty.cena / 100 AS Cena
    FROM Dostawcy
    INNER JOIN Produkty
        ON Dostawcy_id = Dostawcy.id
    ORDER BY Produkty.cena DESC
    LIMIT 1, 15;

    DELIMITER ;;

    -- Procedury wyświetlające wszystkie dane z każdej tabeli

    DROP PROCEDURE IF EXISTS show_table;;
    CREATE PROCEDURE show_table(IN what_table VARCHAR(30))
        BEGIN
            SET @t1 = CONCAT('SELECT * FROM ', what_table);
            PREPARE stmt FROM @t1;
            EXECUTE stmt;
            DEALLOCATE PREPARE stmt;
        END;;

    DROP PROCEDURE IF EXISTS show_all;;
    CREATE PROCEDURE show_all()
        BEGIN
            /*
            SELECT * FROM Stanowiska;
            SELECT * FROM Pracownicy;

            SELECT * FROM Dostawcy;
            SELECT * FROM Produkty;

            SELECT * FROM Klienci;
            SELECT * FROM Adresy;
            SELECT * FROM Zamówienia;
            SELECT * FROM Zamówienia_produkty;
            */
            CALL show_table('Stanowiska');
            CALL show_table('Pracownicy');

            CALL show_table('Dostawcy');
            CALL show_table('Produkty');

            CALL show_table('Klienci');
            CALL show_table('Adresy');
            CALL show_table('Zamówienia');
            CALL show_table('Zamówienia_produkty');
        END;;
    CALL show_all();;

    -- Procedury modyfikujące jedną dowolną daną w tabeli (dla każdej tabeli po jednej procedurze)
    DROP PROCEDURE IF EXISTS podnies_pensje;;
    CREATE PROCEDURE podnies_pensje()
        BEGIN
            UPDATE Stanowiska
            SET pensja = 1.1 * pensja;
        END;;
    CALL podnies_pensje();;

    DROP PROCEDURE IF EXISTS awansuj_pracownika;;
    CREATE PROCEDURE awansuj_pracownika()
        BEGIN
            UPDATE Pracownicy
            SET Stanowiska_id = Stanowiska_id - 1
            WHERE Stanowiska_id > 1
                AND nazwisko = 'Orliński';
        END;;
    CALL awansuj_pracownika();;

    DROP PROCEDURE IF EXISTS dostawca_upada;;
    CREATE PROCEDURE dostawca_upada()
        BEGIN
            UPDATE Dostawcy
            SET nazwa = CONCAT(nazwa, ' w stanie upadłości')
            WHERE id = 8;
        END;;
    CALL dostawca_upada();;

    DROP PROCEDURE IF EXISTS dodaj_opłaty;;
    CREATE PROCEDURE dodaj_opłaty(IN oplata INT)
        BEGIN
            UPDATE Produkty
            SET cena = cena + oplata;
        END;;
    CALL dodaj_opłaty(200);;

    DROP PROCEDURE IF EXISTS zmien_telefony;;
    CREATE PROCEDURE zmien_telefony()
        BEGIN
            UPDATE Klienci
            SET telefon = CONCAT('+48', telefon)
            WHERE telefon NOT LIKE '+%';
        END;;
    CALL zmien_telefony();;
    CALL zmien_telefony();;

    DROP PROCEDURE IF EXISTS zmien_adres;;
    CREATE PROCEDURE zmien_adres()
        BEGIN
            UPDATE Adresy
            SET adres = REPLACE(adres, '6s', '66')
            WHERE id = 1;
        END;;
    CALL zmien_adres();;

    DROP PROCEDURE IF EXISTS opłać_zamówienia;;
    CREATE PROCEDURE opłać_zamówienia()
        BEGIN
            UPDATE Zamówienia
            SET czy_zapłacone = 1
            WHERE Klienci_id = 2;
        END;;
    CALL opłać_zamówienia();;

    DROP PROCEDURE IF EXISTS zmiana_produktów;;
    CREATE PROCEDURE zmiana_produktów()
        BEGIN
            UPDATE Zamówienia_produkty
            SET Produkty_id = 2
            WHERE id = 3;
        END;;
    CALL zmiana_produktów();;

    -- Po jednej dowolnej procedurze dla każdej tabeli

    DROP PROCEDURE IF EXISTS fun_stanowiska;;
    CREATE PROCEDURE fun_stanowiska(IN minimum INT)
        BEGIN
            UPDATE Stanowiska
            SET pensja = minimum
            WHERE pensja < minimum;
        END;;
    CALL fun_stanowiska(2500);;

    DROP PROCEDURE IF EXISTS fun_pracownicy;;
    CREATE PROCEDURE fun_pracownicy()
        BEGIN
           UPDATE Pracownicy
           SET Stanowiska_id = 3
           WHERE nazwisko = 'Dukaj';
        END;;
    CALL fun_pracownicy();;

    DROP PROCEDURE IF EXISTS fun_dostawcy;;
    CREATE PROCEDURE fun_dostawcy()
        BEGIN
           UPDATE Dostawcy
           SET nazwa = REPLACE(nazwa, ' w stanie upadłości', '')
           WHERE nazwa LIKE '%w stanie upadłości%';
        END;;
    CALL fun_dostawcy();;

    DROP PROCEDURE IF EXISTS fun_produkty;;
    CREATE PROCEDURE fun_produkty()
        BEGIN
           UPDATE Produkty
           SET nazwa = REPLACE(nazwa, 'papug', 'ptaków')
           WHERE nazwa LIKE '%papug%';
        END;;
    CALL fun_produkty();;

    DROP PROCEDURE IF EXISTS fun_klienci;;
    CREATE PROCEDURE fun_klienci()
        BEGIN
            SELECT *
            FROM Klienci
            WHERE id NOT IN (
                SELECT DISTINCT Klienci_id
                FROM Zamówienia
            );
        END;;
    CALL fun_klienci();;

    -- adresy spoza Krakowa
    DROP PROCEDURE IF EXISTS fun_adresy;;
    CREATE PROCEDURE fun_adresy()
        BEGIN
            SELECT *
            FROM Adresy
            WHERE adres NOT LIKE '%Kraków%';
        END;;
    CALL fun_adresy();;

    -- Zamówienia do wysłania
    DROP PROCEDURE IF EXISTS fun_zamówienia;;
    CREATE PROCEDURE fun_zamówienia()
        BEGIN
            SELECT Zamówienia.id
                , adres
            FROM Zamówienia
                INNER JOIN Adresy
                    ON Adresy_id = Adresy.id
            WHERE czy_zapłacone
                AND NOT czy_wysłane;
        END;;
    CALL fun_zamówienia();;

    DROP PROCEDURE IF EXISTS dodaj_gratis;;
    CREATE PROCEDURE dodaj_gratis()
        BEGIN
            INSERT INTO Zamówienia_produkty (Zamówienia_id, Produkty_id, ilość)
            SELECT id AS Zamówienia_id
                , 1
                , 1
            FROM Zamówienia
            WHERE czy_wysłane = 0;
        END;;
    CALL dodaj_gratis();;

    DELIMITER ;

    /* vim: set expandtab filetype=mysql: */
