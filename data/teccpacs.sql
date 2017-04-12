BEGIN TRANSACTION;
CREATE TABLE "utilisateur" (
	`login `	varchar(8),
	`password`	varchar(64) NOT NULL,
	`email`	vachar(256) NOT NULL,
	`prenom`	INTEGER,
	`coordonnes `	vachar(512),
	`role_id`	INTEGER NOT NULL,
	PRIMARY KEY(`login `),
	FOREIGN KEY(`role_id`) REFERENCES role(role_id)
);
CREATE TABLE "type_acquisitioon" (
	`type_aquisition_id`	INTEGER PRIMARY KEY AUTOINCREMENT,
	`appareil`	TEXT NOT NULL UNIQUE,
	`modalite`	TEXT
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
CREATE TABLE `serie` (
	`type_acquisition_id`	INTEGER NOT NULL,
	`etude_id`	INTEGER NOT NULL,
	`serie_id`	INTEGER,
	PRIMARY KEY(`serie_id`)
);
CREATE TABLE "role" (
	`role_id`	INTEGER PRIMARY KEY AUTOINCREMENT,
	`nom`	TEXT NOT NULL UNIQUE,
	`description `	TEXT
);
CREATE TABLE `resutlat` (
	`resultat_id`	INTEGER PRIMARY KEY AUTOINCREMENT,
	`nom_fichier`	INTEGER NOT NULL,
	`description`	TEXT,
	`type`	INTEGER,
	`auteur`	INTEGER NOT NULL,
	FOREIGN KEY(`auteur`) REFERENCES utilisateur(login)
);
CREATE TABLE `region_anatomique` (
	`nom`	TEXT NOT NULL UNIQUE,
	`region_id`	INTEGER PRIMARY KEY AUTOINCREMENT
);
CREATE TABLE "referent_etude_utilisateur" (
	`login`	INTEGER NOT NULL,
	`etude_id`	INTEGER NOT NULL,
	FOREIGN KEY(`login`) REFERENCES `utilisateur`(`login`),
	FOREIGN KEY(`etude_id`) REFERENCES `etude`(`etude_id`)
);
CREATE TABLE `note` (
	`texte`	TEXT NOT NULL,
	`date`	INTEGER NOT NULL,
	`auteur`	INTEGER NOT NULL,
	`serie_id`	INTEGER,
	`patient_id`	INTEGER,
	`note_id`	INTEGER PRIMARY KEY AUTOINCREMENT,
	FOREIGN KEY(`auteur`) REFERENCES utilisateur(login),
	FOREIGN KEY(`serie_id`) REFERENCES serie(serie_id),
	FOREIGN KEY(`patient_id`) REFERENCES patient(patient_id)
);
CREATE TABLE "etude" (
	`note`	varchar(128),
	`etude_id`	INTEGER PRIMARY KEY AUTOINCREMENT,
	`patient_id`	INTEGER NOT NULL,
	`region_id`	INTEGER NOT NULL,
	`dateacquisition`	datetime ,
	FOREIGN KEY(`patient_id`) REFERENCES `patient`(`patien_id`),
	FOREIGN KEY(`region_id`) REFERENCES `region`(`region_id`)
);
CREATE TABLE `donnee` (
	`nom_fichier`	INTEGER NOT NULL,
	`heure`	INTEGER NOT NULL,
	`donnee_id`	INTEGER PRIMARY KEY AUTOINCREMENT,
	`serie_id`	INTEGER NOT NULL,
	FOREIGN KEY(`serie_id`) REFERENCES serie(serie_id)
);
CREATE TABLE "Patient" (
	`patient_id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`prenom`	INTEGER,
	`date_de_naissance`	TEXT NOT NULL,
	`sexe`	INTEGER NOT NULL,
	`coordonnes`	varchar(32),
	`nom`	varchar(32)
);
COMMIT;
