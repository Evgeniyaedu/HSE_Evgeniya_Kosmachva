CREATE DATABASE  IF NOT EXISTS `final_university_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `final_university_db`;
-- MySQL dump 10.13  Distrib 8.0.43, for macos15 (arm64)
--
-- Host: localhost    Database: final_university_db
-- ------------------------------------------------------
-- Server version	8.4.6

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
-- Table structure for table `course_assignments`
--

DROP TABLE IF EXISTS `course_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_assignments` (
  `assignment_id` int NOT NULL AUTO_INCREMENT,
  `course_id` int NOT NULL,
  `teacher_id` int NOT NULL,
  `academic_year` year NOT NULL,
  `semester` tinyint NOT NULL,
  `is_main_teacher` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`assignment_id`),
  UNIQUE KEY `unique_assignment` (`course_id`,`teacher_id`,`academic_year`,`semester`),
  KEY `idx_assignments_course` (`course_id`),
  KEY `idx_assignments_teacher` (`teacher_id`),
  KEY `idx_assignments_year_sem` (`academic_year`,`semester`),
  CONSTRAINT `course_assignments_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE,
  CONSTRAINT `course_assignments_ibfk_2` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`teacher_id`) ON DELETE CASCADE,
  CONSTRAINT `chk_assignment_semester` CHECK ((`semester` in (1,2)))
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Назначение преподавателей на курсы в конкретном семестре и году';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_assignments`
--

