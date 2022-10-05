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

Recibe como parametros el ID de paciente, El numero de cama y el movito de ingreso.
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