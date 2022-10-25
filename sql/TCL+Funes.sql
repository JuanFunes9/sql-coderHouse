use hospital;

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

CALL sp_tcl_one();
CALL sp_tcl_two();
