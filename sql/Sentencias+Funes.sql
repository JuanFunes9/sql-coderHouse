/*
	Creacion del primer usuario:
    Permisos: Solo permitido realizar SELECT de cualquier tabla (Solo lectura).
*/
CREATE USER coder1@localhost IDENTIFIED BY 'coderhouse';
GRANT SELECT ON hospital.* TO coder1@localhost;
SHOW GRANTS FOR coder1@localhost;

-- Pruebas de permisos: Las queries son denegadas por falta de permisos, a exepcion del SELECT:
SELECT * FROM hospital.pacientes;

INSERT INTO hospital.pacientes (dni, nombre, apellido, fecha_nacimiento, genero, telefono, email, direccion, localidad_id, obra_social_id)
VALUES('37247539', 'Marcos', 'Perez', '1994-03-12', 'masculino', null, 'marcos@gmail.com', 'fake street 123', 1, 3);

UPDATE hospital.pacientes
SET apellido = 'Jaens'
WHERE id_paciente = 43;

DELETE FROM hospital.pacientes
WHERE id_paciente = 43;

/*
	Creacion del segundo usuario:
    Permisos: para realizar Lectura, Insercion y Modificacion de datos.
*/

CREATE USER coder2@localhost IDENTIFIED BY 'coderhouse';
GRANT SELECT, INSERT, UPDATE ON hospital.* TO coder2@localhost;
SHOW GRANTS FOR coder2@localhost;

-- Pruebas de permisos: Solo la query de DELETE es rechazada por falta de permisos:
SELECT * FROM hospital.pacientes;

INSERT INTO hospital.pacientes (dni, nombre, apellido, fecha_nacimiento, genero, telefono, email, direccion, localidad_id, obra_social_id)
VALUES('37247539', 'Marcos', 'Perez', '1994-03-12', 'masculino', null, 'marcos@gmail.com', 'fake street 123', 1, 3);

UPDATE hospital.pacientes
SET apellido = 'Jaens'
WHERE id_paciente = 43;

DELETE FROM hospital.pacientes
WHERE id_paciente = 43;
