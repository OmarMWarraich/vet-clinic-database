/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT name FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name NOT LIKE '%Gabumon%';
SELECT name FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/*
Inside a transaction update the animals table by setting the species column to unspecified. 
Verify that change was made. Then roll back the change and verify that the species columns 
went back to the state before the transaction.
*/

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

/*
Inside a transaction:
    Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
    Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
    Commit the transaction.
    Verify that change was made and persists after commit.
*/

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

/*
Inside a transaction:
    Delete all records in the animals table, then roll back the transaction.
    After the rollback verify if all records in the table are still there. 
*/

BEGIN;
DELETE FROM animals;
ROLLBACK;

/* 
    Inside a new transaction, delete all animals born after Jan 1st, 2022.
    Create a save point for the transaction.
*/

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT savepoint_name;

/* 
    Update all animals' weight to be their weight multiplied by -1. 
    Verify that change was made. Then roll back to the save point.
    After the rollback, UPDATE all animals' weights that are negative to be their weight multiplied by -1.
    Commit transaction.
*/

UPDATE animals SET weight_kg = weight_kg * -1;
SELECT * FROM animals;
ROLLBACK TO savepoint_name;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
SELECT * FROM animals;
COMMIT;

/*
   wRite queries to answer the following questions:
    How many animals are there?
    How many animals have never tried to escape?
    What is the average weight of animals?
    Who escapes the most, neutered or not neutered animals?
    What is the minimum and maximum weight of each type of animal?
    What is the average number of escape attempts per animal type of those born between 1990 and 2000?
*/

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered FROM animals WHERE escape_attempts = (SELECT MAX(escape_attempts) FROM animals);
SELECT MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

/* Write queries(using JOIN) to answer the following questions: */

/* What animals belong to Melody Pond? */

SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';

/* List of all animals that are pokemon (their type is pokemon). */

SELECT animals.name FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'pokemon';

/* List of all owners and their animals, remember to include those that don't own any animal. */

SELECT owners.full_name, animals.name FROM owners LEFT JOIN animals ON owners.id = animals.owner_id;

/* How many animals are there per species? */

SELECT species.name, COUNT(animals.species_id) FROM species JOIN animals ON species.id = animals.species_id GROUP BY species.name;

/* List all Digimon owned by Jennifer Orwell. */

SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id JOIN species ON animals.species_id = species.id WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

/* List all animals owned by Dean Winchester that haven't tried to escape. */

SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

/* Who owns the most animals */

SELECT owners.full_name, COUNT(animals.owner_id) FROM owners JOIN animals ON owners.id = animals.owner_id GROUP BY owners.full_name ORDER BY COUNT(animals.owner_id) DESC LIMIT 1;