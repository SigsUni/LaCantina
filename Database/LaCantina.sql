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
-- Table structure for table `fornitori`
--

DROP TABLE IF EXISTS `fornitori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fornitori` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(450) NOT NULL,
  `citta` varchar(450) NOT NULL,
  `provincia` varchar(450) NOT NULL,
  `indirizzo` varchar(450) NOT NULL,
  `anno_nascita` int NOT NULL,
  PRIMARY KEY (`id`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fornitori`
--

LOCK TABLES `fornitori` WRITE;
/*!40000 ALTER TABLE `fornitori` DISABLE KEYS */;
INSERT INTO `fornitori` VALUES (1,'LemonGroup','Amalfi','Salerno','via Campagna n.11',1860),(2,'AnticoUliveto','Trentinara','Salerno','via Campagna n.11',1920),(3,'AnticoVinaio','CastelFranco in Miscano','Salerno','via Campagna n.12',1940);
/*!40000 ALTER TABLE `fornitori` ENABLE KEYS */;
UNLOCK TABLES;

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
  `prezzo_acquisto` double NOT NULL,
  `data_ordine` varchar(450) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_utente` (`id_utente`),
  KEY `id_prodotto` (`id_prodotto`),
  KEY `id_riga_ordine` (`id_riga_ordine`),
  CONSTRAINT `ordini_ibfk_1` FOREIGN KEY (`id_utente`) REFERENCES `utenti` (`id`),
  CONSTRAINT `ordini_ibfk_2` FOREIGN KEY (`id_prodotto`) REFERENCES `prodotti` (`id`),
  CONSTRAINT `ordini_ibfk_3` FOREIGN KEY (`id_riga_ordine`) REFERENCES `riga_ordini` (`id`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordini`
--

LOCK TABLES `ordini` WRITE;
/*!40000 ALTER TABLE `ordini` DISABLE KEYS */;
INSERT INTO `ordini` VALUES (25,1,13,14,2,20,'03/01/2026'),(26,1,14,14,2,20,'03/01/2026'),(41,1,14,24,2,20,'10/01/2026'),(42,1,15,24,2,20,'10/01/2026'),(43,1,14,25,1,10,'10/01/2026'),(44,1,14,26,2,20,'10/01/2026'),(45,1,15,26,1,10,'10/01/2026');
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
  `id_fornitore` int NOT NULL,
  `nome` varchar(45) NOT NULL,
  `descrizione` longtext NOT NULL,
  `categoria` varchar(200) NOT NULL,
  `stock` int NOT NULL,
  `prezzo` double NOT NULL,
  `immagine` varchar(45) NOT NULL,
  `stato` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_fornitore` (`id_fornitore`),
  CONSTRAINT `prodotti_ibfk_1` FOREIGN KEY (`id_fornitore`) REFERENCES `fornitori` (`id`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prodotti`
--

LOCK TABLES `prodotti` WRITE;
/*!40000 ALTER TABLE `prodotti` DISABLE KEYS */;
INSERT INTO `prodotti` VALUES (12,2,'olio extravergine d\'oliva 500ml','Bottiglia in vetro di olio extravergine d\'oliva da 500ml lavorato presso il frantoio LaCantina','olio-extravergine-oliva',47,11,'olioEVO1L.png','attivo'),(13,3,'vino rosso 500ml','Bottiglia in vetro di vino rosso del Beneventano da 500ml lavorato presso LaCantina','vino-rosso',32,11,'vinoRosso.png','attivo'),(14,3,'vino bianco 500ml','Bottiglia in vetro di vino bianco del Beneventano da 500ml lavorato presso LaCantina','vino-bianco',28,8,'vinoBianco.png','attivo'),(15,2,'Limoncello  500ml','Bottiglia in vetro di limoncello di Amalfi da 500ml lavorato presso LaCantina','limoncello',36,8,'limoncello.png','attivo'),(16,2,'olio extravergine d\'oliva 1L','Bottiglia in vetro di olio extravergine d\'oliva da 500ml lavorato presso il frantoio LaCantina','olio-extravergine-oliva',5,20,'olioEVO1L.png','attivo'),(17,1,'d','d','olio-extravergine-oliva',2,2,'s.jpg','inattivo');
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
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `riga_ordini`
--

LOCK TABLES `riga_ordini` WRITE;
/*!40000 ALTER TABLE `riga_ordini` DISABLE KEYS */;
INSERT INTO `riga_ordini` VALUES (14,3,60,'attesa di conferma','312312','12122','123121','2131'),(15,1,20,'attesa di conferma','32423','4242','424','242'),(16,1,20,'annullato','2423','42424','24242','24242'),(17,1,30,'attesa di conferma','q','532','q','q'),(18,1,10,'attesa di conferma','393939393939393939','84016','Nocera Superiore','Salerno'),(19,2,120,'attesa di conferma','3333333','3','3','3'),(20,2,40,'attesa di conferma','s','s','s','SALIERN'),(21,2,60,'attesa di conferma','w','2','2','2'),(22,2,120,'attesa di conferma','2','2','2','2'),(23,1,10,'attesa di conferma','1','12312','1212','1'),(24,2,40,'attesa di conferma','423423','3','3','3'),(25,1,10,'attesa di conferma','1234567890212345','12345','nocera supoeriore','mialo'),(26,2,30,'preso in carico','Via Giovanni nicotera, 17','12341','nocera','salerno');
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
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utenti`
--

LOCK TABLES `utenti` WRITE;
/*!40000 ALTER TABLE `utenti` DISABLE KEYS */;
INSERT INTO `utenti` VALUES (1,'gabriele','gabriele.cicalese2004@gmail.com','1234'),(2,'admin','admin@lacantina.it','1234'),(3,'FarbizioGrazioso','fabrizio.grazioso@gmail.com','1234');
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

-- Dump completed on 2026-01-10 21:36:53