LOCK TABLES `course_assignments` WRITE;
/*!40000 ALTER TABLE `course_assignments` DISABLE KEYS */;
INSERT INTO `course_assignments` VALUES (1,1,1,2023,2,1,'2025-11-24 17:19:04'),(2,1,1,2024,1,1,'2025-11-24 17:19:04'),(3,1,1,2024,2,1,'2025-11-24 17:19:04'),(4,1,5,2023,2,0,'2025-11-24 17:19:04'),(5,1,4,2024,1,0,'2025-11-24 17:19:04'),(6,2,2,2023,2,1,'2025-11-24 17:19:04'),(7,2,2,2024,1,1,'2025-11-24 17:19:04'),(8,2,2,2024,2,1,'2025-11-24 17:19:04'),(9,2,2,2025,1,1,'2025-11-24 17:19:04'),(10,3,2,2023,2,1,'2025-11-24 17:19:04'),(11,3,2,2024,1,1,'2025-11-24 17:19:04'),(12,3,5,2024,2,1,'2025-11-24 17:19:04'),(13,4,3,2024,1,1,'2025-11-24 17:19:04'),(14,4,3,2024,2,1,'2025-11-24 17:19:04'),(15,5,4,2024,2,1,'2025-11-24 17:19:04'),(16,5,4,2025,2,1,'2025-11-24 17:19:04'),(17,6,1,2023,2,1,'2025-11-24 17:19:04'),(18,6,1,2024,1,1,'2025-11-24 17:19:04'),(19,6,1,2024,2,1,'2025-11-24 17:19:04'),(20,7,4,2024,1,1,'2025-11-24 17:19:04'),(21,7,4,2025,1,1,'2025-11-24 17:19:04'),(22,8,3,2024,1,1,'2025-11-24 17:19:04'),(23,8,3,2024,2,1,'2025-11-24 17:19:04'),(24,9,2,2023,2,1,'2025-11-24 17:19:04'),(25,9,2,2024,1,1,'2025-11-24 17:19:04'),(26,9,2,2024,2,1,'2025-11-24 17:19:04'),(27,9,2,2025,1,1,'2025-11-24 17:19:04'),(28,10,4,2024,1,1,'2025-11-24 17:19:04'),(29,10,4,2024,2,1,'2025-11-24 17:19:04'),(30,10,4,2025,1,1,'2025-11-24 17:19:04'),(31,11,1,2024,1,1,'2025-11-24 17:19:04'),(32,11,1,2024,2,1,'2025-11-24 17:19:04'),(33,11,1,2025,1,1,'2025-11-24 17:19:04'),(34,8,3,2025,1,1,'2025-12-12 13:25:58');
/*!40000 ALTER TABLE `course_assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courses` (
  `course_id` int NOT NULL AUTO_INCREMENT,
  `course_name` varchar(100) NOT NULL,
  `description` text,
  `course_category` enum('Математические','Гуманитарные','Естественные','Технические','Другое') NOT NULL,
  `credits` tinyint NOT NULL DEFAULT '3',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`course_id`),
  UNIQUE KEY `course_name` (`course_name`),
  KEY `idx_courses_active` (`is_active`),
  KEY `idx_courses_category` (`course_category`),
  CONSTRAINT `courses_chk_1` CHECK ((`credits` between 1 and 10))
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Учебные курсы с категорией и количеством кредитов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES (1,'Математический анализ','Основы дифференциального и интегрального исчисления','Математические',5,1,'2025-11-24 17:18:45'),(2,'Программирование на Python','Изучение основ программирования на языке Python','Технические',4,1,'2025-11-24 17:18:45'),(3,'Базы данных','Проектирование и работа с реляционными базами данных','Технические',4,1,'2025-11-24 17:18:45'),(4,'Общая физика','Основы механики, термодинамики и электромагнетизма','Естественные',6,1,'2025-11-24 17:18:45'),(5,'История науки','Развитие научной мысли от античности до наших дней','Гуманитарные',3,1,'2025-11-24 17:18:45'),(6,'Линейная алгебра','Матрицы, векторы, системы линейных уравнений','Математические',4,1,'2025-11-24 17:18:45'),(7,'Философия','Основы философского мышления и истории философии','Гуманитарные',3,1,'2025-11-24 17:18:45'),(8,'Химия','Основы общей и неорганической химии','Естественные',4,1,'2025-11-24 17:18:45'),(9,'Искусственный интеллект','Основы машинного обучения и нейросетей','Технические',5,1,'2025-11-24 17:18:45'),(10,'Экономика образования','Анализ затрат и эффективности в сфере образования','Гуманитарные',3,1,'2025-11-24 17:18:45'),(11,'Квантовые вычисления','Введение в квантовые алгоритмы','Математические',4,1,'2025-11-24 17:18:45');
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_archive`
--

DROP TABLE IF EXISTS `courses_archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courses_archive` (
  `archive_id` int NOT NULL AUTO_INCREMENT,
  `course_id` int DEFAULT NULL,
  `course_name` varchar(100) DEFAULT NULL,
  `description` text,
  `course_category` enum('Математические','Гуманитарные','Естественные','Технические','Другое') DEFAULT NULL,
  `credits` tinyint DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `archived_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`archive_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_archive`
--

LOCK TABLES `courses_archive` WRITE;
/*!40000 ALTER TABLE `courses_archive` DISABLE KEYS */;
/*!40000 ALTER TABLE `courses_archive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enrollments`
--

DROP TABLE IF EXISTS `enrollments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enrollments` (
  `enrollment_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `course_id` int NOT NULL,
  `semester` tinyint NOT NULL,
  `academic_year` year NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`enrollment_id`),
  UNIQUE KEY `unique_enrollment` (`student_id`,`course_id`,`semester`,`academic_year`),
  KEY `idx_enrollments_student` (`student_id`),
  KEY `idx_enrollments_course` (`course_id`),
  KEY `idx_enrollments_year_semester` (`academic_year`,`semester`),
  CONSTRAINT `enrollments_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE,
  CONSTRAINT `enrollments_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE,
  CONSTRAINT `chk_semester` CHECK ((`semester` in (1,2)))
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Зачисление студентов на курсы по семестрам и годам';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollments`
--

LOCK TABLES `enrollments` WRITE;
/*!40000 ALTER TABLE `enrollments` DISABLE KEYS */;
INSERT INTO `enrollments` VALUES (1,1,1,2,2023,'2025-11-24 17:19:27'),(2,1,1,1,2024,'2025-11-24 17:19:27'),(3,1,1,2,2024,'2025-11-24 17:19:27'),(4,2,1,2,2023,'2025-11-24 17:19:27'),(5,2,1,1,2024,'2025-11-24 17:19:27'),(6,2,1,2,2024,'2025-11-24 17:19:27'),(7,2,6,2,2023,'2025-11-24 17:19:27'),(8,5,1,2,2023,'2025-11-24 17:19:27'),(9,5,1,1,2024,'2025-11-24 17:19:27'),(10,5,1,2,2024,'2025-11-24 17:19:27'),(11,5,6,2,2023,'2025-11-24 17:19:27'),(12,5,6,1,2024,'2025-11-24 17:19:27'),(13,5,6,2,2024,'2025-11-24 17:19:27'),(14,3,2,2,2023,'2025-11-24 17:19:27'),(15,3,2,1,2024,'2025-11-24 17:19:27'),(16,3,2,2,2024,'2025-11-24 17:19:27'),(17,3,3,2,2023,'2025-11-24 17:19:27'),(18,3,3,1,2024,'2025-11-24 17:19:27'),(19,3,3,2,2024,'2025-11-24 17:19:27'),(20,4,9,2,2023,'2025-11-24 17:19:27'),(21,4,2,1,2024,'2025-11-24 17:19:27'),(22,4,2,2,2024,'2025-11-24 17:19:27'),(23,4,3,1,2024,'2025-11-24 17:19:27'),(24,4,3,2,2024,'2025-11-24 17:19:27'),(25,8,9,2,2023,'2025-11-24 17:19:27'),(26,8,9,1,2024,'2025-11-24 17:19:27'),(27,8,9,2,2024,'2025-11-24 17:19:27'),(28,8,3,1,2024,'2025-11-24 17:19:27'),(29,8,3,2,2024,'2025-11-24 17:19:27'),(30,6,9,2,2023,'2025-11-24 17:19:27'),(31,6,2,1,2024,'2025-11-24 17:19:27'),(32,6,2,2,2024,'2025-11-24 17:19:27'),(33,6,3,1,2024,'2025-11-24 17:19:27'),(34,7,2,2,2023,'2025-11-24 17:19:27'),(35,7,2,1,2024,'2025-11-24 17:19:27'),(36,7,2,2,2024,'2025-11-24 17:19:27'),(37,7,3,1,2024,'2025-11-24 17:19:27'),(38,7,9,2,2024,'2025-11-24 17:19:27'),(39,9,9,2,2023,'2025-11-24 17:19:27'),(40,9,2,1,2024,'2025-11-24 17:19:27'),(41,9,2,2,2024,'2025-11-24 17:19:27'),(42,9,3,1,2024,'2025-11-24 17:19:27'),(43,9,3,2,2024,'2025-11-24 17:19:27'),(44,10,9,2,2023,'2025-11-24 17:19:27'),(45,10,2,1,2024,'2025-11-24 17:19:27'),(46,10,2,2,2024,'2025-11-24 17:19:27'),(47,10,3,1,2024,'2025-11-24 17:19:27'),(48,10,3,2,2024,'2025-11-24 17:19:27'),(49,10,3,1,2025,'2025-11-24 17:19:27'),(50,10,3,2,2025,'2025-11-24 17:19:27'),(51,11,9,2,2023,'2025-11-24 17:19:27'),(52,11,2,1,2024,'2025-11-24 17:19:27'),(53,11,2,2,2024,'2025-11-24 17:19:27'),(54,11,3,1,2024,'2025-11-24 17:19:27'),(55,11,3,2,2024,'2025-11-24 17:19:27'),(56,11,3,1,2025,'2025-11-24 17:19:27'),(57,11,3,2,2025,'2025-11-24 17:19:27'),(58,12,9,2,2023,'2025-11-24 17:19:27'),(59,12,7,1,2024,'2025-11-24 17:19:27'),(60,12,9,1,2024,'2025-11-24 17:19:27'),(61,12,3,2,2024,'2025-11-24 17:19:27'),(62,12,9,2,2025,'2025-11-24 17:19:27'),(63,13,4,1,2024,'2025-11-24 17:19:27'),(64,13,4,2,2024,'2025-11-24 17:19:27'),(65,13,6,1,2024,'2025-11-24 17:19:27'),(66,13,6,2,2024,'2025-11-24 17:19:27'),(67,13,5,2,2024,'2025-11-24 17:19:27'),(68,13,6,1,2025,'2025-11-24 17:19:27'),(69,13,6,2,2025,'2025-11-24 17:19:27'),(70,14,11,1,2024,'2025-11-24 17:19:27'),(71,14,11,2,2024,'2025-11-24 17:19:27'),(72,14,10,1,2024,'2025-11-24 17:19:27'),(73,14,10,2,2024,'2025-11-24 17:19:27'),(74,14,10,1,2025,'2025-11-24 17:19:27'),(75,14,8,2,2025,'2025-11-24 17:19:27'),(76,15,7,1,2024,'2025-11-24 17:19:27'),(77,15,9,1,2024,'2025-11-24 17:19:27'),(78,15,3,2,2024,'2025-11-24 17:19:27'),(79,15,9,1,2025,'2025-11-24 17:19:27'),(80,15,9,2,2025,'2025-11-24 17:19:27'),(81,16,4,1,2024,'2025-11-24 17:19:27'),(82,16,4,2,2024,'2025-11-24 17:19:27'),(83,16,5,1,2024,'2025-11-24 17:19:27'),(84,16,5,2,2024,'2025-11-24 17:19:27'),(85,16,5,1,2025,'2025-11-24 17:19:27'),(86,16,6,2,2025,'2025-11-24 17:19:27'),(87,17,6,1,2024,'2025-11-24 17:19:27'),(88,17,7,2,2024,'2025-11-24 17:19:27'),(89,17,7,1,2024,'2025-11-24 17:19:27'),(90,17,11,2,2024,'2025-11-24 17:19:27'),(91,17,11,1,2025,'2025-11-24 17:19:27'),(92,17,6,2,2025,'2025-11-24 17:19:27'),(93,18,7,1,2024,'2025-11-24 17:19:27'),(94,18,9,1,2024,'2025-11-24 17:19:27'),(95,18,5,2,2024,'2025-11-24 17:19:27'),(96,18,9,1,2025,'2025-11-24 17:19:27'),(97,18,5,2,2025,'2025-11-24 17:19:27'),(98,19,4,1,2024,'2025-11-24 17:19:27'),(99,19,4,2,2024,'2025-11-24 17:19:27'),(100,19,6,1,2024,'2025-11-24 17:19:27'),(101,19,5,2,2024,'2025-11-24 17:19:27'),(102,19,6,1,2025,'2025-11-24 17:19:27'),(103,19,6,2,2025,'2025-11-24 17:19:27'),(104,20,11,1,2024,'2025-11-24 17:19:27'),(105,20,11,2,2024,'2025-11-24 17:19:27'),(106,20,10,1,2024,'2025-11-24 17:19:27'),(107,20,10,2,2024,'2025-11-24 17:19:27'),(108,20,10,1,2025,'2025-11-24 17:19:27'),(109,20,8,2,2025,'2025-11-24 17:19:27'),(110,21,7,1,2024,'2025-11-24 17:19:27'),(111,21,9,1,2024,'2025-11-24 17:19:27'),(112,21,3,2,2024,'2025-11-24 17:19:27'),(113,21,9,1,2025,'2025-11-24 17:19:27'),(114,21,9,2,2025,'2025-11-24 17:19:27'),(115,22,6,1,2025,'2025-11-24 17:19:27'),(116,22,6,2,2025,'2025-11-24 17:19:27'),(117,22,11,1,2025,'2025-11-24 17:19:27'),(118,22,11,2,2025,'2025-11-24 17:19:27'),(119,23,10,1,2025,'2025-11-24 17:19:27'),(120,23,8,2,2025,'2025-11-24 17:19:27'),(121,23,11,1,2025,'2025-11-24 17:19:27'),(122,23,11,2,2025,'2025-11-24 17:19:27'),(123,24,9,1,2025,'2025-11-24 17:19:27'),(124,24,9,2,2025,'2025-11-24 17:19:27'),(125,24,10,1,2025,'2025-11-24 17:19:27'),(126,24,10,2,2025,'2025-11-24 17:19:27'),(127,5,9,1,2025,'2025-12-12 13:20:41'),(128,27,8,1,2025,'2025-12-12 13:21:11');
/*!40000 ALTER TABLE `enrollments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enrollments_archive`
--

DROP TABLE IF EXISTS `enrollments_archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enrollments_archive` (
  `archive_id` int NOT NULL AUTO_INCREMENT,
  `enrollment_id` int DEFAULT NULL,
  `student_id` int DEFAULT NULL,
  `course_id` int DEFAULT NULL,
  `semester` tinyint DEFAULT NULL,
  `academic_year` year DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `archived_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`archive_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollments_archive`
--

LOCK TABLES `enrollments_archive` WRITE;
/*!40000 ALTER TABLE `enrollments_archive` DISABLE KEYS */;
/*!40000 ALTER TABLE `enrollments_archive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grades`
--

DROP TABLE IF EXISTS `grades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grades` (
  `grade_id` int NOT NULL AUTO_INCREMENT,
  `enrollment_id` int NOT NULL,
  `teacher_id` int NOT NULL,
  `grade` tinyint NOT NULL,
  `exam_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`grade_id`),
  UNIQUE KEY `unique_exam_grade` (`enrollment_id`,`exam_date`),
  KEY `idx_grades_date` (`exam_date`),
  KEY `idx_grades_teacher` (`teacher_id`),
  KEY `idx_grades_enrollment` (`enrollment_id`),
  CONSTRAINT `grades_ibfk_1` FOREIGN KEY (`enrollment_id`) REFERENCES `enrollments` (`enrollment_id`) ON DELETE CASCADE,
  CONSTRAINT `grades_ibfk_2` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`teacher_id`) ON DELETE CASCADE,
  CONSTRAINT `chk_grade_range` CHECK ((`grade` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Оценки студентов с датой и преподавателем';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grades`
--

LOCK TABLES `grades` WRITE;
/*!40000 ALTER TABLE `grades` DISABLE KEYS */;
INSERT INTO `grades` VALUES (1,1,1,5,'2023-06-20','2025-11-24 17:54:36'),(2,2,1,4,'2023-06-22','2025-11-24 17:54:36'),(3,4,1,4,'2023-06-25','2025-11-24 17:54:36'),(4,8,1,5,'2023-06-18','2025-11-24 17:54:36'),(5,3,1,5,'2024-01-20','2025-11-24 17:54:36'),(6,5,1,4,'2024-01-22','2025-11-24 17:54:36'),(7,6,1,3,'2024-01-25','2025-11-24 17:54:36'),(8,9,1,5,'2024-01-18','2025-11-24 17:54:36'),(9,10,1,4,'2024-01-20','2025-11-24 17:54:36'),(10,7,1,5,'2024-06-15','2025-11-24 17:54:36'),(11,11,1,4,'2024-06-18','2025-11-24 17:54:36'),(12,12,1,5,'2024-06-20','2025-11-24 17:54:36'),(13,13,1,4,'2024-06-22','2025-11-24 17:54:36'),(14,14,2,4,'2023-06-10','2025-11-24 17:54:36'),(15,17,2,5,'2023-06-12','2025-11-24 17:54:36'),(16,20,2,4,'2023-06-15','2025-11-24 17:54:36'),(17,25,2,5,'2023-06-18','2025-11-24 17:54:36'),(18,15,2,5,'2024-01-10','2025-11-24 17:54:36'),(19,16,2,4,'2024-01-12','2025-11-24 17:54:36'),(20,21,2,5,'2024-01-15','2025-11-24 17:54:36'),(21,22,2,4,'2024-01-18','2025-11-24 17:54:36'),(22,26,2,5,'2024-01-20','2025-11-24 17:54:36'),(23,18,2,5,'2023-06-08','2025-11-24 17:54:36'),(24,19,2,4,'2023-06-10','2025-11-24 17:54:36'),(25,23,2,5,'2024-01-08','2025-11-24 17:54:36'),(26,24,2,4,'2024-01-10','2025-11-24 17:54:36'),(27,28,2,5,'2024-01-12','2025-11-24 17:54:36'),(28,29,2,5,'2024-01-15','2025-11-24 17:54:36'),(29,30,5,5,'2024-06-10','2025-11-24 17:54:36'),(30,31,5,4,'2024-06-12','2025-11-24 17:54:36'),(31,32,2,5,'2023-06-05','2025-11-24 17:54:36'),(32,36,2,4,'2023-06-07','2025-11-24 17:54:36'),(33,40,2,5,'2023-06-09','2025-11-24 17:54:36'),(34,33,2,5,'2024-01-05','2025-11-24 17:54:36'),(35,37,2,4,'2024-01-07','2025-11-24 17:54:36'),(36,41,2,5,'2024-01-09','2025-11-24 17:54:36'),(37,34,2,4,'2024-06-05','2025-11-24 17:54:36'),(38,38,2,5,'2024-06-07','2025-11-24 17:54:36'),(39,42,2,4,'2024-06-09','2025-11-24 17:54:36'),(40,44,1,5,'2024-01-25','2025-11-24 17:54:36'),(41,45,1,5,'2024-01-27','2025-11-24 17:54:36'),(42,46,1,5,'2024-01-29','2025-11-24 17:54:36'),(43,48,4,4,'2024-06-20','2025-11-24 17:54:36'),(44,49,4,5,'2024-01-30','2025-11-24 17:54:36'),(45,52,4,4,'2024-02-01','2025-11-24 17:54:36'),(46,50,1,5,'2024-01-28','2025-11-24 17:54:36'),(47,51,1,4,'2024-01-30','2025-11-24 17:54:36'),(48,53,4,5,'2024-01-25','2025-11-24 17:54:36'),(49,54,4,4,'2024-01-27','2025-11-24 17:54:36'),(50,55,2,5,'2025-01-15','2025-11-24 17:54:36'),(51,56,2,4,'2025-01-18','2025-11-24 17:54:36'),(52,57,2,5,'2025-01-25','2025-11-24 17:54:36'),(53,58,2,4,'2025-01-22','2025-11-24 17:54:36'),(54,59,2,5,'2025-01-25','2025-11-24 17:54:36'),(55,60,2,4,'2025-01-28','2025-11-24 17:54:36'),(56,61,2,5,'2025-02-01','2025-11-24 17:54:36'),(57,62,4,4,'2025-01-16','2025-11-24 17:54:36'),(58,63,4,5,'2025-01-19','2025-11-24 17:54:36'),(59,64,4,4,'2025-01-23','2025-11-24 17:54:36'),(60,65,4,5,'2025-01-26','2025-11-24 17:54:36'),(61,66,1,4,'2025-01-17','2025-11-24 17:54:36'),(62,67,1,5,'2025-01-21','2025-11-24 17:54:36'),(63,68,1,4,'2025-01-24','2025-11-24 17:54:36'),(64,69,1,5,'2025-01-27','2025-11-24 17:54:36'),(65,70,1,4,'2025-01-30','2025-11-24 17:54:36'),(66,71,1,5,'2025-02-02','2025-11-24 17:54:36'),(67,72,1,4,'2025-02-05','2025-11-24 17:54:36'),(68,73,4,5,'2025-06-10','2025-11-24 17:54:36'),(69,74,4,4,'2025-06-12','2025-11-24 17:54:36'),(70,75,4,5,'2025-06-15','2025-11-24 17:54:36'),(71,76,3,4,'2025-06-08','2025-11-24 17:54:36'),(72,77,3,5,'2025-06-11','2025-11-24 17:54:36'),(73,78,3,4,'2025-06-14','2025-11-24 17:54:36'),(74,79,2,5,'2025-06-09','2025-11-24 17:54:36'),(75,80,2,4,'2025-06-13','2025-11-24 17:54:36'),(76,81,1,5,'2025-06-07','2025-11-24 17:54:36'),(77,82,1,4,'2025-06-16','2025-11-24 17:54:36'),(78,127,2,2,'2025-11-29','2025-12-12 13:27:25'),(79,128,3,2,'2025-12-12','2025-12-12 13:27:51'),(80,110,4,4,'2024-12-20','2025-12-13 18:57:08');
/*!40000 ALTER TABLE `grades` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_check_teacher_assignment_before_grade_insert` BEFORE INSERT ON `grades` FOR EACH ROW BEGIN
    DECLARE valid_count INT DEFAULT 0;
    
    SELECT COUNT(*) INTO valid_count
    FROM enrollments e
    JOIN course_assignments ca 
      ON e.course_id = ca.course_id
     AND e.academic_year = ca.academic_year
     AND e.semester = ca.semester
    WHERE e.enrollment_id = NEW.enrollment_id
      AND ca.teacher_id = NEW.teacher_id;
      
    IF valid_count = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Ошибка: преподаватель не назначен на этот курс в указанный семестр и год.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `student_groups`
--

DROP TABLE IF EXISTS `student_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_groups` (
  `group_id` int NOT NULL AUTO_INCREMENT,
  `group_name` varchar(20) NOT NULL,
  `program` varchar(100) DEFAULT 'Информационные технологии',
  `admission_year` year NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`group_id`),
  UNIQUE KEY `group_name` (`group_name`),
  KEY `idx_groups_name` (`group_name`),
  KEY `idx_groups_year` (`admission_year`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Учебные группы студентов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_groups`
--

LOCK TABLES `student_groups` WRITE;
/*!40000 ALTER TABLE `student_groups` DISABLE KEYS */;
INSERT INTO `student_groups` VALUES (1,'ИТ-101','Информационные технологии',2023,'2025-11-24 17:11:04'),(2,'ИТ-102','Информационные технологии',2023,'2025-11-24 17:11:04'),(3,'ИТ-103','Информационные технологии',2023,'2025-11-24 17:11:04'),(4,'ИТ-104','Информационные технологии',2023,'2025-11-24 17:11:04'),(5,'ЛТ-101','Информационные технологии',2024,'2025-11-24 17:11:04'),(6,'ЛТ-102','Информационные технологии',2024,'2025-11-24 17:11:04'),(7,'ЛТ-241','Информационные технологии',2024,'2025-11-24 17:11:04'),(8,'МЛИТЕХ-242','Информационные технологии',2025,'2025-11-24 17:11:04');
/*!40000 ALTER TABLE `student_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
  `student_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `date_of_birth` date NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `group_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`student_id`),
  UNIQUE KEY `unique_student_identity` (`first_name`,`last_name`,`date_of_birth`),
  UNIQUE KEY `email` (`email`),
  KEY `idx_students_name` (`first_name`,`last_name`),
  KEY `idx_students_group_id` (`group_id`),
  CONSTRAINT `students_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `student_groups` (`group_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Студенты: ФИО, дата рождения, контакты, группа';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (1,'Иван','Петров','2000-05-15','ivan.petrov@edu.ru','+79161234567',1,'2025-11-24 17:11:28'),(2,'Мария','Сидорова','2001-03-22','maria.sidorova@edu.ru','+79161234568',1,'2025-11-24 17:11:28'),(3,'Алексей','Козлов','2000-11-08','alexey.kozlov@edu.ru','+79161234569',2,'2025-11-24 17:11:28'),(4,'Екатерина','Николаева','2001-07-30','ekaterina.nikolaeva@edu.ru','+79161234570',2,'2025-11-24 17:11:28'),(5,'Дмитрий','Васильев','2000-12-14','dmitry.vasiliev@edu.ru','+79161234571',1,'2025-11-24 17:11:28'),(6,'Анна','Морозова','2001-02-18','anna.morozova@edu.ru','+79161234572',3,'2025-11-24 17:11:28'),(7,'Сергей','Орлов','2000-09-25','sergey.orlov@edu.ru','+79161234573',3,'2025-11-24 17:11:28'),(8,'Мария','Янковская','2002-09-25','mar.yan@edu.ru','+79188234573',2,'2025-11-24 17:11:28'),(9,'София','Галич','2000-07-21','sof.gal@edu.ru','+79164571233',3,'2025-11-24 17:11:28'),(10,'Александр','Орлов','2006-03-25','alexandr.orlov@edu.ru','+79162224573',4,'2025-11-24 17:11:28'),(11,'Марк','Патокин','2005-10-15','mp@edu.ru','+79191234573',4,'2025-11-24 17:11:28'),(12,'Анна','Осман','2005-11-25','ao@edu.ru','+79261234573',4,'2025-11-24 17:11:28'),(13,'Екатерина','Кварц','2000-02-17','ek@edu.ru','+79161234333',5,'2025-11-24 17:11:28'),(14,'Сара','Бернар','2000-01-13','sb@edu.ru','+79161224573',5,'2025-11-24 17:11:28'),(15,'Алексей','Смартов','2000-04-29','as@edu.ru','+79161234573',5,'2025-11-24 17:11:28'),(16,'Ясмина','Мудрая','2000-03-12','yas@edu.ru','+79169374573',6,'2025-11-24 17:11:28'),(17,'Варвара','Фадеева','2003-12-21','vf@edu.ru','+79161234873',6,'2025-11-24 17:11:28'),(18,'Сергей','Пучнин','2001-09-25','sp@edu.ru','+79321234573',6,'2025-11-24 17:11:28'),(19,'Злата','Мудрая','2007-01-10','zm@edu.ru','+79161234443',7,'2025-11-24 17:11:28'),(20,'Софья','Великая','2007-02-11','sv@edu.ru','+75461234573',7,'2025-11-24 17:11:28'),(21,'Петр','Первый','2006-03-12','pp@edu.ru','+79162234573',7,'2025-11-24 17:11:28'),(22,'Ярослав','Мудрый','2008-04-13','yam@edu.ru','+79961234573',8,'2025-11-24 17:11:28'),(23,'Леонид','Островский','2007-05-14','lo@edu.ru','+79161237773',8,'2025-11-24 17:11:28'),(24,'Дмитрий','Ивушкин','2009-06-15','di@edu.ru','+79163234373',8,'2025-11-24 17:11:28'),(27,'Александр','Новоселов','2002-08-15','an@edu.ru','+79112233412',1,'2025-12-08 18:35:28'),(28,'Никита','Соколов','2003-11-28','ns@edu.ru','+79161234604',3,'2025-12-08 18:39:45');
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teachers`
--

DROP TABLE IF EXISTS `teachers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teachers` (
  `teacher_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `date_of_birth` date NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `hire_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`teacher_id`),
  UNIQUE KEY `unique_teacher_identity` (`first_name`,`last_name`,`date_of_birth`),
  UNIQUE KEY `email` (`email`),
  KEY `idx_teachers_name` (`first_name`,`last_name`),
  KEY `idx_teachers_hire_date` (`hire_date`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Преподаватели: ФИО, дата рождения, контакты, дата найма';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teachers`
--

LOCK TABLES `teachers` WRITE;
/*!40000 ALTER TABLE `teachers` DISABLE KEYS */;
INSERT INTO `teachers` VALUES (1,'Анна','Смирнова','1975-08-10','anna.smirnova@university.ru','+79161111111','2010-09-01','2025-11-24 17:18:27'),(2,'Сергей','Иванов','1980-03-25','sergey.ivanov@university.ru','+79161111112','2015-02-15','2025-11-24 17:18:27'),(3,'Ольга','Павлова','1978-11-17','olga.pavlova@university.ru','+79161111113','2012-08-20','2025-11-24 17:18:27'),(4,'Михаил','Федоров','1982-06-05','mikhail.fedorov-new@university.ru','+79169990213','2018-01-10','2025-11-24 17:18:27'),(5,'Елена','Ковалева','1979-04-12','elena.kovaleva@university.ru','+79161111115','2016-03-01','2025-11-24 17:18:27');
/*!40000 ALTER TABLE `teachers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'final_university_db'
--

--
-- Dumping routines for database 'final_university_db'
--
/*!50003 DROP PROCEDURE IF EXISTS `activate_course` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `activate_course`(
    IN p_course_id INT,
    IN p_activated_by INT,
    IN p_reason VARCHAR(255)
)
BEGIN
    DECLARE v_course_name VARCHAR(100);
    
  
    IF NOT EXISTS (SELECT 1 FROM courses WHERE course_id = p_course_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Курс не найден';
    END IF;
    
    IF EXISTS (SELECT 1 FROM courses WHERE course_id = p_course_id AND is_active = 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Курс уже активен';
    END IF;
    
    SELECT course_name INTO v_course_name 
    FROM courses WHERE course_id = p_course_id;
   
    UPDATE courses 
    SET is_active = 1 
    WHERE course_id = p_course_id;
    
    
    SELECT 
        'SUCCESS' as status,
        CONCAT('Курс "', v_course_name, '" активирован') as message,
        'Статус: is_active = 1' as details;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddGradeSimple` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddGradeSimple`(
    IN p_student_first_name VARCHAR(50),
    IN p_student_last_name VARCHAR(50),
    IN p_course_name VARCHAR(100),
    IN p_teacher_first_name VARCHAR(50),
    IN p_teacher_last_name VARCHAR(50),
    IN p_grade TINYINT,
    IN p_exam_date DATE,
    IN p_academic_year YEAR,
    IN p_semester TINYINT
)
BEGIN
    DECLARE v_student_id INT;
    DECLARE v_course_id INT;
    DECLARE v_teacher_id INT;
    DECLARE v_enrollment_id INT;
    
   
    SELECT student_id INTO v_student_id
    FROM students 
    WHERE first_name = p_student_first_name 
      AND last_name = p_student_last_name;
    
    IF v_student_id IS NULL THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Студент не найден';
    END IF;
    
 
    SELECT course_id INTO v_course_id
    FROM courses 
    WHERE course_name = p_course_name;
    
    IF v_course_id IS NULL THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Курс не найден';
    END IF;
    
  
    SELECT teacher_id INTO v_teacher_id
    FROM teachers 
    WHERE first_name = p_teacher_first_name 
      AND last_name = p_teacher_last_name;
    
    IF v_teacher_id IS NULL THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Преподаватель не найден';
    END IF;
    
  
    IF p_grade < 1 OR p_grade > 5 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Оценка должна быть от 1 до 5';
    END IF;
    
  
    SELECT enrollment_id INTO v_enrollment_id
    FROM enrollments 
    WHERE student_id = v_student_id 
      AND course_id = v_course_id
      AND academic_year = p_academic_year
      AND semester = p_semester;
    
    IF v_enrollment_id IS NULL THEN
        INSERT INTO enrollments (student_id, course_id, academic_year, semester)
        VALUES (v_student_id, v_course_id, p_academic_year, p_semester);
        
        SET v_enrollment_id = LAST_INSERT_ID();
    END IF;
    
   
    INSERT INTO grades (enrollment_id, teacher_id, grade, exam_date)
    VALUES (v_enrollment_id, v_teacher_id, p_grade, p_exam_date);
    
  
    SELECT 
        'Оценка добавлена' as status,
        CONCAT(p_student_first_name, ' ', p_student_last_name) as student,
        p_course_name as course,
        p_grade as grade,
        p_exam_date as exam_date,
        CONCAT(p_teacher_first_name, ' ', p_teacher_last_name) as teacher;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddStudent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddStudent`(
    IN p_first_name VARCHAR(50),
    IN p_last_name VARCHAR(50),
    IN p_date_of_birth DATE,
    IN p_email VARCHAR(100),
    IN p_phone_number VARCHAR(20),
    IN p_group_name VARCHAR(20)
)
BEGIN
    DECLARE v_group_id INT;
    
   
    SELECT group_id INTO v_group_id 
    FROM student_groups 
    WHERE group_name = p_group_name;
    
   
    IF v_group_id IS NULL THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Группа не найдена';
    END IF;
    
   
    IF EXISTS (
        SELECT 1 FROM students 
        WHERE first_name = p_first_name 
          AND last_name = p_last_name 
          AND date_of_birth = p_date_of_birth
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Студент уже существует';
    END IF;
    

    INSERT INTO students (
        first_name, 
        last_name, 
        date_of_birth, 
        email, 
        phone_number, 
        group_id
    ) VALUES (
        p_first_name,
        p_last_name,
        p_date_of_birth,
        p_email,
        p_phone_number,
        v_group_id
    );
    

    SELECT LAST_INSERT_ID() as new_student_id;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deactivate_course` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deactivate_course`(
    IN p_course_id INT,
    IN p_deactivated_by INT,
    IN p_reason VARCHAR(255)
)
BEGIN
    DECLARE v_course_name VARCHAR(100);
    
    IF NOT EXISTS (SELECT 1 FROM courses WHERE course_id = p_course_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Курс не найден';
    END IF;
    
    IF EXISTS (SELECT 1 FROM courses WHERE course_id = p_course_id AND is_active = 0) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Курс уже деактивирован';
    END IF;
    
    SELECT course_name INTO v_course_name 
    FROM courses WHERE course_id = p_course_id;
    
    UPDATE courses 
    SET is_active = 0 
    WHERE course_id = p_course_id;
    

    SELECT 
        'SUCCESS' as status,
        CONCAT('Курс "', v_course_name, '" деактивирован') as message,
        'Статус: is_active = 0' as details;
    
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

-- Dump completed on 2025-12-17 19:19:08
