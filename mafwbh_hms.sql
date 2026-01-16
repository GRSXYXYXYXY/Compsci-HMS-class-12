-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: mafwbh_hms
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `audit_logs`
--

DROP TABLE IF EXISTS `audit_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(50) DEFAULT NULL,
  `message` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_logs`
--

LOCK TABLES `audit_logs` WRITE;
/*!40000 ALTER TABLE `audit_logs` DISABLE KEYS */;
INSERT INTO `audit_logs` VALUES (1,'room_add','Added room 5','2026-01-16 17:18:54');
/*!40000 ALTER TABLE `audit_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_services`
--

DROP TABLE IF EXISTS `booking_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_services` (
  `id` int NOT NULL AUTO_INCREMENT,
  `booking_id` int NOT NULL,
  `service_id` int NOT NULL,
  `quantity` int DEFAULT '1',
  `subtotal` decimal(12,2) DEFAULT '0.00',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `booking_id` (`booking_id`),
  KEY `service_id` (`service_id`),
  CONSTRAINT `booking_services_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE CASCADE,
  CONSTRAINT `booking_services_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_services`
--

LOCK TABLES `booking_services` WRITE;
/*!40000 ALTER TABLE `booking_services` DISABLE KEYS */;
INSERT INTO `booking_services` VALUES (1,1,1,2,500.00,'2026-01-16 17:18:02'),(2,3,2,3,450.00,'2026-01-16 17:18:02'),(3,4,3,1,800.00,'2026-01-16 17:18:02'),(4,8,1,4,1000.00,'2026-01-16 17:18:02'),(5,8,4,2,800.00,'2026-01-16 17:18:02');
/*!40000 ALTER TABLE `booking_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `room_id` int NOT NULL,
  `checkin` datetime DEFAULT NULL,
  `checkout` datetime DEFAULT NULL,
  `status` varchar(30) DEFAULT 'reserved',
  `total` decimal(12,2) DEFAULT '0.00',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`),
  KEY `room_id` (`room_id`),
  CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` VALUES (1,1,1,'2026-01-02 12:00:00','2026-01-05 11:00:00','checked_out',4500.00,'2026-01-16 17:17:38'),(2,2,5,'2026-01-03 14:00:00','2026-01-04 10:00:00','checked_out',2200.00,'2026-01-16 17:17:38'),(3,3,12,'2026-01-05 13:00:00','2026-01-08 10:00:00','checked_out',6600.00,'2026-01-16 17:17:38'),(4,4,18,'2026-01-07 12:00:00','2026-01-09 11:00:00','checked_out',7000.00,'2026-01-16 17:17:38'),(5,5,25,'2026-01-10 15:00:00','2026-01-12 10:00:00','checked_out',4400.00,'2026-01-16 17:17:38'),(6,6,30,'2026-01-11 12:00:00','2026-01-13 11:00:00','checked_out',7000.00,'2026-01-16 17:17:38'),(7,7,35,'2026-01-14 13:00:00','2026-01-15 10:00:00','checked_out',1500.00,'2026-01-16 17:17:38'),(8,8,39,'2026-01-14 14:00:00','2026-01-17 10:00:00','checked_out',18000.00,'2026-01-16 17:17:38'),(9,9,10,'2026-01-16 12:00:00','2026-01-18 10:00:00','reserved',12000.00,'2026-01-16 17:17:38'),(10,10,15,'2026-01-17 13:00:00','2026-01-20 10:00:00','reserved',6600.00,'2026-01-16 17:17:38');
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'Aarav','Sharma','9876543210','aarav.s@gmail.com','Delhi','2026-01-16 17:17:25'),(2,'Vivaan','Verma','9876543211','vivaan.v@gmail.com','Mumbai','2026-01-16 17:17:25'),(3,'Aditya','Singh','9876543212','aditya.s@gmail.com','Lucknow','2026-01-16 17:17:25'),(4,'Arjun','Mehta','9876543213','arjun.m@gmail.com','Ahmedabad','2026-01-16 17:17:25'),(5,'Reyansh','Patel','9876543214','reyansh.p@gmail.com','Surat','2026-01-16 17:17:25'),(6,'Ananya','Iyer','9876543215','ananya.i@gmail.com','Chennai','2026-01-16 17:17:25'),(7,'Diya','Kapoor','9876543216','diya.k@gmail.com','Delhi','2026-01-16 17:17:25'),(8,'Ishaan','Khanna','9876543217','ishaan.k@gmail.com','Chandigarh','2026-01-16 17:17:25'),(9,'Kavya','Nair','9876543218','kavya.n@gmail.com','Kochi','2026-01-16 17:17:25'),(10,'Rohan','Das','9876543219','rohan.d@gmail.com','Kolkata','2026-01-16 17:17:25'),(11,'Sanya','Malhotra','9876543220','sanya.m@gmail.com','Delhi','2026-01-16 17:17:25'),(12,'Mohit','Gupta','9876543221','mohit.g@gmail.com','Jaipur','2026-01-16 17:17:25'),(13,'Neha','Joshi','9876543222','neha.j@gmail.com','Pune','2026-01-16 17:17:25'),(14,'Rahul','Bose','9876543223','rahul.b@gmail.com','Kolkata','2026-01-16 17:17:25'),(15,'Priya','Singh','9876543224','priya.s@gmail.com','Patna','2026-01-16 17:17:25'),(16,'Aman','Chopra','9876543225','aman.c@gmail.com','Delhi','2026-01-16 17:17:25'),(17,'Sneha','Reddy','9876543226','sneha.r@gmail.com','Hyderabad','2026-01-16 17:17:25'),(18,'Varun','Arora','9876543227','varun.a@gmail.com','Gurgaon','2026-01-16 17:17:25'),(19,'Pooja','Khatri','9876543228','pooja.k@gmail.com','Indore','2026-01-16 17:17:25'),(20,'Nikhil','Bansal','9876543229','nikhil.b@gmail.com','Noida','2026-01-16 17:17:25');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotels`
--

DROP TABLE IF EXISTS `hotels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotels` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `address` text,
  `phone` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotels`
--

LOCK TABLES `hotels` WRITE;
/*!40000 ALTER TABLE `hotels` DISABLE KEYS */;
INSERT INTO `hotels` VALUES (1,'Mafwbh Inn','DPS Panipat Refinery, Panipat','+91-XXXXXXXXXX','2026-01-16 17:14:07');
/*!40000 ALTER TABLE `hotels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory` (
  `id` int NOT NULL AUTO_INCREMENT,
  `item` varchar(200) DEFAULT NULL,
  `quantity` int DEFAULT '0',
  `unit` varchar(50) DEFAULT NULL,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
INSERT INTO `inventory` VALUES (1,'Bed Sheets',120,'pieces','2026-01-16 17:24:16'),(2,'Pillow Covers',200,'pieces','2026-01-16 17:24:16'),(3,'Bath Towels',150,'pieces','2026-01-16 17:24:16'),(4,'Hand Towels',150,'pieces','2026-01-16 17:24:16'),(5,'Toilet Paper Rolls',300,'rolls','2026-01-16 17:24:16'),(6,'Soap Bars',500,'pieces','2026-01-16 17:24:16'),(7,'Shampoo Bottles',400,'bottles','2026-01-16 17:24:16'),(8,'Mineral Water Bottles',600,'bottles','2026-01-16 17:24:16'),(9,'Cleaning Liquid',50,'liters','2026-01-16 17:24:16'),(10,'Floor Disinfectant',40,'liters','2026-01-16 17:24:16'),(11,'Laundry Detergent',60,'kg','2026-01-16 17:24:16'),(12,'Rice',200,'kg','2026-01-16 17:24:16'),(13,'Wheat Flour',150,'kg','2026-01-16 17:24:16'),(14,'Vegetables Stock',100,'kg','2026-01-16 17:24:16'),(15,'Chicken Stock',80,'kg','2026-01-16 17:24:16'),(16,'Baby Oil',1000,'liters','2026-01-16 17:24:16'),(17,'Gas Cylinders',10,'cylinders','2026-01-16 17:24:16'),(18,'Light Bulbs',50,'pieces','2026-01-16 17:24:16'),(19,'AC Filters',30,'pieces','2026-01-16 17:24:16'),(20,'Batteries',100,'pieces','2026-01-16 17:24:16');
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoices` (
  `id` int NOT NULL AUTO_INCREMENT,
  `booking_id` int NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `paid` decimal(12,2) DEFAULT '0.00',
  `status` varchar(20) DEFAULT 'unpaid',
  `issued_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `booking_id` (`booking_id`),
  CONSTRAINT `invoices_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoices`
--

LOCK TABLES `invoices` WRITE;
/*!40000 ALTER TABLE `invoices` DISABLE KEYS */;
INSERT INTO `invoices` VALUES (1,1,4500.00,4500.00,'paid','2026-01-16 17:17:48'),(2,2,2200.00,2200.00,'paid','2026-01-16 17:17:48'),(3,3,6600.00,6600.00,'paid','2026-01-16 17:17:48'),(4,4,7000.00,7000.00,'paid','2026-01-16 17:17:48'),(5,5,4400.00,4000.00,'partially_paid','2026-01-16 17:17:48'),(6,6,7000.00,0.00,'unpaid','2026-01-16 17:17:48'),(7,7,1500.00,1500.00,'paid','2026-01-16 17:17:48'),(8,8,18000.00,18000.00,'paid','2026-01-16 17:17:48'),(9,9,12000.00,0.00,'unpaid','2026-01-16 17:17:48'),(10,10,6600.00,0.00,'unpaid','2026-01-16 17:17:48');
/*!40000 ALTER TABLE `invoices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `invoice_id` int NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `method` varchar(50) DEFAULT NULL,
  `paid_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `note` text,
  PRIMARY KEY (`id`),
  KEY `invoice_id` (`invoice_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,1,4500.00,'upi','2026-01-05 10:30:00','Full payment'),(2,2,2200.00,'card','2026-01-04 09:50:00','Paid at checkout'),(3,3,6600.00,'upi','2026-01-08 09:40:00','Online payment'),(4,4,7000.00,'cash','2026-01-09 10:10:00','Reception'),(5,5,4000.00,'upi','2026-01-12 09:20:00','Advance paid'),(6,7,1500.00,'cash','2026-01-15 09:45:00','Checkout'),(7,8,18000.00,'card','2026-01-17 09:30:00','Corporate booking');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rooms` (
  `id` int NOT NULL AUTO_INCREMENT,
  `room_number` varchar(20) NOT NULL,
  `room_type` varchar(50) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `status` varchar(20) NOT NULL DEFAULT 'available',
  `description` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `room_number` (`room_number`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms`
--

LOCK TABLES `rooms` WRITE;
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
INSERT INTO `rooms` VALUES (1,'101A','single',1500.00,'available','Single room - A wing','2026-01-16 17:17:17'),(2,'102A','single',1500.00,'available','Single room - A wing','2026-01-16 17:17:17'),(3,'103A','single',1500.00,'available','Single room - A wing','2026-01-16 17:17:17'),(4,'104A','double',2200.00,'available','Double room - A wing','2026-01-16 17:17:17'),(5,'105A','double',2200.00,'available','Double room - A wing','2026-01-16 17:17:17'),(6,'106A','double',2200.00,'available','Double room - A wing','2026-01-16 17:17:17'),(7,'107A','deluxe',3500.00,'available','Deluxe room - A wing','2026-01-16 17:17:17'),(8,'108A','deluxe',3500.00,'available','Deluxe room - A wing','2026-01-16 17:17:17'),(9,'109A','suite',6000.00,'available','Suite - A wing','2026-01-16 17:17:17'),(10,'110A','suite',6000.00,'available','Suite - A wing','2026-01-16 17:17:17'),(11,'101B','single',1500.00,'available','Single room - B wing','2026-01-16 17:17:17'),(12,'102B','single',1500.00,'available','Single room - B wing','2026-01-16 17:17:17'),(13,'103B','single',1500.00,'available','Single room - B wing','2026-01-16 17:17:17'),(14,'104B','double',2200.00,'available','Double room - B wing','2026-01-16 17:17:17'),(15,'105B','double',2200.00,'available','Double room - B wing','2026-01-16 17:17:17'),(16,'106B','double',2200.00,'available','Double room - B wing','2026-01-16 17:17:17'),(17,'107B','deluxe',3500.00,'available','Deluxe room - B wing','2026-01-16 17:17:17'),(18,'108B','deluxe',3500.00,'available','Deluxe room - B wing','2026-01-16 17:17:17'),(19,'109B','suite',6000.00,'available','Suite - B wing','2026-01-16 17:17:17'),(20,'110B','suite',6000.00,'available','Suite - B wing','2026-01-16 17:17:17'),(21,'101C','single',1500.00,'available','Single room - C wing','2026-01-16 17:17:17'),(22,'102C','single',1500.00,'available','Single room - C wing','2026-01-16 17:17:17'),(23,'103C','single',1500.00,'available','Single room - C wing','2026-01-16 17:17:17'),(24,'104C','double',2200.00,'available','Double room - C wing','2026-01-16 17:17:17'),(25,'105C','double',2200.00,'available','Double room - C wing','2026-01-16 17:17:17'),(26,'106C','double',2200.00,'available','Double room - C wing','2026-01-16 17:17:17'),(27,'107C','deluxe',3500.00,'available','Deluxe room - C wing','2026-01-16 17:17:17'),(28,'108C','deluxe',3500.00,'available','Deluxe room - C wing','2026-01-16 17:17:17'),(29,'109C','suite',6000.00,'available','Suite - C wing','2026-01-16 17:17:17'),(30,'110C','suite',6000.00,'available','Suite - C wing','2026-01-16 17:17:17'),(31,'101D','single',1500.00,'available','Single room - D wing','2026-01-16 17:17:17'),(32,'102D','single',1500.00,'available','Single room - D wing','2026-01-16 17:17:17'),(33,'103D','single',1500.00,'available','Single room - D wing','2026-01-16 17:17:17'),(34,'104D','double',2200.00,'available','Double room - D wing','2026-01-16 17:17:17'),(35,'105D','double',2200.00,'available','Double room - D wing','2026-01-16 17:17:17'),(36,'106D','double',2200.00,'available','Double room - D wing','2026-01-16 17:17:17'),(37,'107D','deluxe',3500.00,'available','Deluxe room - D wing','2026-01-16 17:17:17'),(38,'108D','deluxe',3500.00,'available','Deluxe room - D wing','2026-01-16 17:17:17'),(39,'109D','suite',6000.00,'available','Suite - D wing','2026-01-16 17:17:17'),(40,'110D','suite',6000.00,'available','Suite - D wing','2026-01-16 17:17:17'),(41,'5','single',10.00,'available','bad room ','2026-01-16 17:18:53');
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `services` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (1,'Breakfast',250.00,'2026-01-16 17:17:58'),(2,'Laundry',150.00,'2026-01-16 17:17:58'),(3,'Airport Pickup',800.00,'2026-01-16 17:17:58'),(4,'Dinner',400.00,'2026-01-16 17:17:58');
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `role` varchar(100) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (1,'Rajesh Kumar','Manager','9811111111','rajesh.manager@mafwbh.com','2023-03-15',1),(2,'Sam Kepler','Scientist','9811111112','cosq@mafwbh.com','2023-05-10',1),(3,'Suresh Yadav','Receptionist','9811111113','suresh.frontdesk@mafwbh.com','2023-06-01',1),(4,'Ishnoor Singh','Headboy','9811111114','imnoob@mafwbh.com','2023-04-20',1),(5,'Ramesh Das','Housekeeping Staff','9811111115','ramesh.hk@mafwbh.com','2023-07-12',1),(6,'Sunita Devi','Housekeeping Staff','9811111116','sunita.hk@mafwbh.com','2023-07-12',1),(7,'Amit Patel','Chef','9811111117','icook@mafwbh.com','2023-02-05',1),(8,'Dev','Kitchen Staff','9811111118','ieatfood@mafwbh.com','2023-08-18',1),(9,'Vikram Singh','Security Guard','9811111119','vikram.security@mafwbh.com','2023-01-25',1),(10,'Pankaj Sharma','Maintenance Technician','9811111120','pankaj.maintenance@mafwbh.com','2023-09-02',1),(11,'Kavita Nair','Accountant','9811111121','kavita.accounts@mafwbh.com','2023-03-30',1),(12,'Mohit Bansal','Inventory Manager','9811111122','mohit.inventory@mafwbh.com','2023-06-15',1);
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-17  0:03:14
