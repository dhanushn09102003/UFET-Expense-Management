-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: unified_family
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `alert`
--

DROP TABLE IF EXISTS `alert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alert` (
  `alert_id` int NOT NULL AUTO_INCREMENT,
  `budget_id` int DEFAULT NULL,
  `alert_type` enum('Warning','Critical') COLLATE utf8mb4_general_ci DEFAULT NULL,
  `alert_message` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `alert_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `is_resolved` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`alert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alert`
--

LOCK TABLES `alert` WRITE;
/*!40000 ALTER TABLE `alert` DISABLE KEYS */;
/*!40000 ALTER TABLE `alert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `budgets`
--

DROP TABLE IF EXISTS `budgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `budgets` (
  `budget_id` int NOT NULL AUTO_INCREMENT,
  `category_id` int NOT NULL,
  `user_id` int NOT NULL,
  `limit` decimal(10,2) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`budget_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `budgets`
--

LOCK TABLES `budgets` WRITE;
/*!40000 ALTER TABLE `budgets` DISABLE KEYS */;
INSERT INTO `budgets` VALUES (1,1,1,5000.00,'2024-12-01','2025-01-01'),(2,2,2,6000.00,'2024-12-07','2025-01-08'),(3,2,2,5000.00,'2024-12-13','2024-12-28'),(4,3,3,900.00,'2024-12-12','2024-12-13'),(5,4,2,6000.00,'2024-12-01','2024-12-26'),(6,1,1,8000.00,'2024-12-17','2024-12-21'),(7,3,1,80000.00,'2024-12-01','2024-12-28'),(8,1,1,789.00,'2024-12-20','2024-12-28'),(9,1,1,45.00,'2024-12-27','2024-12-28'),(10,3,3,78.00,'2024-12-13','2024-12-25'),(11,3,4,45000.00,'2024-12-20','2024-12-21'),(12,1,1,67.00,'2024-12-19','2024-12-26'),(13,3,3,6000.00,'2024-12-25','2024-12-27'),(16,1,1,10000.00,'2024-12-02','2024-12-25');
/*!40000 ALTER TABLE `budgets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) NOT NULL,
  `description` text,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Food','Expenses spent on food'),(2,'Travel','Amount spent on Travel and Exploration'),(3,'Grocery','Grocery Expenses'),(4,'Stationary','Stationary Expenses');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dataqo`
--

DROP TABLE IF EXISTS `dataqo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dataqo` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `phone_number` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `role` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dataqo`
--

LOCK TABLES `dataqo` WRITE;
/*!40000 ALTER TABLE `dataqo` DISABLE KEYS */;
INSERT INTO `dataqo` VALUES (1,'swati','ss@gmail.com','swati@123','8978675645','admin',''),(2,'praneeta','pra@gmail.com','scrypt:32768:8:1$FHF04FPD7oPxtp9u$8d5db649e19c3b1edaef7c0656d09078224455d6de21821a69453c0f5ab2b555636b12bdf7a3387bdabadeef5237611f00ad77bfef56adf5ab9e92052be4547a','8978675645','admin','');
/*!40000 ALTER TABLE `dataqo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses`
--

DROP TABLE IF EXISTS `expenses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expenses` (
  `ExpenseID` int NOT NULL AUTO_INCREMENT,
  `UserID` int NOT NULL,
  `categoryid` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `amount` int NOT NULL,
  `expensedate` date NOT NULL,
  `expensedesc` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `receiptpath` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `expensetime` time NOT NULL,
  PRIMARY KEY (`ExpenseID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses`
--

LOCK TABLES `expenses` WRITE;
/*!40000 ALTER TABLE `expenses` DISABLE KEYS */;
INSERT INTO `expenses` VALUES (3,1001,'food',5000,'2024-12-20','For food','C:\\\\swati','03:00:00'),(4,2,'education',50000,'2024-12-18','for education','C:\\\\swati','11:55:00'),(5,1,'groceries',700,'2024-12-19','for groceries','C:\\\\swati','08:05:00'),(6,1,'education',3000,'2024-12-17','for education','C:\\\\swati','00:29:00'),(7,2,'food',560,'2024-12-25','For food','C:\\\\swati','00:58:00'),(8,1001,'2',1200,'2024-12-26','Trip with frnds','Recipt_uploads\\Screenshot 2024-12-25 121501.png','10:00:00'),(9,1001,'3',200,'2024-12-26','Weekly groceries','Recipt_uploads\\Screenshot 2024-12-25 121501.png','11:00:00'),(10,1001,'2',1000,'2024-12-27','Hometown','No file uploaded','13:00:00');
/*!40000 ALTER TABLE `expenses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `savings_goals`
--

DROP TABLE IF EXISTS `savings_goals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `savings_goals` (
  `Goal_id` int NOT NULL AUTO_INCREMENT,
  `Target_amount` decimal(10,2) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `Goal_status` enum('On-going','Completed','Cancelled') COLLATE utf8mb4_general_ci DEFAULT 'On-going',
  `Goal_description` text COLLATE utf8mb4_general_ci,
  `Achieved_amount` decimal(10,2) DEFAULT NULL,
  `Goal_type` enum('Personal','Family') COLLATE utf8mb4_general_ci DEFAULT 'Personal',
  `User_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `family_head_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`Goal_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `savings_goals`
--

LOCK TABLES `savings_goals` WRITE;
/*!40000 ALTER TABLE `savings_goals` DISABLE KEYS */;
INSERT INTO `savings_goals` VALUES (2,6000.00,'2024-12-21','2024-12-23','On-going','total to be 6000',1000.00,'Personal','1','1'),(3,7000.00,'2024-12-27','2024-12-28','Completed','total to be 7000',7000.00,'Family','1','1'),(4,7000.00,'2024-12-27','2024-12-28','Completed','total to be 7000',7000.00,'Family',NULL,NULL),(5,7000.00,'2024-12-19','2024-12-27','On-going','total to be 7000',6000.00,'Personal',NULL,NULL),(6,7000.00,'2024-12-19','2024-12-27','On-going','total to be 7000',6000.00,'Personal',NULL,NULL),(7,7000.00,'2024-12-19','2024-12-27','On-going','total to be 7000',6000.00,'Personal',NULL,NULL),(8,90.00,'2024-12-23','2024-12-25','On-going','total to be 90',10.00,'Personal','1','1'),(9,90.00,'2024-12-24','2024-12-25','On-going','total to be 90',60.00,'Personal','1','1'),(10,8000.00,'2024-12-24','2024-12-25','On-going','total to be 8000',7500.00,'Personal','1','1');
/*!40000 ALTER TABLE `savings_goals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `User_id` int NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `user_password` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `family_head_id` int NOT NULL,
  PRIMARY KEY (`User_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'swati','swati@123',1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `role` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT (now()),
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Test','test@gmail.com','scrypt:32768:8:1$LsLYxJGsVFooyLfF$8af76a85768bbf250649196fab8fd1a7a888e35b3e450755d4db1e7e4f7adae020cfc4b81b01d5ccd50b36c24ad73596b300afcadbcc5fb196923ae127adfef6','12345678','users','2024-12-27 11:56:05');
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

-- Dump completed on 2024-12-27 18:36:04
