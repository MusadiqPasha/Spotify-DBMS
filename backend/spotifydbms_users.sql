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
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `User_ID` int NOT NULL AUTO_INCREMENT,
  `User_Name` varchar(255) NOT NULL,
  `DOB` date NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  PRIMARY KEY (`User_ID`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'john_doe','1990-05-15','john.doe@example.com','password123'),(2,'jane_smith','1992-11-20','jane.smith@example.com','janesmith1'),(3,'michael_j','1985-07-12','michael.j@example.com','michaelpass'),(4,'emily_r','1993-01-18','emily.r@example.com','emilyrocks'),(5,'alex_k','1995-09-10','alex.k@example.com','alexking1'),(6,'sarah_l','1987-12-25','sarah.l@example.com','sarahtunes'),(7,'matt_b','1991-03-14','matt.b@example.com','mattbeats'),(8,'linda_g','1989-08-05','linda.g@example.com','lindagrove'),(9,'peter_m','1990-02-17','peter.m@example.com','petertrack'),(10,'kate_w','1994-04-22','kate.w@example.com','katewaves'),(12,'musadiq','2024-10-14','kmusadiqpasha@gmail.com','1234'),(13,'goku','2024-10-03','gg@gmail.com','1234'),(15,'admin','2024-10-02','kmus@gmail.com','admin1234'),(16,'ppp','2024-11-21','pp567@example.com','123'),(17,'taj','2024-11-05','taj@mumbai.com','789'),(18,'ayu','2024-11-11','ayu@gmail.com','123'),(24,'ayu','2024-11-10','aysu@gmail.com','123'),(26,'ayus','2024-11-10','aysau@gmail.com','123'),(27,'ayus','2024-11-10','aysasu@gmail.com','123'),(29,'sdfds','2024-11-11','kmusadiqpassha@gmail.com','147'),(30,'sdfds','2024-11-11','kmusadiqpasssha@gmail.com','147'),(31,'sdfds','2024-11-11','kmusadiqpasssssha@gmail.com','147'),(33,'adminasff','2024-11-11','kmusadisdgvfqpasha@gmail.com','147');
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

-- Dump completed on 2024-11-22  9:11:22
