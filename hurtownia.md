Stanowiska

| id | nazwa           |
|---:|-----------------|
|  1 | kierownik       |
|  2 | Wsparcie IT     |
|  3 | Obsługa klienta |

Pracownicy

| id | imie      | nazwisko         | id_stanowiska |
|---:|-----------|------------------|--------------:|
|  1 | Jarosław  | Rymut            |             1 |
|  2 | Stanisław | Lem              |             2 |
|  3 | Jacek     | Dukaj            |             2 |
|  4 | Wojciech  | Orliński         |             3 |
|  5 | Adam      | Wiśniewski-Snerg |             3 |

--------------------

Artykuły

| id | nazwa                        | cena | id_koloru | id_typu |
|---:|------------------------------|-----:|----------:|--------:|
|  1 | zeszyt a4 80 kartek w kratkę |  230 |         1 |       1 |
|  2 | blok rysunkowy               |  220 |         2 |       3 |
|  3 | długopis czarny              |   75 |         3 |       2 |
|  4 | zeszyt a4 80 kartek w linie  |  320 |         2 |       1 |
|  5 | zeszyt a4 80 kartek w linie  |  320 |         4 |       1 |
|  6 | zeszyt a4 80 kartek w linie  |  320 |         1 |       1 |

Typy

| id | rodzaj         |
|---:|----------------|
|  1 | zeszyt         |
|  2 | długopis       |
|  3 | blok rysunkowy |

Kolory

| id | nazwa     |
|---:|-----------|
|  1 | niebieski |
|  2 | czerwony  |
|  3 | czarny    |
|  4 | fioletowy |

--------------------

Klienci

| id | nazwa   | telefon   |
|---:|---------|-----------|
|  1 | Papirus | 123434300 |
|  2 | Sowa    | 606606606 |
|  3 | Szkolak | 122000000 |

Adresy

| id | adres                     |
|---:|---------------------------|
|  1 | ul. Magiczna 8, Kraków    |
|  2 | ul. Tęczowa 42, Wieliczka |

Zamówienia

| id | id_klienta | id_adresu |
|---:|-----------:|----------:|
|  1 |          1 |         1 |
|  2 |          1 |         1 |
|  3 |          3 |         2 |

Zamówienia_produkty

| id | id_zamówienia | id_produktu | ilość |
|---:|--------------:|------------:|------:|
|  1 |             1 |           1 |    23 |
|  2 |             1 |           3 |   300 |
|  3 |             2 |           3 |   500 |
|  4 |             3 |           2 |     5 |
