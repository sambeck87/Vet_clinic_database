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

/* *********************************************************************************************************************** */

/* Who was the last animal seen by William Tatcher? */
SELECT visits.visit_date, animals.name 
FROM visits 
JOIN animals ON visits.animal_id=animals.id 
JOIN vets ON visits.vet_id=vets.id 
WHERE vets.name='William Tatcher' 
ORDER BY visit_date ASC 
LIMIT 1;
/*
 visit_date |  name  
------------+--------
 2020-05-24 | Agumon
*/

/* How many different animals did Stephanie Mendez see? */
SELECT COUNT(DISTINCT animals.name) 
FROM visits JOIN animals ON visits.animal_id=animals.id 
JOIN vets ON visits.vet_id=vets.id WHERE vets.name='Stephanie Mendez';
/*
 count 
-------
     4
*/

/* List all vets and their specialties, including vets with no specialties */
SELECT vets.name, species.name FROM vets 
LEFT JOIN specializations ON vets.id = specializations.vet_id 
LEFT JOIN species ON specializations.species_id=species.id;
/*
       name       |  name   
------------------+---------
 William Tatcher  | Pokemon
 Stephanie Mendez | Pokemon
 Stephanie Mendez | Digimon
 Jack Harkness    | Digimon
 Maisy Smith      | 
*/

/* List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020 */
SELECT visits.visit_date, animals.name FROM visits 
JOIN animals ON visits.animal_id=animals.id 
JOIN vets ON visits.vet_id=vets.id 
WHERE vets.name='Stephanie Mendez' 
AND visits.visit_date BETWEEN 'Apr 1, 2020' AND 'Aug 30, 2020';
/*
 visit_date |  name   
------------+---------
 2020-07-22 | Agumon
 2020-05-24 | Blossom
*/

/* What animal has the most visits to vets? */
SELECT animals.name, COUNT(animals.name) FROM visits 
JOIN animals ON visits.animal_id=animals.id 
GROUP BY animals.name 
ORDER BY count DESC 
LIMIT 1;
/*
  name   | count 
---------+-------
 Boarmon |     4
*/

/* Who was Maisy Smith's first visit? */
SELECT visits.visit_date, animals.name FROM visits 
JOIN animals ON visits.animal_id=animals.id 
JOIN vets ON visits.vet_id=vets.id 
WHERE vets.name='Maisy Smith' 
ORDER BY visit_date ASC 
LIMIT 1;
/*
 visit_date |  name   
------------+---------
 2019-01-24 | Boarmon
*/

/* Details for most recent visit: animal information, vet information, and date of visit */
SELECT  animals.name as animal_name, 
        animals.escape_attempts, 
        animals.neutered, 
        animals.weight_kg, 
        species.name as specie, 
        owners.full_name as owner, 
        owners.age as owner_age, 
        vets.name as vet, 
        vets.age as vet_age, 
        vets.date_of_graduation as vet_date_of_graduation, 
        visits.visit_date 
FROM specializations 
JOIN species on species_id=species.id 
JOIN vets on vet_id=vets.id 
LEFT JOIN animals ON species.id = animals.species_id 
JOIN owners on animals.owner_id=owners.id 
JOIN visits ON animals.id=visits.animal_id 
ORDER BY visit_date DESC 
LIMIT 1;
/*
 animal_name | escape_attempts | neutered | weight_kg | specie  | owner | owner_age |      vet      | vet_age | vet_date_of_graduation | visit_date 
-------------+-----------------+----------+-----------+---------+-------+-----------+---------------+---------+------------------------+------------
 Devimon     |               5 | t        |        11 | Digimon | Bob   |        45 | Jack Harkness |      38 | 2008-06-08             | 2021-05-04
*/

/* How many visits were with a vet that did not specialize in that animal's species? */
SELECT COUNT(vets.name) FROM visits 
JOIN vets ON visits.vet_id=vets.id 
LEFT JOIN specializations ON vets.id=specializations.vet_id 
WHERE species_id IS NULL;
/*
 count 
-------
     9
*/

/* What specialty should Maisy Smith consider getting? Look for the species she gets the most */
SELECT species.name, COUNT(species.name) FROM visits 
JOIN vets ON visits.vet_id=vets.id 
JOIN animals ON visits.animal_id=animals.id 
JOIN species ON animals.species_id=species.id 
WHERE vets.name='Maisy Smith' 
GROUP BY species.name 
ORDER BY count DESC 
LIMIT 1;
/*
  name   | count 
---------+-------
 Digimon |     6
*/

/* ************************************************************************************ */

/* BEFORE */
EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;
/*
                                                          QUERY PLAN                                                          

 Aggregate  (cost=210819.35..210819.36 rows=1 width=8) (actual time=844.662..855.123 rows=1 loops=1)
   ->  Gather  (cost=1000.00..210819.35 rows=1 width=0) (actual time=844.624..855.083 rows=0 loops=1)
         Workers Planned: 2
         Workers Launched: 2
         ->  Parallel Seq Scan on visits  (cost=0.00..209819.25 rows=1 width=0) (actual time=818.149..818.149 rows=0 loops=3)
               Filter: (animal_id = 4)
               Rows Removed by Filter: 6589520
 Planning Time: 0.439 ms
 JIT:
   Functions: 11
   Options: Inlining false, Optimization false, Expressions true, Deforming true
   Timing: Generation 1.313 ms, Inlining 0.000 ms, Optimization 0.766 ms, Emission 17.005 ms, Total 19.084 ms
 Execution Time:*/ 855.454 ms 

/* AFTER */
EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;
/*
                                                          QUERY PLAN                                                          

 Aggregate  (cost=4.46..4.47 rows=1 width=8) (actual time=0.029..0.030 rows=1 loops=1)
   ->  Index Only Scan using ordered_id on visits  (cost=0.44..4.46 rows=1 width=0) (actual time=0.025..0.025 rows=0 loops=1)
         Index Cond: (animal_id = 4)
         Heap Fetches: 0
 Planning Time: 0.186 ms
 Execution Time:*/ 0.053 ms

                                                /* ******************* */

