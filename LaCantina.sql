-- MySQL dump 10.13  Distrib 8.4.3, for macos14 (arm64)
--
-- Host: localhost    Database: LaCantina
-- ------------------------------------------------------
-- Server version	8.4.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ordini`
--

DROP TABLE IF EXISTS `ordini`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordini` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_utente` int NOT NULL,
  `id_prodotto` int NOT NULL,
  `id_riga_ordine` int NOT NULL,
  `quantity` int NOT NULL,
  `data_ordine` varchar(450) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_utente` (`id_utente`),
  KEY `id_prodotto` (`id_prodotto`),
  KEY `id_riga_ordine` (`id_riga_ordine`),
  CONSTRAINT `ordini_ibfk_1` FOREIGN KEY (`id_utente`) REFERENCES `utenti` (`id`),
  CONSTRAINT `ordini_ibfk_2` FOREIGN KEY (`id_prodotto`) REFERENCES `prodotti` (`id`),
  CONSTRAINT `ordini_ibfk_3` FOREIGN KEY (`id_riga_ordine`) REFERENCES `riga_ordini` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordini`
--

LOCK TABLES `ordini` WRITE;
/*!40000 ALTER TABLE `ordini` DISABLE KEYS */;
INSERT INTO `ordini` VALUES (1,1,13,1,1,'22/12/2025'),(2,1,14,1,2,'22/12/2025'),(3,1,13,2,3,'22/12/2025'),(4,1,14,2,1,'22/12/2025'),(5,1,16,3,3,'22/12/2025'),(6,1,15,3,3,'22/12/2025'),(7,1,12,4,1,'22/12/2025'),(10,1,12,5,1,'23/12/2025'),(11,1,12,6,1,'23/12/2025'),(12,1,13,7,2,'23/12/2025'),(13,1,14,7,1,'23/12/2025'),(14,1,12,8,1,'23/12/2025'),(15,1,14,9,1,'23/12/2025'),(16,1,15,9,4,'23/12/2025'),(17,3,13,10,1,'23/12/2025'),(18,1,13,11,3,'23/12/2025'),(19,1,14,11,2,'23/12/2025'),(20,1,15,11,2,'23/12/2025'),(21,1,13,12,2,'28/12/2025'),(22,1,12,13,1,'28/12/2025'),(23,1,13,13,1,'28/12/2025'),(24,1,14,13,1,'28/12/2025');
/*!40000 ALTER TABLE `ordini` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prodotti`
--

DROP TABLE IF EXISTS `prodotti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prodotti` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `descrizione` longtext NOT NULL,
  `categoria` varchar(200) NOT NULL,
  `stock` int NOT NULL,
  `prezzo` double NOT NULL,
  `immagine` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prodotti`
--

LOCK TABLES `prodotti` WRITE;
/*!40000 ALTER TABLE `prodotti` DISABLE KEYS */;
INSERT INTO `prodotti` VALUES (12,'olio extravergine d\'oliva 500ml','Bottiglia in vetro di olio extravergine d\'oliva da 500ml lavorato presso il frantoio LaCantina','olio-extravergine-oliva',48,10,'olio_extravergine_oliva_500.jpg'),(13,'vino rosso 500ml','Bottiglia in vetro di vino rosso del Beneventano da 500ml lavorato presso LaCantina','vino-rosso',44,10,'olio_extravergine_oliva_500.jpg'),(14,'vino bianco 500ml','Bottiglia in vetro di vino bianco del Beneventano da 500ml lavorato presso LaCantina','vino-bianco',47,10,'olio_extravergine_oliva_500.jpg'),(15,'Limoncello  500ml','Bottiglia in vetro di limoncello di Amalfi da 500ml lavorato presso LaCantina','limoncello',46,10,'olio_extravergine_oliva_500.jpg'),(16,'olio extravergine d\'oliva 1L','Bottiglia in vetro di olio extravergine d\'oliva da 500ml lavorato presso il frantoio LaCantina','olio-extravergine-oliva',2,10,'olio_extravergine_oliva_500.jpg');
/*!40000 ALTER TABLE `prodotti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `riga_ordini`
--

DROP TABLE IF EXISTS `riga_ordini`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `riga_ordini` (
  `id` int NOT NULL AUTO_INCREMENT,
  `numero_ordini` int NOT NULL,
  `prezzo_totale` float NOT NULL,
  `stato_ordine` varchar(50) NOT NULL,
  `indirizzo` varchar(450) NOT NULL,
  `cap` varchar(5) NOT NULL,
  `citta` varchar(450) NOT NULL,
  `provincia` varchar(450) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `riga_ordini`
--

LOCK TABLES `riga_ordini` WRITE;
/*!40000 ALTER TABLE `riga_ordini` DISABLE KEYS */;
INSERT INTO `riga_ordini` VALUES (1,2,30,'annullato','via giovanni','840','Napoli','napoli'),(2,2,40,'spedito','via giovanni nicotera','84015','Nocera Superiore','Salerno'),(3,2,60,'annullato','via giovanni nicotera','84','Nocera Superiore','Salerno'),(4,1,10,'attesa di conferma','via giovanni nicotera','84015','Nocera Superiore','Salerno'),(5,1,10,'annullato','erwerw','84015','123123','123123'),(6,1,20,'attesa di conferma','asdadas','84012','ANGRI','adasdas'),(7,2,30,'in consegna','Gabriele','84015','CIAO2','SALIERNo'),(8,1,10,'spedito','vgjugy','6754','ugkgiug','vkhjgk'),(9,2,50,'spedito','7tt7686y9','89769','hoihoiyoi','9709'),(10,1,10,'annullato','dadas','dadaa','adasdas','adsa'),(11,3,70,'spedito','ewewerwe','87852','rwrewrw','werwer'),(12,1,30,'attesa di conferma','1212121','11111','1212','1212'),(13,3,30,'annullato','312312','1231','1231','1231');
/*!40000 ALTER TABLE `riga_ordini` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utenti`
--

DROP TABLE IF EXISTS `utenti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utenti` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utenti`
--

LOCK TABLES `utenti` WRITE;
/*!40000 ALTER TABLE `utenti` DISABLE KEYS */;
INSERT INTO `utenti` VALUES (1,'gabriele','gabriele.cicalese2004@gmail.com','1234'),(2,'admin','admin@lacantina.it','1234'),(3,'FarbizioGrazioso','fabrizio.grazioso@gmail.com','1234'),(4,'elda vitiello','eldavitielloo@gmail.con','1234');
/*!40000 ALTER TABLE `utenti` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-28  1:02:33
