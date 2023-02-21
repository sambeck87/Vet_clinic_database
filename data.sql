/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Agumon', 'Feb 3, 2020', 10.23, 'TRUE', 0);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Gabumon', 'Nov 15, 2018', 8, 'TRUE', 2);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Pikachu', 'Jan 7, 2021', 15.04, 'FALSE', 1);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Devimon', 'May 12, 2017', 11, 'TRUE', 5);

/* ************************************************************************************************ */

*/ Add new elements */

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Charmander', 'Feb 8, 2020', -11, 'FALSE', 0);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Plantmon', 'Nov 15, 2021', -5.7, 'TRUE', 2);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Squirtle', 'Apr 2, 1993', -12.13, 'FALSE', 3);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Angemon', 'Jun 12, 2005', -45, 'TRUE', 1);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Boarmon', 'Jun 7, 2005', 20.4, 'TRUE', 7);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Blossom', 'Oct 13, 1998', 17, 'TRUE', 3);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Ditto', 'May 14, 2022', 22, 'TRUE', 4);

/* ************************************************************************************************ */

INSERT INTO owners (full_name, age) 
VALUES ('Sam Smith', 34);

INSERT INTO owners (full_name, age) 
VALUES ('Jennifer Orwell', 19);

INSERT INTO owners (full_name, age) 
VALUES ('Bob', 45);

INSERT INTO owners (full_name, age) 
VALUES ('Melody Pond', 77);

INSERT INTO owners (full_name, age) 
VALUES ('Dean Winchester', 14);

INSERT INTO owners (full_name, age) 
VALUES ('Jodie Whittaker', 38);

INSERT INTO species (name) 
VALUES ('Pokemon');

INSERT INTO species (name) 
VALUES ('Digimon');

UPDATE animals SET species_id=2 WHERE name LIKE '%mon%';
UPDATE animals SET species_id=1 WHERE species_id IS NULL;

UPDATE animals SET owner_id=1 WHERE name IN ('Agumon');
UPDATE animals SET owner_id=2 WHERE name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owner_id=3 WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owner_id=4 WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id=5 WHERE name IN ('Angemon', 'Boarmon');

/*
 id |    name    | date_of_birth | escape_attempts | neutered | weight_kg | species_id | owner_id 
----+------------+---------------+-----------------+----------+-----------+------------+----------
 11 | Squirtle   | 1993-04-02    |               3 | f        |     12.13 |          1 |        4
  9 | Charmander | 2020-02-08    |               0 | f        |        11 |          1 |        4
 14 | Blossom    | 1998-10-13    |               3 | t        |        17 |          1 |        4
 10 | Plantmon   | 2021-11-15    |               2 | t        |       5.7 |          2 |        3
  8 | Devimon    | 2017-05-12    |               5 | t        |        11 |          2 |        3
 12 | Angemon    | 2005-06-12    |               1 | t        |        45 |          2 |        5
 13 | Boarmon    | 2005-06-07    |               7 | t        |      20.4 |          2 |        5
 16 | Ditto      | 2022-05-14    |               4 | t        |        22 |          1 |         
  1 | Agumon     | 2020-02-03    |               0 | t        |     10.23 |          2 |        1
  6 | Gabumon    | 2018-11-15    |               2 | t        |         8 |          2 |        2
  7 | Pikachu    | 2021-01-07    |               1 | f        |     15.04 |          1 |        2
(11 filas)
*/