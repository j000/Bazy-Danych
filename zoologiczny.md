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

| id | nazwa  | cena |
|---:|--------|-----:|
|  1 | Chomik |  500 |

--------------------

### Klienci ###

| id | nazwa | telefon |
|---:|-------|---------|

### Adresy ###

| id | adres | Klienci.id |
|---:|-------|-----------:|

### Zamówienia ###

| id | Klienci.id | Adresy.id | czy_zapłacone | czy_wysłane |
|---:|-----------:|----------:|--------------:|------------:|

### Zamówienia_produkty ###

| id | Zamówienia.id | Produkty.id | ilość | cena |
|---:|--------------:|------------:|------:|-----:|
