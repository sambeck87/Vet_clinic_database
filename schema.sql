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

