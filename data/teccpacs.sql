BEGIN TRANSACTION;
CREATE TABLE "utilisateur" (
	`login`	varchar(8),
	`password`	varchar(64) NOT NULL,
	`email`	varchar(256) NOT NULL,
	`nom`	varchar(32),
	`prenom`	varchar(32),
	`coordonnees`	varchar(512),
	`role_id`	INTEGER NOT NULL,
	PRIMARY KEY(`login`),
	FOREIGN KEY(`role_id`) REFERENCES role(role_id)
);
CREATE TABLE "type_acquisition" (
	`type_acquisition_id`	INTEGER PRIMARY KEY AUTOINCREMENT,
	`appareil`	varchar(32) NOT NULL UNIQUE,
	`modalite`	varchar(64)
);
CREATE TABLE `source_resultat_serie` (
	`resultat_cible`	INTEGER NOT NULL,
	`serie_source`	INTEGER NOT NULL,
	FOREIGN KEY(`resultat_cible`) REFERENCES resultat(resultat_id),
	FOREIGN KEY(`serie_source`) REFERENCES serie(serie_id)
);
CREATE TABLE `source_resultat_resultat` (
	`resultat_source`	INTEGER NOT NULL,
	`resultat_cible`	INTEGER NOT NULL,
	FOREIGN KEY(`resultat_source`) REFERENCES resultat(resultat_id),
	FOREIGN KEY(`resultat_cible`) REFERENCES resultat(resultat_id)
);
CREATE TABLE "serie" (
	`serie_id`	INTEGER PRIMARY KEY AUTOINCREMENT,
	`type_acquisition_id`	INTEGER NOT NULL,
	`etude_id`	INTEGER NOT NULL,
	FOREIGN KEY(`type_acquisition_id`) REFERENCES `type_acquisition`(`type_acquisition_id`),
	FOREIGN KEY(`etude_id`) REFERENCES `etude`(`etude_id`)
);
CREATE TABLE `role` (
	`role_id`	INTEGER PRIMARY KEY AUTOINCREMENT,
	`nom`	varchar(32) NOT NULL UNIQUE,
	`description`	varchar(128)
);
CREATE TABLE `resultat` (
	`resultat_id`	INTEGER PRIMARY KEY AUTOINCREMENT,
	`nom_fichier`	varchar(1024) NOT NULL,
	`description`	TEXT,
	`type`	varchar(8),
	`auteur`	varchar(8) NOT NULL,
	FOREIGN KEY(`auteur`) REFERENCES utilisateur(login)
);
CREATE TABLE `region_anatomique` (
	`nom`	varchar(64) NOT NULL UNIQUE,
	`region_id`	INTEGER PRIMARY KEY AUTOINCREMENT
);
CREATE TABLE `referent_etude_utilisateur` (
	`login`	varchar(8) NOT NULL,
	`etude_id`	INTEGER NOT NULL,
	FOREIGN KEY(`login`) REFERENCES utilisateur(login),
	FOREIGN KEY(`etude_id`) REFERENCES etude(etude_id)
);
CREATE TABLE "patient" (
	`patient_id`	INTEGER PRIMARY KEY AUTOINCREMENT,
	`date_naissance`	date NOT NULL,
	`sexe`	varchar(2) NOT NULL,
	`nom`	varchar(32) NOT NULL,
	`prenom`	varchar(32) NOT NULL,
	`coordonnees`	varchar(512)
);
CREATE TABLE `note` (
	`texte`	TEXT NOT NULL,
	`date`	datetime NOT NULL,
	`auteur`	varchar(8) NOT NULL,
	`serie_id`	INTEGER,
	`patient_id`	INTEGER,
	`note_id`	INTEGER PRIMARY KEY AUTOINCREMENT,
	FOREIGN KEY(`auteur`) REFERENCES utilisateur(login),
	FOREIGN KEY(`serie_id`) REFERENCES serie(serie_id),
	FOREIGN KEY(`patient_id`) REFERENCES patient(patient_id)
);
CREATE TABLE "etude" (
	`etude_id`	INTEGER PRIMARY KEY AUTOINCREMENT,
	`dateAcquisition`	date,
	`notes`	TEXT,
	`patient_id`	INTEGER NOT NULL,
	`region_id`	INTEGER NOT NULL,
	FOREIGN KEY(`patient_id`) REFERENCES `patient`(`patient_id`),
	FOREIGN KEY(`region_id`) REFERENCES region_anatomique(region_id)
);
CREATE TABLE `donnee` (
	`nom_fichier`	varchar(1024) NOT NULL,
	`heure`	datetime NOT NULL,
	`donnee_id`	INTEGER PRIMARY KEY AUTOINCREMENT,
	`serie_id`	INTEGER NOT NULL,
	FOREIGN KEY(`serie_id`) REFERENCES serie(serie_id)
);
COMMIT;
