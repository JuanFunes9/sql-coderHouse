-- ================== Creacion de la Base de Datos ================== --
CREATE DATABASE hospital;
USE hospital;

-- ================== Creacion de las Tablas ================== --
CREATE TABLE localidades (
	localidad_id INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY(localidad_id),
    nombre VARCHAR(120) NOT NULL,
    cod_postal VARCHAR(10) NOT NULL
);

CREATE TABLE obras_sociales (
	obra_social_id INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY(obra_social_id),
    nombre VARCHAR(60) NOT NULL,
    telefono VARCHAR(60) NOT NULL,
    email VARCHAR(60) NOT NULL
);

CREATE TABLE especialidades_medicas (
	especialidad_id INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY(especialidad_id),
    nombre VARCHAR(60) NOT NULL
);

CREATE TABLE doctores (
	id_doctor INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY(id_doctor),
    nombre VARCHAR(60) NOT NULL,
    apellido VARCHAR(60) NOT NULL,
    matricula VARCHAR(60) NOT NULL,
    especialidad_id INT NOT NULL,
    FOREIGN KEY(especialidad_id) REFERENCES especialidades_medicas(especialidad_id)
);

CREATE TABLE pacientes (
	id_paciente INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY(id_paciente),
	dni VARCHAR(60) NOT NULL,
    nombre VARCHAR(60) NOT NULL,
    apellido VARCHAR(60) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    genero VARCHAR(60) NOT NULL,
    telefono VARCHAR(60),
    email VARCHAR(60),
    direccion VARCHAR(120) NOT NULL,
    localidad_id INT NOT NULL,
    FOREIGN KEY(localidad_id) REFERENCES localidades(localidad_id),
    obra_social_id INT,
    FOREIGN KEY(obra_social_id) REFERENCES obras_sociales(obra_social_id)
);

CREATE TABLE internaciones (
	internacion_id INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY(internacion_id),
    id_paciente INT NOT NULL,
    FOREIGN KEY(id_paciente) REFERENCES pacientes(id_paciente),
    ingreso DATE NOT NULL,
    cama INT NOT NULL,
    egreso DATE,
    motivo_ingreso VARCHAR(255) NOT NULL
);

CREATE TABLE consultas (
	consulta_id INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY(consulta_id),
    fecha_consulta DATE NOT NULL,
    id_paciente INT NOT NULL,
    FOREIGN KEY(id_paciente) REFERENCES pacientes(id_paciente),
    id_doctor INT NOT NULL,
    FOREIGN KEY(id_doctor) REFERENCES doctores(id_doctor),
    motivo_consulta VARCHAR(255) NOT NULL	
);

-- ================== Creacion de las Vistas ================== --
/* 
Creacion de una vista que trae toda la informacion de cada paciente registrado.
Hace el inner join de las tablas de obras_sociales, y localidades
*/ 
CREATE OR REPLACE VIEW pacientes_completos AS
SELECT
	pac.id_paciente,
    pac.dni,
    concat(pac.nombre, ' ', pac.apellido) AS nombre,
    pac.fecha_nacimiento,
    YEAR(curdate())-YEAR(pac.fecha_nacimiento) AS edad,
    pac.genero,
    pac.telefono,
    pac.email,
    pac.direccion,
    os.nombre AS obra_social,
    loc.nombre AS localidad
FROM pacientes AS pac
INNER JOIN obras_sociales AS os
ON pac.obra_social_id = os.obra_social_id
INNER JOIN localidades AS loc
ON pac.localidad_id = loc.localidad_id; 

-- Query de la vista
SELECT * FROM hospital.pacientes_completos;

/* 
Creacion de vista que muestra todas las consultas ordenadas por fecha descenciente
Se realiza una query a la tabla de consutlas y se inclue el inner join de las tablas de pacientes, especialidades_medicas y doctores
*/ 

CREATE OR REPLACE VIEW consultas_completas AS
SELECT
	cons.consulta_id,
    cons.fecha_consulta,
    concat( pac.nombre, ' ', pac.apellido ) as paciente,
    concat( doc.nombre, ' ', doc.apellido ) as doctor,
    esp.nombre as especialidad,
    cons.motivo_consulta
FROM consultas AS cons
INNER JOIN pacientes AS pac
ON cons.id_paciente = pac.id_paciente
INNER JOIN doctores AS doc
ON cons.id_doctor = doc.id_doctor
INNER JOIN especialidades_medicas AS esp
ON doc.especialidad_id = esp.especialidad_id
ORDER BY cons.fecha_consulta DESC;

-- Query de la vista
SELECT * FROM hospital.consultas_completas;

