-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: magiconlinemarket
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Table structure for table `baralla_carta`
--

DROP TABLE IF EXISTS `baralla_carta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `baralla_carta` (
  `idbaralla_carta` int NOT NULL AUTO_INCREMENT,
  `created_by` int NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int NOT NULL,
  `updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` tinyint NOT NULL DEFAULT '1',
  `quantitat` int NOT NULL DEFAULT '1',
  `idcarta` int NOT NULL,
  `idbaralla` int NOT NULL,
  PRIMARY KEY (`idbaralla_carta`),
  UNIQUE KEY `idbaralla_carta_UNIQUE` (`idbaralla_carta`),
  KEY `fk_baralla_carta_updated_idx` (`updated_by`),
  KEY `fk_baralla_carta_created_idx` (`created_by`),
  KEY `fk_baralla_carta_carta_idx` (`idcarta`),
  KEY `fk_baralla_carta_baralla_idx` (`idbaralla`),
  CONSTRAINT `fk_baralla_carta_baralla` FOREIGN KEY (`idbaralla`) REFERENCES `baralles` (`idbaralla`),
  CONSTRAINT `fk_baralla_carta_carta` FOREIGN KEY (`idcarta`) REFERENCES `cartes` (`idcarta`),
  CONSTRAINT `fk_baralla_carta_created` FOREIGN KEY (`created_by`) REFERENCES `users` (`iduser`),
  CONSTRAINT `fk_baralla_carta_updated` FOREIGN KEY (`updated_by`) REFERENCES `users` (`iduser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `baralla_carta`
--

