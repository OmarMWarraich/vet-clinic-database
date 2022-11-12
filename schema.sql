/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INTEGER PRIMARY KEY,
    name varchar(100),
    date_of_birth date,
    escape_attempts int,
    neutered boolean,
    weight_kg decimal
);

/* Add a new column species of type string to the animals table. */

ALTER TABLE animals ADD species varchar(100);

/* Create a table named owners with the following columns: */

CREATE TABLE owners (
    id INTEGER NOT NULL PRIMARY KEY,
    full_name varchar(100),
    age int
);

/* Create a table namex species with the following columns: */

CREATE TABLE species (
    id INTEGER NOT NULL PRIMARY KEY,
    name varchar(100)
);

/* Modify animals table by dropping column species. */

ALTER TABLE animals DROP COLUMN species;

/* Modify animals table by adding a column species_id of type integer. */

ALTER TABLE animals ADD species_id int;

/* Modify animals table by adding a foreign key to species table. */

ALTER TABLE animals ADD CONSTRAINT fk_species_id FOREIGN KEY (species_id) REFERENCES species (id);

/* Modify animals table by adding a column owner_id which is a foreign key referencing owners table. */

ALTER TABLE animals ADD owner_id int;

ALTER TABLE animals ADD CONSTRAINT fk_owner_id FOREIGN KEY (owner_id) REFERENCES owners (id);