CREATE DATABASE  IF NOT EXISTS `spotifydbms` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `spotifydbms`;
-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: spotifydbms
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `tracks`
--

DROP TABLE IF EXISTS `tracks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tracks` (
  `TrackID` bigint NOT NULL,
  `Title` varchar(255) NOT NULL,
  `Album_ID` bigint DEFAULT NULL,
  `Duration` time DEFAULT NULL,
  `Popularity` int DEFAULT NULL,
  `PlayCount` int DEFAULT NULL,
  PRIMARY KEY (`TrackID`),
  KEY `fk_album_track` (`Album_ID`),
  CONSTRAINT `fk_album_track` FOREIGN KEY (`Album_ID`) REFERENCES `albums` (`Album_ID`) ON DELETE CASCADE,
  CONSTRAINT `tracks_ibfk_1` FOREIGN KEY (`Album_ID`) REFERENCES `albums` (`Album_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tracks`
--

LOCK TABLES `tracks` WRITE;
/*!40000 ALTER TABLE `tracks` DISABLE KEYS */;
INSERT INTO `tracks` VALUES (3,'Bad Guy',2,'00:03:14',85,1200000),(4,'Happier Than Ever',2,'00:04:58',92,1100000),(6,'Shape of You',4,'00:03:53',98,1800000),(7,'Circles',5,'00:03:35',88,900000),(8,'God\'s Plan',6,'00:03:18',93,1500000),(9,'Hello',7,'00:04:55',96,1300000),(10,'Dynamite',8,'00:03:19',97,2000000),(11,'Montero (Call Me By Your Name)',11,'00:02:17',98,2500000),(12,'Work',12,'00:03:39',90,1200000),(13,'Sorry',13,'00:03:20',87,1800000),(14,'Stay',14,'00:02:50',85,1500000),(15,'Blinding Lights',15,'00:03:20',96,2400000),(16,'Watermelon Sugar',16,'00:03:07',94,2000000),(17,'Good 4 U',17,'00:02:58',92,1800000),(18,'Levitating',18,'00:03:23',89,1750000),(19,'Peaches',19,'00:03:18',87,1600000),(20,'Kiss Me More',20,'00:03:29',90,1500000),(21,'Leave The Door Open',21,'00:04:02',96,2400000),(22,'Save Your Tears',22,'00:03:36',91,2000000),(23,'Dynamite',23,'00:03:19',88,1750000),(26,'Dance Monkey',26,'00:03:29',97,2200000),(27,'Old Town Road',27,'00:02:37',90,2100000),(28,'Circles',28,'00:03:35',85,1800000),(29,'Bad Guy',29,'00:03:14',93,2000000),(30,'Happier',30,'00:02:55',86,1700000),(31,'Heartless',31,'00:03:19',89,1750000),(32,'Shivers',32,'00:03:27',92,1600000),(33,'Roses',33,'00:03:12',90,1400000),(35,'Falling',35,'00:03:10',88,1500000),(36,'Sucker',36,'00:03:01',91,1650000),(37,'Truth Hurts',37,'00:02:55',85,1300000),(38,'One Kiss',38,'00:03:32',86,1400000),(39,'In Your Eyes',39,'00:03:56',90,1750000),(40,'Stay With Me',40,'00:02:53',87,1550000),(41,'Hotline Bling',41,'00:03:40',89,1650000),(42,'Somebody That I Used To Know',42,'00:03:05',90,1500000),(43,'Say So',43,'00:03:23',92,1400000),(44,'Wrecking Ball',44,'00:03:41',93,1700000),(45,'Rolling In The Deep',45,'00:03:48',95,1900000),(46,'Firework',46,'00:03:48',91,1800000),(47,'Chasing Cars',47,'00:04:27',88,1600000),(48,'Bleeding Love',48,'00:03:58',89,1700000),(49,'Someone Like You',49,'00:04:45',92,2100000),(50,'Thinking Out Loud',50,'00:04:41',90,2500000),(51,'Stay',51,'00:04:01',94,1400000),(52,'Perfect',52,'00:04:23',97,2300000),(53,'Lose You To Love Me',53,'00:03:26',91,1600000),(54,'Let Me Love You',54,'00:03:23',90,1500000),(55,'Closer',55,'00:04:04',89,1750000),(56,'Despacito',56,'00:03:47',98,2800000),(57,'Shape Of You',57,'00:03:53',96,2400000),(58,'The Box',58,'00:03:17',85,1600000),(59,'Bailando',59,'00:04:03',91,1800000),(60,'Halo',60,'00:04:21',92,2100000),(62,'Beautiful',62,'00:03:39',90,1350000),(63,'Love Me Like You Do',63,'00:04:10',95,1650000),(64,'Into You',64,'00:03:34',88,1500000),(65,'Only Girl (In The World)',65,'00:03:54',90,1400000),(66,'Complicated',66,'00:04:03',87,1300000),(67,'Oops!... I Did It Again',67,'00:03:30',89,1450000),(68,'Toxic',68,'00:03:29',92,1500000),(69,'Umbrella',69,'00:04:35',94,1600000),(70,'Bad Romance',70,'00:04:55',90,1700000),(71,'Shape Of You',71,'00:03:53',95,2000000),(72,'Say You Won?t Let Go',72,'00:03:31',87,1350000),(73,'Bubbly',73,'00:03:23',92,1450000),(74,'I Will Always Love You',74,'00:04:31',91,1550000),(75,'Vision of Love',75,'00:03:35',90,1400000),(76,'Creep',76,'00:03:56',89,1450000),(77,'Zombie',77,'00:03:31',92,1600000),(78,'Bitter Sweet Symphony',78,'00:05:58',90,1750000),(79,'Take Me to Church',79,'00:04:02',91,1800000),(80,'Wonderwall',80,'00:04:18',92,2000000),(81,'Mr. Brightside',81,'00:03:42',88,1550000),(82,'We Belong Together',82,'00:03:23',90,1600000),(83,'Bad Liar',83,'00:03:32',92,1450000),(84,'The Scientist',84,'00:05:09',89,1500000),(85,'If I Ain?t Got You',85,'00:03:45',91,1550000),(86,'I Want It That Way',86,'00:03:33',90,1600000),(87,'With Or Without You',87,'00:04:55',92,1750000),(88,'Somebody to Love',88,'00:04:55',88,1450000),(89,'Take A Bow',89,'00:03:45',91,1550000),(90,'Umbrella',90,'00:04:35',90,1700000),(91,'Halo',91,'00:04:21',92,2100000),(92,'My Heart Will Go On',92,'00:04:40',94,1800000),(93,'I Will Always Love You',93,'00:04:30',95,2000000),(94,'Rolling In The Deep',94,'00:03:48',88,1600000),(95,'Someone Like You',95,'00:04:45',87,1500000),(96,'Chasing Cars',96,'00:04:27',89,1750000),(97,'Bleeding Love',97,'00:03:58',90,1600000),(98,'Shape Of You',98,'00:03:53',92,2400000),(99,'Thank U, Next',99,'00:03:28',94,1800000),(100,'All of Me',100,'00:04:30',92,2200000),(101,'Shallow',101,'00:03:37',95,2000000),(102,'Perfect',102,'00:04:23',91,1900000),(103,'Falling',103,'00:03:10',93,1600000),(104,'Lose Control',104,'00:03:10',89,1500000),(105,'The Greatest',105,'00:03:19',92,1450000),(106,'Dance Monkey',106,'00:03:29',90,2000000),(107,'Beautiful People',107,'00:03:31',88,1550000),(108,'Eastside',108,'00:03:00',87,1400000),(109,'Without Me',109,'00:03:22',90,1500000),(110,'Let Me Down Slowly',110,'00:03:11',92,1600000),(111,'Ocean Eyes',111,'00:03:20',91,1400000),(112,'You Are The Reason',112,'00:03:24',90,1350000),(113,'Beautiful',113,'00:03:39',89,1300000),(114,'Say Something',114,'00:03:50',92,1450000),(115,'Take Me Home',115,'00:03:27',90,1550000),(116,'Here Without You',116,'00:03:56',91,1600000),(117,'Bleeding Love',117,'00:03:58',88,1700000),(118,'I Don?t Wanna Live Forever',118,'00:04:12',93,1600000),(119,'Love Me Like You Do',119,'00:04:10',94,1700000),(120,'Tears Dry On Their Own',120,'00:03:05',91,1400000),(121,'Since U Been Gone',121,'00:03:08',89,1350000),(122,'Chasing Cars',122,'00:04:27',92,2000000),(123,'Somebody That I Used To Know',123,'00:03:05',90,1500000),(124,'Someone You Loved',124,'00:03:02',87,1300000),(125,'One Call Away',125,'00:03:17',92,1400000),(126,'Only Girl (In The World)',126,'00:03:54',90,1500000),(127,'Dance Monkey',127,'00:03:29',95,2000000),(128,'Ride It',128,'00:03:16',89,1350000),(129,'Unstoppable',129,'00:03:02',90,1450000),(130,'Wake Me Up',130,'00:04:07',94,1600000),(131,'I?m Not The Only One',131,'00:03:22',91,1550000),(132,'Rise Up',132,'00:04:10',88,1450000),(133,'Rude',133,'00:03:44',87,1500000),(134,'Take Me to Church',134,'00:04:02',90,1650000),(135,'Never Enough',135,'00:03:25',92,1400000),(136,'What Makes You Beautiful',136,'00:03:18',89,1550000),(137,'Do I Make You Proud',137,'00:03:39',90,1800000),(138,'If I Ain?t Got You',138,'00:03:45',94,1750000),(139,'Too Good At Goodbyes',139,'00:03:21',93,1600000),(140,'I Will Survive',140,'00:03:16',91,1350000),(141,'Someone You Loved',141,'00:03:02',89,1400000),(142,'Thank U, Next',142,'00:03:28',88,1500000),(143,'Shallow',143,'00:03:37',90,2200000),(144,'Take Me to Church',144,'00:04:02',92,2000000),(145,'Firework',145,'00:03:48',93,2100000),(146,'Bad Romance',146,'00:04:55',88,1600000),(147,'Tears Dry On Their Own',147,'00:03:05',91,1400000),(148,'Bleeding Love',148,'00:03:58',90,1600000),(149,'One Call Away',149,'00:03:17',89,1350000),(150,'With Or Without You',150,'00:04:55',91,1700000),(151,'Lose Control',151,'00:03:10',92,1450000),(152,'Ocean Eyes',152,'00:03:20',93,1300000),(153,'Love Me Like You Do',153,'00:04:10',94,1600000),(154,'Bleeding Love',154,'00:03:58',90,1450000),(155,'Someone You Loved',155,'00:03:02',88,1400000),(156,'Halo',156,'00:04:21',92,2200000),(157,'Dance Monkey',157,'00:03:29',93,1750000),(158,'If I Ain?t Got You',158,'00:03:45',94,1800000),(159,'Stay',159,'00:04:01',91,1600000),(160,'Someone Like You',160,'00:04:45',90,1500000),(161,'Shape Of You',161,'00:03:53',92,2400000),(162,'Rolling In The Deep',162,'00:03:48',88,1600000),(163,'Bad Romance',163,'00:04:55',89,1500000),(164,'Halo',164,'00:04:21',91,2100000),(165,'Dance Monkey',165,'00:03:29',92,2000000),(166,'Someone You Loved',166,'00:03:02',90,1450000),(167,'Ocean Eyes',167,'00:03:20',94,1700000),(168,'Take Me to Church',168,'00:04:02',93,1600000),(169,'Chasing Cars',169,'00:04:27',88,1500000),(170,'Bleeding Love',170,'00:03:58',91,1400000),(171,'Say So',171,'00:03:23',89,1600000),(172,'Watermelon Sugar',172,'00:03:07',92,2200000),(173,'Perfect',173,'00:04:23',90,2000000),(174,'Someone You Loved',174,'00:03:02',88,1350000),(175,'Firework',175,'00:03:48',91,1800000),(176,'Dance Monkey',176,'00:03:29',92,1500000),(177,'Adore You',177,'00:03:27',90,1400000),(178,'Closer',178,'00:04:04',94,2100000),(179,'Stay',179,'00:04:01',91,1600000),(180,'Only Girl (In The World)',180,'00:03:54',93,1750000),(181,'Umbrella',181,'00:04:35',90,2000000),(182,'Dynamite',182,'00:03:19',92,1800000),(183,'Shape Of You',183,'00:03:53',88,1450000),(184,'Someone You Loved',184,'00:03:02',90,1350000),(185,'Watermelon Sugar',185,'00:03:07',94,1700000),(186,'Shivers',186,'00:03:27',91,1600000),(187,'Stay',187,'00:04:01',90,2000000),(188,'One Call Away',188,'00:03:17',89,1500000),(189,'Someone You Loved',189,'00:03:02',92,1400000),(190,'Shallow',190,'00:03:37',91,1700000),(191,'Happier',191,'00:02:55',89,1600000),(192,'Lose You To Love Me',192,'00:03:26',92,1500000),(193,'Perfect',193,'00:04:23',90,1800000),(194,'Someone You Loved',194,'00:03:02',88,1350000),(197,'Chasing Cars',197,'00:04:27',90,1600000),(198,'Bleeding Love',198,'00:03:58',88,1400000),(199,'Take Me to Church',199,'00:04:02',94,1700000),(200,'Someone You Loved',200,'00:03:02',91,1500000),(202,'Out of the blue',201,'03:23:00',55,6000),(206,'LOVE WAYY',55,'00:03:26',100,56),(300,'nobody',3,'03:25:00',99,500),(1000,'hard core',1000,'00:03:35',100,100),(1234,'Bewaja',5000,'05:35:00',77,45);
/*!40000 ALTER TABLE `tracks` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-22  9:11:22
