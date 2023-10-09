INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Agumon', '2020-02-03', 10.23, true, 0);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Gabumon', '2018-11-15', 8, true, 2);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Pikachu', '2021-01-07', 15.04, false, 1);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Devimon', '2017-05-12', 11, true, 5);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Charmander', '2020-02-08', -11.0, FALSE, 0);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Plantmon', '2021-11-15', -5.7, TRUE, 2);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Squirtle', '1993-04-02', -12.13, FALSE, 3);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Angemon', '2005-06-12', -45.0, TRUE, 1);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Boarmon', '2005-06-07', 20.4, TRUE, 7);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Blossom', '1998-10-13', 17.0, TRUE, 3);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Ditto', '2022-05-14', 22.0, TRUE, 4);

-- Day 3 Data

INSERT INTO owners (full_name, age)
VALUES 
  ('Sam Smith', 34), 
  ('Jennifer Orwell', 19), 
  ('Bob', 45), 
  ('Melodie Pond', 77), 
  ('Dean Winchester', 14), 
  ('Jodie Whittaker', 38);

INSERT INTO species (name)
VALUES
    ('Pokemon'),
    ('Digimon');

UPDATE animals
SET species_id = (
    CASE
        WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
        ELSE (SELECT id FROM species WHERE name = 'Pokemon')
    END
);

UPDATE animals
SET owner_id = 
    CASE
        WHEN name = 'Agumon' THEN 1
        WHEN name IN ('Gabumon', 'Pikachu') THEN 2
        WHEN name IN ('Devimon', 'Plantmon') THEN 3
        WHEN name IN ('Charmander', 'Squirtle', 'Blossom') THEN 4
        WHEN name IN ('Angemon', 'Boarmon') THEN 5
        ELSE NULL
    END;

-- Day 4 Insert

INSERT INTO vets (name, age, date_of_graduation)
VALUES
    ('Vet William Thatcher', 45, '2000-04-23'),
    ('Vet Maisy Smith', 26, '2019-01-17'),
    ('Vet Stephanie Mendez', 64, '1981-05-04'),
    ('Vet Jack Harkness', 38, '2008-06-08');

INSERT INTO specializations (vet_id, species_id)
VALUES
    (1, 1), 
    (3, 1), 
    (3, 2), 
    (4, 2);

INSERT INTO visits (vets_id, animals_id, date_of_visit)
VALUES
    (1, 1, '2020-05-24'), 
    (3, 1, '2020-07-22'), 
    (4, 2, '2021-02-02'), 
    (2, 3, '2020-01-05'), 
    (2, 3, '2020-03-08'), 
    (2, 3, '2020-05-14'), 
    (3, 4, '2021-05-04'), 
    (4, 5, '2021-02-24'), 
    (2, 6, '2019-12-21'), 
    (1, 6, '2020-08-10'), 
    (2, 6, '2021-04-07'), 
    (3, 7, '2019-09-29'),
    (4, 8, '2020-10-03'), 
    (4, 8, '2020-11-04'), 
    (2, 9, '2019-01-24'), 
    (2, 9, '2019-05-15'), 
    (2, 9, '2020-02-27'), 
    (2, 9, '2020-08-03'), 
    (3, 10, '2020-05-24'), 
    (1, 10, '2021-01-11'); 


INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

INSERT INTO owners (full_name, email) SELECT 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';
