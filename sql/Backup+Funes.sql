/*
	En el siguiente Backup se guardan las siguientes tablas: consultas, doctores, especialdiades_medicas,
    internaciones, localidades, obras_sociales y pacientes
*/

CREATE DATABASE  IF NOT EXISTS `hospital` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `hospital`;
-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: hospital
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `consultas`
--

LOCK TABLES `consultas` WRITE;
/*!40000 ALTER TABLE `consultas` DISABLE KEYS */;
INSERT INTO `consultas` VALUES (1,'2020-01-03',1,1,'Rutina'),(2,'2020-01-17',2,2,'Rutina'),(3,'2020-03-22',3,3,'Rutina'),(4,'2020-05-04',4,4,'Rutina'),(5,'2020-07-26',5,5,'Rutina'),(6,'2020-09-13',6,6,'Dolor abdominal'),(7,'2020-09-27',7,7,'Dolor abdominal'),(8,'2020-11-08',8,8,'Dolor abdominal'),(9,'2021-01-09',9,9,'Reaccion alergica'),(10,'2021-03-02',10,10,'Reaccion alergica'),(11,'2021-03-11',11,11,'Reaccion alergica'),(12,'2021-05-01',12,12,'Rutina'),(13,'2021-06-11',13,13,'Rutina'),(14,'2021-07-03',14,14,'Rutina'),(15,'2021-07-04',15,15,'Rutina'),(16,'2021-08-01',16,16,'Mareos y nauseas'),(17,'2021-08-08',17,17,'Mareos y nauseas'),(18,'2021-09-21',18,18,'Mareos y nauseas'),(19,'2021-12-23',19,19,'Dolor abdominal asociado a cuadro febril'),(20,'2022-01-20',20,20,'Dolor abdominal asociado a cuadro febril'),(21,'2022-02-19',21,21,'Dolor abdominal asociado a cuadro febril'),(22,'2022-03-22',22,22,'Dolor abdominal asociado a cuadro febril'),(24,'2022-10-09',2,5,'hola mundo!'),(25,'2022-10-09',2,5,'dolo abdominal'),(26,'2022-10-09',2,5,'dolo abdominal 2222'),(27,'2022-10-09',2,5,'dolo abdominal 2222'),(28,'2022-10-10',15,8,'Luxacion de tobillo');
/*!40000 ALTER TABLE `consultas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `logs_consultas` AFTER INSERT ON `consultas` FOR EACH ROW BEGIN
	INSERT INTO logs_consultas
    VALUES(
		NULL,
        CURRENT_TIMESTAMP(),
        CURRENT_USER(),
        concat("El paciente: ", NEW.id_paciente, " consulta por: ", NEW.motivo_consulta, ". Siendo atendido por el doctor: ", NEW.id_doctor)
	);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_consultas` BEFORE UPDATE ON `consultas` FOR EACH ROW BEGIN
	INSERT INTO logs_consultas
    VALUES(
		NULL,
        CURRENT_TIMESTAMP(),
        CURRENT_USER(),
        concat("La consulta: ", OLD.consulta_id, "Fue editada con: ", "El paciente: ", NEW.id_paciente, " consulta por: ", NEW.motivo_consulta, ". Siendo atendido por el doctor: ", NEW.id_doctor)
	);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping data for table `doctores`
--

LOCK TABLES `doctores` WRITE;
/*!40000 ALTER TABLE `doctores` DISABLE KEYS */;
INSERT INTO `doctores` VALUES (1,'Yesica','Bueno','98217',1),(2,'Otilia','GÃ³mez ','93880',2),(3,'Joaquin ','Gago ','81674',3),(4,'Avelina ','Corral ','84432',4),(5,'Ahmed ','Kaur ','44662',5),(6,'Carla ','Aznar ','94226',6),(7,'Teodora ','Ferreiro ','43501',7),(8,'Mauro ','Peralta ','63113',8),(9,'Raimundo ','de-La-Rosa ','99774',9),(10,'Leyre ','Ramirez ','96396',10),(11,'Valentin ','Alfaro ','56584',11),(12,'Ã“scar ','Francisco ','53960',12),(13,'Florentino ','Francisco ','44188',13),(14,'Blanca ','Lozano ','60063',14),(15,'Cecilio ','Singh ','59278',15),(16,'Teofilo ','Guijarro ','40225',1),(17,'Julen ','Salgado ','78950',2),(18,'Enzo ','Valenzuela ','50021',3),(19,'Noe ','Melian ','98674',4),(20,'Eva ','Alcaraz ','78574',5),(21,'Nerea ','Alcantara ','80008',6),(22,'Roxana ','Mayoral ','73299',7),(23,'Ramon ','Ballester ','85437',8),(24,'Graciela ','Uriarte ','52714',9),(25,'Martha ','Cabanillas ','94411',10),(26,'Elisabeth ','Seoane ','76406',11);
/*!40000 ALTER TABLE `doctores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `especialidades_medicas`
--

LOCK TABLES `especialidades_medicas` WRITE;
/*!40000 ALTER TABLE `especialidades_medicas` DISABLE KEYS */;
INSERT INTO `especialidades_medicas` VALUES (1,'Cardiologia'),(2,'Traumatologia'),(3,'Dermatologia'),(4,'Nutricion'),(5,'Nefrologia'),(6,'Terapia intensiva'),(7,'Neurologia'),(8,'Cirugia general'),(9,'Neurocirugia'),(10,'Psiquiatria'),(11,'Diagnostico por imagenes'),(12,'Flebologia'),(13,'Inmunologia y reumatologia'),(14,'Oftalmologia'),(15,'Clinica medica');
/*!40000 ALTER TABLE `especialidades_medicas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `internaciones`
--

LOCK TABLES `internaciones` WRITE;
/*!40000 ALTER TABLE `internaciones` DISABLE KEYS */;
INSERT INTO `internaciones` VALUES (1,1,'2020-08-22',4,'2020-09-08','neumonia bilateral asociada a COVID-19'),(2,2,'2020-08-24',5,'2020-09-03','neumonia bilateral asociada a COVID-19'),(3,6,'2020-08-21',8,'2020-09-04','neumonia bilateral asociada a COVID-19'),(4,9,'2020-09-21',4,'2020-10-01','meningitis bacteriana'),(5,12,'2020-10-26',2,'2020-11-22','Neurocirugia de fosa posterior'),(6,26,'2021-04-27',2,'2021-05-11','Intoxicacion por monoxido de carbono'),(7,32,'2021-12-28',3,'2022-01-10','Politraumatismo en accidente de transito'),(8,40,'2022-03-02',19,'2022-03-27','Complicacion de cirrosis alcoholica'),(9,28,'2022-08-30',2,'2022-09-13','Cirugia de cadera'),(10,11,'2022-08-30',4,'2022-09-25','Infeccion urinaria refractante a tratamiento convencional'),(11,2,'2022-09-24',1,NULL,'Neumonia unilateral de origen desconocido'),(12,15,'2022-09-24',5,NULL,'Infeccion en herida de miembro inferior derecho'),(13,16,'2022-09-25',7,NULL,'Meningitis viral'),(14,25,'2022-09-25',2,NULL,'Cirugia de apendice'),(15,26,'2022-09-26',3,NULL,'Colonoscopia'),(16,37,'2022-09-26',4,NULL,'Sobredosis de cocaina'),(17,42,'2022-09-26',6,NULL,'Trombosis del seno venoso asociado a anticonceptivos orales'),(18,43,'2022-09-27',18,NULL,'Cirugia de tobillo'),(20,1,'2022-10-05',10,NULL,'ingreso de prueba. TESTING.'),(24,3,'2022-10-24',2,NULL,'Cirugia de pelvis'),(25,4,'2022-10-24',2,NULL,'Cirugia de pelvis'),(26,5,'2022-10-24',2,NULL,'Cirugia de pelvis'),(27,6,'2022-10-24',2,NULL,'Cirugia de pelvis'),(28,7,'2022-10-24',2,NULL,'Cirugia de pelvis'),(29,8,'2022-10-24',2,NULL,'Cirugia de pelvis'),(30,9,'2022-10-24',2,NULL,'Cirugia de pelvis'),(31,10,'2022-10-24',2,NULL,'Cirugia de pelvis');
/*!40000 ALTER TABLE `internaciones` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `logs_internaciones` AFTER INSERT ON `internaciones` FOR EACH ROW BEGIN
	INSERT INTO logs_internaciones
    VALUES(
		NULL,
        CURRENT_TIMESTAMP(),
        CURRENT_USER(),
        NEW.id_paciente,
        "Ingreso",
        null
	);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_internaciones` BEFORE UPDATE ON `internaciones` FOR EACH ROW BEGIN
	INSERT INTO logs_internaciones
    VALUES(
		NULL,
        CURRENT_TIMESTAMP(),
        CURRENT_USER(),
        NEW.id_paciente,
        "Egreso",
        DATEDIFF(NEW.egreso, OLD.ingreso)
	);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping data for table `localidades`
--

LOCK TABLES `localidades` WRITE;
/*!40000 ALTER TABLE `localidades` DISABLE KEYS */;
INSERT INTO `localidades` VALUES (1,'CABAÂ ','1001'),(2,'Caballito','1184'),(3,'Liniers','1407'),(4,'Pilar','1629'),(5,'Olivos','1636'),(6,'Bella Vista','1661'),(7,'San Miguel','1663'),(8,'Tortuguitas','1667'),(9,'Ciudadela','1702'),(10,'Ramos Mejia','1704'),(11,'Haedo','1706'),(12,'Moron','1708'),(13,'Castelar','1710'),(14,'Ituzaingo','1714'),(15,'Merlo','1718'),(16,'La Reja','1738'),(17,'Paso Del Rey','1742'),(18,'Moreno','1743'),(19,'Almirante Brown','1846'),(20,'Avellaneda','1870'),(21,'Estacion Moreno','1901'),(22,'Lujan','6702');
/*!40000 ALTER TABLE `localidades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `obras_sociales`
--

LOCK TABLES `obras_sociales` WRITE;
/*!40000 ALTER TABLE `obras_sociales` DISABLE KEYS */;
INSERT INTO `obras_sociales` VALUES (1,'Union Personal','0810-444-1122 ','unionpersonal@contacto.com'),(2,'OSDEPYM','0800 288 7963 ','mesadeentrada@osdepym.com.ar '),(3,'Jerarquicos Salud','0810-555-4050','jerarquicos@salud.com.ar'),(4,'Andar','(011) 5237-1900 ','informes@andar.com'),(5,'Cover salud','(011) 4833-8300 ','cover@salud.com'),(6,'D.A.S.U.Te.N','+54 11 5371 5754 ','infodas@rec.utn.edu.ar '),(7,'DOSUBA','0810-989-2752','dosuba@gmail.com'),(8,'Elevar','4861-0124 ','administracion@pasteleros.org.ar '),(9,'FEMEBA','(011) 4383-4467 ','consultas@femeba.com'),(10,'IOMA','0810-999-4662','ioma@info.com'),(11,'Osecac','0810-333-0004 ','info@osecac.com'),(12,'OSFE','0800-333-OSFE (6733) ','contactese@osferroviaria.org.ar '),(13,'Osjera','0810 333 0251 ','contacto@osjera.com'),(14,'Osmedica','0800-999-5396 ','contacto@osmedica.com'),(15,'OSPACA','(011) 4106.4500 ','informes@ospaca.com '),(16,'OSPE','0800 444 OSPE (6773) ','contacto@ospe.com.ar'),(17,'OSPIC','0800-888-7060 ','contacto@ospic.com'),(18,'Swiss Medical','0810-444-7700 ','ventaonline@swissmedical.com.ar '),(19,'OSDE','0800-222-SALUD (72583) ','contacto@osde.com.ar '),(20,'OSPRERA','1143122500','consultas@osprera.org.ar ');
/*!40000 ALTER TABLE `obras_sociales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `pacientes`
--

LOCK TABLES `pacientes` WRITE;
/*!40000 ALTER TABLE `pacientes` DISABLE KEYS */;
INSERT INTO `pacientes` VALUES (1,'39759143','Juan','Castro','1996-02-04','masculino','+54(011)351-44-84847 ','juan@gmail.com','La Rosa 231',3,5),(2,'46658688','Mirian ','Osuna ','1971-03-25','femenino','+54(011)928-60-40184 ','mirian@gmail.com','Ronda Valeria, 815, 90Âº A',1,1),(3,'45099635','Ane ','Llopis ','1980-06-25','femenino','+54(011)757-95-55598 ','ane@gmail.com','Passeig Candelaria, 59 ',2,2),(4,'48172079','Maria ','Mayor ','1943-01-22','femenino','+54(011)443-39-53413 ','maria@gmail.com','Avenida MartÃ­, 1 ',2,3),(5,'30851494','Lucia ','Villaverde ','2018-09-17','femenino','+54(011)097-40-93450 ','locia@gmail.com','Paseo Casillas, 929',4,4),(6,'43293525','Alicia ','Diallo ','1955-07-20','femenino','+54(011)304-95-08363 ','alicia@gmail.com','Avenida Isaac, 57',5,5),(7,'35117319','Jesus ','Encinas ','1984-10-21','masculino','+54(011)966-50-16386 ','jesus@gmail.com','Camino Andrea, 391 ',6,6),(8,'21290678','Noemi ','Murillo ','1925-11-09','femenino','','noemi@gmail.com','Avenida Ana, 9',7,7),(9,'47331175','Yolanda ','Rus ','1974-06-10','femenino','+54(011)613-65-82585 ','yolanda@gmail.com','Plaza Gabriela, 4',2,8),(10,'49720941','Alejandro ','Bello ','1926-03-13','masculino','+54(011)340-33-49719 ','alejandro@gmail.com','RÃºa Mara, 0, 7Âº A',9,9),(11,'57163458','Nestor ','Aparicio ','1989-01-30','masculino','+54(011)843-01-79815 ','nestor_a@gmail.com','CamiÃ±o Marco, 6',6,10),(12,'44946937','Agustina ','Maroto ','1998-12-23','femenino','+54(011)425-24-00064 ','agus.maroto@gmail.com','Travessera Miguel, 23',7,11),(13,'32273313','Evaristo ','Solana ','2002-09-25','masculino','+54(011)176-88-14608 ','evaristo@gmail.com','PlaÃ§a Jorge, 3, Entre suelo 2Âº',2,12),(14,'47259042','Andoni ','Cabrera ','1999-07-12','masculino','+54(011)963-00-77653 ','andoni_cabrera5@gmail.com','Avenida Quintana, 2 ',3,13),(15,'47398340','Maria Soledad ','Gascon ','1994-01-15','femenino','+54(011)782-14-36508 ','mgascon@gmail.com','Ronda Prado, 3 ',4,14),(16,'21971264','Jose Antonio ','Urbano ','1984-09-08','masculino','','J-antonio@gmail.com','Carrer Gerard, 666',5,15),(17,'39681949','Jose Antonio ','Gabarri ','2009-11-08','masculino','+54(011)760-81-68908 ','gabarri_jose@gmail.com','TravesÃ­a Paola, 88',6,16),(18,'29103833','Eliseo ','Aragon ','1935-07-16','masculino','','eliseo@gmail.com','Calle Sotelo, 6',9,17),(19,'53123372','Nancy ','Villa ','1993-09-25','femenino','+54(011)487-16-47944 ','nancy@gmail.com','Avenida Espinal, 79',8,18),(20,'43948557','Adoracion ','Lorente ','2022-03-13','masculino','+54(011)761-02-71199 ','ador@gmail.com','Calle Romo, 37',4,19),(21,'31393142','Salvador ','Vaca ','1992-06-12','masculino','','salvador_vaca@gmail.com','Plaza Isaac, 357',11,1),(22,'28564781','Roberto ','de Leon ','2010-09-02','masculino','','roberto@gmail.com','CamiÃ±o Nil, 0, 9Âº E',6,12),(23,'39632888','Maria Pilar ','Jurado ','1982-05-18','femenino','+54(011)978-66-87541 ','mp_jurado@gmail.com','RÃºa Valentina, 2',13,11),(24,'28033068','Diego ','Barcelo ','1987-06-04','masculino','','diego01@gmail.com','Ruela Villar, 9',3,1),(25,'26305520','Karima ','Plasencia ','1969-04-23','femenino','','karima_pla@gmail.com','Av. MÃ­a MontaÃ±ez # 53351',4,2),(26,'44881485','Florentino ','Arellano ','1937-02-05','masculino','+54(011)220-60-01588 ','Florentino_123@gmail.com','Cl. Hidalgo Terrazas # 43 Hab. 480',5,3),(27,'39445609','SÃ©rgio ','Melendez ','1940-11-13','masculino','+54(011)094-71-56036 ','sergiom@gmail.com','Jr. Montserrat Castellanos # 26384',6,4),(28,'59382573','Angela ','Orozco ','1923-08-13','femenino','+54(011)135-00-05247 ','angela@gmail.com','Urb. Jacobo Corral # 17',7,5),(29,'48432361','Saturnina ','Mercado ','1959-08-14','femenino','+54(011)235-86-96698 ','saturnina@gmail.com','Av. Regina Linares # 46839 Piso 9',8,6),(30,'40084375','Andres ','Vera ','1989-08-17','masculino','+54(011)389-96-94583 ','Andres_19234@gmail.com','Jr. Ian Cano # 6',9,7),(31,'53203344','Yesica ','Bellido ','2015-04-02','femenino','+54(011)799-17-79591 ','Yesi_1@gmail.com','Ronda Tijerina, 52',1,8),(32,'25463607','Hipolito ','Campos ','1986-04-14','masculino','','hipolito@gmail.com','Calle Benavides, 354',11,9),(33,'37266810','Victorina ','Sosa ','1990-05-22','femenino','+54(011)504-57-14518 ','victorina@gmail.com','Passeig RaÃºl, 10',12,10),(34,'55568603','Malika ','SÃ¡nchez ','2006-04-17','femenino','+54(011)179-12-50567 ','Mailka.24@gmail.com','Avinguda Sisneros, 2 ',2,11),(35,'31841248','Mauro ','Abad ','2017-08-06','masculino','+54(011)692-38-83069 ','mauritodm@gmail.com','Passeig JosÃ© Antonio, 89 ',4,12),(36,'48904162','Nuria ','Barroso ','2021-11-22','femenino','+54(011)148-38-35767 ','nuria@gmail.com','CamiÃ±o Adam, 25',5,13),(37,'37375482','Markel ','Arevalo ','1960-11-05','masculino','+54(011)686-29-28675 ','markel@gmail.com','Ronda CabÃ¡n, 89',6,14),(38,'25179629','Engracia ','Navarro ','1961-08-15','masculino','','engracia@gmail.com','Avinguda Valeria, 012',7,15),(39,'40741137','Alvaro ','Iglesias ','1931-08-06','masculino','+54(011)093-83-45257 ','alvaro_igle@gmail.com','Passeig SaÃºl, 4, 7Âº C',8,16),(40,'40552469','Izan ','Quintero ','1921-07-19','masculino','+54(011)305-66-22379 ','izan@gmail.com','Plaza Benito, 72 ',9,17),(41,'44250911','Roxana ','Ruiz ','2013-07-13','femenino','+54(011)700-03-32335 ','roxana@gmail.com','TravesÃ­a Eva, 8',2,18),(42,'51340293','Amelia ','Barrero ','1999-03-28','femenino','+54(011)563-68-04147 ','ame_barrero@gmail.com','Ruela Lucero, 7 ',11,19),(43,'53582733','Simona ','Jaens','1978-02-19','femenino','+54(011)858-18-99857 ','somina@gmail.com','Carrer Mercado, 091',12,20),(44,'37247539','Marcos','Perez','1994-03-12','masculino',NULL,'marcos@gmail.com','fake street 123',1,3),(45,'37247539','Marcos','Perez','1994-03-12','masculino',NULL,'marcos@gmail.com','fake street 123',1,3);
/*!40000 ALTER TABLE `pacientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'hospital'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_listado_pacientes_ordenado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listado_pacientes_ordenado`(IN p_order_column VARCHAR(100), IN p_order_type VARCHAR(40))
BEGIN
    
    SET @ordenar = concat(" ORDER BY ", p_order_column, " ", p_order_type);
    SET @clausula = CONCAT("SELECT * FROM pacientes", @ordenar);

    PREPARE mi_clausula FROM @clausula;
    EXECUTE mi_clausula;
    DEALLOCATE PREPARE mi_clausula;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_nueva_internacion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_nueva_internacion`(IN p_id_px INT, IN p_cama INT, IN p_motivo_ingreso VARCHAR(255))
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tcl_one` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tcl_one`()
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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tcl_two` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tcl_two`()
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
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-26 23:48:01
