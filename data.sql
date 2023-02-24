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

/* ************************************************************************************************ */

INSERT INTO vets(name, age, date_of_graduation)
VALUES  ('William Tatcher', 45, 'Apr 23, 2000'),
        ('Maisy Smith', 26, 'Jan 17, 2019'), 
        ('Stephanie Mendez', 64, 'May 4, 1981'), 
        ('Jack Harkness', 38, 'Jun 8, 2008');
/*
 id |       name       | age | date_of_graduation 
----+------------------+-----+--------------------
  1 | William Tatcher  |  45 | 2000-04-23
  2 | Maisy Smith      |  26 | 2019-01-17
  3 | Stephanie Mendez |  64 | 1981-05-04
  4 | Jack Harkness    |  38 | 2008-06-08
*/

INSERT INTO specializations(vet_id, species_id) 
VALUES
        ((SELECT id FROM vets WHERE name='William Tatcher'),(SELECT id FROM species WHERE name = 'Pokemon')),
        ((SELECT id FROM vets WHERE name='Stephanie Mendez'),(SELECT id FROM species WHERE name = 'Pokemon')), 
        ((SELECT id FROM vets WHERE name='Stephanie Mendez'),(SELECT id FROM species WHERE name = 'Digimon')), 
        ((SELECT id FROM vets WHERE name='Jack Harkness'),(SELECT id FROM species WHERE name = 'Digimon'));
/*
 species_id | vet_id 
------------+--------
          1 |      1
          1 |      3
          2 |      3
          2 |      4
*/

INSERT INTO visits(animal_id, vet_id, visit_date) 
VALUES
        ((SELECT id FROM animals WHERE name ='Agumon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), 'May 24, 2020'), 
        ((SELECT id FROM animals WHERE name ='Agumon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 'Jul 22, 2020'), 
        ((SELECT id FROM animals WHERE name ='Gabumon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), 'Feb 2, 2021'), 
        ((SELECT id FROM animals WHERE name ='Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'Jan 5, 2020'), 
        ((SELECT id FROM animals WHERE name ='Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'Mar 8, 2020'), 
        ((SELECT id FROM animals WHERE name ='Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'May 14, 2020'), 
        ((SELECT id FROM animals WHERE name ='Devimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 'May 4, 2021'), 
        ((SELECT id FROM animals WHERE name ='Charmander'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), 'Feb 24, 2021'), 
        ((SELECT id FROM animals WHERE name ='Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'Dec 21, 2019'), 
        ((SELECT id FROM animals WHERE name ='Plantmon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), 'Aug 10, 2020'), 
        ((SELECT id FROM animals WHERE name ='Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'Apr 7, 2021'), 
        ((SELECT id FROM animals WHERE name ='Squirtle'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 'Sep 29, 2019'), 
        ((SELECT id FROM animals WHERE name ='Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), 'Oct 3, 2020'), 
        ((SELECT id FROM animals WHERE name ='Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), 'Nov 4, 2020'), 
        ((SELECT id FROM animals WHERE name ='Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'Jan 24, 2019'), 
        ((SELECT id FROM animals WHERE name ='Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'May 15, 2019'), 
        ((SELECT id FROM animals WHERE name ='Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'Feb 27, 2020'), 
        ((SELECT id FROM animals WHERE name ='Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'Aug 3, 2020'), 
        ((SELECT id FROM animals WHERE name ='Blossom'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 'May 24, 2020'), 
        ((SELECT id FROM animals WHERE name ='Blossom'), (SELECT id FROM vets WHERE name = 'William Tatcher'), 'Jan 11, 2021');
        /*
         animal_id | vet_id | visit_date 
-----------+--------+------------
         1 |      1 | 2020-05-24
         1 |      3 | 2020-07-22
         6 |      4 | 2021-02-02
         7 |      2 | 2020-01-05
         7 |      2 | 2020-03-08
         7 |      2 | 2020-05-14
         8 |      3 | 2021-05-04
         9 |      4 | 2021-02-24
        10 |      2 | 2019-12-21
        10 |      1 | 2020-08-10
        10 |      2 | 2021-04-07
        11 |      3 | 2019-09-29
        12 |      4 | 2020-10-03
        12 |      4 | 2020-11-04
        13 |      2 | 2019-01-24
        13 |      2 | 2019-05-15
        13 |      2 | 2020-02-27
        13 |      2 | 2020-08-03
        14 |      3 | 2020-05-24
        14 |      1 | 2021-01-11
*/

