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
