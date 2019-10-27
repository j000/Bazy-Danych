# ALTER DATABASE (SELECT DATABASE()) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8_unicode_ci;

CREATE TABLE `Stanowiska` (
	`id` INT AUTO_INCREMENT NOT NULL,
	`nazwa` VARCHAR(255) NOT NULL,

	PRIMARY KEY (`id`)
);

CREATE TABLE `Pracownicy` (
	`id` INT AUTO_INCREMENT NOT NULL,
	`imie` VARCHAR(255) NOT NULL,
	`nazwisko` VARCHAR(255) NOT NULL,
	`Stanowiska_id` INT NOT NULL,

	PRIMARY KEY (`id`),

	FOREIGN KEY (`Stanowiska_id`) REFERENCES `Stanowiska` (`id`)
);

CREATE TABLE `Produkty` (
	`id` INT AUTO_INCREMENT NOT NULL,
	`nazwa` VARCHAR(255) NOT NULL,
	`cena` INT,

	PRIMARY KEY (`id`)
);

CREATE TABLE `Klienci` (
	`id` INT AUTO_INCREMENT NOT NULL,
	`nazwa` VARCHAR(255) NOT NULL,
	`telefon` VARCHAR(255),

	PRIMARY KEY (`id`)
);

CREATE TABLE `Adresy` (
	`id` INT AUTO_INCREMENT NOT NULL,
	`adres` VARCHAR(255) NOT NULL,
	`Klienci_id` INT,

	PRIMARY KEY (`id`),

	FOREIGN KEY (`Klienci_id`) REFERENCES `Klienci` (`id`)
);

CREATE TABLE `Zamówienia` (
	`id` INT AUTO_INCREMENT NOT NULL,
	`Klienci_id` INT,
	`Adresy_id` INT,
	`czy_zaplacone` BOOL NOT NULL,
	`czy_wysłane` BOOL NOT NULL,

	PRIMARY KEY (`id`),

	FOREIGN KEY (`Klienci_id`) REFERENCES `Klienci` (`id`),
	FOREIGN KEY (`Adresy_id`) REFERENCES `Adresy` (`id`)
);

CREATE TABLE `Zamówienia_produkty` (
	`id` INT AUTO_INCREMENT NOT NULL,
	`Zamówienia_id` INT,
	`Produkty_id` INT,
	`ilość` INT,

	PRIMARY KEY (`id`),

	FOREIGN KEY (`Zamówienia_id`) REFERENCES `Zamówienia` (`id`),
	FOREIGN KEY (`Produkty_id`) REFERENCES `Produkty` (`id`)
);
