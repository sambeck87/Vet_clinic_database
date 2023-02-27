/* Database schema to keep the structure of entire database. */
createdb vet_clinic

CREATE TABLE animals (
id INT GENERATED ALWAYS AS IDENTITY,
name VARCHAR,
date_of_birth DATE,
escape_attempts INT,
neutered BOOL,
weight_kg DECIMAL
);

/* ****************************************************************************************** */

/* Add species column */
ALTER TABLE animals ADD COLUMN species VARCHAR;

/* ****************************************************************************************** */

CREATE TABLE owners (
  id INT GENERATED ALWAYS AS IDENTITY NOT NULL, 
  full_name VARCHAR NOT NULL, 
  age INT NOT NULL, 
  PRIMARY KEY(id));

CREATE TABLE species (
  id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
   name VARCHAR NOT NULL,
   PRIMARY KEY (id));

ALTER TABLE animals ADD PRIMARY KEY (id);

ALTER TABLE animals DROP species;
/*
 id |    name    | date_of_birth | escape_attempts | neutered | weight_kg 
----+------------+---------------+-----------------+----------+-----------
 10 | Plantmon   | 2021-11-15    |               2 | t        |       5.7
 12 | Angemon    | 2005-06-12    |               1 | t        |        45
 11 | Squirtle   | 1993-04-02    |               3 | f        |     12.13
  9 | Charmander | 2020-02-08    |               0 | f        |        11
  1 | Agumon     | 2020-02-03    |               0 | t        |     10.23
  6 | Gabumon    | 2018-11-15    |               2 | t        |         8
  8 | Devimon    | 2017-05-12    |               5 | t        |        11
 13 | Boarmon    | 2005-06-07    |               7 | t        |      20.4
 16 | Ditto      | 2022-05-14    |               4 | t        |        22
  7 | Pikachu    | 2021-01-07    |               1 | f        |     15.04
 14 | Blossom    | 1998-10-13    |               3 | t        |        17
(11 filas)
*/

ALTER TABLE animals ADD COLUMN species_id INT REFERENCES species(id);
ALTER TABLE animals ADD COLUMN owner_id INT REFERENCES owners(id);

/* ****************************************************************************************** */

CREATE TABLE vets 
( 
  id INT GENERATED ALWAYS AS IDENTITY, 
  name VARCHAR NOT NULL, 
  age INT NOT NULL, 
  date_of_graduation DATE NOT NULL, 
  PRIMARY KEY(id)
);

CREATE TABLE specializations
(
  species_id INT REFERENCES species(id), 
  vet_id INT REFERENCES vets(id)
);

CREATE TABLE visits
(
  animal_id INT REFERENCES animals(id),
   vet_id INT REFERENCES vets(id),
    visit_date DATE
);

/* ********************************************************* */

ALTER TABLE owners ADD COLUMN email VARCHAR(120);

CREATE INDEX ordered_id ON visits(animal_id ASC);