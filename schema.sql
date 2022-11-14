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

/* Create a table named vets with the following columns: */

CREATE TABLE vets (
    id INTEGER NOT NULL PRIMARY KEY,
    name varchar(100),
    age int,
    date_of_graduation date
);

/* There is a many-to-many relationship between the tables species and vets, a vet can specialize in multiple species,
and a species can have multiple vets specializing in it. Create a "join table" called specializations to handle this relationship. */

CREATE TABLE specializations (
    vet_id int,
    species_id int,
    CONSTRAINT fk_vet_id FOREIGN KEY (vet_id) REFERENCES vets (id),
    CONSTRAINT fk_species_id FOREIGN KEY (species_id) REFERENCES species (id)
);

/* There is a many-to-many relationship between the tables animals and vets: an animal can visit multiple vets and one vet can be
visited by multiple animals. Create a "join table" called visits to handle this relationship, It should also keep track of the date of the visit. */

CREATE TABLE visits (
    vet_id int,
    animal_id int,
    date_of_visit date,
    CONSTRAINT fk_vet_id FOREIGN KEY (vet_id) REFERENCES vets (id),
    CONSTRAINT fk_animal_id FOREIGN KEY (animal_id) REFERENCES animals (id)
);


-- To improve this command: SELECT COUNT(*) FROM visits where animal_id = 4;
CREATE INDEX visits_animal_id ON visits(animal_id);

-- To improve this command: SELECT * FROM visits where vet_id = 2;
CREATE INDEX visits_vet_id ON visits(vet_id);

-- To improve this command: SELECT * FROM owners where email = 'owner_18327@mail.com';
CREATE INDEX owners_email ON owners(email);
