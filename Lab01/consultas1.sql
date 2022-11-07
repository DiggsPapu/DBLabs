--DDL: Data Definition Language

DROP TABLE ESTUDIANTE

CREATE TABLE ESTUDIANTE(
	carnet		VARCHAR(12),
	nombre		VARCHAR(64),
	anio_nac	INT,
	direccion	VARCHAR(128),
	email		VARCHAR(25)
)

--DML: Data Manipulation Language
INSERT INTO ESTUDIANTE (carnet, nombre, anio_nac, direccion, email)
VALUES ('123xyz','Diego Alonzo', 2002, 'Ciudad Capital', '123xyz@uvg.edu.gt')

INSERT INTO ESTUDIANTE (carnet, nombre, anio_nac, direccion)
VALUES ('456xyz','Raul Sanchez', 2003, 'Ciudad Capital')

INSERT INTO ESTUDIANTE (carnet, nombre, anio_nac, direccion, email)
VALUES ('789xyz','Juan Miguel', 2001, 'Ciudad Capital', null)

INSERT INTO ESTUDIANTE (carnet, nombre, anio_nac, direccion, email)
VALUES ('456xyz','Daniel Gonzalez', 2003, 'Ciudad Capital', null)

INSERT INTO ESTUDIANTE (carnet, nombre, anio_nac, direccion, email)
VALUES ('555xyz','Cristina Bautista', 0, 'Ciudad Capital', null)

SELECT	AVG(anio_nac)
FROM	ESTUDIANTE




