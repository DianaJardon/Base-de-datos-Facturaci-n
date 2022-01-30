-- MariaDB dump 10.17  Distrib 10.4.14-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: facturacion
-- ------------------------------------------------------
-- Server version	10.4.14-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categoria` (
  `ID_Categoria` int(11) NOT NULL,
  `Nom_Categoria` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT 'Este campo almacena el nombre de la categoria.',
  `Descrip_Categoria` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT 'Este campo almacena a descripcion del cliente.',
  PRIMARY KEY (`ID_Categoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'Limpieza','Productos de limpieza del hogar'),(2,'Dama','Productos cosmeticos'),(3,'Caballero','Productos de barberia y aseo personal'),(4,'Mascotas','Productos para mascotas, alimento y accesorio'),(5,'Tecnologia','Productos electronicos como laptops, monitore'),(6,'Abarrotes','Productos alimentos empaquetados'),(7,'Cremeria','Productos lacteos, y de salchichoneria');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_factura`
--

DROP TABLE IF EXISTS `detalle_factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `detalle_factura` (
  `Num_Fac` int(11) DEFAULT NULL COMMENT 'FK de la tabla factura.',
  `ID_Producto` int(11) DEFAULT NULL COMMENT 'FK de la tabla producto.',
  `Cantidad` int(11) DEFAULT NULL COMMENT 'Este campo almacena la cantidad del producto en la factura.',
  `Importe` decimal(7,2) DEFAULT NULL COMMENT 'Este campo almacena el importe en la factura.',
  KEY `FK_tablaFactura` (`Num_Fac`),
  KEY `FK_tablaProducto` (`ID_Producto`),
  CONSTRAINT `FK_tablaFactura` FOREIGN KEY (`Num_Fac`) REFERENCES `factura` (`Num_Fac`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_tablaProducto` FOREIGN KEY (`ID_Producto`) REFERENCES `producto` (`ID_Producto`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_factura`
--

LOCK TABLES `detalle_factura` WRITE;
/*!40000 ALTER TABLE `detalle_factura` DISABLE KEYS */;
INSERT INTO `detalle_factura` VALUES (1,2,2,241.40),(1,3,5,684.45),(1,2,1,120.70);
/*!40000 ALTER TABLE `detalle_factura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `factura`
--

DROP TABLE IF EXISTS `factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `factura` (
  `Num_Fac` int(11) NOT NULL COMMENT 'Clave principal de la tabla factura.',
  `ID_Cliente` int(11) DEFAULT NULL COMMENT 'ID_Cliente es un campo foraneo de la tabla cliente.  ',
  `Fecha_Fac` datetime DEFAULT NULL COMMENT 'Este campo almacena la fecha de la factura del cliente.',
  `ID_MetodoP` int(11) DEFAULT NULL COMMENT 'Es un campo foraneo de la tabla Metodo de pago',
  `RFC` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT 'Registro federal del cuasantes de la persona fisica.',
  `Regimen_Fis` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `Total_Articulos` int(11) DEFAULT NULL COMMENT 'Este campo almacena el total de articulos del cliente.',
  `Subtotal` decimal(7,2) DEFAULT NULL COMMENT 'Este campo almacena el subtotal de la factura del cliente.',
  `IVA` decimal(7,2) DEFAULT NULL COMMENT 'Este campo almacena el IVA del cliente.',
  `Descuento` decimal(7,2) DEFAULT NULL COMMENT 'Este campo almacena el descuento en la factura del cliente.',
  `Total_Neto` decimal(7,2) DEFAULT NULL COMMENT 'Este campo almacena el total neto en la factura del cliente.',
  PRIMARY KEY (`Num_Fac`),
  KEY `FK_tablaCliente` (`ID_Cliente`),
  KEY `FK_tablaPago` (`ID_MetodoP`),
  CONSTRAINT `FK_tablaCliente` FOREIGN KEY (`ID_Cliente`) REFERENCES `razonsocial` (`ID_Cliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_tablaPago` FOREIGN KEY (`ID_MetodoP`) REFERENCES `metodo pago` (`ID_MetodoP`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `factura`
--

LOCK TABLES `factura` WRITE;
/*!40000 ALTER TABLE `factura` DISABLE KEYS */;
INSERT INTO `factura` VALUES (1,666,'2021-09-27 14:02:15',NULL,NULL,NULL,NULL,1047.00,NULL,NULL,NULL);
/*!40000 ALTER TABLE `factura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metodo pago`
--

DROP TABLE IF EXISTS `metodo pago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metodo pago` (
  `ID_MetodoP` int(11) NOT NULL COMMENT 'Clave principal del metodo de pago.',
  `Nom_MetodoP` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT 'Este campo almacena el nombre del metodo de pago.',
  `Descrip_MP` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT 'Este campo almacena la descripcion del Metodo de Pago.',
  PRIMARY KEY (`ID_MetodoP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metodo pago`
--

LOCK TABLES `metodo pago` WRITE;
/*!40000 ALTER TABLE `metodo pago` DISABLE KEYS */;
/*!40000 ALTER TABLE `metodo pago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto`
--

DROP TABLE IF EXISTS `producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `producto` (
  `ID_Producto` int(11) NOT NULL COMMENT 'Clave principal de la tabla Producto.',
  `ID_Categoria` int(11) DEFAULT NULL COMMENT 'ID_Categoria es un campo foraneo de la tabla categoria. ',
  `Nom_Producto` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT 'Este campo almacena el nombre del producto del cliente.',
  `Total_Stock` int(11) DEFAULT NULL COMMENT 'Este campo almacena el total del stock del cliente.',
  `Precio_Product` decimal(7,2) DEFAULT NULL COMMENT 'Este campo almacena el precio del producto.',
  PRIMARY KEY (`ID_Producto`),
  KEY `FK_tablaCategoria` (`ID_Categoria`),
  CONSTRAINT `FK_tablaCategoria  ` FOREIGN KEY (`ID_Categoria`) REFERENCES `categoria` (`ID_Categoria`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto`
--

LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
INSERT INTO `producto` VALUES (1,1,'Escoba',2,70.00),(2,2,'Labial',7,120.70),(3,2,'Blush',3,136.89),(4,3,'Espuma para rasurar',5,100.00),(5,1,'Cloro 6lt',20,110.50),(6,4,'Cepillo ',9,89.99),(7,5,'Monitor Gamer Curvo Gigabyte',3,6719.00),(8,2,'Mascara para pestañas',20,120.70),(9,3,'Cera ',16,46.50),(10,1,'Fabuloso 950ml',18,21.60),(11,1,'Jalador',13,35.70),(12,2,'Paleta de sombras',8,299.90),(13,4,'Shampoo',10,45.00),(14,5,'Mouse gamer',5,1008.81),(15,4,'Arena para gato',5,50.99),(16,5,'Teclado gamer',6,699.99),(17,2,'Pestanas postizas',28,70.00),(18,3,'Loción despues de afeitar',5,90.00),(19,1,'Limpia vidrios',7,44.99),(20,2,'Locion',4,300.00),(21,3,'Rasuradora personal',3,350.00),(22,3,'Locion ',5,400.60),(23,2,'Polvo compacto',3,30.00),(24,2,'Esmalte para uñas ',13,24.99),(25,4,'Jabon mata pulgas',2,33.70),(26,4,'Correa de cuero',5,70.00),(27,2,'Delineador de ojos',8,45.50),(28,1,'Quita cochambre',4,55.00),(29,5,'Web cam',2,3000.00),(30,1,'Jabon para manos',2,30.00),(31,6,'Pasta',7,8.00),(32,6,'Arroz',20,32.50),(33,6,'Frijol',9,35.00),(34,6,'Frutas en almibar ',3,33.00),(35,6,'Champinones',8,22.00),(36,6,'Granos de elote',6,14.70),(37,6,'Chiles chipotles',3,12.80),(38,6,'Cafe',5,50.00),(39,6,'Aceite',9,36.50),(40,6,'Avena',2,27.40),(41,7,'Crema',5,30.10),(42,7,'Jamon',20,50.00),(43,7,'Salchicha',8,100.00),(44,7,'Leche',30,27.80),(45,7,'yogurt ',18,10.00),(46,6,'Chocolate abuelita',4,60.00),(47,7,'Queso blanco',2,120.40),(48,7,'queso oaxaca',4,110.00),(49,6,'atun',6,27.89),(50,6,'Cereal',8,49.99),(51,6,'Chocolate en polvo',0,49.99);
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `razonsocial`
--

DROP TABLE IF EXISTS `razonsocial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `razonsocial` (
  `ID_Cliente` int(11) NOT NULL COMMENT 'Este campo esta definido como Primary Key, para relacionarlo con la tabla factura.',
  `Nom_RSocial` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT 'Este campo almacena el nombre completo del cliente.',
  `A_P` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT 'Apellido Paterno del cliente.',
  `A_M` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT 'Apellido materno del cliente.',
  `FECHA_NAC` date DEFAULT NULL COMMENT 'Este campo almacena fecha de nacimiento del cliente.',
  `edad` int(10) DEFAULT NULL,
  `SEXO` varchar(5) COLLATE utf8_bin DEFAULT NULL COMMENT 'Este campo almacena el sexo del cliente.',
  `TEL_CEL` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT 'Este campo almacena el telefono de celular del cliente.',
  `EMAIL` text COLLATE utf8_bin DEFAULT NULL COMMENT 'Este campo almacena el email del cliente.',
  PRIMARY KEY (`ID_Cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `razonsocial`
--

LOCK TABLES `razonsocial` WRITE;
/*!40000 ALTER TABLE `razonsocial` DISABLE KEYS */;
INSERT INTO `razonsocial` VALUES (666,'Tayde','Chora','Portilla','1979-09-20',42,'Femen','666666','tayde@gmail.com'),(999,'Dianita','Jardon','Vilchis','2000-10-07',20,'Femen','5555555','diana@gmail.com');
/*!40000 ALTER TABLE `razonsocial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'facturacion'
--
/*!50003 DROP FUNCTION IF EXISTS `actualizarStock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `actualizarStock`(cod_articulo int) RETURNS int(11)
BEGIN
declare total_pro int;
set total_pro=(select Total_Stock from producto where ID_Producto=cod_articulo);
RETURN total_pro;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `sumaImporte` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `sumaImporte`(num_fac int) RETURNS int(11)
BEGIN
declare sumTotal decimal(7,2);
set sumTotal=(select sum(Importe) from detalle_factura where Num_Fac=num_fac);
RETURN sumTotal;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `total_art` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `total_art`(id_clie int) RETURNS int(11)
BEGIN
declare total_art int;
set total_art=(select sum(Cantidad) from detalle_factura where Num_Fac=id_clie);
RETURN total_art;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `actualizar importe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar importe`(z int)
BEGIN
	if not exists (	select Num_Fac from detalle_factura where Num_Fac=z)then
		select "no existe la factura";
	else
		set SQL_SAFE_UPDATES=0;
        UPDATE detalle_factura SET importe = (producto.Precio_Product*detalle_factura.Cantidad);
        SELECT *FROM detalle_factura;
	end if;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `actu_subtotal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `actu_subtotal`(nfact int)
BEGIN
	SET SQL_SAFE_UPDATES = 0;
    update factura set factura.Subtotal = (select sumaImporte(nfact))
    where  
		factura.Num_Fac = nfact;
		#select * from facturar;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `act_totart` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `act_totart`(id_fa int)
BEGIN
SET SQL_SAFE_UPDATES = 0;
UPDATE factura SET factura.Total_Articulos=(select total_art(id_fa)) 
WHERE factura.Num_Fac = id_fa;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Add_detalle_factura` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Add_detalle_factura`(id_factura int, cod_producto int, cant int)
BEGIN
	declare existencia int;
		set existencia= (select actualizarStock(cod_producto));
		set sql_safe_updates=0;
    
if existencia=0 then 
	select "No hay existencia" as "sock";
else
	if cant <= existencia then
		select existencia as "Productos en existencia";
        insert into detalle_factura values(id_factura,cod_producto,cant,Null);
        update producto set Total_Stock = existencia - cant where ID_Producto = cod_producto;
	else
		select existencia as "stock insuficiente ";
	end if;
end if;
        
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `calcular_importe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `calcular_importe`(num_fact int)
BEGIN
	SET SQL_SAFE_UPDATES = 0;
	IF EXISTS (SELECT * FROM detalle_factura WHERE Num_Fac = num_fact)
		THEN
			UPDATE detalle_factura, producto SET Importe = ( detalle_factura.Cantidad * producto.Precio_Product ) 
            WHERE detalle_factura.ID_Producto = producto.ID_Producto and detalle_factura.Num_Fac=num_fact;
            select *from detalle_factura;
	ELSE
		SELECT 'No existe el numero de factura';
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Condicional1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Condicional1`(clave int)
BEGIN
if clave=666  then
	select 'Es la maestra' as resultado;
else 
	select 'Eres alumno';
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Consulta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Consulta`()
BEGIN
IF EXISTS(
SELECT *FROM information_schema.COLUMNS
WHERE column_name='edad'
and table_name='razonsocial') THEN
select 'el campo si existe';
ELSE
select 'el campo no existe';
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Consulta_criterio_producto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Consulta_criterio_producto`(letra char(4))
BEGIN
select *from producto 
where Nom_Producto like letra;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `consulta_detalleF` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `consulta_detalleF`(Num_Fac int)
BEGIN
SELECT razonsocial.ID_Cliente,razonsocial.Nom_RSocial,razonsocial.A_P,
factura.Num_Fac,producto.ID_Producto,producto.Nom_Producto,producto.Precio_Product,detalle_factura.Cantidad
from razonsocial, factura,producto,detalle_factura
where razonsocial.ID_Cliente=factura.ID_Cliente and
factura.Num_Fac=detalle_factura.Num_Fac and producto.ID_Producto=detalle_factura.ID_Producto
and detalle_factura.Num_Fac;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Consulta_TBLProducto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Consulta_TBLProducto`()
BEGIN
select *from producto;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `generarNumeroFactura` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `generarNumeroFactura`(z int(5))
BEGIN
	DECLARE x INT;
    REGRESAR: loop
    SET x = rand() * 5;
    SELECT x;
    if exists( select ID_Cliente from razonsocial where ID_Cliente = z ) then
		select 'El cliente si existe';
		if not exists (select Num_Fac from factura where Num_Fac = x )
		then
			INSERT INTO factura (Num_Fac,ID_Cliente,ID_MetodoP,Fecha_Fac) 
			values (x,z,null,NOW());
			SELECT * FROM factura;
		else
		SELECT 'El numero de factura ya existe';
		END IF;   
	else
    Select 'El cliente no existe';
    end if;
    LEAVE REGRESAR;
    END loop;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `random1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `random1`(y int)
BEGIN
declare x int(50);
my_loop : loop
set x = floor(rand() * (30 - 1) + 1);
if not exists (select *from factura where Num_Fac = x)then
insert into factura(Num_Fac, ID_Cliente, Fecha_Fac)
values(x,y,curdate());
leave my_loop;
 end if;
end loop my_loop;
select Num_Fac, ID_Cliente,Fecha_Fac from factura;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `random2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `random2`(y int)
BEGIN
declare x int(50);
my_loop : loop
set x = floor(rand() * (30 - 1) + 1);
values(x,y);
leave my_loop;
end loop my_loop;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `verificar_columna` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `verificar_columna`()
BEGIN
	if not exists (	select * from information_schema.columns as informe
    where informe.column_name = 'edad' and informe.table_name = 'razonsocial')then
		alter table razonsocial add edad int(10) after FECHA_NAC;
        describe razonsocial;
	else
		set SQL_SAFE_UPDATES=0;
        UPDATE razonsocial SET edad = (timestampdiff(year,FECHA_NAC, CURDATE()));
        SELECT *FROM razonsocial;
	end if;
    
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

-- Dump completed on 2021-10-04 10:56:24
