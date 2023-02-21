/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon%';
/* 
 id |  name   | date_of_birth | escape_attempts | neutered | weight_kg 
----+---------+---------------+-----------------+----------+-----------
  1 | Agumon  | 2020-02-03    |               0 | t        |     10.23
  6 | Gabumon | 2018-11-15    |               2 | t        |         8
  8 | Devimon | 2017-05-12    |               5 | t        |        11
*/

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
/*
  name   
---------
 Gabumon
 Devimon
*/

SELECT name FROM animals WHERE neutered=TRUE AND escape_attempts < 3;
/*
  name   
---------
 Agumon
 Gabumon
*/

SELECT date_of_birth FROM animals WHERE name IN ('Pikachu', 'Agumon');
/*
 date_of_birth 
---------------
 2020-02-03
 2021-01-07
*/

SELECT name, escape_attempts FROM animals WHERE weight_kg>10.5;
/*
  name   | escape_attempts 
---------+-----------------
 Devimon |               5
 Pikachu |               1
*/

SELECT * FROM animals WHERE neutered=TRUE;
/*
 id |  name   | date_of_birth | escape_attempts | neutered | weight_kg 
----+---------+---------------+-----------------+----------+-----------
  1 | Agumon  | 2020-02-03    |               0 | t        |     10.23
  6 | Gabumon | 2018-11-15    |               2 | t        |         8
  8 | Devimon | 2017-05-12    |               5 | t        |        11
*/

SELECT * FROM animals WHERE name!='Gabumon';
/*
 id |  name   | date_of_birth | escape_attempts | neutered | weight_kg 
----+---------+---------------+-----------------+----------+-----------
  1 | Agumon  | 2020-02-03    |               0 | t        |     10.23
  8 | Devimon | 2017-05-12    |               5 | t        |        11
  7 | Pikachu | 2021-01-07    |               1 | f        |     15.04
*/

SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;
/*
 id |  name   | date_of_birth | escape_attempts | neutered | weight_kg 
----+---------+---------------+-----------------+----------+-----------
  8 | Devimon | 2017-05-12    |               5 | t        |        11
  7 | Pikachu | 2021-01-07    |               1 | f        |     15.04
*/

/* ************************************************************************************** */
/* UPDATE species to unspecified */

BEGIN;
SAVEPOINT before_update;
UPDATE animals SET species='unspecified';
SELECT * FROM animals;
/*
 id |    name    | date_of_birth | escape_attempts | neutered | weight_kg |   species   
----+------------+---------------+-----------------+----------+-----------+-------------
 16 | Ditto      | 2022-05-14    |               4 | t        |        22 | unspecified
  1 | Agumon     | 2020-02-03    |               0 | t        |     10.23 | unspecified
  6 | Gabumon    | 2018-11-15    |               2 | t        |         8 | unspecified
  8 | Devimon    | 2017-05-12    |               5 | t        |        11 | unspecified
 13 | Boarmon    | 2005-06-07    |               7 | t        |      20.4 | unspecified
  7 | Pikachu    | 2021-01-07    |               1 | f        |     15.04 | unspecified
 14 | Blossom    | 1998-10-13    |               3 | t        |        17 | unspecified
 10 | Plantmon   | 2021-11-15    |               2 | t        |      -5.7 | unspecified
 12 | Angemon    | 2005-06-12    |               1 | t        |       -45 | unspecified
 11 | Squirtle   | 1993-04-02    |               3 | f        |    -12.13 | unspecified
  9 | Charmander | 2020-02-08    |               0 | f        |       -11 | unspecified
(11 filas)
*/
ROLLBACK TO before_update;
SELECT * FROM animals;
/*
 id |    name    | date_of_birth | escape_attempts | neutered | weight_kg | species 
----+------------+---------------+-----------------+----------+-----------+---------
 16 | Ditto      | 2022-05-14    |               4 | t        |        22 | 
  1 | Agumon     | 2020-02-03    |               0 | t        |     10.23 | 
  6 | Gabumon    | 2018-11-15    |               2 | t        |         8 | 
  8 | Devimon    | 2017-05-12    |               5 | t        |        11 | 
 13 | Boarmon    | 2005-06-07    |               7 | t        |      20.4 | 
  7 | Pikachu    | 2021-01-07    |               1 | f        |     15.04 | 
 14 | Blossom    | 1998-10-13    |               3 | t        |        17 | 
 10 | Plantmon   | 2021-11-15    |               2 | t        |      -5.7 | 
 12 | Angemon    | 2005-06-12    |               1 | t        |       -45 | 
 11 | Squirtle   | 1993-04-02    |               3 | f        |    -12.13 | 
  9 | Charmander | 2020-02-08    |               0 | f        |       -11 | 
(11 filas)
*/
COMMIT;