/* 
Creacion de vista que muestra los registros de pacientes internados actualmente. Tambien muestra su edad, genero y cuantos dias llevan ingresados
Se realiza la quer sobre la tabla de internaciones y el inner join con las tablas de pacientes y obras_sociales
*/ 
CREATE OR REPLACE VIEW internaciones_completas AS
SELECT
	inter.internacion_id,
    concat(pac.nombre, ' ', pac.apellido) AS paciente,
    YEAR(curdate())-YEAR(pac.fecha_nacimiento) AS edad,
    pac.genero,
    os.nombre AS obra_social,
    inter.ingreso,
    inter.cama,
    datediff(curdate(), inter.ingreso) AS dias_internado,
    inter.motivo_ingreso
FROM internaciones AS inter
INNER JOIN pacientes AS pac
ON inter.id_paciente = pac.id_paciente
INNER JOIN obras_sociales AS os
ON pac.obra_social_id = os.obra_social_id
WHERE inter.egreso IS NULL
ORDER BY dias_internado;

-- Query de la vista
SELECT * FROM hospital.internaciones_completas;

/* 
Creacion de una vista que muestra la informacion de todos los doctores
Los ordena segun la cantidad de cosultas que atendieron en el ultimo tiempo
hace el inner join con la tablas de especialidades_medicas y una subconsulta a la tabla de consultas.
*/ 
CREATE OR REPLACE VIEW doctores_completos AS
SELECT
	doc.id_doctor,
    concat('Dr/a. ', doc.nombre, ' ', doc.apellido) AS nombre,
    doc.matricula,
    esp.nombre AS especialidad,
    (SELECT count(id_doctor) FROM consultas WHERE id_doctor = doc.id_doctor) AS consultas_atendidas
FROM doctores AS doc
INNER JOIN especialidades_medicas AS esp
ON doc.especialidad_id = esp.especialidad_id
ORDER BY consultas_atendidas DESC;

-- Query de la vista
SELECT * FROM hospital.doctores_completos;

/* 
Creacion de la vista que devuelve informacion de las obras sociales y cuales son las mas elegidas por los pacientes
Hace la query a la tabla de obras_sociales y una subconsulta a la tabla de pacientes.
*/ 
CREATE OR REPLACE VIEW obras_sociales_completas AS
SELECT
	os.obra_social_id,
    os.nombre,
    os.telefono,
    os.email,
    (SELECT count(obra_social_id) FROM pacientes WHERE obra_social_id = os.obra_social_id) AS usuarios
FROM obras_sociales AS os
ORDER BY usuarios DESC;

-- Query de la vista
SELECT * FROM hospital.obras_sociales_completas;

-- ================== Creacion de las Funciones ================== --
DELIMITER $$
CREATE FUNCTION get_edad_paciente_by_fecha_nac( p_id INT, p_fecha_nac date )
RETURNS int
READS SQL DATA
BEGIN

	DECLARE edad INT;
    SELECT floor(datediff(curdate(),p_fecha_nac) / 365)
	INTO edad
    FROM pacientes
    WHERE pacientes.id_paciente = p_id;
    RETURN edad;

END$$

CREATE FUNCTION get_cantidad_consultas( d_id INT )
RETURNS int
READS SQL DATA
BEGIN

	DECLARE cant_consultas INT;
    SELECT count(1)
	INTO cant_consultas
    FROM consultas
    WHERE consultas.id_doctor = d_id;
    RETURN cant_consultas;

END$$

DELIMITER ;

-- ================== Creacion de los Stored Procedures ================== --
DELIMITER $$
-- El Siguiente SP devuelve la tabla de pacientes ordenada. Recibe 2 parametros: la columna a ordenar y en que orden. 
CREATE PROCEDURE sp_listado_pacientes_ordenado(IN p_order_column VARCHAR(100), IN p_order_type VARCHAR(40))
BEGIN
    
    SET @ordenar = concat(" ORDER BY ", p_order_column, " ", p_order_type);
    SET @clausula = CONCAT("SELECT * FROM pacientes", @ordenar);

    PREPARE mi_clausula FROM @clausula;
    EXECUTE mi_clausula;
    DEALLOCATE PREPARE mi_clausula;

END $$

