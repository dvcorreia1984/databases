SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

-- Screenshot1

BEGIN;
UPDATE animals
SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Screenshot2

BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL OR species = '';
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

-- Screenshot3

BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Screenshot4

BEGIN;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
SELECT * FROM animals;
SAVEPOINT my_savepoint;
UPDATE animals
SET weight_kg = weight_kg * -1;
ROLLBACK TO my_savepoint;
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

-- Screenshot5
SELECT COUNT(*) AS total_animals
FROM animals;

SELECT COUNT(*) AS non_escapers
FROM animals
WHERE escape_attempts = 0;

SELECT AVG(weight_kg) AS average_weight
FROM animals;

SELECT neutered, MAX(escape_attempts) AS max_escape_attempts
FROM animals
GROUP BY neutered;

SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

SELECT species, AVG(escape_attempts) AS average_escape_attempts
FROM animals
WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-12-31'
GROUP BY species;

-- Day 3 Queries

SELECT a.name
FROM animals AS a
JOIN owners AS o ON a.owner_id = o.id
WHERE o.full_name = 'Melodie Pond';

SELECT animals.name
FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT owners.full_name, animals.name AS animal_name
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id;

SELECT species.name AS species_name, COUNT(animals.id) AS animal_count
FROM species
LEFT JOIN animals ON species.id = animals.species_id
GROUP BY species.name;

SELECT animals.name AS digimon_name
FROM animals
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owner_id = owners.id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

SELECT a.name AS animal_name
FROM animals AS a
JOIN owners AS o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester';

SELECT owners.full_name AS owner_name, COUNT(animals.id) AS animal_count
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY animal_count DESC
LIMIT 1;














