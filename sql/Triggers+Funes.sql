USE hospital;

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
logsa_internaciones. Calcula la cantidad de dias que el paciente estuvo ingresado.
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