LOCK TABLES `baralla_carta` WRITE;
/*!40000 ALTER TABLE `baralla_carta` DISABLE KEYS */;
/*!40000 ALTER TABLE `baralla_carta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `baralles`
--

DROP TABLE IF EXISTS `baralles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `baralles` (
  `idbaralla` int NOT NULL AUTO_INCREMENT,
  `created_by` int DEFAULT NULL,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated` datetime DEFAULT CURRENT_TIMESTAMP,
  `active` tinyint DEFAULT '1',
  `nom` varchar(80) DEFAULT NULL,
  `ispublic` tinyint NOT NULL DEFAULT '0',
  `idusuari` int NOT NULL,
  PRIMARY KEY (`idbaralla`),
  UNIQUE KEY `idbaralla_UNIQUE` (`idbaralla`),
  KEY `fk_baralla_created_idx` (`created_by`),
  KEY `fk_baralla_updated_idx` (`updated_by`),
  KEY `fk_baralla_user_idx` (`idusuari`),
  CONSTRAINT `fk_baralla_created` FOREIGN KEY (`created_by`) REFERENCES `users` (`iduser`),
  CONSTRAINT `fk_baralla_updated` FOREIGN KEY (`updated_by`) REFERENCES `users` (`iduser`),
  CONSTRAINT `fk_baralla_user` FOREIGN KEY (`idusuari`) REFERENCES `users` (`iduser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Baralla són el conjunt de cartes que componen una baralla d''un usuari/a';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `baralles`
--

LOCK TABLES `baralles` WRITE;
/*!40000 ALTER TABLE `baralles` DISABLE KEYS */;
/*!40000 ALTER TABLE `baralles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cartes`
--

DROP TABLE IF EXISTS `cartes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cartes` (
  `idcarta` int NOT NULL AUTO_INCREMENT,
  `updated_by` int NOT NULL,
  `updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` tinyint NOT NULL DEFAULT '1',
  `nom` varchar(45) DEFAULT NULL,
  `costmana` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idcarta`),
  UNIQUE KEY `idcarta_UNIQUE` (`idcarta`),
  KEY `fk_carta_created_idx` (`created_by`),
  KEY `fk_carta_updated` (`updated_by`),
  CONSTRAINT `fk_carta_created` FOREIGN KEY (`created_by`) REFERENCES `users` (`iduser`),
  CONSTRAINT `fk_carta_updated` FOREIGN KEY (`updated_by`) REFERENCES `users` (`iduser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='cartes existents, les cartes composen una baralla i es relacionen amb producte ja\nque una carta pot ser un producte. A més les cartes tenen un tipus y una edició.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cartes`
--

LOCK TABLES `cartes` WRITE;
/*!40000 ALTER TABLE `cartes` DISABLE KEYS */;
/*!40000 ALTER TABLE `cartes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ciutats`
--

DROP TABLE IF EXISTS `ciutats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ciutats` (
  `idciutat` int NOT NULL AUTO_INCREMENT,
  `updated_by` int NOT NULL,
  `updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isactive` tinyint NOT NULL DEFAULT '1',
  `nom` varchar(45) DEFAULT NULL,
  `idpais` int DEFAULT NULL,
  PRIMARY KEY (`idciutat`),
  UNIQUE KEY `idciutat_UNIQUE` (`idciutat`),
  KEY `fk_city_created_idx` (`created_by`),
  KEY `fk_city_updated_idx` (`updated_by`),
  KEY `fk_ciutat_pais_idx` (`idpais`),
  CONSTRAINT `fk_ciutat_created` FOREIGN KEY (`created_by`) REFERENCES `users` (`iduser`),
  CONSTRAINT `fk_ciutat_pais` FOREIGN KEY (`idpais`) REFERENCES `paisos` (`idpais`),
  CONSTRAINT `fk_ciutat_updated` FOREIGN KEY (`updated_by`) REFERENCES `users` (`iduser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ciutats`
--

LOCK TABLES `ciutats` WRITE;
/*!40000 ALTER TABLE `ciutats` DISABLE KEYS */;
/*!40000 ALTER TABLE `ciutats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comandes`
--

DROP TABLE IF EXISTS `comandes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comandes` (
  `idcomanda` int NOT NULL AUTO_INCREMENT,
  `updated_by` int NOT NULL,
  `updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` tinyint NOT NULL DEFAULT '1',
  `idcomprador` int NOT NULL,
  `total` double NOT NULL DEFAULT '0.05',
  PRIMARY KEY (`idcomanda`),
  UNIQUE KEY `idcomanda_UNIQUE` (`idcomanda`),
  KEY `fk_comanda_updated_idx` (`updated_by`),
  KEY `fk_comanda_created_idx` (`created_by`),
  KEY `fk_comanada_comprador_idx` (`idcomprador`),
  CONSTRAINT `fk_comanada_comprador` FOREIGN KEY (`idcomprador`) REFERENCES `users` (`iduser`),
  CONSTRAINT `fk_comanda_created` FOREIGN KEY (`created_by`) REFERENCES `users` (`iduser`),
  CONSTRAINT `fk_comanda_updated` FOREIGN KEY (`updated_by`) REFERENCES `users` (`iduser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='comanda son el conjunt de productes oferits comprats per un usuari (linies de comandes)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comandes`
--

LOCK TABLES `comandes` WRITE;
/*!40000 ALTER TABLE `comandes` DISABLE KEYS */;
/*!40000 ALTER TABLE `comandes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `direccions`
--

DROP TABLE IF EXISTS `direccions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `direccions` (
  `iddireccio` int NOT NULL AUTO_INCREMENT,
  `created_by` int NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int NOT NULL,
  `updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isactive` tinyint NOT NULL DEFAULT '1',
  `direccio` varchar(45) NOT NULL,
  `codipostal` varchar(45) NOT NULL,
  `idciutat` int DEFAULT NULL,
  `idusuari` int DEFAULT NULL,
  PRIMARY KEY (`iddireccio`),
  UNIQUE KEY `iddireccio_UNIQUE` (`iddireccio`),
  KEY `created_by_idx` (`idusuari`),
  KEY `updated_by_idx` (`updated_by`),
  KEY `fk_created_user_idx` (`created_by`),
  KEY `fk_direccio_ciutat_idx` (`idciutat`),
  CONSTRAINT `fk_direccio_ciutat` FOREIGN KEY (`idciutat`) REFERENCES `ciutats` (`idciutat`),
  CONSTRAINT `fk_direccio_created` FOREIGN KEY (`created_by`) REFERENCES `users` (`iduser`),
  CONSTRAINT `fk_direccio_updated` FOREIGN KEY (`updated_by`) REFERENCES `users` (`iduser`),
  CONSTRAINT `fk_direccio_user` FOREIGN KEY (`idusuari`) REFERENCES `users` (`iduser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Direccions que pot tenri un usuari.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `direccions`
--

LOCK TABLES `direccions` WRITE;
/*!40000 ALTER TABLE `direccions` DISABLE KEYS */;
/*!40000 ALTER TABLE `direccions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enviaments`
--

DROP TABLE IF EXISTS `enviaments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enviaments` (
  `idenviament` int NOT NULL AUTO_INCREMENT,
  `updated_by` int NOT NULL,
  `updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` tinyint NOT NULL DEFAULT '1',
  `iddireccio` int NOT NULL,
  `idcomanda` int NOT NULL,
  `idtipusenviament` int NOT NULL,
  PRIMARY KEY (`idenviament`),
  UNIQUE KEY `idenviament_UNIQUE` (`idenviament`),
  KEY `fk_enviament_updated_idx` (`updated_by`),
  KEY `fk_enviament_created_idx` (`created_by`),
  KEY `fk_enviament_direccio_idx` (`iddireccio`),
  KEY `fk_enviament_tipusenviament_idx` (`idtipusenviament`),
  CONSTRAINT `fk_enviament_created` FOREIGN KEY (`created_by`) REFERENCES `users` (`iduser`),
  CONSTRAINT `fk_enviament_direccio` FOREIGN KEY (`iddireccio`) REFERENCES `direccions` (`iddireccio`),
  CONSTRAINT `fk_enviament_tipusenviament` FOREIGN KEY (`idtipusenviament`) REFERENCES `tipusenviaments` (`idtipusenviament`),
  CONSTRAINT `fk_enviament_updated` FOREIGN KEY (`updated_by`) REFERENCES `users` (`iduser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='un enviament es una comanda enviada al seu comprador a la seva direccio';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enviaments`
--

LOCK TABLES `enviaments` WRITE;
/*!40000 ALTER TABLE `enviaments` DISABLE KEYS */;
/*!40000 ALTER TABLE `enviaments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expansio_carta`
--

DROP TABLE IF EXISTS `expansio_carta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expansio_carta` (
  `idexpansio_carta` int NOT NULL AUTO_INCREMENT,
  `updated_by` int NOT NULL,
  `updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` tinyint NOT NULL DEFAULT '1',
  `id_carta` int NOT NULL,
  `id_expansio` int NOT NULL,
  `url_imatge` varchar(500) NOT NULL,
  PRIMARY KEY (`idexpansio_carta`),
  UNIQUE KEY `idexpansio_carta_UNIQUE` (`idexpansio_carta`),
  KEY `fk_expansio_carta_updated_idx` (`updated_by`),
  KEY `fk_expansio_carta_created_idx` (`created_by`),
  KEY `fk_expansio_carta_expansio_idx` (`id_expansio`),
  KEY `fk_expansio_carta_carta_idx` (`id_carta`),
  CONSTRAINT `fk_expansio_carta_carta` FOREIGN KEY (`id_carta`) REFERENCES `cartes` (`idcarta`),
  CONSTRAINT `fk_expansio_carta_created` FOREIGN KEY (`created_by`) REFERENCES `users` (`iduser`),
  CONSTRAINT `fk_expansio_carta_expansio` FOREIGN KEY (`id_expansio`) REFERENCES `expansions` (`idexpansio`),
  CONSTRAINT `fk_expansio_carta_updated` FOREIGN KEY (`updated_by`) REFERENCES `users` (`iduser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expansio_carta`
--

LOCK TABLES `expansio_carta` WRITE;
/*!40000 ALTER TABLE `expansio_carta` DISABLE KEYS */;
/*!40000 ALTER TABLE `expansio_carta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expansions`
--

DROP TABLE IF EXISTS `expansions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expansions` (
  `idexpansio` int NOT NULL AUTO_INCREMENT,
  `updated_by` int NOT NULL,
  `updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` tinyint NOT NULL DEFAULT '1',
  `nom` varchar(45) NOT NULL,
  `datasortida` datetime DEFAULT NULL,
  PRIMARY KEY (`idexpansio`),
  UNIQUE KEY `idexpansio_UNIQUE` (`idexpansio`),
  KEY `fk_expansio_updated_idx` (`updated_by`),
  KEY `fk_expansio_created_idx` (`created_by`),
  CONSTRAINT `fk_expansio_created` FOREIGN KEY (`created_by`) REFERENCES `users` (`iduser`),
  CONSTRAINT `fk_expansio_updated` FOREIGN KEY (`updated_by`) REFERENCES `users` (`iduser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='les expansions es aquella col·lecció a la que pertany un producte concret.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expansions`
--

LOCK TABLES `expansions` WRITE;
/*!40000 ALTER TABLE `expansions` DISABLE KEYS */;
/*!40000 ALTER TABLE `expansions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `linies`
--

DROP TABLE IF EXISTS `linies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `linies` (
  `idlinia` int NOT NULL AUTO_INCREMENT,
  `updated_by` int NOT NULL,
  `updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` tinyint NOT NULL DEFAULT '1',
  `idOferta` int NOT NULL,
  `quantitat` int NOT NULL DEFAULT '1',
  `idcomanda` int NOT NULL,
  `total` int NOT NULL,
  PRIMARY KEY (`idlinia`),
  UNIQUE KEY `idliniaComanda_UNIQUE` (`idlinia`),
  KEY `fk_linia_updated_idx` (`updated_by`),
  KEY `fk_linia_created_idx` (`created_by`),
  KEY `fk_linia_oferta_idx` (`idOferta`),
  KEY `fk_linia_comanda_idx` (`idcomanda`),
  CONSTRAINT `fk_linia_comanda` FOREIGN KEY (`idcomanda`) REFERENCES `comandes` (`idcomanda`),
  CONSTRAINT `fk_linia_created` FOREIGN KEY (`created_by`) REFERENCES `users` (`iduser`),
  CONSTRAINT `fk_linia_oferta` FOREIGN KEY (`idOferta`) REFERENCES `ofertes` (`idoferta`),
  CONSTRAINT `fk_linia_updated` FOREIGN KEY (`updated_by`) REFERENCES `users` (`iduser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='linies de comanda son cadascuna de les lines que componen una comanda\ncadascuna correspon amb una oferta d''un venedor(user) per un preu.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `linies`
--

LOCK TABLES `linies` WRITE;
/*!40000 ALTER TABLE `linies` DISABLE KEYS */;
/*!40000 ALTER TABLE `linies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofertes`
--

DROP TABLE IF EXISTS `ofertes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ofertes` (
  `idoferta` int NOT NULL AUTO_INCREMENT,
  `updated_by` int NOT NULL,
  `updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` tinyint NOT NULL DEFAULT '1',
  `preu` float NOT NULL DEFAULT '0.05',
  `quantitat` int NOT NULL DEFAULT '1',
  `id_producte` int NOT NULL,
  `id_venedor` int NOT NULL,
  PRIMARY KEY (`idoferta`),
  UNIQUE KEY `idoferta_UNIQUE` (`idoferta`),
  KEY `fk_oferta_created_idx` (`created_by`),
  KEY `fk_oferta_updated_idx` (`updated_by`),
  KEY `fk_oferta_user_idx` (`id_venedor`),
  KEY `fk_oferta_producte_idx` (`id_producte`),
  CONSTRAINT `fk_oferta_created` FOREIGN KEY (`created_by`) REFERENCES `users` (`iduser`),
  CONSTRAINT `fk_oferta_producte` FOREIGN KEY (`id_producte`) REFERENCES `productes` (`idproducte`),
  CONSTRAINT `fk_oferta_updated` FOREIGN KEY (`updated_by`) REFERENCES `users` (`iduser`),
  CONSTRAINT `fk_oferta_user` FOREIGN KEY (`id_venedor`) REFERENCES `users` (`iduser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Oferta es un producte que ofereix un usuari/a per un preu.\nPodrá en un futur ser comprat';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofertes`
--

LOCK TABLES `ofertes` WRITE;
/*!40000 ALTER TABLE `ofertes` DISABLE KEYS */;
/*!40000 ALTER TABLE `ofertes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paisos`
--

DROP TABLE IF EXISTS `paisos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paisos` (
  `idpais` int NOT NULL AUTO_INCREMENT,
  `created_by` int NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int NOT NULL,
  `updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isactive` tinyint NOT NULL DEFAULT '1',
  `nom` varchar(45) NOT NULL,
  PRIMARY KEY (`idpais`),
  UNIQUE KEY `idpais_UNIQUE` (`idpais`),
  KEY `fk_city_created_idx` (`created_by`),
  KEY `fk_pais_updated_idx` (`updated_by`),
  CONSTRAINT `fk_pais_created` FOREIGN KEY (`created_by`) REFERENCES `users` (`iduser`),
  CONSTRAINT `fk_pais_updated` FOREIGN KEY (`updated_by`) REFERENCES `users` (`iduser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paisos`
--

LOCK TABLES `paisos` WRITE;
/*!40000 ALTER TABLE `paisos` DISABLE KEYS */;
/*!40000 ALTER TABLE `paisos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `premis`
--

DROP TABLE IF EXISTS `premis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `premis` (
  `idpremi` int NOT NULL AUTO_INCREMENT,
  `updated_by` int NOT NULL,
  `updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` tinyint NOT NULL DEFAULT '1',
  `posicio` int NOT NULL DEFAULT '1',
  `quantitat` int NOT NULL DEFAULT '1',
  `id_torneig` int NOT NULL,
  `id_producte` int NOT NULL,
  PRIMARY KEY (`idpremi`),
  UNIQUE KEY `idpremi_UNIQUE` (`idpremi`),
  KEY `fk_premi_updated_idx` (`updated_by`),
  KEY `fk_premi_created_idx` (`created_by`),
  KEY `fk_premi_torneig_idx` (`id_torneig`),
  KEY `fk_premi_producte_idx` (`id_producte`),
  CONSTRAINT `fk_premi_created` FOREIGN KEY (`created_by`) REFERENCES `users` (`iduser`),
  CONSTRAINT `fk_premi_producte` FOREIGN KEY (`id_producte`) REFERENCES `productes` (`idproducte`),
  CONSTRAINT `fk_premi_torneig` FOREIGN KEY (`id_torneig`) REFERENCES `tornejos` (`idtorneig`),
  CONSTRAINT `fk_premi_updated` FOREIGN KEY (`updated_by`) REFERENCES `users` (`iduser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='premis que son productes que es donen al torneig';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `premis`
--

LOCK TABLES `premis` WRITE;
/*!40000 ALTER TABLE `premis` DISABLE KEYS */;
/*!40000 ALTER TABLE `premis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productes`
--

DROP TABLE IF EXISTS `productes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productes` (
  `idproducte` int NOT NULL AUTO_INCREMENT,
  `updated_by` int NOT NULL,
  `updated` datetime NOT NULL,
  `created_by` int NOT NULL,
  `created` datetime NOT NULL,
  `active` tinyint NOT NULL,
  `nom` varchar(100) DEFAULT NULL,
  `idexpansio_carta` int DEFAULT NULL,
  PRIMARY KEY (`idproducte`),
  UNIQUE KEY `idproducte_UNIQUE` (`idproducte`),
  KEY `fk_producte_updated_idx` (`updated_by`),
  KEY `fk_producte_created_idx` (`created_by`),
  KEY `fk_producte_expansio_carta_idx` (`idexpansio_carta`),
  CONSTRAINT `fk_producte_created` FOREIGN KEY (`created_by`) REFERENCES `users` (`iduser`),
  CONSTRAINT `fk_producte_expansio_carta` FOREIGN KEY (`idexpansio_carta`) REFERENCES `expansio_carta` (`idexpansio_carta`),
  CONSTRAINT `fk_producte_updated` FOREIGN KEY (`updated_by`) REFERENCES `users` (`iduser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='producte seria el punt més concret, per exemple, seria la carta de l''expansió, un tapet, una capsa segellada de cartes...\nels productes poden ser de diferents categories de productes que després seran utilitzades en la recerca.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productes`
--

LOCK TABLES `productes` WRITE;
/*!40000 ALTER TABLE `productes` DISABLE KEYS */;
/*!40000 ALTER TABLE `productes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipuscarta_carta`
--

DROP TABLE IF EXISTS `tipuscarta_carta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipuscarta_carta` (
  `idtipuscarta_carta` int NOT NULL AUTO_INCREMENT,
  `updated_by` int NOT NULL,
  `updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` tinyint NOT NULL,
  `id_carta` int NOT NULL,
  `id_tipuscarta` int NOT NULL,
  PRIMARY KEY (`idtipuscarta_carta`),
  UNIQUE KEY `idtipuscarta_carta_UNIQUE` (`idtipuscarta_carta`),
  KEY `fk_tipuscarta_carta_updated_idx` (`updated_by`),
  KEY `fk_tipuscarta_carta_created_idx` (`created_by`),
  KEY `fk_tipuscarta_carta_carta_idx` (`id_carta`),
  KEY `fk_tipuscarta_carta_tipuscarta_idx` (`id_tipuscarta`),
  CONSTRAINT `fk_tipuscarta_carta_carta` FOREIGN KEY (`id_carta`) REFERENCES `cartes` (`idcarta`),
  CONSTRAINT `fk_tipuscarta_carta_created` FOREIGN KEY (`created_by`) REFERENCES `users` (`iduser`),
  CONSTRAINT `fk_tipuscarta_carta_tipuscarta` FOREIGN KEY (`id_tipuscarta`) REFERENCES `tipuscartes` (`idtipuscarta`),
  CONSTRAINT `fk_tipuscarta_carta_updated` FOREIGN KEY (`updated_by`) REFERENCES `users` (`iduser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipuscarta_carta`
--

LOCK TABLES `tipuscarta_carta` WRITE;
/*!40000 ALTER TABLE `tipuscarta_carta` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipuscarta_carta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipuscartes`
--

DROP TABLE IF EXISTS `tipuscartes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipuscartes` (
  `idtipuscarta` int NOT NULL AUTO_INCREMENT,
  `updated_by` int NOT NULL,
  `updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` tinyint NOT NULL DEFAULT '1',
  `nom` varchar(45) NOT NULL,
  PRIMARY KEY (`idtipuscarta`),
  UNIQUE KEY `idtipuscarta_UNIQUE` (`idtipuscarta`),
  UNIQUE KEY `nom_UNIQUE` (`nom`),
  KEY `fk_tipuscarta_created_idx` (`created_by`),
  KEY `fk_tipuscarta_updated_idx` (`updated_by`),
  CONSTRAINT `fk_tipuscarta_created` FOREIGN KEY (`created_by`) REFERENCES `users` (`iduser`),
  CONSTRAINT `fk_tipuscarta_updated` FOREIGN KEY (`updated_by`) REFERENCES `users` (`iduser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='tipus de carta representa quin tipus de carta té una carta, com un carta pot tenir diferents tipus de cartes es una relacion NM.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipuscartes`
--

LOCK TABLES `tipuscartes` WRITE;
/*!40000 ALTER TABLE `tipuscartes` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipuscartes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipusenviaments`
--

DROP TABLE IF EXISTS `tipusenviaments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipusenviaments` (
  `idtipusenviament` int NOT NULL AUTO_INCREMENT,
  `created_by` int DEFAULT NULL,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated` datetime DEFAULT CURRENT_TIMESTAMP,
  `active` tinyint DEFAULT '1',
  `nom` varchar(45) DEFAULT NULL,
  `preu` double DEFAULT '0.05',
  PRIMARY KEY (`idtipusenviament`),
  UNIQUE KEY `idtipusenviament_UNIQUE` (`idtipusenviament`),
  KEY `fk_tipusenviament_created_idx` (`created_by`),
  KEY `fk_tipusenviament_updated_idx` (`updated_by`),
  CONSTRAINT `fk_tipusenviament_created` FOREIGN KEY (`created_by`) REFERENCES `users` (`iduser`),
  CONSTRAINT `fk_tipusenviament_updated` FOREIGN KEY (`updated_by`) REFERENCES `users` (`iduser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='correspon als diferents tipus d''enviaments';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipusenviaments`
--

LOCK TABLES `tipusenviaments` WRITE;
/*!40000 ALTER TABLE `tipusenviaments` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipusenviaments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipustorneig`
--

DROP TABLE IF EXISTS `tipustorneig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipustorneig` (
  `idtipustorneig` int NOT NULL AUTO_INCREMENT,
  `updated_by` int NOT NULL,
  `updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` tinyint NOT NULL DEFAULT '1',
  `descripcio` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idtipustorneig`),
  UNIQUE KEY `idtipustorneig_UNIQUE` (`idtipustorneig`),
  KEY `fk_tipustorneig_created_idx` (`created_by`),
  KEY `fk_tipustorneig_updated_idx` (`updated_by`),
  CONSTRAINT `fk_tipustorneig_created` FOREIGN KEY (`created_by`) REFERENCES `users` (`iduser`),
  CONSTRAINT `fk_tipustorneig_updated` FOREIGN KEY (`updated_by`) REFERENCES `users` (`iduser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipustorneig`
--

LOCK TABLES `tipustorneig` WRITE;
/*!40000 ALTER TABLE `tipustorneig` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipustorneig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `torneig_usuari`
--

DROP TABLE IF EXISTS `torneig_usuari`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `torneig_usuari` (
  `idtorneig_usuari` int NOT NULL AUTO_INCREMENT,
  `updated_by` int NOT NULL,
  `updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` tinyint NOT NULL DEFAULT '1',
  `id_participant` int NOT NULL,
  `id_torneig` int NOT NULL,
  PRIMARY KEY (`idtorneig_usuari`),
  UNIQUE KEY `idtorneig_usuari_UNIQUE` (`idtorneig_usuari`),
  KEY `fk_torneig_usuari_created_idx` (`created_by`),
  KEY `fk_torneig_usuari_updated_idx` (`updated_by`),
  KEY `fk_torneig_usuari_partcipant_idx` (`id_participant`),
  KEY `fk_torneig_usuari_torneig_idx` (`id_torneig`),
  CONSTRAINT `fk_torneig_usuari_created` FOREIGN KEY (`created_by`) REFERENCES `users` (`iduser`),
  CONSTRAINT `fk_torneig_usuari_partcipant` FOREIGN KEY (`id_participant`) REFERENCES `users` (`iduser`),
  CONSTRAINT `fk_torneig_usuari_torneig` FOREIGN KEY (`id_torneig`) REFERENCES `tornejos` (`idtorneig`),
  CONSTRAINT `fk_torneig_usuari_updated` FOREIGN KEY (`updated_by`) REFERENCES `users` (`iduser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='taula resultant dels participants en un torneig';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `torneig_usuari`
--

LOCK TABLES `torneig_usuari` WRITE;
/*!40000 ALTER TABLE `torneig_usuari` DISABLE KEYS */;
/*!40000 ALTER TABLE `torneig_usuari` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tornejos`
--

DROP TABLE IF EXISTS `tornejos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tornejos` (
  `idtorneig` int NOT NULL AUTO_INCREMENT,
  `updated_by` int NOT NULL,
  `updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` tinyint NOT NULL DEFAULT '1',
  `maxparticipants` int DEFAULT NULL,
  `minparticipants` int DEFAULT '2',
  `idtipustorneig` int NOT NULL,
  `punts` int DEFAULT NULL,
  `horainici` datetime DEFAULT NULL,
  PRIMARY KEY (`idtorneig`),
  UNIQUE KEY `idtorneig_UNIQUE` (`idtorneig`),
  KEY `fk_torneig_updated_idx` (`updated_by`),
  KEY `fk_torneig_created_idx` (`created_by`),
  KEY `fk_torneig_tipustorneig_idx` (`idtipustorneig`),
  CONSTRAINT `fk_torneig_created` FOREIGN KEY (`created_by`) REFERENCES `users` (`iduser`),
  CONSTRAINT `fk_torneig_tipustorneig` FOREIGN KEY (`idtipustorneig`) REFERENCES `tipustorneig` (`idtipustorneig`),
  CONSTRAINT `fk_torneig_updated` FOREIGN KEY (`updated_by`) REFERENCES `users` (`iduser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tornejos`
--

LOCK TABLES `tornejos` WRITE;
/*!40000 ALTER TABLE `tornejos` DISABLE KEYS */;
/*!40000 ALTER TABLE `tornejos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `iduser` int NOT NULL,
  `created_by` int NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int NOT NULL,
  `isactive` tinyint NOT NULL DEFAULT '1',
  `nick` varchar(45) NOT NULL,
  `nom` varchar(60) DEFAULT NULL,
  `updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cognom` varchar(60) DEFAULT NULL,
  `email` varchar(40) NOT NULL,
  `isTenda` tinyint DEFAULT '0',
  `valoracio` float DEFAULT '0',
  `saldo` double DEFAULT '0',
  `numeroVendes` int DEFAULT '0',
  PRIMARY KEY (`iduser`),
  UNIQUE KEY `idusers_UNIQUE` (`iduser`),
  KEY `fk_user_updated_idx` (`updated_by`),
  KEY `fk_user_created_idx` (`created_by`),
  CONSTRAINT `fk_user_created` FOREIGN KEY (`created_by`) REFERENCES `users` (`iduser`),
  CONSTRAINT `fk_user_updated` FOREIGN KEY (`updated_by`) REFERENCES `users` (`iduser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Usuaris de l''aplicació que poden ser venedors o compradors.\nLa taula serà reflexiva.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-03 19:31:31
