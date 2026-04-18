-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: child_nutrition
-- ------------------------------------------------------
-- Server version	8.0.45

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
-- Table structure for table `admin_otps`
--

DROP TABLE IF EXISTS `admin_otps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_otps` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `otp` varchar(6) NOT NULL,
  `expires_at` datetime NOT NULL,
  `attempts` int DEFAULT '0',
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_expire` (`user_id`,`expires_at`),
  CONSTRAINT `admin_otps_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_otps`
--

LOCK TABLES `admin_otps` WRITE;
/*!40000 ALTER TABLE `admin_otps` DISABLE KEYS */;
INSERT INTO `admin_otps` VALUES (1,3,'597458','2026-03-14 09:09:56',0,'127.0.0.1','2026-03-14 03:34:56'),(2,3,'638839','2026-03-14 09:55:50',1,'127.0.0.1','2026-03-14 04:20:49'),(3,8,'920117','2026-03-14 09:59:52',0,'127.0.0.1','2026-03-14 04:24:51'),(4,8,'804538','2026-03-14 10:19:04',1,'127.0.0.1','2026-03-14 04:44:03'),(5,8,'982545','2026-03-17 06:44:33',0,'127.0.0.1','2026-03-17 01:09:32'),(6,3,'141317','2026-03-17 11:27:39',0,'127.0.0.1','2026-03-17 05:52:38'),(7,3,'822091','2026-03-18 09:12:29',0,'127.0.0.1','2026-03-18 03:37:28'),(15,10,'652977','2026-04-02 11:53:43',0,'127.0.0.1','2026-04-02 06:18:43');
/*!40000 ALTER TABLE `admin_otps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alerts`
--

DROP TABLE IF EXISTS `alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alerts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `child_id` int NOT NULL,
  `alert_type` enum('malnutrition_risk','follow_up_due','weight_loss','no_improvement','referral_required','appointment_reminder','system') NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text,
  `priority` enum('low','medium','high','critical') DEFAULT 'medium',
  `is_read` tinyint(1) DEFAULT '0',
  `is_resolved` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `resolved_at` timestamp NULL DEFAULT NULL,
  `assigned_to` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `child_id` (`child_id`),
  KEY `assigned_to` (`assigned_to`),
  CONSTRAINT `alerts_ibfk_1` FOREIGN KEY (`child_id`) REFERENCES `children` (`id`) ON DELETE CASCADE,
  CONSTRAINT `alerts_ibfk_2` FOREIGN KEY (`assigned_to`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alerts`
--

LOCK TABLES `alerts` WRITE;
/*!40000 ALTER TABLE `alerts` DISABLE KEYS */;
/*!40000 ALTER TABLE `alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `child_id` int NOT NULL,
  `appointment_date` datetime NOT NULL,
  `appointment_type` enum('checkup','follow_up','vaccination','assessment','counseling','other') NOT NULL,
  `location` varchar(200) DEFAULT NULL,
  `notes` text,
  `status` enum('scheduled','completed','cancelled','no_show') DEFAULT 'scheduled',
  `created_by` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `child_id` (`child_id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`child_id`) REFERENCES `children` (`id`) ON DELETE CASCADE,
  CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointments`
--

LOCK TABLES `appointments` WRITE;
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
/*!40000 ALTER TABLE `appointments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `children`
--

DROP TABLE IF EXISTS `children`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `children` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parent_id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `sex` tinyint(1) NOT NULL,
  `birth_weight` decimal(5,2) DEFAULT NULL,
  `birth_height` decimal(5,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `age` decimal(5,2) NOT NULL,
  `weight` decimal(5,2) NOT NULL,
  `height` decimal(5,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_children_parent` (`parent_id`),
  CONSTRAINT `children_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `children`
--

LOCK TABLES `children` WRITE;
/*!40000 ALTER TABLE `children` DISABLE KEYS */;
INSERT INTO `children` VALUES (54,49,'Anjali',NULL,0,NULL,NULL,'2026-04-02 06:28:26','2026-04-02 06:28:26',4.50,16.20,98.50),(55,49,'Ravi',NULL,1,NULL,NULL,'2026-04-02 06:28:26','2026-04-02 06:28:26',6.20,22.10,115.00),(56,50,'Priyanka',NULL,0,NULL,NULL,'2026-04-02 06:28:26','2026-04-02 06:28:26',3.80,14.00,92.00),(57,50,'Amit',NULL,1,NULL,NULL,'2026-04-02 06:28:26','2026-04-02 06:28:26',8.00,28.50,128.00),(58,51,'Sita',NULL,0,NULL,NULL,'2026-04-02 06:28:26','2026-04-02 06:28:26',5.50,18.50,105.00),(59,51,'Karan',NULL,1,NULL,NULL,'2026-04-02 06:28:26','2026-04-02 06:28:26',7.20,25.00,122.00),(60,53,'Thiru',NULL,1,NULL,NULL,'2026-04-02 08:25:20','2026-04-02 08:25:20',12.00,25.00,110.00),(61,49,'Jagashree',NULL,0,NULL,NULL,'2026-04-02 08:27:06','2026-04-02 08:27:06',4.50,16.20,98.50),(62,51,'Gayathri',NULL,0,NULL,NULL,'2026-04-02 09:06:00','2026-04-02 09:06:00',10.00,20.00,110.00),(63,54,'SaiAswanth',NULL,1,NULL,NULL,'2026-04-08 08:43:57','2026-04-08 08:43:57',6.00,20.00,130.00);
/*!40000 ALTER TABLE `children` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `follow_ups`
--

DROP TABLE IF EXISTS `follow_ups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `follow_ups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `monitoring_plan_id` int DEFAULT NULL,
  `child_id` int NOT NULL,
  `scheduled_date` date NOT NULL,
  `completed_date` date DEFAULT NULL,
  `weight` decimal(5,2) DEFAULT NULL,
  `height` decimal(5,2) DEFAULT NULL,
  `notes` text,
  `conducted_by` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `monitoring_plan_id` (`monitoring_plan_id`),
  KEY `child_id` (`child_id`),
  KEY `conducted_by` (`conducted_by`),
  CONSTRAINT `follow_ups_ibfk_1` FOREIGN KEY (`monitoring_plan_id`) REFERENCES `monitoring_plans` (`id`) ON DELETE SET NULL,
  CONSTRAINT `follow_ups_ibfk_2` FOREIGN KEY (`child_id`) REFERENCES `children` (`id`) ON DELETE CASCADE,
  CONSTRAINT `follow_ups_ibfk_3` FOREIGN KEY (`conducted_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follow_ups`
--

LOCK TABLES `follow_ups` WRITE;
/*!40000 ALTER TABLE `follow_ups` DISABLE KEYS */;
/*!40000 ALTER TABLE `follow_ups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `health_records`
--

DROP TABLE IF EXISTS `health_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `health_records` (
  `id` int NOT NULL AUTO_INCREMENT,
  `child_id` int NOT NULL,
  `recorded_by` int NOT NULL,
  `sex` enum('0','1') NOT NULL,
  `age` decimal(5,2) NOT NULL,
  `weight` decimal(5,2) NOT NULL,
  `height` decimal(5,2) NOT NULL,
  `status` varchar(50) NOT NULL,
  `advice` text,
  `recorded_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `child_id` (`child_id`),
  KEY `recorded_by` (`recorded_by`),
  CONSTRAINT `health_records_ibfk_1` FOREIGN KEY (`child_id`) REFERENCES `children` (`id`) ON DELETE CASCADE,
  CONSTRAINT `health_records_ibfk_2` FOREIGN KEY (`recorded_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `health_records`
--

LOCK TABLES `health_records` WRITE;
/*!40000 ALTER TABLE `health_records` DISABLE KEYS */;
INSERT INTO `health_records` VALUES (22,60,53,'0',12.00,25.00,110.00,'Normal','Maintain balanced diet.','2026-04-02 08:25:31'),(23,54,52,'0',4.50,16.20,98.50,'Underweight','Increase protein-rich foods.','2026-04-02 08:26:31'),(24,56,52,'0',3.80,14.00,92.00,'Normal','Maintain balanced diet.','2026-04-02 08:27:28'),(25,58,52,'1',5.50,18.50,105.00,'Normal','Maintain balanced diet.','2026-04-02 08:29:25'),(26,62,52,'0',10.00,20.00,110.00,'Normal','Maintain balanced diet.','2026-04-02 09:06:24'),(27,60,53,'0',12.00,25.00,110.00,'Normal','Maintain balanced diet.','2026-04-02 09:07:13'),(28,63,54,'0',6.00,20.00,130.00,'Normal','Maintain balanced diet.','2026-04-08 08:44:04');
/*!40000 ALTER TABLE `health_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interventions`
--

DROP TABLE IF EXISTS `interventions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `interventions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `child_id` int NOT NULL,
  `intervention_type` enum('nutritional_counseling','supplementary_feeding','micronutrient_supplement','deworming','referral','other') NOT NULL,
  `description` text,
  `status` enum('prescribed','ongoing','completed','defaulted') DEFAULT 'prescribed',
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `prescribed_by` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `child_id` (`child_id`),
  KEY `prescribed_by` (`prescribed_by`),
  CONSTRAINT `interventions_ibfk_1` FOREIGN KEY (`child_id`) REFERENCES `children` (`id`) ON DELETE CASCADE,
  CONSTRAINT `interventions_ibfk_2` FOREIGN KEY (`prescribed_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interventions`
--

LOCK TABLES `interventions` WRITE;
/*!40000 ALTER TABLE `interventions` DISABLE KEYS */;
/*!40000 ALTER TABLE `interventions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `malnutrition_cases`
--

DROP TABLE IF EXISTS `malnutrition_cases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `malnutrition_cases` (
  `id` int NOT NULL AUTO_INCREMENT,
  `child_id` int NOT NULL,
  `record_id` int NOT NULL,
  `malnutrition_type` enum('underweight','stunting','wasting','overweight','obese','normal') NOT NULL,
  `severity` enum('none','mild','moderate','severe') DEFAULT 'none',
  `bmi` decimal(5,2) DEFAULT NULL,
  `status` enum('active','recovered','referral_pending','closed') DEFAULT 'active',
  `detected_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `resolved_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `child_id` (`child_id`),
  KEY `record_id` (`record_id`),
  CONSTRAINT `malnutrition_cases_ibfk_1` FOREIGN KEY (`child_id`) REFERENCES `children` (`id`) ON DELETE CASCADE,
  CONSTRAINT `malnutrition_cases_ibfk_2` FOREIGN KEY (`record_id`) REFERENCES `health_records` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `malnutrition_cases`
--

LOCK TABLES `malnutrition_cases` WRITE;
/*!40000 ALTER TABLE `malnutrition_cases` DISABLE KEYS */;
/*!40000 ALTER TABLE `malnutrition_cases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `monitoring_plans`
--

DROP TABLE IF EXISTS `monitoring_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `monitoring_plans` (
  `id` int NOT NULL AUTO_INCREMENT,
  `child_id` int NOT NULL,
  `created_by` int NOT NULL,
  `plan_name` varchar(200) DEFAULT NULL,
  `goal` text,
  `target_weight` decimal(5,2) DEFAULT NULL,
  `target_date` date DEFAULT NULL,
  `status` enum('active','completed','cancelled') DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `child_id` (`child_id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `monitoring_plans_ibfk_1` FOREIGN KEY (`child_id`) REFERENCES `children` (`id`) ON DELETE CASCADE,
  CONSTRAINT `monitoring_plans_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `monitoring_plans`
--

LOCK TABLES `monitoring_plans` WRITE;
/*!40000 ALTER TABLE `monitoring_plans` DISABLE KEYS */;
/*!40000 ALTER TABLE `monitoring_plans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_logs`
--

DROP TABLE IF EXISTS `system_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `action` varchar(100) NOT NULL,
  `entity_type` varchar(50) DEFAULT NULL,
  `entity_id` int DEFAULT NULL,
  `details` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `system_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_logs`
--

LOCK TABLES `system_logs` WRITE;
/*!40000 ALTER TABLE `system_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('parent','nutrition_worker','admin') NOT NULL DEFAULT 'parent',
  `phone` varchar(20) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (3,'Dhanu','dhanusrimurugesan4@gmail.com','$2b$12$/PlXPwcBaYgTtFr9dSQxVe.NU1rwujPqZFM6ZuUO1F58XBYymVsmm','admin',NULL,1,'2026-03-05 08:20:11','2026-03-05 08:20:11'),(8,'DhanuSri','dhanusrim96@gmail.com','$2b$12$V1a0CNCj5dqGsJb85efZW.0H26oxmg3m8/7EiczbpnE5aIP/DZ2vO','admin',NULL,1,'2026-03-14 04:24:33','2026-03-14 04:24:33'),(10,'HemalathaGanesan','hemalathaganesan08@gmail.com','$2b$12$qMM8arHakww9VoN.hh2WcuINe/3XihI6GgaH6hrDnO/3i31AnXTHG','admin',NULL,1,'2026-03-19 03:38:48','2026-03-19 03:38:48'),(13,'Test Admin2','admin2@test.com','$2b$12$5Ofcp2zCdR3sjxGDDh5Dee9R3LzmgRtjb1fMOszjO2n7s3YC8mnF.','admin',NULL,1,'2026-03-19 04:26:45','2026-03-19 04:26:45'),(48,'Test Worker','worker@test.com','$2b$12$C2OJs.c0A6VsgIFfEMbGIe4yxc8ehp62s3zdpWAtJaeepX9P8HYa2','nutrition_worker',NULL,1,'2026-04-02 06:28:25','2026-04-02 06:28:25'),(49,'Dhanusri','dhanu.parent@test.com','$2b$12$SUSL.U2NWVRAEnCGu8Yy..RzXlIkzABB8J8sNhxg18rurQ85h2Wpa','parent',NULL,1,'2026-04-02 06:28:26','2026-04-02 06:28:26'),(50,'Priya Sharma','priya@test.com','$2b$12$uSbJbcRxf906bP4NSKKuluXQmPbTTAM1BX6nSZ9Jey6mcdWXEKO9O','parent',NULL,1,'2026-04-02 06:28:26','2026-04-02 06:28:26'),(51,'Rajesh Kumar','rajesh@test.com','$2b$12$1naGxDSDZfIpzEw82M7vXuiYWemUUTIm9hgyjXudgKXN9gHtvLsGu','parent',NULL,1,'2026-04-02 06:28:26','2026-04-02 06:28:26'),(52,'Dharsana','dharsana.cs23@bitsathy.ac.in','$2b$12$Z43Qnab6VbjlZPyHbJpLz.55l671ioBHjMoqYXz.YA2pWwXHdqTB2','nutrition_worker',NULL,1,'2026-04-02 06:29:59','2026-04-02 06:29:59'),(53,'Sathya','sathya@gmail.com','$2b$12$..2Y59j/T6jujwHt7e8HOOlsM7/6uYn2Ss8mE53eofD7nCqFWHxTa','parent',NULL,1,'2026-04-02 07:19:37','2026-04-02 07:19:37'),(54,'Sonikaa','sonika.cs23@bitsathy.ac.in','$2b$12$gfCQpQBRYMxAyeBaEHoaf.elfYm5DvoK2OLQ0bbTUxw3w7QjFkm7y','parent',NULL,1,'2026-04-08 08:43:11','2026-04-08 08:43:11');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `worker_assignments`
--

DROP TABLE IF EXISTS `worker_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `worker_assignments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nutrition_worker_id` int NOT NULL,
  `child_id` int NOT NULL,
  `assigned_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `assigned_by` int NOT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_assignment` (`nutrition_worker_id`,`child_id`),
  KEY `child_id` (`child_id`),
  KEY `assigned_by` (`assigned_by`),
  CONSTRAINT `worker_assignments_ibfk_1` FOREIGN KEY (`nutrition_worker_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `worker_assignments_ibfk_2` FOREIGN KEY (`child_id`) REFERENCES `children` (`id`) ON DELETE CASCADE,
  CONSTRAINT `worker_assignments_ibfk_3` FOREIGN KEY (`assigned_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `worker_assignments`
--

LOCK TABLES `worker_assignments` WRITE;
/*!40000 ALTER TABLE `worker_assignments` DISABLE KEYS */;
/*!40000 ALTER TABLE `worker_assignments` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-17 14:27:33
