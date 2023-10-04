CREATE TABLE animals (
    id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    PRIMARY KEY (id)
);

ALTER TABLE animals
ADD COLUMN species VARCHAR(255);

ALTER TABLE animals
ADD COLUMN species VARCHAR(255);

-- Day 3 Queries

CREATE TABLE owners (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(50) NOT NULL,
    age INTEGER NOT NULL
);

CREATE TABLE species (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50) NOT NULL
);

ALTER TABLE animals
DROP COLUMN species;
SELECT * FROM animals;

ALTER TABLE animals
ADD COLUMN species_id INT,
ADD CONSTRAINT fk_species
FOREIGN KEY (species_id)
REFERENCES species(id);
\d animals

ALTER TABLE animals
ADD COLUMN owner_id INT,
ADD CONSTRAINT fk_owner
FOREIGN KEY (owner_id)
REFERENCES owners(id);
\d animals


