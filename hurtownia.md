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
Cena w groszach. Dodatkowe typy i kolory, żeby można było łatwiej wyszukiwać produkty.

| id | nazwa                        | cena | Kolory.id | Typy.id | czy_dostępne |
|---:|------------------------------|-----:|----------:|--------:|-------------:|
|  1 | zeszyt a4 80 kartek w kratkę |  230 |         1 |       1 |            1 |
|  2 | blok rysunkowy               |  220 |         2 |       3 |            1 |
|  3 | długopis                     |   75 |         3 |       2 |            1 |
|  4 | zeszyt a4 80 kartek w linie  |  320 |         2 |       1 |            1 |
|  5 | zeszyt a4 80 kartek w linie  |  320 |         4 |       1 |            0 |
|  6 | zeszyt a4 80 kartek w linie  |  320 |         1 |       1 |            1 |

### Typy ###

| id | rodzaj         |
|---:|----------------|
|  1 | zeszyt         |
|  2 | długopis       |
|  3 | blok rysunkowy |

### Kolory ###

| id | nazwa     |
|---:|-----------|
|  1 | niebieski |
|  2 | czerwony  |
|  3 | czarny    |
|  4 | fioletowy |

--------------------

### Klienci ###

| id | nazwa   | telefon   |
|---:|---------|-----------|
|  1 | Papirus | 123434300 |
|  2 | Sowa    | 606606606 |
|  3 | Szkolak | 122000000 |

### Adresy ###
Pamiętamy więcej niż jeden adres dostawy dla klientów.

| id | adres                          | Klienci.id |
|---:|--------------------------------|-----------:|
|  1 | ul. Magiczna 8, Kraków         |          1 |
|  2 | ul. Tęczowa 42, Wieliczka      |          3 |
|  3 | ul. Czarodziejska 13, Skawina  |          2 |
|  4 | ul. Zaczarowana 3/4, Zabierzów |          1 |

### Zamówienia ###

| id | Klienci.id | Adresy.id | czy_zapłacone | czy_wysłane |
|---:|-----------:|----------:|--------------:|------------:|
|  1 |          1 |         1 |             1 |           1 |
|  2 |          1 |         1 |             1 |           0 |
|  3 |          3 |         2 |             1 |           0 |
|  4 |          1 |         4 |             0 |           0 |

### Zamówienia_produkty ###
Przechowujemy cenę jednostkową z momentu zakupu, by móc łatwo zaktualizować katalog.

| id | Zamówienia.id | Produkty.id | ilość | cena |
|---:|--------------:|------------:|------:|-----:|
|  1 |             1 |           1 |    23 |  220 |
|  2 |             1 |           3 |   300 |   70 |
|  3 |             2 |           3 |   500 |   70 |
|  4 |             3 |           2 |    36 |  210 |
|  5 |             3 |           5 |    36 |  320 |
|  6 |             4 |           3 |   120 |   75 |
|  7 |             4 |           4 |   120 |  320 |

