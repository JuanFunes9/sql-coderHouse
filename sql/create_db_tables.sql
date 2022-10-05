-- Creacion de la db
CREATE DATABASE hospital;
USE hospital;


-- Creacion de tablas
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