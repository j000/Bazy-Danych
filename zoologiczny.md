### Stanowiska ###

| id | nazwa           |
|---:|-----------------|
|  1 | kierownik       |
|  2 | Wsparcie IT     |
|  3 | Obsługa klienta |

### Pracownicy ###

| id | imie      | nazwisko         | Stanowiska.id |
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

| id | adres                      | Klienci.id |
|---:|----------------------------|-----------:|
|  1 | ul. Niedostępna 6s, Kraków |          1 |
|  2 | ul. Lwia 104, Kraków       |          2 |
|  3 | ul. Rozrywka 4, Kraków     |          3 |
|  4 | ul. Fajna 8, Kraków        |          3 |

### Zamówienia ###

| id | Klienci.id | Adresy.id | czy_zapłacone | czy_wysłane |
|---:|-----------:|----------:|--------------:|------------:|
|  1 |          1 |         1 |             1 |           1 |
|  2 |          1 |         1 |             1 |           0 |
|  3 |          2 |         2 |             0 |           0 |
|  4 |          3 |         3 |             1 |           1 |
|  5 |          3 |         4 |             1 |           0 |

### Zamówienia_produkty ###

| id | Zamówienia.id | Produkty.id | ilość | cena |
|---:|--------------:|------------:|------:|-----:|
|  1 |             1 |           1 |     5 |  400 |
|  2 |             2 |           1 |     8 |  450 |
|  3 |             3 |           3 |     1 | 1200 |
|  4 |             4 |           4 |     2 | 1300 |
|  5 |             4 |           2 |     1 | 2700 |
|  6 |             5 |           2 |     1 | 2700 |