/* UPDATE species to pokemon and digimon */

BEGIN;
UPDATE animals SET species='digimon' WHERE name LIKE '%mon%';
UPDATE animals SET species='pokemon' WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;
/*
 id |    name    | date_of_birth | escape_attempts | neutered | weight_kg | species 
----+------------+---------------+-----------------+----------+-----------+---------
  1 | Agumon     | 2020-02-03    |               0 | t        |     10.23 | digimon
  6 | Gabumon    | 2018-11-15    |               2 | t        |         8 | digimon
  8 | Devimon    | 2017-05-12    |               5 | t        |        11 | digimon
 13 | Boarmon    | 2005-06-07    |               7 | t        |      20.4 | digimon
 10 | Plantmon   | 2021-11-15    |               2 | t        |      -5.7 | digimon
 12 | Angemon    | 2005-06-12    |               1 | t        |       -45 | digimon
 16 | Ditto      | 2022-05-14    |               4 | t        |        22 | pokemon
  7 | Pikachu    | 2021-01-07    |               1 | f        |     15.04 | pokemon
 14 | Blossom    | 1998-10-13    |               3 | t        |        17 | pokemon
 11 | Squirtle   | 1993-04-02    |               3 | f        |    -12.13 | pokemon
  9 | Charmander | 2020-02-08    |               0 | f        |       -11 | pokemon
(11 filas)
*/

/* delete all data and restore it */

BEGIN;
SAVEPOINT before_delete;
DELETE FROM animals;
SELECT * FROM animals;
/*
 id | name | date_of_birth | escape_attempts | neutered | weight_kg | species 
----+------+---------------+-----------------+----------+-----------+---------
(0 filas)
*/

ROLLBACK TO before_delete;
SELECT * FROM animals;
/*
 id |    name    | date_of_birth | escape_attempts | neutered | weight_kg | species 
----+------------+---------------+-----------------+----------+-----------+---------
  1 | Agumon     | 2020-02-03    |               0 | t        |     10.23 | digimon
  6 | Gabumon    | 2018-11-15    |               2 | t        |         8 | digimon
  8 | Devimon    | 2017-05-12    |               5 | t        |        11 | digimon
 13 | Boarmon    | 2005-06-07    |               7 | t        |      20.4 | digimon
 10 | Plantmon   | 2021-11-15    |               2 | t        |      -5.7 | digimon
 12 | Angemon    | 2005-06-12    |               1 | t        |       -45 | digimon
 16 | Ditto      | 2022-05-14    |               4 | t        |        22 | pokemon
  7 | Pikachu    | 2021-01-07    |               1 | f        |     15.04 | pokemon
 14 | Blossom    | 1998-10-13    |               3 | t        |        17 | pokemon
 11 | Squirtle   | 1993-04-02    |               3 | f        |    -12.13 | pokemon
  9 | Charmander | 2020-02-08    |               0 | f        |       -11 | pokemon
(11 filas)
*/

COMMIT;

/* Change weight */