/*
El siguiente SP realiza el ingreso de un nuevo paciente en internaciones. Antes del INSERT, realiza las validaciones de:
1) Que el paciente exista en la DB
2) Que NO sea un paciente internado actualmente
3) Que la cama en la que se lo quiera ingresar NO este ya ocupada por otro paciente
Recibe como parametros el ID de paciente, El numero de cama y el motivo de ingreso.
*/
CREATE PROCEDURE sp_nueva_internacion(IN p_id_px INT, IN p_cama INT, IN p_motivo_ingreso VARCHAR(255))
BEGIN
    
    DECLARE v_px_id INT;
    DECLARE v_px_internado INT;
    DECLARE v_cama_id INT;
    
    SELECT id_paciente INTO v_px_id FROM pacientes WHERE id_paciente = p_id_px;
    
    /*1) Validamos que el paciente existe*/
    IF v_px_id IS NOT NULL THEN
		SELECT internacion_id INTO v_px_internado FROM internaciones WHERE id_paciente = p_id_px AND egreso IS NULL;
        /*2) Validamos que sea un paciente que NO este internado actualmente*/
        IF v_px_internado IS NULL THEN
			/*3) validamos que la cama no este ocupada actualmente*/
			SELECT cama INTO v_cama_id FROM internaciones WHERE cama = p_cama AND egreso is null;
            IF v_cama_id IS NULL THEN
				/*4) Luego de validar, hacemos el INSERT de la nueva internacion*/
                INSERT INTO internaciones (id_paciente, ingreso, cama, egreso, motivo_ingreso)
                VALUES(v_px_id, curdate(), p_cama, null, p_motivo_ingreso);
				SELECT concat("El paciente: ", v_px_id, " fue ingresado en la cama: ", p_cama) as success_msg;
            ELSE
				SELECT concat("No se ha podido realizar la internacion del paciente: ", v_px_id, " porque la cama: ", v_cama_id, " se encuentra ocupada.") AS error_msg;
            END IF;
        ELSE
			SELECT concat("No se ha podido realizar la operacion. El paciente con ID: ", v_px_id, " ya se encuentra internado.") AS error_msg;
		END IF;
    ELSE
		SELECT concat("No existe un paciente con ID:", p_id_px) AS error_msg;
	END IF;
END $$
DELIMITER ;

-- ================== Creacion de los Triggers ================== --
-- Creacion de la tabla de logs_consultas
CREATE TABLE logs_consultas (
	log_id INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY(log_id),
    fecha_hora DATETIME NOT NULL,
    empleado VARCHAR(45) NOT NULL,
    detalle VARCHAR(355)
);

-- Creacion de la tabla de logs_internaciones
CREATE TABLE logs_internaciones (
	log_id INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY(log_id),
    fecha_hora DATETIME NOT NULL,
    empleado VARCHAR(45) NOT NULL,
    id_paciente INT NOT NULL,
    FOREIGN KEY(id_paciente) REFERENCES pacientes(id_paciente),
    tipo VARCHAR(20),
    total_dias_internado INT
);

-- Creacion de los triggers:
/*El siguiente trigger inserta la informacion y el detalle de cada consulta a una tabla de logs_consultas*/
DELIMITER $$
CREATE TRIGGER logs_consultas
AFTER INSERT ON consultas
FOR EACH ROW
BEGIN
	INSERT INTO logs_consultas
    VALUES(
		NULL,
        CURRENT_TIMESTAMP(),
        CURRENT_USER(),
        concat("El paciente: ", NEW.id_paciente, " consulta por: ", NEW.motivo_consulta, ". Siendo atendido por el doctor: ", NEW.id_doctor)
	);
END$$

/*El siguiente trigger deja el registro de las consultas que fueron editadas*/
CREATE TRIGGER update_consultas
BEFORE UPDATE ON consultas
FOR EACH ROW
BEGIN
	INSERT INTO logs_consultas
    VALUES(
		NULL,
        CURRENT_TIMESTAMP(),
        CURRENT_USER(),
        concat("La consulta: ", OLD.consulta_id, " fue editada con: El paciente: ", NEW.id_paciente, " consulta por: ", NEW.motivo_consulta, ". Siendo atendido por el doctor: ", NEW.id_doctor)
	);
END$$


/*El siguiente trigger inserta la informacion y el detalle de cada internacion a una tabla de logs_internaciones*/
CREATE TRIGGER logs_internaciones
AFTER INSERT ON internaciones
FOR EACH ROW
BEGIN
	INSERT INTO logs_internaciones
    VALUES(
		NULL,
        CURRENT_TIMESTAMP(),
        CURRENT_USER(),
        NEW.id_paciente,
        "Ingreso",
        null
	);
END$$

/*
El siguiente trigger se ejecuta cuando se le da de alta a un paciente. Tambien inserta la informacion en la tabla de 
logs_internaciones. Calcula la cantidad de dias que el paciente estuvo ingresado.
Ejemplo de sentencia update:
	UPDATE internaciones
	SET egreso = curdate()
	WHERE internacion_id = 23;
*/
CREATE TRIGGER update_internaciones
BEFORE UPDATE ON internaciones
FOR EACH ROW
BEGIN
	INSERT INTO logs_internaciones
    VALUES(
		NULL,
        CURRENT_TIMESTAMP(),
        CURRENT_USER(),
        NEW.id_paciente,
        "Egreso",
        DATEDIFF(NEW.egreso, OLD.ingreso)
	);
