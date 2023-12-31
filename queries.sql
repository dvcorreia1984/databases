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
SELECT animals.name A digimon_name
FROM animals
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owner_id = owners.id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

SELECT a.name AS animal_name
FROM animals AS a
JOIN owners AS o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

SELECT owners.full_name AS owner_name, COUNT(animals.id) AS animal_count
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY animal_count DESC
LIMIT 1;

-- Queries Day 4 

SELECT a.name AS last_animal_seen
FROM visits v
JOIN animals a ON v.animals_id = a.id
WHERE v.vets_id = 1
ORDER BY v.date_of_visit DESC
LIMIT 1;

SELECT COUNT(DISTINCT v.animals_id) AS animals_seen_by_stephanie
FROM visits v
WHERE v.vets_id = 3;

SELECT v.name AS vet_name, COALESCE(specialization_names.name, 'No Specialty') AS specialty_name
FROM vets v
LEFT JOIN (
    SELECT vet_id, STRING_AGG(species_name, ', ') AS name
    FROM (
        SELECT v.id AS vet_id, s.name AS species_name
        FROM vets v
        LEFT JOIN specializations sp ON v.id = sp.vet_id
        LEFT JOIN species s ON sp.species_id = s.id
    ) AS subquery
    GROUP BY vet_id
) AS specialization_names ON v.id = specialization_names.vet_id;

SELECT a.name AS animal_name
FROM visits v
JOIN animals a ON v.animals_id = a.id
WHERE v.vets_id = 3
    AND v.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

SELECT a.name AS most_visited_animal
FROM (
    SELECT animals_id, COUNT(*) AS visit_count
    FROM visits
    GROUP BY animals_id
    ORDER BY visit_count DESC
    LIMIT 1
) AS most_visited
JOIN animals a ON most_visited.animals_id = a.id;

SELECT a.name AS first_visit_animal
FROM visits v
JOIN animals a ON v.animals_id = a.id
WHERE v.vets_id = 2
ORDER BY v.date_of_visit ASC
LIMIT 1;

SELECT a.name AS animal_name, vet.name AS vet_name, v.date_of_visit AS date_of_most_recent_visit
FROM visits v
JOIN animals a ON v.animals_id = a.id
JOIN vets vet ON v.vets_id = vet.id
ORDER BY v.date_of_visit DESC
LIMIT 1;

SELECT COUNT(*) AS visits_with_non_specialist
FROM visits v
LEFT JOIN specializations s ON v.vets_id = s.vet_id AND v.animals_id = s.species_id
WHERE s.species_id IS NULL;

SELECT s.name AS recommended_specialty
FROM (
    SELECT a.species_id, COUNT(*) AS visit_count
    FROM visits v
    JOIN animals a ON v.animals_id = a.id
    WHERE v.vets_id = 2
    GROUP BY a.species_id
    ORDER BY visit_count DESC
    LIMIT 1
) AS most_visited_species
JOIN species s ON most_visited_species.species_id = s.id;
















