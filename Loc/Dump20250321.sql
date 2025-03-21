-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: laptopstore
-- ------------------------------------------------------
-- Server version	9.1.0

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
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `account_status` bigint DEFAULT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `type` bigint DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `uname` varchar(255) DEFAULT NULL,
  `gender` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKhjajpobu6qimp3kr3dtl1egmo` (`uname`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (1,1,1,'ditran.120804@gmail.com',NULL,'Tran Mai Di','123','0123456789','di',_binary ''),(1,16,1,'hiholap884@barodis.com',NULL,'vieet','123',NULL,'hiholap884',_binary '');
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bill_details`
--

DROP TABLE IF EXISTS `bill_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill_details` (
  `bill_id` bigint NOT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `product_id` bigint NOT NULL,
  `quantity` bigint NOT NULL,
  `total` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKfwm4sko9p82ndh6belyxx12bj` (`bill_id`),
  KEY `FK4iagdr0uhsq4tj0ag99nmmya1` (`product_id`),
  CONSTRAINT `FK4iagdr0uhsq4tj0ag99nmmya1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `FKfwm4sko9p82ndh6belyxx12bj` FOREIGN KEY (`bill_id`) REFERENCES `bills` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill_details`
--

LOCK TABLES `bill_details` WRITE;
/*!40000 ALTER TABLE `bill_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `bill_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bills`
--

DROP TABLE IF EXISTS `bills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bills` (
  `account_id` bigint NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `status` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKo4nukfu6ckab62do87t4wyops` (`account_id`),
  CONSTRAINT `FKo4nukfu6ckab62do87t4wyops` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bills`
--

LOCK TABLES `bills` WRITE;
/*!40000 ALTER TABLE `bills` DISABLE KEYS */;
/*!40000 ALTER TABLE `bills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `image_url` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKt8o6pivur7nn124jehx7cygw5` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'p84f4e7bf-153e-4f3e-864b-60a2bcf08007.jpg','Beef'),(2,'p57e073b2-9ec4-4bb6-80ab-b0665601f6d8.jpg','Chicken'),(3,'pd75742b3-b4e1-4866-83d7-ca764bbb2b1c.png','Dessert'),(4,'pbafed474-2130-4827-980a-da2afb99dc77.jpg','beverage'),(5,'pd4b52ca5-6e14-42b2-9b9a-e6ff1f539238.jpg','food');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `otp_token`
--

DROP TABLE IF EXISTS `otp_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `otp_token` (
  `is_verified` bit(1) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `expires_at` datetime(6) DEFAULT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `id_account` bigint DEFAULT NULL,
  `type` bigint DEFAULT NULL,
  `otp_code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `otp_token`
--

LOCK TABLES `otp_token` WRITE;
/*!40000 ALTER TABLE `otp_token` DISABLE KEYS */;
INSERT INTO `otp_token` VALUES (_binary '\0','2025-03-21 08:13:56.934000','2025-03-21 08:23:56.934000',1,1,1,'32484'),(_binary '\0','2025-03-21 12:42:32.540000','2025-03-21 12:52:32.540000',2,15,1,'99760'),(_binary '\0','2025-03-21 12:46:08.433000','2025-03-21 12:56:08.433000',3,16,1,'86483');
/*!40000 ALTER TABLE `otp_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `status` smallint NOT NULL DEFAULT '1',
  `category_id` bigint DEFAULT NULL,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `price` bigint DEFAULT NULL,
  `sold_count` bigint DEFAULT NULL,
  `stock_count` bigint DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `product_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKog2rp4qthbtt2lfyhfo32lsw9` (`category_id`),
  CONSTRAINT `FKog2rp4qthbtt2lfyhfo32lsw9` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,5,'2025-03-21 01:20:06',1,30000,0,1,'pfb30ba13-bf94-4f73-be3f-53644c21f982.jpg','pho'),(1,5,'2025-03-21 01:21:12',2,35000,0,1,'p562102d6-8917-459b-b416-e46ce061c7c6.jpg','bun cha'),(1,5,'2025-03-21 01:22:00',3,20000,0,1,'p8d5b087c-5181-4a0b-9bfc-9a68551141ec.jpg','banh mi'),(1,4,'2025-03-21 01:23:04',4,20000,0,1,'pac53b158-99c2-4970-bd8d-32044cee3964.jpg','bia'),(1,2,'2025-03-21 01:29:17',5,35000,0,1,'p1b2383a2-9ad7-45d7-a8d6-d068a99b5fb2.jpg','ga ran'),(1,2,'2025-03-21 01:29:43',6,160000,0,60,'p39baf55c-c476-4d5e-b586-05b7c97e14bf.jpg','Air fryer roast chicken'),(1,2,'2025-03-21 01:30:09',7,50000,0,1,'pc80c6687-ca2e-4a37-9464-da892c0392d7.jpg','ga kho xa'),(1,1,'2025-03-21 01:30:36',8,160000,0,60,'p10675b72-e3e6-4e6c-8cdf-b9495d5906a5.jpg','Best Beef Steak'),(1,4,'2025-03-21 01:31:00',9,15000,0,1,'p434bea24-0073-4af9-beaa-5a11c15fcce8.jpg','333'),(1,1,'2025-03-21 01:31:17',10,160000,0,60,'p2f5d0099-f8d4-4b8d-acd7-c5df2f8dc1d7.jpg',' Beef Steak áp chảo bơ tỏi'),(1,1,'2025-03-21 01:31:55',11,160000,0,60,'p6e588493-46f7-447b-b21e-f07a7ecef626.jpg','Sirloin Steak'),(1,3,'2025-03-21 01:32:05',12,5000,0,1,'p8567feff-7192-48bc-b7b8-605706182f4c.jpg','banh plan'),(1,1,'2025-03-21 01:32:38',13,1600,0,52,'p05848088-9bf4-473d-b076-bab9152d81f6.jpg','Beef steaks with warm'),(1,3,'2025-03-21 01:32:58',14,15000,0,1,'pe0bd7bed-ffdb-4880-b072-b62249db670f.jpg','kem socola'),(1,3,'2025-03-21 01:34:31',15,26000,0,52,'pa7305fcd-d2cb-44d4-aa0e-ad7fb10bbeeb.jpg','Summer family desserts'),(1,3,'2025-03-21 01:34:51',16,5000,0,1,'pca4e96fe-e100-4c46-8ccd-aa9eca51a262.jpg','keo'),(1,3,'2025-03-21 01:35:36',17,12000,0,1000,'p737b2ca8-11cf-4b05-99e9-240cd60ffc9b.jpg','Chocolate and Berries Yogurt'),(1,4,'2025-03-21 01:35:39',18,5000,0,1,'p46517ef1-d503-48d4-939a-7a1653008c24.jpg','heineken'),(1,4,'2025-03-21 01:36:14',19,5000,0,1,'pf71af738-2680-40f2-8985-3ebb36e0a89a.jpg','coca'),(1,5,'2025-03-21 01:36:27',20,12000,0,1000,'p48b09a2f-0c2e-44bc-bb6d-a03a7fcdfd09.jpg','Cơm chiên gà xé thập cẩm'),(1,4,'2025-03-21 01:36:55',21,5000,0,1,'p029b6459-ea5b-4c62-bf9c-174264169195.jpg','pepsi');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-21 13:33:29
