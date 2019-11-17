/*

### Stanowiska ###

| id | nazwa           |
|---:|-----------------|
|  1 | kierownik       |
|  2 | Wsparcie IT     |
|  3 | Obsługa klienta |

### Pracownicy ###

| id | imie      | nazwisko         | Stanowiska_id |
|---:|-----------|------------------|--------------:|
|  1 | Jarosław  | Rymut            |             1 |
|  2 | Stanisław | Lem              |             2 |
|  3 | Jacek     | Dukaj            |             2 |
|  4 | Wojciech  | Orliński         |             3 |
|  5 | Adam      | Wiśniewski-Snerg |             3 |

--------------------

### Produkty ###

| id | nazwa                | cena |
|---:|----------------------|-----:|
|  1 | Chomik               |  500 |
|  2 | Karma dla papug 500g | 2700 |
|  3 | Karma dla kotów 3kg  | 1200 |
|  4 | Karma dla rybek 100g | 1300 |

--------------------

### Klienci ###

| id | nazwa                  | telefon   |
|---:|------------------------|-----------|
|  1 | Dzikie węże sp. z o.o. | 122000000 |
|  2 | Kocia kawiarnia        | 602900000 |
|  3 | Jan Nowak              | 603604605 |

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

    /* vim: set expandtab filetype=mysql: */
