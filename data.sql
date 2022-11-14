/* Populate database with sample data. */

INSERT INTO animals (id,name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES (1, 'Agumon', '2020-02-03', 0, true, 10.23),
(2, 'Gabumon', '2018-11-15', 2, true, 8),
(3, 'Pikachu', '2021-01-07', 1, false, 15.04),
(4, 'Devimon', '2017-05-12', 5, true, 11),
(6, 'Charmander', '2020-02-08', 0, false, 11),
(5, 'Plantmon', '2021-11-15', 2, true, 5.7),
(7, 'Squirtle', '1993-04-02', 3, false, 12.13),
(8, 'Angemon', '2005-06-12', 1, true, 45),
(9, 'Boarmon', '2005-06-07', 7, true, 20.4),
(10, 'Blossom', '1998-10-13', 3, true, 17),
(11, 'Ditto', '2022-05-14', 4, true, 22);

INSERT INTO owners (id, full_name, age) 
VALUES (1, 'Sam Smith', 34), 
       (2, 'Jennifer Orwell', 19),
       (3, 'Bob', 45),
       (4, 'Melody Pond', 77),
       (5, 'Dean Winchester', 14),
       (6, 'Jodie Whittaker', 38);

INSERT INTO species (id, name) 
VALUES (1, 'Pokemon'),
       (2, 'Digimon');  

/* Update the animals table by setting the species column to Digimon for all animals that have a name ending in mon. */

UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';

/* Update the animals table by setting the species column to Pokemon for all animals that don't have species already set. */

UPDATE animals SET species_id = 1 WHERE species_id IS NULL;

/* Modify the inserted animals to include owner information (owner_id) */

UPDATE animals SET owner_id = 1 WHERE name = 'Agumon';
UPDATE animals SET owner_id = 2 WHERE name = 'Gabumon';
UPDATE animals SET owner_id = 2 WHERE name = 'Pikachu';
UPDATE animals SET owner_id = 3 WHERE name = 'Devimon';
UPDATE animals SET owner_id = 3 WHERE name = 'Plantmon';
UPDATE animals SET owner_id = 4 WHERE name = 'Charmander';
UPDATE animals SET owner_id = 4 WHERE name = 'Squirtle';
UPDATE animals SET owner_id = 4 WHERE name = 'Blossom';
UPDATE animals SET owner_id = 5 WHERE name = 'Angemon';
UPDATE animals SET owner_id = 5 WHERE name = 'Boarmon';

/*
    Insert the following data for vets:
        Vet William Tatcher is 45 years old and graduated Apr 23rd, 2000.
        Vet Maisy Smith is 26 years old and graduated Jan 17th, 2019.
        Vet Stephanie Mendez is 64 years old and graduated May 4th, 1981.
        Vet Jack Harkness is 38 years old and graduated Jun 8th, 2008.
*/

INSERT INTO vets (name, age, date_of_graduation)
VALUES ('William Tatcher', 45, '2000-04-23'),
       ('Maisy Smith', 26, '2019-01-17'),
       ('Stephanie Mendez', 64, '1981-05-04'),
       ('Jack Harkness', 38, '2008-06-08');
       
/* Insert the following data for specializations: */

INSERT INTO specializations (vet_id, species_id)
VALUES (1, 1),
       (3, 1),
       (3, 2),
       (4, 2);

/* Insert the follwing data for visits: */

INSERT INTO visits (animal_id, vet_id, date_of_visit)
VALUES (1, 1, '2020-05-24'),
       (1, 3, '2020-07-22'),
       (2, 4, '2021-02-02'),
       (3, 2, '2020-01-05'),
       (3, 2, '2020-03-08'),
       (3, 2, '2020-05-14'),
       (4, 3, '2021-05-04'),
       (6, 4, '2021-02-24'),
       (5, 2, '2019-12-21'),
       (5, 1, '2020-08-10'),
       (5, 2, '2021-04-07'),
       (7, 3, '2019-09-29'),
       (8, 4, '2020-10-03'),
       (8, 4, '2020-11-04'),
       (9, 2, '2019-01-24'),
       (9, 2, '2019-05-15'),
       (9, 2, '2020-02-27'),
       (9, 2, '2020-08-03'),
       (10, 3, '2020-05-24'),
       (10, 1, '2021-01-11');


-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

/*
Create sequence for id primary key in owners table
*/

CREATE SEQUENCE owners_id_s
    START WITH 7
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (id, full_name, email) select (nextval('id_s')), 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';













