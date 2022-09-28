USE hospital;
/* 
Creacion de una vista que trae toda la informacion de cada paciente registrado.
Hace el inner join de las tablas de obras_sociales, y localidades
*/ 
CREATE VIEW pacientes_completos AS
SELECT
	pac.id_paciente,
    pac.dni,
    concat(pac.nombre, ' ', pac.apellido) AS nombre,
    pac.fecha_nacimiento,
    YEAR(curdate())-YEAR(pac.fecha_nacimiento) AS edad,
    pac.genero,
    pac.internado,
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

CREATE VIEW consultas_completas AS
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
CREATE VIEW internaciones_completas AS
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
CREATE VIEW doctores_completos AS
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
Hace la query a la tabla de obras_sociales y una subcunsulta a la tabla de pacientes.
*/ 
CREATE VIEW obras_sociales_completas AS
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