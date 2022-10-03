USE hospital;
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