END$$

DELIMITER ;

-- ================== Creacion de los usuarios y permisos ================== --
/*
	Creacion del primer usuario:
    Permisos: Solo permitido realizar SELECT de cualquier tabla (Solo lectura).
*/
CREATE USER coder1@localhost IDENTIFIED BY 'coderhouse';
GRANT SELECT ON hospital.* TO coder1@localhost;
SHOW GRANTS FOR coder1@localhost;

-- Pruebas de permisos: Las queries son denegadas por falta de permisos, a exepcion del SELECT:
/*
SELECT * FROM hospital.pacientes;

INSERT INTO hospital.pacientes (dni, nombre, apellido, fecha_nacimiento, genero, telefono, email, direccion, localidad_id, obra_social_id)
VALUES('37247539', 'Marcos', 'Perez', '1994-03-12', 'masculino', null, 'marcos@gmail.com', 'fake street 123', 1, 3);

UPDATE hospital.pacientes
SET apellido = 'Jaens'
WHERE id_paciente = 43;

DELETE FROM hospital.pacientes
WHERE id_paciente = 43;
*/

/*
	Creacion del segundo usuario:
    Permisos: para realizar Lectura, Insercion y Modificacion de datos.
*/

CREATE USER coder2@localhost IDENTIFIED BY 'coderhouse';
GRANT SELECT, INSERT, UPDATE ON hospital.* TO coder2@localhost;
SHOW GRANTS FOR coder2@localhost;

-- Pruebas de permisos: Solo la query de DELETE es rechazada por falta de permisos:
/*
SELECT * FROM hospital.pacientes;

INSERT INTO hospital.pacientes (dni, nombre, apellido, fecha_nacimiento, genero, telefono, email, direccion, localidad_id, obra_social_id)
VALUES('37247539', 'Marcos', 'Perez', '1994-03-12', 'masculino', null, 'marcos@gmail.com', 'fake street 123', 1, 3);

UPDATE hospital.pacientes
SET apellido = 'Jaens'
WHERE id_paciente = 43;

DELETE FROM hospital.pacientes
WHERE id_paciente = 43;
*/

-- ================== Creacion de las sentencias TCL ================== --\
DELIMITER $$

/*
	El Siguiente SP, a traves de una transaccion, valida si una tabla contiene o no registros. Si esta vacia ejecuta un INSERT,
    De lo contrario elimina el ultimo registro que fue insertado en la tabla
*/
CREATE PROCEDURE sp_tcl_one()
BEGIN
	DECLARE v_count INT;
    DECLARE v_last_int INT;
    
	SET AUTOCOMMIT = 0;
	START TRANSACTION;
		SELECT count(1) INTO v_count
		FROM internaciones;
        
        IF v_count = 0 THEN
			INSERT INTO internaciones VALUES(NULL, 2, CURDATE(), 2, null, "Cirugia de pelvis");
        ELSE
			SELECT max(internacion_id) INTO v_last_int FROM internaciones;
			DELETE FROM internaciones WHERE internacion_id = v_last_int;
        END IF;
        
        -- ROLLBACK; 
        COMMIT;

END $$

/*
	El Siguiente SP, a traves de una transaccion, ejecuta 8 sentencias INSERT en la tabla de internaciones dividiendolas en 
    2 savepoints de 4 sentencias cada una.
*/

CREATE PROCEDURE sp_tcl_two()
BEGIN
	SET AUTOCOMMIT = 0;
	START TRANSACTION;
	INSERT INTO internaciones VALUES(NULL, 3, CURDATE(), 2, null, "Cirugia de pelvis");
    INSERT INTO internaciones VALUES(NULL, 4, CURDATE(), 2, null, "Cirugia de pelvis");
    INSERT INTO internaciones VALUES(NULL, 5, CURDATE(), 2, null, "Cirugia de pelvis");
    INSERT INTO internaciones VALUES(NULL, 6, CURDATE(), 2, null, "Cirugia de pelvis");
    SAVEPOINT lote_1;
    INSERT INTO internaciones VALUES(NULL, 7, CURDATE(), 2, null, "Cirugia de pelvis");
    INSERT INTO internaciones VALUES(NULL, 8, CURDATE(), 2, null, "Cirugia de pelvis");
    INSERT INTO internaciones VALUES(NULL, 9, CURDATE(), 2, null, "Cirugia de pelvis");
    INSERT INTO internaciones VALUES(NULL, 10, CURDATE(), 2, null, "Cirugia de pelvis");
    SAVEPOINT lote_2;
    -- RELEASE SAVEPOINT lote_1;
    COMMIT;
    
END $$

-- Prueba de ejecucion:
-- CALL sp_tcl_one();
-- CALL sp_tcl_two();