BEGIN;
SAVEPOINT before_delete_date;
DELETE FROM animals WHERE date_of_birth>'Jan 1, 2022';
SELECT * FROM animals;
/*
 id |    name    | date_of_birth | escape_attempts | neutered | weight_kg | species 
----+------------+---------------+-----------------+----------+-----------+---------
  1 | Agumon     | 2020-02-03    |               0 | t        |     10.23 | digimon
  6 | Gabumon    | 2018-11-15    |               2 | t        |         8 | digimon
  8 | Devimon    | 2017-05-12    |               5 | t        |        11 | digimon
 13 | Boarmon    | 2005-06-07    |               7 | t        |      20.4 | digimon
  7 | Pikachu    | 2021-01-07    |               1 | f        |     15.04 | pokemon
 14 | Blossom    | 1998-10-13    |               3 | t        |        17 | pokemon
 10 | Plantmon   | 2021-11-15    |               2 | t        |       5.7 | digimon
 12 | Angemon    | 2005-06-12    |               1 | t        |        45 | digimon
 11 | Squirtle   | 1993-04-02    |               3 | f        |     12.13 | pokemon
  9 | Charmander | 2020-02-08    |               0 | f        |        11 | pokemon
(10 filas)
*/
UPDATE animals SET weight_kg=weight_kg*-1;
SELECT * FROM animals;
/*
 id |    name    | date_of_birth | escape_attempts | neutered | weight_kg | species 
----+------------+---------------+-----------------+----------+-----------+---------
  1 | Agumon     | 2020-02-03    |               0 | t        |    -10.23 | digimon
  6 | Gabumon    | 2018-11-15    |               2 | t        |        -8 | digimon
  8 | Devimon    | 2017-05-12    |               5 | t        |       -11 | digimon
 13 | Boarmon    | 2005-06-07    |               7 | t        |     -20.4 | digimon
 10 | Plantmon   | 2021-11-15    |               2 | t        |       5.7 | digimon
 12 | Angemon    | 2005-06-12    |               1 | t        |        45 | digimon
  7 | Pikachu    | 2021-01-07    |               1 | f        |    -15.04 | pokemon
 14 | Blossom    | 1998-10-13    |               3 | t        |       -17 | pokemon
 11 | Squirtle   | 1993-04-02    |               3 | f        |     12.13 | pokemon
  9 | Charmander | 2020-02-08    |               0 | f        |        11 | pokemon

*/

ROLLBACK TO before_delete_date;
SELECT * FROM animals;
/*
 id |    name    | date_of_birth | escape_attempts | neutered | weight_kg | species 
----+------------+---------------+-----------------+----------+-----------+---------
  1 | Agumon     | 2020-02-03    |               0 | t        |     10.23 | digimon
  6 | Gabumon    | 2018-11-15    |               2 | t        |         8 | digimon
  8 | Devimon    | 2017-05-12    |               5 | t        |        11 | digimon
 13 | Boarmon    | 2005-06-07    |               7 | t        |      20.4 | digimon
 10 | Plantmon   | 2021-11-15    |               2 | t        |      -5.7 | digimon
 12 | Angemon    | 2005-06-12    |               1 | t        |       -45 | digimon
 16 | Ditto      | 2022-05-14    |               4 | t        |        22 | pokemon
  7 | Pikachu    | 2021-01-07    |               1 | f        |     15.04 | pokemon
 14 | Blossom    | 1998-10-13    |               3 | t        |        17 | pokemon
 11 | Squirtle   | 1993-04-02    |               3 | f        |    -12.13 | pokemon
  9 | Charmander | 2020-02-08    |               0 | f        |       -11 | pokemon
*/

UPDATE animals SET weight_kg=weight_kg*-1 
WHERE weight_kg<0;
SELECT * FROM animals;
/*
 id |    name    | date_of_birth | escape_attempts | neutered | weight_kg | species 
----+------------+---------------+-----------------+----------+-----------+---------
 10 | Plantmon   | 2021-11-15    |               2 | t        |       5.7 | digimon
 12 | Angemon    | 2005-06-12    |               1 | t        |        45 | digimon
 11 | Squirtle   | 1993-04-02    |               3 | f        |     12.13 | pokemon
  9 | Charmander | 2020-02-08    |               0 | f        |        11 | pokemon
  1 | Agumon     | 2020-02-03    |               0 | t        |     10.23 | digimon
  6 | Gabumon    | 2018-11-15    |               2 | t        |         8 | digimon
  8 | Devimon    | 2017-05-12    |               5 | t        |        11 | digimon
 13 | Boarmon    | 2005-06-07    |               7 | t        |      20.4 | digimon
 16 | Ditto      | 2022-05-14    |               4 | t        |        22 | pokemon
  7 | Pikachu    | 2021-01-07    |               1 | f        |     15.04 | pokemon
 14 | Blossom    | 1998-10-13    |               3 | t        |        17 | pokemon
*/
COMMIT;

/* ****************************************************************************************************** */

/* How many animals are there? */
SELECT COUNT(*) FROM animals;
/*
 count 
-------
    11
(1 fila)

*/

/* How many animals have never tried to escape? */
SELECT COUNT(*) FROM animals 
WHERE escape_attempts=0;
/*
 count 
-------
     2
(1 fila)

*/

/* What is the average weight of animals? */
SELECT AVG(weight_kg) FROM animals;
/*
         avg         
---------------------
 16.1363636363636364
(1 fila)
*/

/* Who escapes the most, neutered or not neutered animals? */
SELECT neutered, AVG(escape_attempts) as AVG_escape
FROM animals
GROUP BY neutered;
/*
 neutered |     avg_escape     
----------+--------------------
 f        | 1.3333333333333333
 t        | 3.0000000000000000
*/

/* What is the minimum and maximum weight of each type of animal? */
SELECT species, MIN(weight_kg) FROM animals 
GROUP BY species;
/*
 species | min 
---------+-----
 pokemon |  11
 digimon | 5.7
(2 filas)
*/

SELECT species, MAX(weight_kg) FROM animals 
GROUP BY species;
/*
 species | max 
---------+-----
 pokemon |  22
 digimon |  45
(2 filas)
*/

/* What is the average number of escape attempts per animal type of those born between 1990 and 2000? */
SELECT species,AVG(escape_attempts) FROM animals 
WHERE date_of_birth 
BETWEEN 'Jan 1, 1990' AND 'Dec 31, 2000'
GROUP BY species;
/*
 species |        avg         
---------+--------------------
 pokemon | 3.0000000000000000
(1 fila)
*/

/* *********************************************************************************************************************** */

/* What animals belong to Melody Pond? */
SELECT name FROM animals 
JOIN owners ON animals.owner_id=owners.id 
WHERE owners.full_name = 'Melody Pond';
/*
    name    
------------
 Squirtle
 Charmander
 Blossom
(3 filas)
*/

*/ List of all animals that are pokemon (their type is Pokemon). */
SELECT * FROM animals 
JOIN species ON animals.species_id=species.id 
WHERE species.name = 'Pokemon';
/*
 id |    name    | date_of_birth | escape_attempts | neutered | weight_kg | species_id | owner_id | id |  name   
----+------------+---------------+-----------------+----------+-----------+------------+----------+----+---------
 11 | Squirtle   | 1993-04-02    |               3 | f        |     12.13 |          1 |        4 |  1 | Pokemon
  9 | Charmander | 2020-02-08    |               0 | f        |        11 |          1 |        4 |  1 | Pokemon
 14 | Blossom    | 1998-10-13    |               3 | t        |        17 |          1 |        4 |  1 | Pokemon
 16 | Ditto      | 2022-05-14    |               4 | t        |        22 |          1 |          |  1 | Pokemon
  7 | Pikachu    | 2021-01-07    |               1 | f        |     15.04 |          1 |        2 |  1 | Pokemon
(5 filas)
*/

/* List all owners and their animals, remember to include those that don't own any animal. */
SELECT owners.full_name, animals.name FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id;
/*
    full_name    |    name    
-----------------+------------
 Sam Smith       | Agumon
 Jennifer Orwell | Pikachu
 Jennifer Orwell | Gabumon
 Bob             | Devimon
 Bob             | Plantmon
 Melody Pond     | Blossom
 Melody Pond     | Charmander
 Melody Pond     | Squirtle
 Dean Winchester | Boarmon
 Dean Winchester | Angemon
 Jodie Whittaker | 
(11 filas)
*/

/*How many animals are there per species?*/
SELECT species.name, COUNT(*) FROM species 
JOIN animals ON species.id=animals.species_id 
GROUP BY species.name;
/*
  name   | count 
---------+-------
 Pokemon |     5
 Digimon |     6
(2 filas)
*/

/* List all Digimon owned by Jennifer Orwell. */
SELECT animals.name FROM animals 
JOIN owners ON animals.owner_id=owners.id 
JOIN species ON animals.species_id=species.id 
WHERE owners.full_name='Jennifer Orwell' AND species.name = 'Digimon';
/*
  name   
---------
 Gabumon
(1 fila)
*/

/* List all animals owned by Dean Winchester that haven't tried to escape.*/
SELECT animals.name FROM animals 
JOIN owners ON animals.owner_id=owners.id 
WHERE owners.full_name='Dean Winchester' AND animals.escape_attempts=0;
/*
 name 
------
(0 filas)
*/

/* Who owns the most animals? */
SELECT owners.full_name, COUNT(animals.name) FROM owners 
LEFT JOIN animals ON owners.id = animals.owner_id 
GROUP BY owners.full_name 
ORDER BY count DESC 
LIMIT 1;
/*
  full_name  | count 
-------------+-------
 Melody Pond |     3
(1 fila)
*/