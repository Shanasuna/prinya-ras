-- MySQL dump 10.13  Distrib 5.5.31, for Linux (x86_64)
--
-- Host: localhost    Database: 
-- ------------------------------------------------------
-- Server version	(null)

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `Prinya_Project`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `Prinya_Project` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `Prinya_Project`;

--
-- Table structure for table `academic_year`
--

DROP TABLE IF EXISTS `academic_year`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `academic_year` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `semester_number` int(1) NOT NULL,
  `begin_date` date NOT NULL,
  `end_date` date NOT NULL,
  `university_id` int(11) DEFAULT NULL,
  `year` int(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `university_id` (`university_id`),
  CONSTRAINT `academic_year_ibfk_1` FOREIGN KEY (`university_id`) REFERENCES `university` (`university_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academic_year`
--

LOCK TABLES `academic_year` WRITE;
/*!40000 ALTER TABLE `academic_year` DISABLE KEYS */;
/*!40000 ALTER TABLE `academic_year` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assignment`
--

DROP TABLE IF EXISTS `assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assignment` (
  `assignment_id` int(6) NOT NULL AUTO_INCREMENT,
  `course_id` int(6) NOT NULL,
  `title` varchar(250) NOT NULL,
  `description` text,
  `file_id` int(6) DEFAULT NULL,
  `score` int(4) DEFAULT NULL,
  `percentage` int(3) DEFAULT NULL,
  PRIMARY KEY (`assignment_id`),
  KEY `course_id_idx` (`course_id`),
  KEY `file_id_idx` (`file_id`),
  CONSTRAINT `assignment_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `assignment_ibfk_2` FOREIGN KEY (`file_id`) REFERENCES `file` (`file_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assignment`
--

LOCK TABLES `assignment` WRITE;
/*!40000 ALTER TABLE `assignment` DISABLE KEYS */;
/*!40000 ALTER TABLE `assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendance`
--

DROP TABLE IF EXISTS `attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attendance` (
  `section_id` int(6) NOT NULL,
  `student_id` int(6) NOT NULL,
  `status` int(2) NOT NULL,
  `DATE` date DEFAULT NULL,
  `lastupdate` time DEFAULT NULL,
  PRIMARY KEY (`section_id`,`student_id`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`section_id`) REFERENCES `section` (`section_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `attendance_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance`
--

LOCK TABLES `attendance` WRITE;
/*!40000 ALTER TABLE `attendance` DISABLE KEYS */;
/*!40000 ALTER TABLE `attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campusannoucement`
--

DROP TABLE IF EXISTS `campusannoucement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campusannoucement` (
  `campusannoucement_id` int(6) NOT NULL,
  `title` varchar(250) DEFAULT NULL,
  `description` text,
  `create_date` timestamp NULL DEFAULT NULL,
  `create_by` int(6) NOT NULL,
  `university_id` int(6) NOT NULL,
  PRIMARY KEY (`campusannoucement_id`),
  KEY `create_by_idx` (`create_by`),
  KEY `university_id_idx` (`university_id`),
  CONSTRAINT `create_by_constraint2` FOREIGN KEY (`create_by`) REFERENCES `staff` (`staff_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `university_id_constraint3` FOREIGN KEY (`university_id`) REFERENCES `university` (`university_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campusannoucement`
--

LOCK TABLES `campusannoucement` WRITE;
/*!40000 ALTER TABLE `campusannoucement` DISABLE KEYS */;
/*!40000 ALTER TABLE `campusannoucement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campusevent`
--

DROP TABLE IF EXISTS `campusevent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campusevent` (
  `campusevent_id` int(6) NOT NULL,
  `title` varchar(250) DEFAULT NULL,
  `description` text,
  `create_date` timestamp NULL DEFAULT NULL,
  `start_date` int(1) DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_date` int(1) DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `create_by` int(6) NOT NULL,
  `university_id` int(6) NOT NULL,
  PRIMARY KEY (`campusevent_id`),
  KEY `create_by_idx` (`create_by`),
  KEY `university_id_idx` (`university_id`),
  CONSTRAINT `create_by_constraint1` FOREIGN KEY (`create_by`) REFERENCES `staff` (`staff_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `university_id_constraint4` FOREIGN KEY (`university_id`) REFERENCES `university` (`university_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campusevent`
--

LOCK TABLES `campusevent` WRITE;
/*!40000 ALTER TABLE `campusevent` DISABLE KEYS */;
/*!40000 ALTER TABLE `campusevent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course` (
  `course_id` int(6) NOT NULL AUTO_INCREMENT,
  `course_code` varchar(7) NOT NULL,
  `course_name` varchar(250) NOT NULL,
  `course_description` text NOT NULL,
  `credit_lecture` int(1) NOT NULL,
  `credit_lab` int(1) NOT NULL,
  `credit_learning` int(1) NOT NULL,
  `type_credit_lecture` int(1) NOT NULL,
  `type_credit_lab` int(1) NOT NULL,
  `price` int(6) NOT NULL,
  `department` varchar(250) NOT NULL,
  `faculty` varchar(250) NOT NULL,
  `faculty_id` int(6) NOT NULL,
  `university_id` int(11) DEFAULT NULL,
  `circle_id` varchar(250) DEFAULT NULL,
  `circle_url` varchar(250) DEFAULT NULL,
  `site_url` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`course_id`),
  KEY `university_id_constraint2` (`university_id`),
  KEY `faculty_id_constraint2` (`faculty_id`),
  CONSTRAINT `faculty_id_constraint2` FOREIGN KEY (`faculty_id`) REFERENCES `faculty` (`faculty_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `university_id_constraint2` FOREIGN KEY (`university_id`) REFERENCES `university` (`university_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (64,'188374','Test','test',3,0,3,0,0,100,'2','Engineering',2,1,NULL,NULL,NULL),(65,'TES-301','Test Course','Test Course to see mailing group, circle and site',3,3,3,0,0,0,'2','Engineering',2,1,'735391eb88e7624a','https://www.googleapis.com/plus/v1domains/circles/735391eb88e7624a',NULL),(66,'ENG-024','kkkI','Test',3,3,3,0,0,1000,'1','Engineering',1,3,NULL,NULL,NULL),(67,'ENG-025','tttI','Test',3,3,3,0,0,1000,'1','Engineering',1,3,NULL,NULL,NULL),(68,'ENG-026','ttt II','Test',3,3,3,0,0,1000,'1','Engineering',1,3,NULL,NULL,NULL),(69,'ENG-027','ttt III','Test',3,3,3,0,0,1000,'1','Engineering',1,3,NULL,NULL,NULL),(70,'ENG-028','ttt IV','Test',3,3,3,0,0,1000,'1','Engineering',1,3,NULL,NULL,NULL),(71,'ENG-029','ttt V','Test',3,3,3,0,0,1000,'1','Engineering',1,3,NULL,NULL,NULL),(72,'ENG-030','ttt VI','Test',3,3,3,0,0,1000,'1','Engineering',1,3,NULL,NULL,NULL),(73,'ENG-031','ttt VII','Test',3,3,3,0,0,1000,'1','Engineering',1,3,NULL,NULL,NULL),(74,'ENG-032','ttt VIII','Test',3,3,3,0,0,1000,'1','Engineering',1,3,NULL,NULL,NULL),(75,'ENG-033','ttt IX','Test',3,3,3,0,0,1000,'1','Engineering',1,3,NULL,NULL,NULL);
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cron_job`
--

DROP TABLE IF EXISTS `cron_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cron_job` (
  `id` int(6) NOT NULL,
  `semester_number` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cron_job`
--

LOCK TABLES `cron_job` WRITE;
/*!40000 ALTER TABLE `cron_job` DISABLE KEYS */;
INSERT INTO `cron_job` VALUES (1,1),(1,1),(1,1),(1,1),(1,1),(1,1),(1,1),(1,1);
/*!40000 ALTER TABLE `cron_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `department_id` int(6) NOT NULL AUTO_INCREMENT,
  `department_name` varchar(50) NOT NULL,
  `faculty_id` int(6) NOT NULL,
  `fee` int(11) DEFAULT NULL,
  PRIMARY KEY (`department_id`),
  KEY `faculty_id` (`faculty_id`),
  CONSTRAINT `faculty_id` FOREIGN KEY (`faculty_id`) REFERENCES `faculty` (`faculty_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam`
--

DROP TABLE IF EXISTS `exam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exam` (
  `exam_id` int(6) NOT NULL AUTO_INCREMENT,
  `course_id` int(6) NOT NULL,
  `title` varchar(250) NOT NULL,
  `description` text,
  `DATE` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `room` varchar(50) DEFAULT NULL,
  `score` int(4) DEFAULT NULL,
  `percentage` int(3) DEFAULT NULL,
  PRIMARY KEY (`exam_id`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `exam_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam`
--

LOCK TABLES `exam` WRITE;
/*!40000 ALTER TABLE `exam` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `examscore`
--

DROP TABLE IF EXISTS `examscore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `examscore` (
  `exam_id` int(6) NOT NULL,
  `student_id` int(6) NOT NULL,
  `score` int(4) DEFAULT NULL,
  PRIMARY KEY (`exam_id`,`student_id`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `examscore_ibfk_1` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`exam_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `examscore_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `examscore`
--

LOCK TABLES `examscore` WRITE;
/*!40000 ALTER TABLE `examscore` DISABLE KEYS */;
/*!40000 ALTER TABLE `examscore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faculty`
--

DROP TABLE IF EXISTS `faculty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faculty` (
  `faculty_id` int(6) NOT NULL AUTO_INCREMENT,
  `title` varchar(250) NOT NULL,
  `maxcredit_per_semester` int(6) NOT NULL,
  `fee` int(6) NOT NULL,
  `university_id` int(6) NOT NULL,
  `department` text,
  PRIMARY KEY (`faculty_id`),
  KEY `university_id_constraint1` (`university_id`),
  CONSTRAINT `university_id_constraint1` FOREIGN KEY (`university_id`) REFERENCES `university` (`university_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faculty`
--

LOCK TABLES `faculty` WRITE;
/*!40000 ALTER TABLE `faculty` DISABLE KEYS */;
INSERT INTO `faculty` VALUES (1,'Engineering',23,0,3,'Computer Engineering,Environment Engineering, Electrical Engineering, Mechanical Engineering'),(2,'Engineering',23,0,1,'Computer Engineering,Environment Engineering, Electrical Engineering, Mechanical Engineering'),(3,'Science',23,0,1,'Computer Science, Maths, Biology');
/*!40000 ALTER TABLE `faculty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file`
--

DROP TABLE IF EXISTS `file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file` (
  `file_id` int(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  `url` text,
  `timestamp` time NOT NULL,
  `type` varchar(25) NOT NULL,
  PRIMARY KEY (`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file`
--

LOCK TABLES `file` WRITE;
/*!40000 ALTER TABLE `file` DISABLE KEYS */;
/*!40000 ALTER TABLE `file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `followcourse`
--

DROP TABLE IF EXISTS `followcourse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `followcourse` (
  `follow_id` int(6) NOT NULL AUTO_INCREMENT,
  `student_id` int(6) NOT NULL,
  `regiscourse_id` int(6) NOT NULL,
  `section_id` int(6) NOT NULL,
  PRIMARY KEY (`follow_id`),
  KEY `student_id_idx` (`student_id`),
  KEY `regiscourse_id_idx` (`regiscourse_id`),
  KEY `section_id_idx` (`section_id`),
  CONSTRAINT `regiscourse_id_constraint22` FOREIGN KEY (`regiscourse_id`) REFERENCES `regiscourse` (`regiscourse_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `section_id_constraint22` FOREIGN KEY (`section_id`) REFERENCES `section` (`section_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `student_id_constraint22` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `followcourse`
--

LOCK TABLES `followcourse` WRITE;
/*!40000 ALTER TABLE `followcourse` DISABLE KEYS */;
/*!40000 ALTER TABLE `followcourse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gradinginfo`
--

DROP TABLE IF EXISTS `gradinginfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gradinginfo` (
  `course_id` int(6) NOT NULL,
  `type` varchar(10) NOT NULL,
  `percentage` int(3) DEFAULT NULL,
  PRIMARY KEY (`course_id`,`type`),
  CONSTRAINT `gradinginfo_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gradinginfo`
--

LOCK TABLES `gradinginfo` WRITE;
/*!40000 ALTER TABLE `gradinginfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `gradinginfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gradingscore`
--

DROP TABLE IF EXISTS `gradingscore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gradingscore` (
  `student_id` int(6) NOT NULL,
  `course_id` int(6) NOT NULL,
  `grade` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`course_id`,`student_id`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `gradingscore_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `gradingscore_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gradingscore`
--

LOCK TABLES `gradingscore` WRITE;
/*!40000 ALTER TABLE `gradingscore` DISABLE KEYS */;
/*!40000 ALTER TABLE `gradingscore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lesson`
--

DROP TABLE IF EXISTS `lesson`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lesson` (
  `lesson_id` int(6) NOT NULL AUTO_INCREMENT,
  `course_id` int(6) NOT NULL,
  `title` varchar(250) NOT NULL,
  `description` text,
  `file_id` int(6) DEFAULT NULL,
  PRIMARY KEY (`lesson_id`),
  KEY `course_id_idx` (`course_id`),
  KEY `file_id_idx` (`file_id`),
  CONSTRAINT `lesson_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `lesson_ibfk_2` FOREIGN KEY (`file_id`) REFERENCES `file` (`file_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lesson`
--

LOCK TABLES `lesson` WRITE;
/*!40000 ALTER TABLE `lesson` DISABLE KEYS */;
/*!40000 ALTER TABLE `lesson` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log` (
  `log_id` int(6) NOT NULL AUTO_INCREMENT,
  `staff_id` int(6) NOT NULL,
  `course_code` varchar(7) NOT NULL,
  `day` date NOT NULL,
  `time` time NOT NULL,
  `type` int(1) NOT NULL,
  `university_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log`
--

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
INSERT INTO `log` VALUES (1,1007,'TES-301','2013-09-21','21:32:17',1,1),(2,1007,'TES-301','2013-09-21','21:32:35',2,1),(3,1019,'ENG-029','2013-09-21','00:39:06',1,3),(4,1019,'ENG-030','2013-09-21','00:41:15',1,3),(5,1019,'ENG-031','2013-09-21','00:44:01',1,3),(6,1019,'ENG-032','2013-09-21','00:48:31',1,3),(7,1019,'ENG-033','2013-09-21','00:52:06',1,3);
/*!40000 ALTER TABLE `log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paymentstatus`
--

DROP TABLE IF EXISTS `paymentstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paymentstatus` (
  `payment_id` int(6) NOT NULL AUTO_INCREMENT,
  `student_id` int(6) NOT NULL,
  `semester` int(1) NOT NULL,
  `year` int(4) NOT NULL,
  `status` int(1) DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `student_id_idx` (`student_id`),
  CONSTRAINT `paymentstatus_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paymentstatus`
--

LOCK TABLES `paymentstatus` WRITE;
/*!40000 ALTER TABLE `paymentstatus` DISABLE KEYS */;
/*!40000 ALTER TABLE `paymentstatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prerequisite_course`
--

DROP TABLE IF EXISTS `prerequisite_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prerequisite_course` (
  `p_id` int(6) NOT NULL AUTO_INCREMENT,
  `course_id` int(6) NOT NULL,
  `type` int(1) DEFAULT NULL,
  `prerequisite_id` int(6) NOT NULL,
  PRIMARY KEY (`p_id`),
  KEY `course_id_idx` (`course_id`),
  KEY `prerequisite_id_idx` (`prerequisite_id`),
  CONSTRAINT `course_id_constraint` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `prerequisite_id_constraint` FOREIGN KEY (`prerequisite_id`) REFERENCES `course` (`course_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prerequisite_course`
--

LOCK TABLES `prerequisite_course` WRITE;
/*!40000 ALTER TABLE `prerequisite_course` DISABLE KEYS */;
/*!40000 ALTER TABLE `prerequisite_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `regiscourse`
--

DROP TABLE IF EXISTS `regiscourse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `regiscourse` (
  `regiscourse_id` int(6) NOT NULL AUTO_INCREMENT,
  `course_id` int(6) NOT NULL,
  `semester` int(1) NOT NULL,
  `year` int(4) NOT NULL,
  `status` int(1) NOT NULL,
  `scorefile` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`regiscourse_id`),
  KEY `course_id_idx` (`course_id`),
  CONSTRAINT `course_id` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `regiscourse`
--

LOCK TABLES `regiscourse` WRITE;
/*!40000 ALTER TABLE `regiscourse` DISABLE KEYS */;
INSERT INTO `regiscourse` VALUES (49,65,1,2556,1,NULL),(50,66,1,2556,1,NULL),(51,67,1,2556,1,NULL),(52,68,1,2556,1,NULL),(53,69,1,2556,1,NULL),(54,70,1,2556,1,NULL),(55,71,1,2556,1,NULL),(56,72,1,2556,1,NULL),(57,73,1,2556,1,NULL),(58,74,1,2556,1,NULL),(59,75,1,2556,1,NULL);
/*!40000 ALTER TABLE `regiscourse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registeredcourse`
--

DROP TABLE IF EXISTS `registeredcourse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registeredcourse` (
  `registered_id` int(6) NOT NULL AUTO_INCREMENT,
  `student_id` int(6) NOT NULL,
  `regiscourse_id` int(6) NOT NULL,
  `section_id` int(6) NOT NULL,
  PRIMARY KEY (`registered_id`),
  KEY `student_id_idx` (`student_id`),
  KEY `regiscourse_id_idx` (`regiscourse_id`),
  KEY `section_id_idx` (`section_id`),
  CONSTRAINT `regiscourse_id_constraint11` FOREIGN KEY (`regiscourse_id`) REFERENCES `regiscourse` (`regiscourse_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `section_id_constraint11` FOREIGN KEY (`regiscourse_id`) REFERENCES `regiscourse` (`regiscourse_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `student_id_constraint11` FOREIGN KEY (`regiscourse_id`) REFERENCES `regiscourse` (`regiscourse_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registeredcourse`
--

LOCK TABLES `registeredcourse` WRITE;
/*!40000 ALTER TABLE `registeredcourse` DISABLE KEYS */;
/*!40000 ALTER TABLE `registeredcourse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `section`
--

DROP TABLE IF EXISTS `section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `section` (
  `section_id` int(6) NOT NULL AUTO_INCREMENT,
  `regiscourse_id` int(6) NOT NULL,
  `section_number` int(2) NOT NULL,
  `teacher_id` int(6) NOT NULL,
  `capacity` int(6) NOT NULL,
  `enroll` int(3) NOT NULL,
  `circle_id` varchar(250) DEFAULT NULL,
  `circle_url` varchar(250) DEFAULT NULL,
  `site_url` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`section_id`),
  KEY `regiscourse_id_idx` (`regiscourse_id`),
  KEY `teacher_id_idx` (`teacher_id`),
  CONSTRAINT `regiscourse_id` FOREIGN KEY (`regiscourse_id`) REFERENCES `regiscourse` (`regiscourse_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `section_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `staff` (`staff_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `section`
--

LOCK TABLES `section` WRITE;
/*!40000 ALTER TABLE `section` DISABLE KEYS */;
INSERT INTO `section` VALUES (44,49,1,14,30,0,'62181b5b0e7de73b','https://www.googleapis.com/plus/v1domains/circles/62181b5b0e7de73b',NULL);
/*!40000 ALTER TABLE `section` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `section_time`
--

DROP TABLE IF EXISTS `section_time`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `section_time` (
  `sectime_id` int(11) NOT NULL AUTO_INCREMENT,
  `day` int(1) NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `room` varchar(4) DEFAULT NULL,
  `section_id` int(6) NOT NULL,
  PRIMARY KEY (`sectime_id`),
  KEY `section_id_idx` (`section_id`),
  CONSTRAINT `section_id` FOREIGN KEY (`section_id`) REFERENCES `section` (`section_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `section_time`
--

LOCK TABLES `section_time` WRITE;
/*!40000 ALTER TABLE `section_time` DISABLE KEYS */;
/*!40000 ALTER TABLE `section_time` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `semester`
--

DROP TABLE IF EXISTS `semester`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `semester` (
  `semester_id` int(1) NOT NULL AUTO_INCREMENT,
  `open_date` date NOT NULL,
  `end_date` date NOT NULL,
  PRIMARY KEY (`semester_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `semester`
--

LOCK TABLES `semester` WRITE;
/*!40000 ALTER TABLE `semester` DISABLE KEYS */;
/*!40000 ALTER TABLE `semester` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff` (
  `staff_id` int(6) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `type` int(1) DEFAULT NULL,
  `office_locations` varchar(250) DEFAULT NULL,
  `associated_faculities` varchar(250) DEFAULT NULL,
  `university_id` int(6) DEFAULT NULL,
  `faculty_id` int(6) DEFAULT NULL,
  PRIMARY KEY (`staff_id`,`email`)
) ENGINE=InnoDB AUTO_INCREMENT=1020 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (1,'ku.tharnnapat_st@tni.ac.th','Tharnnapat','Kungwarnsishsorn','083-608-3901',1,'TNI','IT',1,NULL),(2,'kh.teerapol_st@tni.ac.th','Teerapol','Khajornkrung','083-811-6548',1,'TNI','IT',1,NULL),(3,'pr.vorachat _st@tni.ac.th','vorachat','promkul','-',1,'TNI','IT',1,NULL),(5,'tui2tone@gmail.com','Charuwit','Nodthaisong',NULL,2,NULL,NULL,3,NULL),(8,'sombat_ae@tni.ac.th','Sombat','Tamna',NULL,NULL,NULL,NULL,NULL,NULL),(9,'piyaporn_c@tni.ac.th','Piyaporn','Chansuay',NULL,NULL,NULL,NULL,NULL,NULL),(10,'icc_helpdesk@tni.ac.th','icchelp','icchelp',NULL,NULL,NULL,NULL,NULL,NULL),(11,'takashi_i@tni.ac.th','Takashi','Ikeda',NULL,NULL,NULL,NULL,NULL,NULL),(12,'takeshi_i@tni.ac.th','Takashi','IKEDA',NULL,NULL,NULL,NULL,NULL,NULL),(13,'icc_infrastructure@tni.ac.th','iccinfra','iccinfra',NULL,NULL,NULL,NULL,NULL,NULL),(14,'pichit_n@tni.ac.th','Pichit','Ngamjarussrivichai',NULL,2,NULL,NULL,1,NULL),(16,'anchalee_s@tni.ac.th','Anchalee','Supithak',NULL,NULL,NULL,NULL,NULL,NULL),(17,'athitaya_t@tni.ac.th','Athitaya','Thaiyong',NULL,NULL,NULL,NULL,NULL,NULL),(18,'it_tni@tni.ac.th','ittni','ittni',NULL,NULL,NULL,NULL,NULL,NULL),(19,'qa_tni@tni.ac.th','qa','qa',NULL,NULL,NULL,NULL,NULL,NULL),(20,'anchalee_y@tni.ac.th','anchalee_y','yunim',NULL,NULL,NULL,NULL,NULL,NULL),(21,'acad@tni.ac.th','TNI','ACAD',NULL,NULL,NULL,NULL,NULL,NULL),(22,'academics@tni.ac.th','academics','academics',NULL,NULL,NULL,NULL,NULL,NULL),(23,'adisak@tni.ac.th','Adisak','Suasaming',NULL,NULL,NULL,NULL,NULL,NULL),(24,'admin@tni.ac.th','Dolwichit','Junnarm',NULL,NULL,NULL,NULL,NULL,NULL),(25,'admission@tni.ac.th','admission','admission',NULL,NULL,NULL,NULL,NULL,NULL),(26,'adna@tni.ac.th','Adna','Sengto',NULL,NULL,NULL,NULL,NULL,NULL),(27,'aekkasit@tni.ac.th','Aekkasit','Pootrakool',NULL,NULL,NULL,NULL,NULL,NULL),(28,'aeknarong@tni.ac.th','aeknarong','aeknarong',NULL,NULL,NULL,NULL,NULL,NULL),(29,'akekarin@tni.ac.th','akekarin','akekarin',NULL,NULL,NULL,NULL,NULL,NULL),(30,'alan@tni.ac.th','Alan','Greenhill MCADAM',NULL,NULL,NULL,NULL,NULL,NULL),(31,'alongkorn@tni.ac.th','Alongkorn','Prakitpong',NULL,NULL,NULL,NULL,NULL,NULL),(32,'amarawadee@tni.ac.th','Amarawadee','Tappoon',NULL,NULL,NULL,NULL,NULL,NULL),(33,'amnart@tni.ac.th','amnart','amnart',NULL,NULL,NULL,NULL,NULL,NULL),(34,'amonpan@tni.ac.th','Amonpan','Chomklin',NULL,NULL,NULL,NULL,NULL,NULL),(35,'amorn@tni.ac.th','Amorn','Koomsupsiri',NULL,NULL,NULL,NULL,NULL,NULL),(36,'anan@tni.ac.th','Anan','Klaodee',NULL,NULL,NULL,NULL,NULL,NULL),(37,'anchalee@tni.ac.th','Anchalee','Yunim',NULL,NULL,NULL,NULL,NULL,NULL),(38,'anucha@tni.ac.th','Anucha','Bunjung',NULL,2,NULL,NULL,1,NULL),(39,'anusorn@tni.ac.th','Anusorn','Atthasiri',NULL,NULL,NULL,NULL,NULL,NULL),(40,'anuwat@tni.ac.th','Anuwat','Charoensuk',NULL,NULL,NULL,NULL,NULL,NULL),(41,'apichaya@tni.ac.th','Apichaya','Nimkoompai',NULL,NULL,NULL,NULL,NULL,NULL),(42,'araya@tni.ac.th','Araya','Hongchindaket',NULL,NULL,NULL,NULL,NULL,NULL),(43,'areerat@tni.ac.th','Areerat','Leelhaphunt',NULL,NULL,NULL,NULL,NULL,NULL),(44,'aroonluck@tni.ac.th','Aroonluck','Vithyavijin',NULL,NULL,NULL,NULL,NULL,NULL),(45,'athitaya@tni.ac.th','Athitaya','Thaiyong',NULL,NULL,NULL,NULL,NULL,NULL),(46,'attaphol@tni.ac.th','attaphol','attaphol',NULL,NULL,NULL,NULL,NULL,NULL),(47,'auemporn@tni.ac.th','Auemporn','Rodim',NULL,NULL,NULL,NULL,NULL,NULL),(48,'awaji@tni.ac.th','awaji','awaji',NULL,NULL,NULL,NULL,NULL,NULL),(49,'bandhit@tni.ac.th','Bandhit','Rojarayanont',NULL,NULL,NULL,NULL,NULL,NULL),(50,'bba@tni.ac.th','BBA','TNI',NULL,NULL,NULL,NULL,NULL,NULL),(51,'bohdan@tni.ac.th','bohdan','bohdan',NULL,NULL,NULL,NULL,NULL,NULL),(52,'boonchai@tni.ac.th','Boonchai','Khongsagtrakool',NULL,NULL,NULL,NULL,NULL,NULL),(53,'boonrit@tni.ac.th','Boonrit','Keawprachum',NULL,NULL,NULL,NULL,NULL,NULL),(54,'budsaraphorn@tni.ac.th','Budsaraphorn','Luangmalawat',NULL,NULL,NULL,NULL,NULL,NULL),(55,'buncha@tni.ac.th','Buncha','Choupradit',NULL,NULL,NULL,NULL,NULL,NULL),(56,'bundit@tni.ac.th','Bundit','Anuyahong',NULL,NULL,NULL,NULL,NULL,NULL),(57,'bunyawee@tni.ac.th','Bunyawee','Chokprasoetsom',NULL,NULL,NULL,NULL,NULL,NULL),(58,'busaraphorn@tni.ac.th','busaraphonrn','busaraphonrn',NULL,NULL,NULL,NULL,NULL,NULL),(59,'bussakorn@tni.ac.th','Bussakorn','Hammachukitatikul',NULL,NULL,NULL,NULL,NULL,NULL),(60,'calendar@tni.ac.th','calendar','calendar',NULL,NULL,NULL,NULL,NULL,NULL),(61,'cctv@tni.ac.th','cctv','cctv',NULL,NULL,NULL,NULL,NULL,NULL),(62,'ch.saravudh@tni.ac.th','Saravudh','Cheepchol',NULL,NULL,NULL,NULL,NULL,NULL),(63,'chalermkhwan@tni.ac.th','Chalermkhwan','Krootboonyong',NULL,NULL,NULL,NULL,NULL,NULL),(64,'chan@tni.ac.th','Chan','Jaruvongrangsee',NULL,NULL,NULL,NULL,NULL,NULL),(65,'chananya@tni.ac.th','Chananya','Lakdan',NULL,NULL,NULL,NULL,NULL,NULL),(66,'changepass@tni.ac.th','Change','Password',NULL,NULL,NULL,NULL,NULL,NULL),(67,'channu@tni.ac.th','Channu','Montriphiriyaphon',NULL,NULL,NULL,NULL,NULL,NULL),(68,'chanya@tni.ac.th','Chanya','Sontamino',NULL,NULL,NULL,NULL,NULL,NULL),(69,'chareeluk@tni.ac.th','Chareeluk','Tantip',NULL,NULL,NULL,NULL,NULL,NULL),(70,'chark@tni.ac.th','Chark','Tingsabhat',NULL,NULL,NULL,NULL,NULL,NULL),(71,'chartchan@tni.ac.th','Chartchan','Phodhiphad',NULL,NULL,NULL,NULL,NULL,NULL),(72,'chartree@tni.ac.th','Chartree','Tongwan',NULL,NULL,NULL,NULL,NULL,NULL),(73,'chatkamol@tni.ac.th','Chatkamol','Rodprasert',NULL,NULL,NULL,NULL,NULL,NULL),(74,'chatree@tni.ac.th','Chatree','Khongruay',NULL,NULL,NULL,NULL,NULL,NULL),(75,'chavakarn@tni.ac.th','Chavakarn','Tharapath',NULL,NULL,NULL,NULL,NULL,NULL),(76,'chie@tni.ac.th','chie','NAGATA',NULL,NULL,NULL,NULL,NULL,NULL),(77,'Chirapan@tni.ac.th','Chirapan','Oulapathorn',NULL,NULL,NULL,NULL,NULL,NULL),(78,'chittra@tni.ac.th','Chittra','Chantragatrawi',NULL,NULL,NULL,NULL,NULL,NULL),(79,'chombongkoch@tni.ac.th','chmbongkoch','chmbongkoch',NULL,NULL,NULL,NULL,NULL,NULL),(80,'chomchanok@tni.ac.th','Chomchanok','Sattorchat',NULL,NULL,NULL,NULL,NULL,NULL),(81,'chomphunut@tni.ac.th','Chomphunut','Krajangworanet',NULL,NULL,NULL,NULL,NULL,NULL),(82,'chonticha@tni.ac.th','Chonticha','Na-ngam',NULL,NULL,NULL,NULL,NULL,NULL),(83,'chookid@tni.ac.th','Chookid','Ngamwong',NULL,NULL,NULL,NULL,NULL,NULL),(84,'choompolpat@tni.ac.th','Choompolpat','Kongtanajaruanun',NULL,NULL,NULL,NULL,NULL,NULL),(85,'chothika@tni.ac.th','chothika','chothika',NULL,NULL,NULL,NULL,NULL,NULL),(86,'chutikarn@tni.ac.th','Chutikarn','Niyaboon',NULL,NULL,NULL,NULL,NULL,NULL),(87,'Copeland.m@tni.ac.th','Michael','James Copeland',NULL,NULL,NULL,NULL,NULL,NULL),(88,'daecha@tni.ac.th','Daecha','Tunmeesuk',NULL,NULL,NULL,NULL,NULL,NULL),(89,'daisuke@tni.ac.th','Daisuke','Kosaki',NULL,NULL,NULL,NULL,NULL,NULL),(90,'Damri@tni.ac.th','Damri','Sukhothanang',NULL,NULL,NULL,NULL,NULL,NULL),(91,'Damrong@tni.ac.th','Damrong','Thawesaengskulthai',NULL,NULL,NULL,NULL,NULL,NULL),(92,'datchakorn@tni.ac.th','datchakorn','datchakorn',NULL,NULL,NULL,NULL,NULL,NULL),(93,'dissatat@tni.ac.th','dissatat','dissatat',NULL,NULL,NULL,NULL,NULL,NULL),(94,'dolwichit@tni.ac.th','Dolwichit','Jannarm',NULL,NULL,NULL,NULL,NULL,NULL),(95,'don@tni.ac.th','Don','Kaewdook',NULL,NULL,NULL,NULL,NULL,NULL),(96,'duangkamon@tni.ac.th','Duangkamon','Chaiyaphut',NULL,NULL,NULL,NULL,NULL,NULL),(97,'dumrongkiat@tni.ac.th','Dumrongkiat','Rattana-amornpin',NULL,NULL,NULL,NULL,NULL,NULL),(98,'ek-u@tni.ac.th','Ek-u','Thammakornbunjut',NULL,NULL,NULL,NULL,NULL,NULL),(99,'ekanarong@tni.ac.th','ekanarong','ekanarong',NULL,NULL,NULL,NULL,NULL,NULL),(100,'ekkasit@tni.ac.th','Ekkasit','Khemnguad',NULL,NULL,NULL,NULL,NULL,NULL),(101,'elearning@tni.ac.th','elearning','elearning',NULL,NULL,NULL,NULL,NULL,NULL),(102,'engineering.tni@tni.ac.th','Engineering','TNI',NULL,NULL,NULL,NULL,NULL,NULL),(103,'example@tni.ac.th','example','example',NULL,NULL,NULL,NULL,NULL,NULL),(104,'fujino@tni.ac.th','Hiroshi','Fujino',NULL,NULL,NULL,NULL,NULL,NULL),(105,'fukuda@tni.ac.th','Miki','FUKUDA',NULL,NULL,NULL,NULL,NULL,NULL),(106,'gary@tni.ac.th','gary','gary',NULL,NULL,NULL,NULL,NULL,NULL),(107,'gearclub@tni.ac.th','gearclub','gearclub',NULL,NULL,NULL,NULL,NULL,NULL),(108,'griffee@tni.ac.th','John','Griffee',NULL,NULL,NULL,NULL,NULL,NULL),(109,'gun@tni.ac.th','Gun','Arlaiyart',NULL,NULL,NULL,NULL,NULL,NULL),(110,'haruthai@tni.ac.th','Haruthai','Sinwittayarak',NULL,NULL,NULL,NULL,NULL,NULL),(111,'helponline@tni.ac.th','helponline','helponline',NULL,NULL,NULL,NULL,NULL,NULL),(112,'hiroshi@tni.ac.th','hiroshi','FUJINO',NULL,NULL,NULL,NULL,NULL,NULL),(113,'icc@tni.ac.th','ICC-Mail','Thongchai',NULL,NULL,NULL,NULL,NULL,NULL),(114,'imamura@tni.ac.th','Imamura','Yuko',NULL,NULL,NULL,NULL,NULL,NULL),(115,'inagaki@tni.ac.th','inagaki','inagaki',NULL,NULL,NULL,NULL,NULL,NULL),(116,'inoue@tni.ac.th','Masashi','INOUE',NULL,NULL,NULL,NULL,NULL,NULL),(117,'international@tni.ac.th','international','international',NULL,NULL,NULL,NULL,NULL,NULL),(118,'ishida@tni.ac.th','ishida','ishida',NULL,NULL,NULL,NULL,NULL,NULL),(119,'itdoc@tni.ac.th','IT','Document',NULL,NULL,NULL,NULL,NULL,NULL),(120,'itqa1@tni.ac.th','Prakan','Kunnapab',NULL,NULL,NULL,NULL,NULL,NULL),(121,'itqa2@tni.ac.th','IT','QA',NULL,NULL,NULL,NULL,NULL,NULL),(122,'itqa3@tni.ac.th','IT','QA',NULL,NULL,NULL,NULL,NULL,NULL),(123,'jackson@tni.ac.th','James','Jackson',NULL,NULL,NULL,NULL,NULL,NULL),(124,'jakarin@tni.ac.th','jakarin','jakarin',NULL,NULL,NULL,NULL,NULL,NULL),(125,'jakkrapong@tni.ac.th','Jakkrapong','Limpanussorn',NULL,NULL,NULL,NULL,NULL,NULL),(126,'james@tni.ac.th','James','Stephen Gareth ALLEY',NULL,NULL,NULL,NULL,NULL,NULL),(127,'jarinee@tni.ac.th','Jarinee','Hoyhoul',NULL,NULL,NULL,NULL,NULL,NULL),(128,'jarinya@tni.ac.th','jarinya','jarinya',NULL,NULL,NULL,NULL,NULL,NULL),(129,'jarunee@tni.ac.th','Jarunee','Sinchairojkul',NULL,NULL,NULL,NULL,NULL,NULL),(130,'jatupat@tni.ac.th','Jatupat','Roungdom',NULL,NULL,NULL,NULL,NULL,NULL),(131,'jermjit@tni.ac.th','Jermjit','Yampaga',NULL,NULL,NULL,NULL,NULL,NULL),(132,'jintawat@tni.ac.th','Jintawat','Chaichanawong',NULL,NULL,NULL,NULL,NULL,NULL),(133,'jirapa@tni.ac.th','Jirapa','Khamta',NULL,NULL,NULL,NULL,NULL,NULL),(134,'jirapong@tni.ac.th','Jirapong','Sukatip',NULL,NULL,NULL,NULL,NULL,NULL),(135,'jittima@tni.ac.th','Jittima','Klaithai',NULL,NULL,NULL,NULL,NULL,NULL),(136,'journal@tni.ac.th','TNI','JOURNAL',NULL,NULL,NULL,NULL,NULL,NULL),(137,'juntra@tni.ac.th','Juntra','Rittiruk',NULL,NULL,NULL,NULL,NULL,NULL),(138,'juthamas@tni.ac.th','Juthamas','Prasopsan',NULL,NULL,NULL,NULL,NULL,NULL),(139,'kameshima@tni.ac.th','Keiki','KAMESHIMA',NULL,NULL,NULL,NULL,NULL,NULL),(140,'kan@tni.ac.th','Kan','Sakkamdoung',NULL,NULL,NULL,NULL,NULL,NULL),(141,'kanazawa@tni.ac.th','kanazawa','kanazawa',NULL,NULL,NULL,NULL,NULL,NULL),(142,'kanidta@tni.ac.th','Kanidta','Naksook',NULL,NULL,NULL,NULL,NULL,NULL),(143,'kanista@tni.ac.th','Kanista','Songjakkaew',NULL,NULL,NULL,NULL,NULL,NULL),(144,'kanjanaporn@tni.ac.th','Kanjanaporn','Namsimma',NULL,NULL,NULL,NULL,NULL,NULL),(145,'kanticha@tni.ac.th','Kanticha','Kittipeerachon',NULL,NULL,NULL,NULL,NULL,NULL),(146,'kanyakorn@tni.ac.th','Kanyakorn','Wongsri',NULL,NULL,NULL,NULL,NULL,NULL),(147,'kanyapat@tni.ac.th','Kanyapat','Ladpila',NULL,NULL,NULL,NULL,NULL,NULL),(148,'karnjana@tni.ac.th','Karnjana','Muennek',NULL,NULL,NULL,NULL,NULL,NULL),(149,'kasem@tni.ac.th','Kasem','Thiptarajan',NULL,NULL,NULL,NULL,NULL,NULL),(150,'kaseshima@tni.ac.th','kaseshima','kaseshima',NULL,NULL,NULL,NULL,NULL,NULL),(151,'katesuda@tni.ac.th','katesuda','katesuda',NULL,NULL,NULL,NULL,NULL,NULL),(152,'keiki@tni.ac.th','keiki','KAMESHIMA',NULL,NULL,NULL,NULL,NULL,NULL),(153,'kingmanee@tni.ac.th','Bhavita','Santiwongse',NULL,NULL,NULL,NULL,NULL,NULL),(154,'kitiya@tni.ac.th','kitiya','kitiya',NULL,NULL,NULL,NULL,NULL,NULL),(155,'kittisak@tni.ac.th','kittisak','kittisak',NULL,NULL,NULL,NULL,NULL,NULL),(156,'km@tni.ac.th','TNI','KM',NULL,NULL,NULL,NULL,NULL,NULL),(157,'kodaka@tni.ac.th','kadaka','kadaka',NULL,NULL,NULL,NULL,NULL,NULL),(158,'komkit@tni.ac.th','Komkit','Kongruay',NULL,NULL,NULL,NULL,NULL,NULL),(159,'kongkiat@tni.ac.th','Kongkiat','Weraarchakul',NULL,NULL,NULL,NULL,NULL,NULL),(160,'korakot@tni.ac.th','Korakot','Hamsathapat',NULL,NULL,NULL,NULL,NULL,NULL),(161,'kornthip@tni.ac.th','Kornthip','Ratanapumma',NULL,NULL,NULL,NULL,NULL,NULL),(162,'kosaka@tni.ac.th','Kosaka','Chikako',NULL,NULL,NULL,NULL,NULL,NULL),(163,'kosawat@tni.ac.th','Kosawat','Ratanothayanon',NULL,NULL,NULL,NULL,NULL,NULL),(164,'krisada.v@tni.ac.th','Krisada','Visavateeranon',NULL,NULL,NULL,NULL,NULL,NULL),(165,'krishna@tni.ac.th','Krisahna','Kosashunhanan',NULL,NULL,NULL,NULL,NULL,NULL),(166,'Krissanapong@tni.ac.th','Krissanapong','Kirtikara',NULL,NULL,NULL,NULL,NULL,NULL),(167,'kulrumpa@tni.ac.th','kulrumpa','kulrumpa',NULL,NULL,NULL,NULL,NULL,NULL),(168,'kuntaphot@tni.ac.th','Kuntaphot','Leeratanon',NULL,NULL,NULL,NULL,NULL,NULL),(169,'kunyada@tni.ac.th','kunyada','kunyada',NULL,NULL,NULL,NULL,NULL,NULL),(170,'kurihara@tni.ac.th','Kurihara','Naoko',NULL,NULL,NULL,NULL,NULL,NULL),(171,'lalida@tni.ac.th','Lalida','Puechamnuay',NULL,NULL,NULL,NULL,NULL,NULL),(172,'lalita@tni.ac.th','Lalita','Na Nongkhai',NULL,NULL,NULL,NULL,NULL,NULL),(173,'lerkiat@tni.ac.th','Lerkiat','Vongsarnpigoon',NULL,NULL,NULL,NULL,NULL,NULL),(174,'library@tni.ac.th','library','library',NULL,NULL,NULL,NULL,NULL,NULL),(175,'likasit@tni.ac.th','Likasit','Thong-orn',NULL,NULL,NULL,NULL,NULL,NULL),(176,'mailadmin@tni.ac.th','mailadmin','mailadmin',NULL,NULL,NULL,NULL,NULL,NULL),(177,'Mangkorn@tni.ac.th','Mangkorn','Rodprapakorn',NULL,NULL,NULL,NULL,NULL,NULL),(178,'manop@tni.ac.th','Manop','Choomphukae',NULL,NULL,NULL,NULL,NULL,NULL),(179,'marnote@tni.ac.th','marnote','boonjong',NULL,NULL,NULL,NULL,NULL,NULL),(180,'masashi@tni.ac.th','Masashi','INOUE',NULL,NULL,NULL,NULL,NULL,NULL),(181,'masuda@tni.ac.th','masuda','masuda',NULL,NULL,NULL,NULL,NULL,NULL),(182,'matsui@tni.ac.th','matsui','matsui',NULL,NULL,NULL,NULL,NULL,NULL),(183,'matthew@tni.ac.th','mattew','mattew',NULL,NULL,NULL,NULL,NULL,NULL),(184,'mayu@tni.ac.th','Mayu','Morigiwa',NULL,NULL,NULL,NULL,NULL,NULL),(185,'mayumi@tni.ac.th','Mayumi','Mineta',NULL,NULL,NULL,NULL,NULL,NULL),(186,'met.tni@tni.ac.th','TNI','MET',NULL,NULL,NULL,NULL,NULL,NULL),(187,'michael@tni.ac.th','michael','michael',NULL,NULL,NULL,NULL,NULL,NULL),(188,'mie@tni.ac.th','Mie','Tanaka',NULL,NULL,NULL,NULL,NULL,NULL),(189,'miki@tni.ac.th','Miki','Fukuda',NULL,NULL,NULL,NULL,NULL,NULL),(190,'mingkwan@tni.ac.th','mingkwan','mingkwan',NULL,NULL,NULL,NULL,NULL,NULL),(191,'mizutani@tni.ac.th','Koichi','Mizutani',NULL,NULL,NULL,NULL,NULL,NULL),(192,'mjames@tni.ac.th','Michael James','Copeland',NULL,NULL,NULL,NULL,NULL,NULL),(193,'motomura@tni.ac.th','Nokubo','MOTOMURA',NULL,NULL,NULL,NULL,NULL,NULL),(194,'mrbs@tni.ac.th','mrbs','mrbs',NULL,NULL,NULL,NULL,NULL,NULL),(195,'muraoka@tni.ac.th','muraoka','Shinsuke',NULL,NULL,NULL,NULL,NULL,NULL),(196,'nagata@tni.ac.th','Chie','NAGATA',NULL,NULL,NULL,NULL,NULL,NULL),(197,'nahoko@tni.ac.th','nahoko','TAKAMAGARI',NULL,NULL,NULL,NULL,NULL,NULL),(198,'naito@tni.ac.th','Naito','Naito',NULL,NULL,NULL,NULL,NULL,NULL),(199,'nakayama@tni.ac.th','nakayama','nakayama',NULL,NULL,NULL,NULL,NULL,NULL),(200,'nalinrat@tni.ac.th','Nalinrat','Sungsiri',NULL,NULL,NULL,NULL,NULL,NULL),(201,'namporn@tni.ac.th','Namporn','Sathirakul',NULL,NULL,NULL,NULL,NULL,NULL),(202,'nanapas@tni.ac.th','Nanapas','Wungsriroj',NULL,NULL,NULL,NULL,NULL,NULL),(203,'napaporn@tni.ac.th','Napaporn','Wijit',NULL,NULL,NULL,NULL,NULL,NULL),(204,'napat@tni.ac.th','napat','napat',NULL,NULL,NULL,NULL,NULL,NULL),(205,'naren@tni.ac.th','Naren','Chaithanee',NULL,NULL,NULL,NULL,NULL,NULL),(206,'narong@tni.ac.th','Narong','Anankawanich',NULL,NULL,NULL,NULL,NULL,NULL),(207,'narongpon@tni.ac.th','Narongpon','Boonsongpaisan',NULL,NULL,NULL,NULL,NULL,NULL),(209,'narungsun@tni.ac.th','Narungsun','Wilaisakoolyong',NULL,NULL,NULL,NULL,NULL,NULL),(210,'natcha@tni.ac.th','natcha','natcha',NULL,NULL,NULL,NULL,NULL,NULL),(211,'nattapong@tni.ac.th','Nattapong','Bangthamai',NULL,NULL,NULL,NULL,NULL,NULL),(212,'nattawadee@tni.ac.th','nattawadee','nattawadee',NULL,NULL,NULL,NULL,NULL,NULL),(213,'natthaphon@tni.ac.th','Natthaphon','JARAT',NULL,NULL,NULL,NULL,NULL,NULL),(214,'nattida@tni.ac.th','Nattida','Pucharoen',NULL,NULL,NULL,NULL,NULL,NULL),(215,'navarat@tni.ac.th','navarat','navarat',NULL,NULL,NULL,NULL,NULL,NULL),(216,'netprapa@tni.ac.th','netprapa','netprapa',NULL,NULL,NULL,NULL,NULL,NULL),(217,'nicholas@tni.ac.th','Nicholas','HOVER',NULL,NULL,NULL,NULL,NULL,NULL),(218,'nidapan@tni.ac.th','Nidapan','Sureerattanan',NULL,NULL,NULL,NULL,NULL,NULL),(219,'niratsai@tni.ac.th','Niratsai','Sornwit',NULL,NULL,NULL,NULL,NULL,NULL),(220,'nitirat@tni.ac.th','A.Nitirat','Tanthavech',NULL,NULL,NULL,NULL,NULL,NULL),(221,'nobuko@tni.ac.th','Nobuko','Motomura',NULL,NULL,NULL,NULL,NULL,NULL),(222,'nongnuch@tni.ac.th','Nongnuch','Pakon',NULL,NULL,NULL,NULL,NULL,NULL),(223,'nongpanga@tni.ac.th','Nongpanga','Ruengyot',NULL,NULL,NULL,NULL,NULL,NULL),(224,'noppadol@tni.ac.th','Noppadol','Sriputtha',NULL,NULL,NULL,NULL,NULL,NULL),(225,'nuchanart@tni.ac.th','Nuchanart','Pongpanich',NULL,NULL,NULL,NULL,NULL,NULL),(226,'nutchapon@tni.ac.th','Nutchapon','Somrak',NULL,NULL,NULL,NULL,NULL,NULL),(227,'nutcharee@tni.ac.th','Nutcharee','Saelee',NULL,NULL,NULL,NULL,NULL,NULL),(228,'nuttakarn@tni.ac.th','nuttakarn','nuttakarn',NULL,NULL,NULL,NULL,NULL,NULL),(230,'nuttapol@tni.ac.th','Nuttapol','Limjeerajarus',NULL,NULL,NULL,NULL,NULL,NULL),(231,'sombat_ae@tni.ac.th','Sombat','Tamna',NULL,NULL,NULL,NULL,NULL,NULL),(232,'oeb@tni.ac.th','Oeb','Taveechat',NULL,NULL,NULL,NULL,NULL,NULL),(233,'piyaporn_c@tni.ac.th','Piyaporn','Chansuay',NULL,NULL,NULL,NULL,NULL,NULL),(234,'okubo@tni.ac.th','Okubo','Hiroyuki',NULL,NULL,NULL,NULL,NULL,NULL),(235,'icc_helpdesk@tni.ac.th','icchelp','icchelp',NULL,NULL,NULL,NULL,NULL,NULL),(236,'orn@tni.ac.th','Orn','Eungkaneungdeja',NULL,NULL,NULL,NULL,NULL,NULL),(237,'takashi_i@tni.ac.th','Takashi','Ikeda',NULL,NULL,NULL,NULL,NULL,NULL),(238,'ornprang@tni.ac.th','Ornprang','Yamkunthong',NULL,NULL,NULL,NULL,NULL,NULL),(239,'takeshi_i@tni.ac.th','Takashi','IKEDA',NULL,NULL,NULL,NULL,NULL,NULL),(240,'pakin@tni.ac.th','pakin','lerdwichitwatthana',NULL,NULL,NULL,NULL,NULL,NULL),(241,'icc_infrastructure@tni.ac.th','iccinfra','iccinfra',NULL,NULL,NULL,NULL,NULL,NULL),(242,'paleerat@tni.ac.th','Paleerat','Lakawathana',NULL,NULL,NULL,NULL,NULL,NULL),(244,'panaree@tni.ac.th','panaree','panaree',NULL,NULL,NULL,NULL,NULL,NULL),(246,'panatkorn@tni.ac.th','panatkorn','panatkorn',NULL,NULL,NULL,NULL,NULL,NULL),(247,'anchalee_s@tni.ac.th','Anchalee','Supithak',NULL,NULL,NULL,NULL,NULL,NULL),(248,'panitharn@tni.ac.th','panitarn','panitarn',NULL,NULL,NULL,NULL,NULL,NULL),(249,'athitaya_t@tni.ac.th','Athitaya','Thaiyong',NULL,NULL,NULL,NULL,NULL,NULL),(250,'pannathadh@tni.ac.th','Pannathadh','Chomchark',NULL,NULL,NULL,NULL,NULL,NULL),(251,'it_tni@tni.ac.th','ittni','ittni',NULL,NULL,NULL,NULL,NULL,NULL),(252,'panya@tni.ac.th','panya','panya',NULL,NULL,NULL,NULL,NULL,NULL),(253,'qa_tni@tni.ac.th','qa','qa',NULL,NULL,NULL,NULL,NULL,NULL),(254,'pard@tni.ac.th','Pard','Teekasap',NULL,NULL,NULL,NULL,NULL,NULL),(255,'anchalee_y@tni.ac.th','anchalee_y','yunim',NULL,NULL,NULL,NULL,NULL,NULL),(256,'parichat@tni.ac.th','Parichat','Kongtong',NULL,NULL,NULL,NULL,NULL,NULL),(257,'acad@tni.ac.th','TNI','ACAD',NULL,NULL,NULL,NULL,NULL,NULL),(258,'pariwat@tni.ac.th','Pariwat','Khonggamnerd',NULL,NULL,NULL,NULL,NULL,NULL),(259,'academics@tni.ac.th','academics','academics',NULL,NULL,NULL,NULL,NULL,NULL),(260,'paskorn-a@tni.ac.th','Paskorn','Apiruk',NULL,NULL,NULL,NULL,NULL,NULL),(261,'adisak@tni.ac.th','Adisak','Suasaming',NULL,NULL,NULL,NULL,NULL,NULL),(262,'paskorn@tni.ac.th','Paskorn','phanophat',NULL,NULL,NULL,NULL,NULL,NULL),(263,'admin@tni.ac.th','Dolwichit','Junnarm',NULL,NULL,NULL,NULL,NULL,NULL),(264,'passakorn@tni.ac.th','passakorn','passakorn',NULL,NULL,NULL,NULL,NULL,NULL),(265,'admission@tni.ac.th','admission','admission',NULL,NULL,NULL,NULL,NULL,NULL),(266,'patcharee@tni.ac.th','Patcharee','Malathong',NULL,NULL,NULL,NULL,NULL,NULL),(267,'adna@tni.ac.th','Adna','Sengto',NULL,NULL,NULL,NULL,NULL,NULL),(268,'patraree@tni.ac.th','Patraree','Amatayakul',NULL,NULL,NULL,NULL,NULL,NULL),(269,'aekkasit@tni.ac.th','Aekkasit','Pootrakool',NULL,NULL,NULL,NULL,NULL,NULL),(270,'patsama@tni.ac.th','Patsama','Charoenpong',NULL,NULL,NULL,NULL,NULL,NULL),(271,'aeknarong@tni.ac.th','aeknarong','aeknarong',NULL,NULL,NULL,NULL,NULL,NULL),(272,'pattanapong@tni.ac.th','pattanapong','pattanapong',NULL,NULL,NULL,NULL,NULL,NULL),(273,'akekarin@tni.ac.th','akekarin','akekarin',NULL,NULL,NULL,NULL,NULL,NULL),(274,'paul@tni.ac.th','paul','paul',NULL,NULL,NULL,NULL,NULL,NULL),(275,'alan@tni.ac.th','Alan','Greenhill MCADAM',NULL,NULL,NULL,NULL,NULL,NULL),(276,'pawat@tni.ac.th','pawat','pawat',NULL,NULL,NULL,NULL,NULL,NULL),(277,'alongkorn@tni.ac.th','Alongkorn','Prakitpong',NULL,NULL,NULL,NULL,NULL,NULL),(278,'penkhae@tni.ac.th','Penkhae','Prachonpachanuk',NULL,NULL,NULL,NULL,NULL,NULL),(279,'amarawadee@tni.ac.th','Amarawadee','Tappoon',NULL,NULL,NULL,NULL,NULL,NULL),(280,'petchsri@tni.ac.th','Petchsri','Limpibunterng',NULL,NULL,NULL,NULL,NULL,NULL),(281,'amnart@tni.ac.th','amnart','amnart',NULL,NULL,NULL,NULL,NULL,NULL),(282,'peter@tni.ac.th','Peter','Holden',NULL,NULL,NULL,NULL,NULL,NULL),(283,'amonpan@tni.ac.th','Amonpan','Chomklin',NULL,NULL,NULL,NULL,NULL,NULL),(284,'ph.weeravat@tni.ac.th','WEERAVAT','PHASATIT',NULL,NULL,NULL,NULL,NULL,NULL),(285,'amorn@tni.ac.th','Amorn','Koomsupsiri',NULL,NULL,NULL,NULL,NULL,NULL),(286,'phaisarn@tni.ac.th','Phaisarn','Sudwilai',NULL,NULL,NULL,NULL,NULL,NULL),(287,'anan@tni.ac.th','Anan','Klaodee',NULL,NULL,NULL,NULL,NULL,NULL),(288,'phatcharin@tni.ac.th','Phatcharin','Setajan',NULL,NULL,NULL,NULL,NULL,NULL),(289,'anchalee@tni.ac.th','Anchalee','Yunim',NULL,NULL,NULL,NULL,NULL,NULL),(290,'phattira@tni.ac.th','phattira','phattira',NULL,NULL,NULL,NULL,NULL,NULL),(292,'phulporn@tni.ac.th','Phulporn','Saengbangpla',NULL,NULL,NULL,NULL,NULL,NULL),(293,'anusorn@tni.ac.th','Anusorn','Atthasiri',NULL,NULL,NULL,NULL,NULL,NULL),(295,'anuwat@tni.ac.th','Anuwat','Charoensuk',NULL,NULL,NULL,NULL,NULL,NULL),(296,'piengduen@tni.ac.th','Piengduen','Thawonkeaw',NULL,NULL,NULL,NULL,NULL,NULL),(297,'apichaya@tni.ac.th','Apichaya','Nimkoompai',NULL,NULL,NULL,NULL,NULL,NULL),(298,'pika@tni.ac.th','Pika','Chunvijittra',NULL,NULL,NULL,NULL,NULL,NULL),(299,'araya@tni.ac.th','Araya','Hongchindaket',NULL,NULL,NULL,NULL,NULL,NULL),(300,'pimpet@tni.ac.th','Pimpet','SratongOn',NULL,NULL,NULL,NULL,NULL,NULL),(301,'areerat@tni.ac.th','Areerat','Leelhaphunt',NULL,NULL,NULL,NULL,NULL,NULL),(302,'pimrot@tni.ac.th','Pimrot','Phipatanakul',NULL,NULL,NULL,NULL,NULL,NULL),(303,'aroonluck@tni.ac.th','Aroonluck','Vithyavijin',NULL,NULL,NULL,NULL,NULL,NULL),(304,'pisut@tni.ac.th','Pisut','Pongchairerks',NULL,NULL,NULL,NULL,NULL,NULL),(305,'athitaya@tni.ac.th','Athitaya','Thaiyong',NULL,NULL,NULL,NULL,NULL,NULL),(306,'pitsanu@tni.ac.th','pitsanu','pitsanu',NULL,NULL,NULL,NULL,NULL,NULL),(307,'attaphol@tni.ac.th','attaphol','attaphol',NULL,NULL,NULL,NULL,NULL,NULL),(308,'pittaya@tni.ac.th','Robin','Nont',NULL,NULL,NULL,NULL,NULL,NULL),(309,'auemporn@tni.ac.th','Auemporn','Rodim',NULL,NULL,NULL,NULL,NULL,NULL),(310,'piyaporn@tni.ac.th','Piyaporn','Boontang',NULL,NULL,NULL,NULL,NULL,NULL),(311,'awaji@tni.ac.th','awaji','awaji',NULL,NULL,NULL,NULL,NULL,NULL),(312,'Piyawat@tni.ac.th','Piyawat','Boon-Long',NULL,NULL,NULL,NULL,NULL,NULL),(313,'bandhit@tni.ac.th','Bandhit','Rojarayanont',NULL,NULL,NULL,NULL,NULL,NULL),(314,'pongpon@tni.ac.th','Pongpon','Suansri',NULL,NULL,NULL,NULL,NULL,NULL),(315,'bba@tni.ac.th','BBA','TNI',NULL,NULL,NULL,NULL,NULL,NULL),(316,'pongsak@tni.ac.th','Pongsak','Saithanya',NULL,NULL,NULL,NULL,NULL,NULL),(317,'bohdan@tni.ac.th','bohdan','bohdan',NULL,NULL,NULL,NULL,NULL,NULL),(318,'pongsakorn@tni.ac.th','pongsakorn','pongsakorn',NULL,NULL,NULL,NULL,NULL,NULL),(319,'boonchai@tni.ac.th','Boonchai','Khongsagtrakool',NULL,NULL,NULL,NULL,NULL,NULL),(320,'ponwimol@tni.ac.th','Ponwimol','Wipanarapai',NULL,NULL,NULL,NULL,NULL,NULL),(321,'boonrit@tni.ac.th','Boonrit','Keawprachum',NULL,NULL,NULL,NULL,NULL,NULL),(322,'pornanong@tni.ac.th','Pornanong','Niyomka Horikawa',NULL,NULL,NULL,NULL,NULL,NULL),(323,'budsaraphorn@tni.ac.th','Budsaraphorn','Luangmalawat',NULL,NULL,NULL,NULL,NULL,NULL),(324,'pornrat@tni.ac.th','Pornrat','Yenjai',NULL,NULL,NULL,NULL,NULL,NULL),(325,'buncha@tni.ac.th','Buncha','Choupradit',NULL,NULL,NULL,NULL,NULL,NULL),(326,'pornsawan@tni.ac.th','pornsawan','pornsawan',NULL,NULL,NULL,NULL,NULL,NULL),(327,'bundit@tni.ac.th','Bundit','Anuyahong',NULL,NULL,NULL,NULL,NULL,NULL),(328,'pr@tni.ac.th','pr','pr',NULL,NULL,NULL,NULL,NULL,NULL),(329,'bunyawee@tni.ac.th','Bunyawee','Chokprasoetsom',NULL,NULL,NULL,NULL,NULL,NULL),(330,'Pranee@tni.ac.th','Pranee','Jongsutjarittam',NULL,NULL,NULL,NULL,NULL,NULL),(331,'busaraphorn@tni.ac.th','busaraphonrn','busaraphonrn',NULL,NULL,NULL,NULL,NULL,NULL),(332,'pranisa@tni.ac.th','Pranisa','Israsena',NULL,NULL,NULL,NULL,NULL,NULL),(333,'bussakorn@tni.ac.th','Bussakorn','Hammachukitatikul',NULL,NULL,NULL,NULL,NULL,NULL),(334,'prapawarin@tni.ac.th','prapawarin','prapawarin',NULL,NULL,NULL,NULL,NULL,NULL),(335,'calendar@tni.ac.th','calendar','calendar',NULL,NULL,NULL,NULL,NULL,NULL),(336,'pratyawan@tni.ac.th','Pratyawan','Chantakhan',NULL,NULL,NULL,NULL,NULL,NULL),(337,'cctv@tni.ac.th','cctv','cctv',NULL,NULL,NULL,NULL,NULL,NULL),(338,'prawet@tni.ac.th','Prawet','Ueatringchit',NULL,NULL,NULL,NULL,NULL,NULL),(339,'ch.saravudh@tni.ac.th','Saravudh','Cheepchol',NULL,NULL,NULL,NULL,NULL,NULL),(340,'Prayoon@tni.ac.th','Prayoon','Shiowattana',NULL,NULL,NULL,NULL,NULL,NULL),(341,'chalermkhwan@tni.ac.th','Chalermkhwan','Krootboonyong',NULL,NULL,NULL,NULL,NULL,NULL),(342,'preyawan@tni.ac.th','Preyawan','P.',NULL,NULL,NULL,NULL,NULL,NULL),(343,'chan@tni.ac.th','Chan','Jaruvongrangsee',NULL,NULL,NULL,NULL,NULL,NULL),(344,'puranee@tni.ac.th','Puranee','Boonsri',NULL,NULL,NULL,NULL,NULL,NULL),(345,'chananya@tni.ac.th','Chananya','Lakdan',NULL,NULL,NULL,NULL,NULL,NULL),(346,'puttipong@tni.ac.th','Puttipong','Anantasopon',NULL,NULL,NULL,NULL,NULL,NULL),(347,'changepass@tni.ac.th','Change','Password',NULL,NULL,NULL,NULL,NULL,NULL),(348,'puwadol@tni.ac.th','Puwadol','Sirikongtham',NULL,NULL,NULL,NULL,NULL,NULL),(349,'channu@tni.ac.th','Channu','Montriphiriyaphon',NULL,NULL,NULL,NULL,NULL,NULL),(350,'qa@tni.ac.th','TNI','QA',NULL,NULL,NULL,NULL,NULL,NULL),(351,'chanya@tni.ac.th','Chanya','Sontamino',NULL,NULL,NULL,NULL,NULL,NULL),(352,'raksit@tni.ac.th','Raksit','Chutipakdeevong',NULL,NULL,NULL,NULL,NULL,NULL),(353,'chareeluk@tni.ac.th','Chareeluk','Tantip',NULL,NULL,NULL,NULL,NULL,NULL),(354,'rangsan@tni.ac.th','Rangsan','Krisaranont',NULL,NULL,NULL,NULL,NULL,NULL),(355,'chark@tni.ac.th','Chark','Tingsabhat',NULL,NULL,NULL,NULL,NULL,NULL),(356,'ratana@tni.ac.th','Sittipong','DajthaiRatana',NULL,NULL,NULL,NULL,NULL,NULL),(357,'chartchan@tni.ac.th','Chartchan','Phodhiphad',NULL,NULL,NULL,NULL,NULL,NULL),(358,'reg@tni.ac.th','TNI','REG',NULL,NULL,NULL,NULL,NULL,NULL),(359,'chartree@tni.ac.th','Chartree','Tongwan',NULL,NULL,NULL,NULL,NULL,NULL),(360,'registrar@tni.ac.th','registrar','registrar',NULL,NULL,NULL,NULL,NULL,NULL),(361,'chatkamol@tni.ac.th','Chatkamol','Rodprasert',NULL,NULL,NULL,NULL,NULL,NULL),(362,'research@tni.ac.th','research','research',NULL,NULL,NULL,NULL,NULL,NULL),(363,'chatree@tni.ac.th','Chatree','Khongruay',NULL,NULL,NULL,NULL,NULL,NULL),(364,'rodjaney@tni.ac.th','Rodjaney','Narinont',NULL,NULL,NULL,NULL,NULL,NULL),(365,'chavakarn@tni.ac.th','Chavakarn','Tharapath',NULL,NULL,NULL,NULL,NULL,NULL),(366,'ronnatud@tni.ac.th','Ronnatud','Julawattana',NULL,NULL,NULL,NULL,NULL,NULL),(367,'chie@tni.ac.th','chie','NAGATA',NULL,NULL,NULL,NULL,NULL,NULL),(368,'rungsun@tni.ac.th','Rungsun','Lertnaisat',NULL,NULL,NULL,NULL,NULL,NULL),(369,'Chirapan@tni.ac.th','Chirapan','Oulapathorn',NULL,NULL,NULL,NULL,NULL,NULL),(370,'rutairat@tni.ac.th','Rutairat','Vichaidis',NULL,NULL,NULL,NULL,NULL,NULL),(371,'chittra@tni.ac.th','Chittra','Chantragatrawi',NULL,NULL,NULL,NULL,NULL,NULL),(372,'ruttikorn@tni.ac.th','Ruttikorn','Varakulsiripunth',NULL,NULL,NULL,NULL,NULL,NULL),(373,'chombongkoch@tni.ac.th','chmbongkoch','chmbongkoch',NULL,NULL,NULL,NULL,NULL,NULL),(374,'sahasawat@tni.ac.th','Sahasawat','Phol-at',NULL,NULL,NULL,NULL,NULL,NULL),(375,'chomchanok@tni.ac.th','Chomchanok','Sattorchat',NULL,NULL,NULL,NULL,NULL,NULL),(376,'saisunee@tni.ac.th','kanyakorn','Wongsri',NULL,NULL,NULL,NULL,NULL,NULL),(377,'chomphunut@tni.ac.th','Chomphunut','Krajangworanet',NULL,NULL,NULL,NULL,NULL,NULL),(378,'sakchai@tni.ac.th','Sakchai','Kirinpanu',NULL,NULL,NULL,NULL,NULL,NULL),(379,'chonticha@tni.ac.th','Chonticha','Na-ngam',NULL,NULL,NULL,NULL,NULL,NULL),(380,'saleela@tni.ac.th','Saleela','Boontrakulsuk',NULL,NULL,NULL,NULL,NULL,NULL),(381,'chookid@tni.ac.th','Chookid','Ngamwong',NULL,NULL,NULL,NULL,NULL,NULL),(382,'salilrat@tni.ac.th','Salilrat','Kaweejarumongkol',NULL,NULL,NULL,NULL,NULL,NULL),(383,'choompolpat@tni.ac.th','Choompolpat','Kongtanajaruanun',NULL,NULL,NULL,NULL,NULL,NULL),(384,'salinla@tni.ac.th','Salinla','Chevakidagarn',NULL,NULL,NULL,NULL,NULL,NULL),(385,'chothika@tni.ac.th','chothika','chothika',NULL,NULL,NULL,NULL,NULL,NULL),(386,'sansanee@tni.ac.th','sansanee','sansanee',NULL,NULL,NULL,NULL,NULL,NULL),(387,'chutikarn@tni.ac.th','Chutikarn','Niyaboon',NULL,NULL,NULL,NULL,NULL,NULL),(388,'santhawut@tni.ac.th','Santhawut','Tularak',NULL,NULL,NULL,NULL,NULL,NULL),(389,'Copeland.m@tni.ac.th','Michael','James Copeland',NULL,NULL,NULL,NULL,NULL,NULL),(390,'santhiti@tni.ac.th','Santhiti','Thongnoi',NULL,NULL,NULL,NULL,NULL,NULL),(391,'daecha@tni.ac.th','Daecha','Tunmeesuk',NULL,NULL,NULL,NULL,NULL,NULL),(392,'daisuke@tni.ac.th','Daisuke','Kosaki',NULL,NULL,NULL,NULL,NULL,NULL),(393,'Damri@tni.ac.th','Damri','Sukhothanang',NULL,NULL,NULL,NULL,NULL,NULL),(394,'Damrong@tni.ac.th','Damrong','Thawesaengskulthai',NULL,NULL,NULL,NULL,NULL,NULL),(395,'datchakorn@tni.ac.th','datchakorn','datchakorn',NULL,NULL,NULL,NULL,NULL,NULL),(396,'dissatat@tni.ac.th','dissatat','dissatat',NULL,NULL,NULL,NULL,NULL,NULL),(397,'dolwichit@tni.ac.th','Dolwichit','Jannarm',NULL,NULL,NULL,NULL,NULL,NULL),(398,'don@tni.ac.th','Don','Kaewdook',NULL,NULL,NULL,NULL,NULL,NULL),(399,'duangkamon@tni.ac.th','Duangkamon','Chaiyaphut',NULL,NULL,NULL,NULL,NULL,NULL),(400,'dumrongkiat@tni.ac.th','Dumrongkiat','Rattana-amornpin',NULL,NULL,NULL,NULL,NULL,NULL),(401,'ek-u@tni.ac.th','Ek-u','Thammakornbunjut',NULL,NULL,NULL,NULL,NULL,NULL),(402,'ekanarong@tni.ac.th','ekanarong','ekanarong',NULL,NULL,NULL,NULL,NULL,NULL),(403,'ekkasit@tni.ac.th','Ekkasit','Khemnguad',NULL,NULL,NULL,NULL,NULL,NULL),(404,'elearning@tni.ac.th','elearning','elearning',NULL,NULL,NULL,NULL,NULL,NULL),(405,'engineering.tni@tni.ac.th','Engineering','TNI',NULL,NULL,NULL,NULL,NULL,NULL),(406,'example@tni.ac.th','example','example',NULL,NULL,NULL,NULL,NULL,NULL),(407,'fujino@tni.ac.th','Hiroshi','Fujino',NULL,NULL,NULL,NULL,NULL,NULL),(408,'fukuda@tni.ac.th','Miki','FUKUDA',NULL,NULL,NULL,NULL,NULL,NULL),(409,'gary@tni.ac.th','gary','gary',NULL,NULL,NULL,NULL,NULL,NULL),(410,'gearclub@tni.ac.th','gearclub','gearclub',NULL,NULL,NULL,NULL,NULL,NULL),(411,'griffee@tni.ac.th','John','Griffee',NULL,NULL,NULL,NULL,NULL,NULL),(412,'gun@tni.ac.th','Gun','Arlaiyart',NULL,NULL,NULL,NULL,NULL,NULL),(413,'haruthai@tni.ac.th','Haruthai','Sinwittayarak',NULL,NULL,NULL,NULL,NULL,NULL),(414,'helponline@tni.ac.th','helponline','helponline',NULL,NULL,NULL,NULL,NULL,NULL),(415,'hiroshi@tni.ac.th','hiroshi','FUJINO',NULL,NULL,NULL,NULL,NULL,NULL),(416,'icc@tni.ac.th','ICC-Mail','Thongchai',NULL,NULL,NULL,NULL,NULL,NULL),(417,'imamura@tni.ac.th','Imamura','Yuko',NULL,NULL,NULL,NULL,NULL,NULL),(418,'inagaki@tni.ac.th','inagaki','inagaki',NULL,NULL,NULL,NULL,NULL,NULL),(419,'inoue@tni.ac.th','Masashi','INOUE',NULL,NULL,NULL,NULL,NULL,NULL),(420,'international@tni.ac.th','international','international',NULL,NULL,NULL,NULL,NULL,NULL),(421,'ishida@tni.ac.th','ishida','ishida',NULL,NULL,NULL,NULL,NULL,NULL),(422,'itdoc@tni.ac.th','IT','Document',NULL,NULL,NULL,NULL,NULL,NULL),(423,'itqa1@tni.ac.th','Prakan','Kunnapab',NULL,NULL,NULL,NULL,NULL,NULL),(424,'itqa2@tni.ac.th','IT','QA',NULL,NULL,NULL,NULL,NULL,NULL),(425,'itqa3@tni.ac.th','IT','QA',NULL,NULL,NULL,NULL,NULL,NULL),(426,'jackson@tni.ac.th','James','Jackson',NULL,NULL,NULL,NULL,NULL,NULL),(427,'jakarin@tni.ac.th','jakarin','jakarin',NULL,NULL,NULL,NULL,NULL,NULL),(428,'jakkrapong@tni.ac.th','Jakkrapong','Limpanussorn',NULL,NULL,NULL,NULL,NULL,NULL),(429,'james@tni.ac.th','James','Stephen Gareth ALLEY',NULL,NULL,NULL,NULL,NULL,NULL),(430,'jarinee@tni.ac.th','Jarinee','Hoyhoul',NULL,NULL,NULL,NULL,NULL,NULL),(431,'jarinya@tni.ac.th','jarinya','jarinya',NULL,NULL,NULL,NULL,NULL,NULL),(432,'jarunee@tni.ac.th','Jarunee','Sinchairojkul',NULL,NULL,NULL,NULL,NULL,NULL),(433,'jatupat@tni.ac.th','Jatupat','Roungdom',NULL,NULL,NULL,NULL,NULL,NULL),(434,'jermjit@tni.ac.th','Jermjit','Yampaga',NULL,NULL,NULL,NULL,NULL,NULL),(435,'jintawat@tni.ac.th','Jintawat','Chaichanawong',NULL,NULL,NULL,NULL,NULL,NULL),(436,'jirapa@tni.ac.th','Jirapa','Khamta',NULL,NULL,NULL,NULL,NULL,NULL),(437,'jirapong@tni.ac.th','Jirapong','Sukatip',NULL,NULL,NULL,NULL,NULL,NULL),(438,'jittima@tni.ac.th','Jittima','Klaithai',NULL,NULL,NULL,NULL,NULL,NULL),(439,'journal@tni.ac.th','TNI','JOURNAL',NULL,NULL,NULL,NULL,NULL,NULL),(440,'juntra@tni.ac.th','Juntra','Rittiruk',NULL,NULL,NULL,NULL,NULL,NULL),(441,'juthamas@tni.ac.th','Juthamas','Prasopsan',NULL,NULL,NULL,NULL,NULL,NULL),(442,'kameshima@tni.ac.th','Keiki','KAMESHIMA',NULL,NULL,NULL,NULL,NULL,NULL),(443,'kan@tni.ac.th','Kan','Sakkamdoung',NULL,NULL,NULL,NULL,NULL,NULL),(444,'kanazawa@tni.ac.th','kanazawa','kanazawa',NULL,NULL,NULL,NULL,NULL,NULL),(445,'kanidta@tni.ac.th','Kanidta','Naksook',NULL,NULL,NULL,NULL,NULL,NULL),(446,'kanista@tni.ac.th','Kanista','Songjakkaew',NULL,NULL,NULL,NULL,NULL,NULL),(447,'kanjanaporn@tni.ac.th','Kanjanaporn','Namsimma',NULL,NULL,NULL,NULL,NULL,NULL),(448,'kanticha@tni.ac.th','Kanticha','Kittipeerachon',NULL,NULL,NULL,NULL,NULL,NULL),(449,'kanyakorn@tni.ac.th','Kanyakorn','Wongsri',NULL,NULL,NULL,NULL,NULL,NULL),(450,'kanyapat@tni.ac.th','Kanyapat','Ladpila',NULL,NULL,NULL,NULL,NULL,NULL),(451,'karnjana@tni.ac.th','Karnjana','Muennek',NULL,NULL,NULL,NULL,NULL,NULL),(452,'kasem@tni.ac.th','Kasem','Thiptarajan',NULL,NULL,NULL,NULL,NULL,NULL),(453,'kaseshima@tni.ac.th','kaseshima','kaseshima',NULL,NULL,NULL,NULL,NULL,NULL),(454,'katesuda@tni.ac.th','katesuda','katesuda',NULL,NULL,NULL,NULL,NULL,NULL),(455,'keiki@tni.ac.th','keiki','KAMESHIMA',NULL,NULL,NULL,NULL,NULL,NULL),(456,'kingmanee@tni.ac.th','Bhavita','Santiwongse',NULL,NULL,NULL,NULL,NULL,NULL),(457,'kitiya@tni.ac.th','kitiya','kitiya',NULL,NULL,NULL,NULL,NULL,NULL),(458,'kittisak@tni.ac.th','kittisak','kittisak',NULL,NULL,NULL,NULL,NULL,NULL),(459,'km@tni.ac.th','TNI','KM',NULL,NULL,NULL,NULL,NULL,NULL),(460,'kodaka@tni.ac.th','kadaka','kadaka',NULL,NULL,NULL,NULL,NULL,NULL),(461,'komkit@tni.ac.th','Komkit','Kongruay',NULL,NULL,NULL,NULL,NULL,NULL),(462,'kongkiat@tni.ac.th','Kongkiat','Weraarchakul',NULL,NULL,NULL,NULL,NULL,NULL),(463,'korakot@tni.ac.th','Korakot','Hamsathapat',NULL,NULL,NULL,NULL,NULL,NULL),(464,'kornthip@tni.ac.th','Kornthip','Ratanapumma',NULL,NULL,NULL,NULL,NULL,NULL),(465,'kosaka@tni.ac.th','Kosaka','Chikako',NULL,NULL,NULL,NULL,NULL,NULL),(466,'kosawat@tni.ac.th','Kosawat','Ratanothayanon',NULL,NULL,NULL,NULL,NULL,NULL),(467,'krisada.v@tni.ac.th','Krisada','Visavateeranon',NULL,NULL,NULL,NULL,NULL,NULL),(468,'krishna@tni.ac.th','Krisahna','Kosashunhanan',NULL,NULL,NULL,NULL,NULL,NULL),(469,'Krissanapong@tni.ac.th','Krissanapong','Kirtikara',NULL,NULL,NULL,NULL,NULL,NULL),(470,'kulrumpa@tni.ac.th','kulrumpa','kulrumpa',NULL,NULL,NULL,NULL,NULL,NULL),(471,'kuntaphot@tni.ac.th','Kuntaphot','Leeratanon',NULL,NULL,NULL,NULL,NULL,NULL),(472,'kunyada@tni.ac.th','kunyada','kunyada',NULL,NULL,NULL,NULL,NULL,NULL),(473,'kurihara@tni.ac.th','Kurihara','Naoko',NULL,NULL,NULL,NULL,NULL,NULL),(474,'lalida@tni.ac.th','Lalida','Puechamnuay',NULL,NULL,NULL,NULL,NULL,NULL),(475,'lalita@tni.ac.th','Lalita','Na Nongkhai',NULL,NULL,NULL,NULL,NULL,NULL),(476,'lerkiat@tni.ac.th','Lerkiat','Vongsarnpigoon',NULL,NULL,NULL,NULL,NULL,NULL),(477,'library@tni.ac.th','library','library',NULL,NULL,NULL,NULL,NULL,NULL),(478,'likasit@tni.ac.th','Likasit','Thong-orn',NULL,NULL,NULL,NULL,NULL,NULL),(479,'mailadmin@tni.ac.th','mailadmin','mailadmin',NULL,NULL,NULL,NULL,NULL,NULL),(480,'Mangkorn@tni.ac.th','Mangkorn','Rodprapakorn',NULL,NULL,NULL,NULL,NULL,NULL),(481,'manop@tni.ac.th','Manop','Choomphukae',NULL,NULL,NULL,NULL,NULL,NULL),(482,'marnote@tni.ac.th','marnote','boonjong',NULL,NULL,NULL,NULL,NULL,NULL),(483,'masashi@tni.ac.th','Masashi','INOUE',NULL,NULL,NULL,NULL,NULL,NULL),(484,'masuda@tni.ac.th','masuda','masuda',NULL,NULL,NULL,NULL,NULL,NULL),(485,'matsui@tni.ac.th','matsui','matsui',NULL,NULL,NULL,NULL,NULL,NULL),(486,'matthew@tni.ac.th','mattew','mattew',NULL,NULL,NULL,NULL,NULL,NULL),(487,'mayu@tni.ac.th','Mayu','Morigiwa',NULL,NULL,NULL,NULL,NULL,NULL),(488,'mayumi@tni.ac.th','Mayumi','Mineta',NULL,NULL,NULL,NULL,NULL,NULL),(489,'met.tni@tni.ac.th','TNI','MET',NULL,NULL,NULL,NULL,NULL,NULL),(490,'michael@tni.ac.th','michael','michael',NULL,NULL,NULL,NULL,NULL,NULL),(491,'mie@tni.ac.th','Mie','Tanaka',NULL,NULL,NULL,NULL,NULL,NULL),(492,'miki@tni.ac.th','Miki','Fukuda',NULL,NULL,NULL,NULL,NULL,NULL),(493,'mingkwan@tni.ac.th','mingkwan','mingkwan',NULL,NULL,NULL,NULL,NULL,NULL),(494,'mizutani@tni.ac.th','Koichi','Mizutani',NULL,NULL,NULL,NULL,NULL,NULL),(495,'mjames@tni.ac.th','Michael James','Copeland',NULL,NULL,NULL,NULL,NULL,NULL),(496,'motomura@tni.ac.th','Nokubo','MOTOMURA',NULL,NULL,NULL,NULL,NULL,NULL),(497,'mrbs@tni.ac.th','mrbs','mrbs',NULL,NULL,NULL,NULL,NULL,NULL),(498,'muraoka@tni.ac.th','muraoka','Shinsuke',NULL,NULL,NULL,NULL,NULL,NULL),(499,'nagata@tni.ac.th','Chie','NAGATA',NULL,NULL,NULL,NULL,NULL,NULL),(500,'nahoko@tni.ac.th','nahoko','TAKAMAGARI',NULL,NULL,NULL,NULL,NULL,NULL),(501,'naito@tni.ac.th','Naito','Naito',NULL,NULL,NULL,NULL,NULL,NULL),(502,'nakayama@tni.ac.th','nakayama','nakayama',NULL,NULL,NULL,NULL,NULL,NULL),(503,'nalinrat@tni.ac.th','Nalinrat','Sungsiri',NULL,NULL,NULL,NULL,NULL,NULL),(504,'namporn@tni.ac.th','Namporn','Sathirakul',NULL,NULL,NULL,NULL,NULL,NULL),(505,'nanapas@tni.ac.th','Nanapas','Wungsriroj',NULL,NULL,NULL,NULL,NULL,NULL),(506,'napaporn@tni.ac.th','Napaporn','Wijit',NULL,NULL,NULL,NULL,NULL,NULL),(507,'napat@tni.ac.th','napat','napat',NULL,NULL,NULL,NULL,NULL,NULL),(508,'naren@tni.ac.th','Naren','Chaithanee',NULL,NULL,NULL,NULL,NULL,NULL),(509,'narong@tni.ac.th','Narong','Anankawanich',NULL,NULL,NULL,NULL,NULL,NULL),(510,'narongpon@tni.ac.th','Narongpon','Boonsongpaisan',NULL,NULL,NULL,NULL,NULL,NULL),(512,'narungsun@tni.ac.th','Narungsun','Wilaisakoolyong',NULL,NULL,NULL,NULL,NULL,NULL),(513,'natcha@tni.ac.th','natcha','natcha',NULL,NULL,NULL,NULL,NULL,NULL),(514,'nattapong@tni.ac.th','Nattapong','Bangthamai',NULL,NULL,NULL,NULL,NULL,NULL),(515,'nattawadee@tni.ac.th','nattawadee','nattawadee',NULL,NULL,NULL,NULL,NULL,NULL),(516,'natthaphon@tni.ac.th','Natthaphon','JARAT',NULL,NULL,NULL,NULL,NULL,NULL),(517,'nattida@tni.ac.th','Nattida','Pucharoen',NULL,NULL,NULL,NULL,NULL,NULL),(518,'navarat@tni.ac.th','navarat','navarat',NULL,NULL,NULL,NULL,NULL,NULL),(519,'netprapa@tni.ac.th','netprapa','netprapa',NULL,NULL,NULL,NULL,NULL,NULL),(520,'nicholas@tni.ac.th','Nicholas','HOVER',NULL,NULL,NULL,NULL,NULL,NULL),(521,'nidapan@tni.ac.th','Nidapan','Sureerattanan',NULL,NULL,NULL,NULL,NULL,NULL),(522,'niratsai@tni.ac.th','Niratsai','Sornwit',NULL,NULL,NULL,NULL,NULL,NULL),(523,'nitirat@tni.ac.th','A.Nitirat','Tanthavech',NULL,NULL,NULL,NULL,NULL,NULL),(524,'nobuko@tni.ac.th','Nobuko','Motomura',NULL,NULL,NULL,NULL,NULL,NULL),(525,'nongnuch@tni.ac.th','Nongnuch','Pakon',NULL,NULL,NULL,NULL,NULL,NULL),(526,'nongpanga@tni.ac.th','Nongpanga','Ruengyot',NULL,NULL,NULL,NULL,NULL,NULL),(527,'noppadol@tni.ac.th','Noppadol','Sriputtha',NULL,NULL,NULL,NULL,NULL,NULL),(528,'nuchanart@tni.ac.th','Nuchanart','Pongpanich',NULL,NULL,NULL,NULL,NULL,NULL),(529,'nutchapon@tni.ac.th','Nutchapon','Somrak',NULL,NULL,NULL,NULL,NULL,NULL),(530,'nutcharee@tni.ac.th','Nutcharee','Saelee',NULL,NULL,NULL,NULL,NULL,NULL),(531,'nuttakarn@tni.ac.th','nuttakarn','nuttakarn',NULL,NULL,NULL,NULL,NULL,NULL),(532,'nuttapol@tni.ac.th','Nuttapol','Limjeerajarus',NULL,NULL,NULL,NULL,NULL,NULL),(533,'oeb@tni.ac.th','Oeb','Taveechat',NULL,NULL,NULL,NULL,NULL,NULL),(534,'okubo@tni.ac.th','Okubo','Hiroyuki',NULL,NULL,NULL,NULL,NULL,NULL),(535,'orn@tni.ac.th','Orn','Eungkaneungdeja',NULL,NULL,NULL,NULL,NULL,NULL),(536,'ornprang@tni.ac.th','Ornprang','Yamkunthong',NULL,NULL,NULL,NULL,NULL,NULL),(537,'pakin@tni.ac.th','pakin','lerdwichitwatthana',NULL,NULL,NULL,NULL,NULL,NULL),(538,'paleerat@tni.ac.th','Paleerat','Lakawathana',NULL,NULL,NULL,NULL,NULL,NULL),(539,'panaree@tni.ac.th','panaree','panaree',NULL,NULL,NULL,NULL,NULL,NULL),(540,'panatkorn@tni.ac.th','panatkorn','panatkorn',NULL,NULL,NULL,NULL,NULL,NULL),(541,'panitharn@tni.ac.th','panitarn','panitarn',NULL,NULL,NULL,NULL,NULL,NULL),(542,'pannathadh@tni.ac.th','Pannathadh','Chomchark',NULL,NULL,NULL,NULL,NULL,NULL),(543,'panya@tni.ac.th','panya','panya',NULL,NULL,NULL,NULL,NULL,NULL),(544,'pard@tni.ac.th','Pard','Teekasap',NULL,NULL,NULL,NULL,NULL,NULL),(545,'parichat@tni.ac.th','Parichat','Kongtong',NULL,NULL,NULL,NULL,NULL,NULL),(546,'pariwat@tni.ac.th','Pariwat','Khonggamnerd',NULL,NULL,NULL,NULL,NULL,NULL),(547,'paskorn-a@tni.ac.th','Paskorn','Apiruk',NULL,NULL,NULL,NULL,NULL,NULL),(548,'paskorn@tni.ac.th','Paskorn','phanophat',NULL,NULL,NULL,NULL,NULL,NULL),(549,'passakorn@tni.ac.th','passakorn','passakorn',NULL,NULL,NULL,NULL,NULL,NULL),(550,'patcharee@tni.ac.th','Patcharee','Malathong',NULL,NULL,NULL,NULL,NULL,NULL),(551,'patraree@tni.ac.th','Patraree','Amatayakul',NULL,NULL,NULL,NULL,NULL,NULL),(552,'patsama@tni.ac.th','Patsama','Charoenpong',NULL,NULL,NULL,NULL,NULL,NULL),(553,'pattanapong@tni.ac.th','pattanapong','pattanapong',NULL,NULL,NULL,NULL,NULL,NULL),(554,'paul@tni.ac.th','paul','paul',NULL,NULL,NULL,NULL,NULL,NULL),(555,'pawat@tni.ac.th','pawat','pawat',NULL,NULL,NULL,NULL,NULL,NULL),(556,'penkhae@tni.ac.th','Penkhae','Prachonpachanuk',NULL,NULL,NULL,NULL,NULL,NULL),(557,'petchsri@tni.ac.th','Petchsri','Limpibunterng',NULL,NULL,NULL,NULL,NULL,NULL),(558,'peter@tni.ac.th','Peter','Holden',NULL,NULL,NULL,NULL,NULL,NULL),(559,'ph.weeravat@tni.ac.th','WEERAVAT','PHASATIT',NULL,NULL,NULL,NULL,NULL,NULL),(560,'phaisarn@tni.ac.th','Phaisarn','Sudwilai',NULL,NULL,NULL,NULL,NULL,NULL),(561,'phatcharin@tni.ac.th','Phatcharin','Setajan',NULL,NULL,NULL,NULL,NULL,NULL),(562,'phattira@tni.ac.th','phattira','phattira',NULL,NULL,NULL,NULL,NULL,NULL),(563,'phulporn@tni.ac.th','Phulporn','Saengbangpla',NULL,NULL,NULL,NULL,NULL,NULL),(565,'piengduen@tni.ac.th','Piengduen','Thawonkeaw',NULL,NULL,NULL,NULL,NULL,NULL),(566,'pika@tni.ac.th','Pika','Chunvijittra',NULL,NULL,NULL,NULL,NULL,NULL),(567,'pimpet@tni.ac.th','Pimpet','SratongOn',NULL,NULL,NULL,NULL,NULL,NULL),(568,'pimrot@tni.ac.th','Pimrot','Phipatanakul',NULL,NULL,NULL,NULL,NULL,NULL),(569,'pisut@tni.ac.th','Pisut','Pongchairerks',NULL,NULL,NULL,NULL,NULL,NULL),(570,'pitsanu@tni.ac.th','pitsanu','pitsanu',NULL,NULL,NULL,NULL,NULL,NULL),(571,'pittaya@tni.ac.th','Robin','Nont',NULL,NULL,NULL,NULL,NULL,NULL),(572,'piyaporn@tni.ac.th','Piyaporn','Boontang',NULL,NULL,NULL,NULL,NULL,NULL),(574,'sombat_ae@tni.ac.th','Sombat','Tamna',NULL,NULL,NULL,NULL,NULL,NULL),(575,'piyaporn_c@tni.ac.th','Piyaporn','Chansuay',NULL,NULL,NULL,NULL,NULL,NULL),(576,'icc_helpdesk@tni.ac.th','icchelp','icchelp',NULL,NULL,NULL,NULL,NULL,NULL),(577,'takashi_i@tni.ac.th','Takashi','Ikeda',NULL,NULL,NULL,NULL,NULL,NULL),(578,'takeshi_i@tni.ac.th','Takashi','IKEDA',NULL,NULL,NULL,NULL,NULL,NULL),(579,'icc_infrastructure@tni.ac.th','iccinfra','iccinfra',NULL,NULL,NULL,NULL,NULL,NULL),(582,'anchalee_s@tni.ac.th','Anchalee','Supithak',NULL,NULL,NULL,NULL,NULL,NULL),(583,'athitaya_t@tni.ac.th','Athitaya','Thaiyong',NULL,NULL,NULL,NULL,NULL,NULL),(584,'it_tni@tni.ac.th','ittni','ittni',NULL,NULL,NULL,NULL,NULL,NULL),(585,'qa_tni@tni.ac.th','qa','qa',NULL,NULL,NULL,NULL,NULL,NULL),(586,'anchalee_y@tni.ac.th','anchalee_y','yunim',NULL,NULL,NULL,NULL,NULL,NULL),(587,'acad@tni.ac.th','TNI','ACAD',NULL,NULL,NULL,NULL,NULL,NULL),(588,'academics@tni.ac.th','academics','academics',NULL,NULL,NULL,NULL,NULL,NULL),(589,'adisak@tni.ac.th','Adisak','Suasaming',NULL,NULL,NULL,NULL,NULL,NULL),(590,'admin@tni.ac.th','Dolwichit','Junnarm',NULL,NULL,NULL,NULL,NULL,NULL),(591,'admission@tni.ac.th','admission','admission',NULL,NULL,NULL,NULL,NULL,NULL),(592,'adna@tni.ac.th','Adna','Sengto',NULL,NULL,NULL,NULL,NULL,NULL),(593,'aekkasit@tni.ac.th','Aekkasit','Pootrakool',NULL,NULL,NULL,NULL,NULL,NULL),(594,'aeknarong@tni.ac.th','aeknarong','aeknarong',NULL,NULL,NULL,NULL,NULL,NULL),(595,'akekarin@tni.ac.th','akekarin','akekarin',NULL,NULL,NULL,NULL,NULL,NULL),(596,'alan@tni.ac.th','Alan','Greenhill MCADAM',NULL,NULL,NULL,NULL,NULL,NULL),(597,'alongkorn@tni.ac.th','Alongkorn','Prakitpong',NULL,NULL,NULL,NULL,NULL,NULL),(598,'amarawadee@tni.ac.th','Amarawadee','Tappoon',NULL,NULL,NULL,NULL,NULL,NULL),(599,'amnart@tni.ac.th','amnart','amnart',NULL,NULL,NULL,NULL,NULL,NULL),(600,'amonpan@tni.ac.th','Amonpan','Chomklin',NULL,NULL,NULL,NULL,NULL,NULL),(601,'amorn@tni.ac.th','Amorn','Koomsupsiri',NULL,NULL,NULL,NULL,NULL,NULL),(602,'anan@tni.ac.th','Anan','Klaodee',NULL,NULL,NULL,NULL,NULL,NULL),(603,'anchalee@tni.ac.th','Anchalee','Yunim',NULL,NULL,NULL,NULL,NULL,NULL),(605,'anusorn@tni.ac.th','Anusorn','Atthasiri',NULL,NULL,NULL,NULL,NULL,NULL),(606,'anuwat@tni.ac.th','Anuwat','Charoensuk',NULL,NULL,NULL,NULL,NULL,NULL),(607,'apichaya@tni.ac.th','Apichaya','Nimkoompai',NULL,NULL,NULL,NULL,NULL,NULL),(608,'araya@tni.ac.th','Araya','Hongchindaket',NULL,NULL,NULL,NULL,NULL,NULL),(609,'areerat@tni.ac.th','Areerat','Leelhaphunt',NULL,NULL,NULL,NULL,NULL,NULL),(610,'aroonluck@tni.ac.th','Aroonluck','Vithyavijin',NULL,NULL,NULL,NULL,NULL,NULL),(611,'athitaya@tni.ac.th','Athitaya','Thaiyong',NULL,NULL,NULL,NULL,NULL,NULL),(612,'attaphol@tni.ac.th','attaphol','attaphol',NULL,NULL,NULL,NULL,NULL,NULL),(613,'auemporn@tni.ac.th','Auemporn','Rodim',NULL,NULL,NULL,NULL,NULL,NULL),(614,'awaji@tni.ac.th','awaji','awaji',NULL,NULL,NULL,NULL,NULL,NULL),(615,'bandhit@tni.ac.th','Bandhit','Rojarayanont',NULL,NULL,NULL,NULL,NULL,NULL),(616,'bba@tni.ac.th','BBA','TNI',NULL,NULL,NULL,NULL,NULL,NULL),(617,'bohdan@tni.ac.th','bohdan','bohdan',NULL,NULL,NULL,NULL,NULL,NULL),(618,'boonchai@tni.ac.th','Boonchai','Khongsagtrakool',NULL,NULL,NULL,NULL,NULL,NULL),(619,'boonrit@tni.ac.th','Boonrit','Keawprachum',NULL,NULL,NULL,NULL,NULL,NULL),(620,'budsaraphorn@tni.ac.th','Budsaraphorn','Luangmalawat',NULL,NULL,NULL,NULL,NULL,NULL),(621,'buncha@tni.ac.th','Buncha','Choupradit',NULL,NULL,NULL,NULL,NULL,NULL),(622,'bundit@tni.ac.th','Bundit','Anuyahong',NULL,NULL,NULL,NULL,NULL,NULL),(623,'bunyawee@tni.ac.th','Bunyawee','Chokprasoetsom',NULL,NULL,NULL,NULL,NULL,NULL),(624,'busaraphorn@tni.ac.th','busaraphonrn','busaraphonrn',NULL,NULL,NULL,NULL,NULL,NULL),(625,'bussakorn@tni.ac.th','Bussakorn','Hammachukitatikul',NULL,NULL,NULL,NULL,NULL,NULL),(626,'calendar@tni.ac.th','calendar','calendar',NULL,NULL,NULL,NULL,NULL,NULL),(627,'cctv@tni.ac.th','cctv','cctv',NULL,NULL,NULL,NULL,NULL,NULL),(628,'ch.saravudh@tni.ac.th','Saravudh','Cheepchol',NULL,NULL,NULL,NULL,NULL,NULL),(629,'chalermkhwan@tni.ac.th','Chalermkhwan','Krootboonyong',NULL,NULL,NULL,NULL,NULL,NULL),(630,'chan@tni.ac.th','Chan','Jaruvongrangsee',NULL,NULL,NULL,NULL,NULL,NULL),(631,'chananya@tni.ac.th','Chananya','Lakdan',NULL,NULL,NULL,NULL,NULL,NULL),(632,'changepass@tni.ac.th','Change','Password',NULL,NULL,NULL,NULL,NULL,NULL),(633,'channu@tni.ac.th','Channu','Montriphiriyaphon',NULL,NULL,NULL,NULL,NULL,NULL),(634,'chanya@tni.ac.th','Chanya','Sontamino',NULL,NULL,NULL,NULL,NULL,NULL),(635,'chareeluk@tni.ac.th','Chareeluk','Tantip',NULL,NULL,NULL,NULL,NULL,NULL),(636,'chark@tni.ac.th','Chark','Tingsabhat',NULL,NULL,NULL,NULL,NULL,NULL),(637,'chartchan@tni.ac.th','Chartchan','Phodhiphad',NULL,NULL,NULL,NULL,NULL,NULL),(638,'chartree@tni.ac.th','Chartree','Tongwan',NULL,NULL,NULL,NULL,NULL,NULL),(639,'chatkamol@tni.ac.th','Chatkamol','Rodprasert',NULL,NULL,NULL,NULL,NULL,NULL),(640,'chatree@tni.ac.th','Chatree','Khongruay',NULL,NULL,NULL,NULL,NULL,NULL),(641,'chavakarn@tni.ac.th','Chavakarn','Tharapath',NULL,NULL,NULL,NULL,NULL,NULL),(642,'chie@tni.ac.th','chie','NAGATA',NULL,NULL,NULL,NULL,NULL,NULL),(643,'Chirapan@tni.ac.th','Chirapan','Oulapathorn',NULL,NULL,NULL,NULL,NULL,NULL),(644,'chittra@tni.ac.th','Chittra','Chantragatrawi',NULL,NULL,NULL,NULL,NULL,NULL),(645,'chombongkoch@tni.ac.th','chmbongkoch','chmbongkoch',NULL,NULL,NULL,NULL,NULL,NULL),(646,'chomchanok@tni.ac.th','Chomchanok','Sattorchat',NULL,NULL,NULL,NULL,NULL,NULL),(647,'chomphunut@tni.ac.th','Chomphunut','Krajangworanet',NULL,NULL,NULL,NULL,NULL,NULL),(648,'chonticha@tni.ac.th','Chonticha','Na-ngam',NULL,NULL,NULL,NULL,NULL,NULL),(649,'chookid@tni.ac.th','Chookid','Ngamwong',NULL,NULL,NULL,NULL,NULL,NULL),(650,'choompolpat@tni.ac.th','Choompolpat','Kongtanajaruanun',NULL,NULL,NULL,NULL,NULL,NULL),(651,'chothika@tni.ac.th','chothika','chothika',NULL,NULL,NULL,NULL,NULL,NULL),(652,'chutikarn@tni.ac.th','Chutikarn','Niyaboon',NULL,NULL,NULL,NULL,NULL,NULL),(653,'Copeland.m@tni.ac.th','Michael','James Copeland',NULL,NULL,NULL,NULL,NULL,NULL),(654,'daecha@tni.ac.th','Daecha','Tunmeesuk',NULL,NULL,NULL,NULL,NULL,NULL),(655,'daisuke@tni.ac.th','Daisuke','Kosaki',NULL,NULL,NULL,NULL,NULL,NULL),(656,'Damri@tni.ac.th','Damri','Sukhothanang',NULL,NULL,NULL,NULL,NULL,NULL),(657,'Damrong@tni.ac.th','Damrong','Thawesaengskulthai',NULL,NULL,NULL,NULL,NULL,NULL),(658,'datchakorn@tni.ac.th','datchakorn','datchakorn',NULL,NULL,NULL,NULL,NULL,NULL),(659,'dissatat@tni.ac.th','dissatat','dissatat',NULL,NULL,NULL,NULL,NULL,NULL),(660,'dolwichit@tni.ac.th','Dolwichit','Jannarm',NULL,NULL,NULL,NULL,NULL,NULL),(661,'don@tni.ac.th','Don','Kaewdook',NULL,NULL,NULL,NULL,NULL,NULL),(662,'duangkamon@tni.ac.th','Duangkamon','Chaiyaphut',NULL,NULL,NULL,NULL,NULL,NULL),(663,'dumrongkiat@tni.ac.th','Dumrongkiat','Rattana-amornpin',NULL,NULL,NULL,NULL,NULL,NULL),(664,'ek-u@tni.ac.th','Ek-u','Thammakornbunjut',NULL,NULL,NULL,NULL,NULL,NULL),(665,'ekanarong@tni.ac.th','ekanarong','ekanarong',NULL,NULL,NULL,NULL,NULL,NULL),(666,'ekkasit@tni.ac.th','Ekkasit','Khemnguad',NULL,NULL,NULL,NULL,NULL,NULL),(667,'elearning@tni.ac.th','elearning','elearning',NULL,NULL,NULL,NULL,NULL,NULL),(668,'engineering.tni@tni.ac.th','Engineering','TNI',NULL,NULL,NULL,NULL,NULL,NULL),(669,'example@tni.ac.th','example','example',NULL,NULL,NULL,NULL,NULL,NULL),(670,'fujino@tni.ac.th','Hiroshi','Fujino',NULL,NULL,NULL,NULL,NULL,NULL),(671,'fukuda@tni.ac.th','Miki','FUKUDA',NULL,NULL,NULL,NULL,NULL,NULL),(672,'gary@tni.ac.th','gary','gary',NULL,NULL,NULL,NULL,NULL,NULL),(673,'gearclub@tni.ac.th','gearclub','gearclub',NULL,NULL,NULL,NULL,NULL,NULL),(674,'griffee@tni.ac.th','John','Griffee',NULL,NULL,NULL,NULL,NULL,NULL),(675,'gun@tni.ac.th','Gun','Arlaiyart',NULL,NULL,NULL,NULL,NULL,NULL),(676,'haruthai@tni.ac.th','Haruthai','Sinwittayarak',NULL,NULL,NULL,NULL,NULL,NULL),(677,'helponline@tni.ac.th','helponline','helponline',NULL,NULL,NULL,NULL,NULL,NULL),(678,'hiroshi@tni.ac.th','hiroshi','FUJINO',NULL,NULL,NULL,NULL,NULL,NULL),(679,'icc@tni.ac.th','ICC-Mail','Thongchai',NULL,NULL,NULL,NULL,NULL,NULL),(680,'imamura@tni.ac.th','Imamura','Yuko',NULL,NULL,NULL,NULL,NULL,NULL),(681,'inagaki@tni.ac.th','inagaki','inagaki',NULL,NULL,NULL,NULL,NULL,NULL),(682,'inoue@tni.ac.th','Masashi','INOUE',NULL,NULL,NULL,NULL,NULL,NULL),(683,'international@tni.ac.th','international','international',NULL,NULL,NULL,NULL,NULL,NULL),(684,'ishida@tni.ac.th','ishida','ishida',NULL,NULL,NULL,NULL,NULL,NULL),(685,'itdoc@tni.ac.th','IT','Document',NULL,NULL,NULL,NULL,NULL,NULL),(686,'itqa1@tni.ac.th','Prakan','Kunnapab',NULL,NULL,NULL,NULL,NULL,NULL),(687,'itqa2@tni.ac.th','IT','QA',NULL,NULL,NULL,NULL,NULL,NULL),(688,'itqa3@tni.ac.th','IT','QA',NULL,NULL,NULL,NULL,NULL,NULL),(689,'jackson@tni.ac.th','James','Jackson',NULL,NULL,NULL,NULL,NULL,NULL),(690,'jakarin@tni.ac.th','jakarin','jakarin',NULL,NULL,NULL,NULL,NULL,NULL),(691,'jakkrapong@tni.ac.th','Jakkrapong','Limpanussorn',NULL,NULL,NULL,NULL,NULL,NULL),(692,'james@tni.ac.th','James','Stephen Gareth ALLEY',NULL,NULL,NULL,NULL,NULL,NULL),(693,'jarinee@tni.ac.th','Jarinee','Hoyhoul',NULL,NULL,NULL,NULL,NULL,NULL),(694,'jarinya@tni.ac.th','jarinya','jarinya',NULL,NULL,NULL,NULL,NULL,NULL),(695,'jarunee@tni.ac.th','Jarunee','Sinchairojkul',NULL,NULL,NULL,NULL,NULL,NULL),(696,'jatupat@tni.ac.th','Jatupat','Roungdom',NULL,NULL,NULL,NULL,NULL,NULL),(697,'jermjit@tni.ac.th','Jermjit','Yampaga',NULL,NULL,NULL,NULL,NULL,NULL),(698,'jintawat@tni.ac.th','Jintawat','Chaichanawong',NULL,NULL,NULL,NULL,NULL,NULL),(699,'jirapa@tni.ac.th','Jirapa','Khamta',NULL,NULL,NULL,NULL,NULL,NULL),(700,'jirapong@tni.ac.th','Jirapong','Sukatip',NULL,NULL,NULL,NULL,NULL,NULL),(701,'jittima@tni.ac.th','Jittima','Klaithai',NULL,NULL,NULL,NULL,NULL,NULL),(702,'journal@tni.ac.th','TNI','JOURNAL',NULL,NULL,NULL,NULL,NULL,NULL),(703,'juntra@tni.ac.th','Juntra','Rittiruk',NULL,NULL,NULL,NULL,NULL,NULL),(704,'juthamas@tni.ac.th','Juthamas','Prasopsan',NULL,NULL,NULL,NULL,NULL,NULL),(705,'kameshima@tni.ac.th','Keiki','KAMESHIMA',NULL,NULL,NULL,NULL,NULL,NULL),(706,'kan@tni.ac.th','Kan','Sakkamdoung',NULL,NULL,NULL,NULL,NULL,NULL),(707,'kanazawa@tni.ac.th','kanazawa','kanazawa',NULL,NULL,NULL,NULL,NULL,NULL),(708,'kanidta@tni.ac.th','Kanidta','Naksook',NULL,NULL,NULL,NULL,NULL,NULL),(709,'kanista@tni.ac.th','Kanista','Songjakkaew',NULL,NULL,NULL,NULL,NULL,NULL),(710,'kanjanaporn@tni.ac.th','Kanjanaporn','Namsimma',NULL,NULL,NULL,NULL,NULL,NULL),(711,'kanticha@tni.ac.th','Kanticha','Kittipeerachon',NULL,NULL,NULL,NULL,NULL,NULL),(712,'kanyakorn@tni.ac.th','Kanyakorn','Wongsri',NULL,NULL,NULL,NULL,NULL,NULL),(713,'kanyapat@tni.ac.th','Kanyapat','Ladpila',NULL,NULL,NULL,NULL,NULL,NULL),(714,'karnjana@tni.ac.th','Karnjana','Muennek',NULL,NULL,NULL,NULL,NULL,NULL),(715,'kasem@tni.ac.th','Kasem','Thiptarajan',NULL,NULL,NULL,NULL,NULL,NULL),(716,'kaseshima@tni.ac.th','kaseshima','kaseshima',NULL,NULL,NULL,NULL,NULL,NULL),(717,'katesuda@tni.ac.th','katesuda','katesuda',NULL,NULL,NULL,NULL,NULL,NULL),(718,'keiki@tni.ac.th','keiki','KAMESHIMA',NULL,NULL,NULL,NULL,NULL,NULL),(719,'kingmanee@tni.ac.th','Bhavita','Santiwongse',NULL,NULL,NULL,NULL,NULL,NULL),(720,'kitiya@tni.ac.th','kitiya','kitiya',NULL,NULL,NULL,NULL,NULL,NULL),(721,'kittisak@tni.ac.th','kittisak','kittisak',NULL,NULL,NULL,NULL,NULL,NULL),(722,'km@tni.ac.th','TNI','KM',NULL,NULL,NULL,NULL,NULL,NULL),(723,'kodaka@tni.ac.th','kadaka','kadaka',NULL,NULL,NULL,NULL,NULL,NULL),(724,'komkit@tni.ac.th','Komkit','Kongruay',NULL,NULL,NULL,NULL,NULL,NULL),(725,'kongkiat@tni.ac.th','Kongkiat','Weraarchakul',NULL,NULL,NULL,NULL,NULL,NULL),(726,'korakot@tni.ac.th','Korakot','Hamsathapat',NULL,NULL,NULL,NULL,NULL,NULL),(727,'kornthip@tni.ac.th','Kornthip','Ratanapumma',NULL,NULL,NULL,NULL,NULL,NULL),(728,'kosaka@tni.ac.th','Kosaka','Chikako',NULL,NULL,NULL,NULL,NULL,NULL),(729,'kosawat@tni.ac.th','Kosawat','Ratanothayanon',NULL,NULL,NULL,NULL,NULL,NULL),(730,'krisada.v@tni.ac.th','Krisada','Visavateeranon',NULL,NULL,NULL,NULL,NULL,NULL),(731,'krishna@tni.ac.th','Krisahna','Kosashunhanan',NULL,NULL,NULL,NULL,NULL,NULL),(732,'Krissanapong@tni.ac.th','Krissanapong','Kirtikara',NULL,NULL,NULL,NULL,NULL,NULL),(733,'kulrumpa@tni.ac.th','kulrumpa','kulrumpa',NULL,NULL,NULL,NULL,NULL,NULL),(734,'kuntaphot@tni.ac.th','Kuntaphot','Leeratanon',NULL,NULL,NULL,NULL,NULL,NULL),(735,'kunyada@tni.ac.th','kunyada','kunyada',NULL,NULL,NULL,NULL,NULL,NULL),(736,'kurihara@tni.ac.th','Kurihara','Naoko',NULL,NULL,NULL,NULL,NULL,NULL),(737,'lalida@tni.ac.th','Lalida','Puechamnuay',NULL,NULL,NULL,NULL,NULL,NULL),(738,'lalita@tni.ac.th','Lalita','Na Nongkhai',NULL,NULL,NULL,NULL,NULL,NULL),(739,'lerkiat@tni.ac.th','Lerkiat','Vongsarnpigoon',NULL,NULL,NULL,NULL,NULL,NULL),(740,'library@tni.ac.th','library','library',NULL,NULL,NULL,NULL,NULL,NULL),(741,'likasit@tni.ac.th','Likasit','Thong-orn',NULL,NULL,NULL,NULL,NULL,NULL),(742,'mailadmin@tni.ac.th','mailadmin','mailadmin',NULL,NULL,NULL,NULL,NULL,NULL),(743,'Mangkorn@tni.ac.th','Mangkorn','Rodprapakorn',NULL,NULL,NULL,NULL,NULL,NULL),(744,'manop@tni.ac.th','Manop','Choomphukae',NULL,NULL,NULL,NULL,NULL,NULL),(745,'marnote@tni.ac.th','marnote','boonjong',NULL,NULL,NULL,NULL,NULL,NULL),(746,'masashi@tni.ac.th','Masashi','INOUE',NULL,NULL,NULL,NULL,NULL,NULL),(747,'masuda@tni.ac.th','masuda','masuda',NULL,NULL,NULL,NULL,NULL,NULL),(748,'matsui@tni.ac.th','matsui','matsui',NULL,NULL,NULL,NULL,NULL,NULL),(749,'matthew@tni.ac.th','mattew','mattew',NULL,NULL,NULL,NULL,NULL,NULL),(750,'mayu@tni.ac.th','Mayu','Morigiwa',NULL,NULL,NULL,NULL,NULL,NULL),(751,'mayumi@tni.ac.th','Mayumi','Mineta',NULL,NULL,NULL,NULL,NULL,NULL),(752,'met.tni@tni.ac.th','TNI','MET',NULL,NULL,NULL,NULL,NULL,NULL),(753,'michael@tni.ac.th','michael','michael',NULL,NULL,NULL,NULL,NULL,NULL),(754,'mie@tni.ac.th','Mie','Tanaka',NULL,NULL,NULL,NULL,NULL,NULL),(755,'miki@tni.ac.th','Miki','Fukuda',NULL,NULL,NULL,NULL,NULL,NULL),(756,'mingkwan@tni.ac.th','mingkwan','mingkwan',NULL,NULL,NULL,NULL,NULL,NULL),(757,'mizutani@tni.ac.th','Koichi','Mizutani',NULL,NULL,NULL,NULL,NULL,NULL),(758,'mjames@tni.ac.th','Michael James','Copeland',NULL,NULL,NULL,NULL,NULL,NULL),(759,'motomura@tni.ac.th','Nokubo','MOTOMURA',NULL,NULL,NULL,NULL,NULL,NULL),(760,'mrbs@tni.ac.th','mrbs','mrbs',NULL,NULL,NULL,NULL,NULL,NULL),(761,'muraoka@tni.ac.th','muraoka','Shinsuke',NULL,NULL,NULL,NULL,NULL,NULL),(762,'nagata@tni.ac.th','Chie','NAGATA',NULL,NULL,NULL,NULL,NULL,NULL),(763,'nahoko@tni.ac.th','nahoko','TAKAMAGARI',NULL,NULL,NULL,NULL,NULL,NULL),(764,'naito@tni.ac.th','Naito','Naito',NULL,NULL,NULL,NULL,NULL,NULL),(765,'nakayama@tni.ac.th','nakayama','nakayama',NULL,NULL,NULL,NULL,NULL,NULL),(766,'nalinrat@tni.ac.th','Nalinrat','Sungsiri',NULL,NULL,NULL,NULL,NULL,NULL),(767,'namporn@tni.ac.th','Namporn','Sathirakul',NULL,NULL,NULL,NULL,NULL,NULL),(768,'nanapas@tni.ac.th','Nanapas','Wungsriroj',NULL,NULL,NULL,NULL,NULL,NULL),(769,'napaporn@tni.ac.th','Napaporn','Wijit',NULL,NULL,NULL,NULL,NULL,NULL),(770,'napat@tni.ac.th','napat','napat',NULL,NULL,NULL,NULL,NULL,NULL),(771,'naren@tni.ac.th','Naren','Chaithanee',NULL,NULL,NULL,NULL,NULL,NULL),(772,'narong@tni.ac.th','Narong','Anankawanich',NULL,NULL,NULL,NULL,NULL,NULL),(773,'narongpon@tni.ac.th','Narongpon','Boonsongpaisan',NULL,NULL,NULL,NULL,NULL,NULL),(775,'narungsun@tni.ac.th','Narungsun','Wilaisakoolyong',NULL,NULL,NULL,NULL,NULL,NULL),(776,'natcha@tni.ac.th','natcha','natcha',NULL,NULL,NULL,NULL,NULL,NULL),(777,'nattapong@tni.ac.th','Nattapong','Bangthamai',NULL,NULL,NULL,NULL,NULL,NULL),(778,'nattawadee@tni.ac.th','nattawadee','nattawadee',NULL,NULL,NULL,NULL,NULL,NULL),(779,'natthaphon@tni.ac.th','Natthaphon','JARAT',NULL,NULL,NULL,NULL,NULL,NULL),(780,'nattida@tni.ac.th','Nattida','Pucharoen',NULL,NULL,NULL,NULL,NULL,NULL),(781,'navarat@tni.ac.th','navarat','navarat',NULL,NULL,NULL,NULL,NULL,NULL),(782,'netprapa@tni.ac.th','netprapa','netprapa',NULL,NULL,NULL,NULL,NULL,NULL),(783,'nicholas@tni.ac.th','Nicholas','HOVER',NULL,NULL,NULL,NULL,NULL,NULL),(784,'nidapan@tni.ac.th','Nidapan','Sureerattanan',NULL,NULL,NULL,NULL,NULL,NULL),(785,'niratsai@tni.ac.th','Niratsai','Sornwit',NULL,NULL,NULL,NULL,NULL,NULL),(786,'nitirat@tni.ac.th','A.Nitirat','Tanthavech',NULL,NULL,NULL,NULL,NULL,NULL),(787,'nobuko@tni.ac.th','Nobuko','Motomura',NULL,NULL,NULL,NULL,NULL,NULL),(788,'nongnuch@tni.ac.th','Nongnuch','Pakon',NULL,NULL,NULL,NULL,NULL,NULL),(789,'nongpanga@tni.ac.th','Nongpanga','Ruengyot',NULL,NULL,NULL,NULL,NULL,NULL),(790,'noppadol@tni.ac.th','Noppadol','Sriputtha',NULL,NULL,NULL,NULL,NULL,NULL),(791,'nuchanart@tni.ac.th','Nuchanart','Pongpanich',NULL,NULL,NULL,NULL,NULL,NULL),(792,'nutchapon@tni.ac.th','Nutchapon','Somrak',NULL,NULL,NULL,NULL,NULL,NULL),(793,'nutcharee@tni.ac.th','Nutcharee','Saelee',NULL,NULL,NULL,NULL,NULL,NULL),(794,'nuttakarn@tni.ac.th','nuttakarn','nuttakarn',NULL,NULL,NULL,NULL,NULL,NULL),(795,'nuttapol@tni.ac.th','Nuttapol','Limjeerajarus',NULL,NULL,NULL,NULL,NULL,NULL),(796,'oeb@tni.ac.th','Oeb','Taveechat',NULL,NULL,NULL,NULL,NULL,NULL),(797,'okubo@tni.ac.th','Okubo','Hiroyuki',NULL,NULL,NULL,NULL,NULL,NULL),(798,'orn@tni.ac.th','Orn','Eungkaneungdeja',NULL,NULL,NULL,NULL,NULL,NULL),(799,'ornprang@tni.ac.th','Ornprang','Yamkunthong',NULL,NULL,NULL,NULL,NULL,NULL),(800,'pakin@tni.ac.th','pakin','lerdwichitwatthana',NULL,NULL,NULL,NULL,NULL,NULL),(801,'paleerat@tni.ac.th','Paleerat','Lakawathana',NULL,NULL,NULL,NULL,NULL,NULL),(802,'panaree@tni.ac.th','panaree','panaree',NULL,NULL,NULL,NULL,NULL,NULL),(803,'panatkorn@tni.ac.th','panatkorn','panatkorn',NULL,NULL,NULL,NULL,NULL,NULL),(804,'panitharn@tni.ac.th','panitarn','panitarn',NULL,NULL,NULL,NULL,NULL,NULL),(805,'pannathadh@tni.ac.th','Pannathadh','Chomchark',NULL,NULL,NULL,NULL,NULL,NULL),(806,'panya@tni.ac.th','panya','panya',NULL,NULL,NULL,NULL,NULL,NULL),(807,'pard@tni.ac.th','Pard','Teekasap',NULL,NULL,NULL,NULL,NULL,NULL),(808,'parichat@tni.ac.th','Parichat','Kongtong',NULL,NULL,NULL,NULL,NULL,NULL),(809,'pariwat@tni.ac.th','Pariwat','Khonggamnerd',NULL,NULL,NULL,NULL,NULL,NULL),(810,'paskorn-a@tni.ac.th','Paskorn','Apiruk',NULL,NULL,NULL,NULL,NULL,NULL),(811,'paskorn@tni.ac.th','Paskorn','phanophat',NULL,NULL,NULL,NULL,NULL,NULL),(812,'passakorn@tni.ac.th','passakorn','passakorn',NULL,NULL,NULL,NULL,NULL,NULL),(813,'patcharee@tni.ac.th','Patcharee','Malathong',NULL,NULL,NULL,NULL,NULL,NULL),(814,'patraree@tni.ac.th','Patraree','Amatayakul',NULL,NULL,NULL,NULL,NULL,NULL),(815,'patsama@tni.ac.th','Patsama','Charoenpong',NULL,NULL,NULL,NULL,NULL,NULL),(816,'pattanapong@tni.ac.th','pattanapong','pattanapong',NULL,NULL,NULL,NULL,NULL,NULL),(817,'paul@tni.ac.th','paul','paul',NULL,NULL,NULL,NULL,NULL,NULL),(818,'pawat@tni.ac.th','pawat','pawat',NULL,NULL,NULL,NULL,NULL,NULL),(819,'penkhae@tni.ac.th','Penkhae','Prachonpachanuk',NULL,NULL,NULL,NULL,NULL,NULL),(820,'petchsri@tni.ac.th','Petchsri','Limpibunterng',NULL,NULL,NULL,NULL,NULL,NULL),(821,'peter@tni.ac.th','Peter','Holden',NULL,NULL,NULL,NULL,NULL,NULL),(822,'ph.weeravat@tni.ac.th','WEERAVAT','PHASATIT',NULL,NULL,NULL,NULL,NULL,NULL),(823,'phaisarn@tni.ac.th','Phaisarn','Sudwilai',NULL,NULL,NULL,NULL,NULL,NULL),(824,'phatcharin@tni.ac.th','Phatcharin','Setajan',NULL,NULL,NULL,NULL,NULL,NULL),(825,'phattira@tni.ac.th','phattira','phattira',NULL,NULL,NULL,NULL,NULL,NULL),(826,'phulporn@tni.ac.th','Phulporn','Saengbangpla',NULL,NULL,NULL,NULL,NULL,NULL),(828,'piengduen@tni.ac.th','Piengduen','Thawonkeaw',NULL,NULL,NULL,NULL,NULL,NULL),(829,'pika@tni.ac.th','Pika','Chunvijittra',NULL,NULL,NULL,NULL,NULL,NULL),(830,'pimpet@tni.ac.th','Pimpet','SratongOn',NULL,NULL,NULL,NULL,NULL,NULL),(831,'pimrot@tni.ac.th','Pimrot','Phipatanakul',NULL,NULL,NULL,NULL,NULL,NULL),(832,'pisut@tni.ac.th','Pisut','Pongchairerks',NULL,NULL,NULL,NULL,NULL,NULL),(833,'pitsanu@tni.ac.th','pitsanu','pitsanu',NULL,NULL,NULL,NULL,NULL,NULL),(834,'pittaya@tni.ac.th','Robin','Nont',NULL,NULL,NULL,NULL,NULL,NULL),(835,'piyaporn@tni.ac.th','Piyaporn','Boontang',NULL,NULL,NULL,NULL,NULL,NULL),(836,'Piyawat@tni.ac.th','Piyawat','Boon-Long',NULL,NULL,NULL,NULL,NULL,NULL),(837,'pongpon@tni.ac.th','Pongpon','Suansri',NULL,NULL,NULL,NULL,NULL,NULL),(838,'pongsak@tni.ac.th','Pongsak','Saithanya',NULL,NULL,NULL,NULL,NULL,NULL),(839,'pongsakorn@tni.ac.th','pongsakorn','pongsakorn',NULL,NULL,NULL,NULL,NULL,NULL),(840,'ponwimol@tni.ac.th','Ponwimol','Wipanarapai',NULL,NULL,NULL,NULL,NULL,NULL),(841,'pornanong@tni.ac.th','Pornanong','Niyomka Horikawa',NULL,NULL,NULL,NULL,NULL,NULL),(842,'pornrat@tni.ac.th','Pornrat','Yenjai',NULL,NULL,NULL,NULL,NULL,NULL),(843,'pornsawan@tni.ac.th','pornsawan','pornsawan',NULL,NULL,NULL,NULL,NULL,NULL),(844,'pr@tni.ac.th','pr','pr',NULL,NULL,NULL,NULL,NULL,NULL),(845,'Pranee@tni.ac.th','Pranee','Jongsutjarittam',NULL,NULL,NULL,NULL,NULL,NULL),(846,'pranisa@tni.ac.th','Pranisa','Israsena',NULL,NULL,NULL,NULL,NULL,NULL),(847,'prapawarin@tni.ac.th','prapawarin','prapawarin',NULL,NULL,NULL,NULL,NULL,NULL),(848,'pratyawan@tni.ac.th','Pratyawan','Chantakhan',NULL,NULL,NULL,NULL,NULL,NULL),(849,'prawet@tni.ac.th','Prawet','Ueatringchit',NULL,NULL,NULL,NULL,NULL,NULL),(850,'Prayoon@tni.ac.th','Prayoon','Shiowattana',NULL,NULL,NULL,NULL,NULL,NULL),(851,'preyawan@tni.ac.th','Preyawan','P.',NULL,NULL,NULL,NULL,NULL,NULL),(852,'puranee@tni.ac.th','Puranee','Boonsri',NULL,NULL,NULL,NULL,NULL,NULL),(853,'puttipong@tni.ac.th','Puttipong','Anantasopon',NULL,NULL,NULL,NULL,NULL,NULL),(854,'puwadol@tni.ac.th','Puwadol','Sirikongtham',NULL,NULL,NULL,NULL,NULL,NULL),(855,'qa@tni.ac.th','TNI','QA',NULL,NULL,NULL,NULL,NULL,NULL),(856,'raksit@tni.ac.th','Raksit','Chutipakdeevong',NULL,NULL,NULL,NULL,NULL,NULL),(857,'rangsan@tni.ac.th','Rangsan','Krisaranont',NULL,NULL,NULL,NULL,NULL,NULL),(858,'ratana@tni.ac.th','Sittipong','DajthaiRatana',NULL,NULL,NULL,NULL,NULL,NULL),(859,'reg@tni.ac.th','TNI','REG',NULL,NULL,NULL,NULL,NULL,NULL),(860,'registrar@tni.ac.th','registrar','registrar',NULL,NULL,NULL,NULL,NULL,NULL),(861,'research@tni.ac.th','research','research',NULL,NULL,NULL,NULL,NULL,NULL),(862,'rodjaney@tni.ac.th','Rodjaney','Narinont',NULL,NULL,NULL,NULL,NULL,NULL),(863,'ronnatud@tni.ac.th','Ronnatud','Julawattana',NULL,NULL,NULL,NULL,NULL,NULL),(864,'rungsun@tni.ac.th','Rungsun','Lertnaisat',NULL,NULL,NULL,NULL,NULL,NULL),(865,'rutairat@tni.ac.th','Rutairat','Vichaidis',NULL,NULL,NULL,NULL,NULL,NULL),(866,'ruttikorn@tni.ac.th','Ruttikorn','Varakulsiripunth',NULL,NULL,NULL,NULL,NULL,NULL),(867,'sahasawat@tni.ac.th','Sahasawat','Phol-at',NULL,NULL,NULL,NULL,NULL,NULL),(868,'saisunee@tni.ac.th','kanyakorn','Wongsri',NULL,NULL,NULL,NULL,NULL,NULL),(869,'sakchai@tni.ac.th','Sakchai','Kirinpanu',NULL,NULL,NULL,NULL,NULL,NULL),(870,'saleela@tni.ac.th','Saleela','Boontrakulsuk',NULL,NULL,NULL,NULL,NULL,NULL),(871,'salilrat@tni.ac.th','Salilrat','Kaweejarumongkol',NULL,NULL,NULL,NULL,NULL,NULL),(872,'salinla@tni.ac.th','Salinla','Chevakidagarn',NULL,NULL,NULL,NULL,NULL,NULL),(873,'sansanee@tni.ac.th','sansanee','sansanee',NULL,NULL,NULL,NULL,NULL,NULL),(874,'santhawut@tni.ac.th','Santhawut','Tularak',NULL,NULL,NULL,NULL,NULL,NULL),(875,'santhiti@tni.ac.th','Santhiti','Thongnoi',NULL,NULL,NULL,NULL,NULL,NULL),(876,'saowaree@tni.ac.th','Saowaree','Nakagawa',NULL,NULL,NULL,NULL,NULL,NULL),(877,'saprangsit@tni.ac.th','Saprangsit','Mruetusatorn',NULL,NULL,NULL,NULL,NULL,NULL),(878,'sared@tni.ac.th','Sared','Wansopa',NULL,NULL,NULL,NULL,NULL,NULL),(879,'saromporn@tni.ac.th','Saromporn','Charoenpit',NULL,NULL,NULL,NULL,NULL,NULL),(880,'sawanya@tni.ac.th','Sawanya','Suwannawong',NULL,NULL,NULL,NULL,NULL,NULL),(881,'shinsuke@tni.ac.th','Shinsuke','Muraoka',NULL,NULL,NULL,NULL,NULL,NULL),(882,'shuichi@tni.ac.th','Shuichi','Sano',NULL,NULL,NULL,NULL,NULL,NULL),(883,'sidshchadhaa@tni.ac.th','Sidshchadhaa','Aumted',NULL,NULL,NULL,NULL,NULL,NULL),(884,'sirapat@tni.ac.th','sirapat','sirapat',NULL,NULL,NULL,NULL,NULL,NULL),(885,'sirapin@tni.ac.th','Sirapin','Porjai',NULL,NULL,NULL,NULL,NULL,NULL),(886,'sirichai@tni.ac.th','Sirichai','Putwattana',NULL,NULL,NULL,NULL,NULL,NULL),(887,'siriluck@tni.ac.th','Siriluck','Anekboonlab',NULL,NULL,NULL,NULL,NULL,NULL),(888,'siripat@tni.ac.th','siripat','siripat',NULL,NULL,NULL,NULL,NULL,NULL),(889,'siripong@tni.ac.th','Siripong','Sangsarpan',NULL,NULL,NULL,NULL,NULL,NULL),(890,'sittipong@tni.ac.th','Sittipong','Dajthairatana',NULL,NULL,NULL,NULL,NULL,NULL),(891,'siyada@tni.ac.th','siyada','siyada',NULL,NULL,NULL,NULL,NULL,NULL),(892,'sombat@tni.ac.th','Sombat','Warintornnuwat',NULL,NULL,NULL,NULL,NULL,NULL),(893,'somjet@tni.ac.th','somjet','somjet',NULL,NULL,NULL,NULL,NULL,NULL),(894,'songpol@tni.ac.th','Songpol','Trakarnchatree',NULL,NULL,NULL,NULL,NULL,NULL),(895,'sontaya@tni.ac.th','sontaya','sontaya',NULL,NULL,NULL,NULL,NULL,NULL),(896,'sorarat@tni.ac.th','Sorarat','Sorarat',NULL,NULL,NULL,NULL,NULL,NULL),(897,'sorayut@tni.ac.th','Sorayut','Youngmanee',NULL,NULL,NULL,NULL,NULL,NULL),(898,'srisit@tni.ac.th','srisit','srisit',NULL,NULL,NULL,NULL,NULL,NULL),(899,'suchadha@tni.ac.th','Suchadha','Wanna',NULL,NULL,NULL,NULL,NULL,NULL),(900,'Sucharit@tni.ac.th','Sucharit','Koontanakulvong',NULL,NULL,NULL,NULL,NULL,NULL),(901,'suchart@tni.ac.th','suchart','suchart',NULL,NULL,NULL,NULL,NULL,NULL),(902,'sucheera@tni.ac.th','Sucheera','Nuanthong',NULL,NULL,NULL,NULL,NULL,NULL),(903,'suleeporn@tni.ac.th','suleeporn','suleeporn',NULL,NULL,NULL,NULL,NULL,NULL),(904,'supaluk@tni.ac.th','Supaluk','Prapan',NULL,NULL,NULL,NULL,NULL,NULL),(905,'supanithi@tni.ac.th','Supanithi','Ruangthong',NULL,NULL,NULL,NULL,NULL,NULL),(906,'supansa@tni.ac.th','Supansa','Pinsri',NULL,NULL,NULL,NULL,NULL,NULL),(907,'supaporn.r@tni.ac.th','supaporn','ruandsuwan',NULL,NULL,NULL,NULL,NULL,NULL),(908,'supaporn@tni.ac.th','Supaporn','Hempongsopa',NULL,NULL,NULL,NULL,NULL,NULL),(909,'supatsorn@tni.ac.th','Supatsorn','Jindathai',NULL,NULL,NULL,NULL,NULL,NULL),(910,'supit@tni.ac.th','Supit','Baykaykom',NULL,NULL,NULL,NULL,NULL,NULL),(911,'supong.c@tni.ac.th','Supong','Chayutsahakij',NULL,NULL,NULL,NULL,NULL,NULL),(912,'sura.l@tni.ac.th','Sura','Larptawee',NULL,NULL,NULL,NULL,NULL,NULL),(913,'sura@tni.ac.th','Sura','Lekhakul',NULL,NULL,NULL,NULL,NULL,NULL),(914,'suradech@tni.ac.th','Suradech','Phattaravichien',NULL,NULL,NULL,NULL,NULL,NULL),(915,'surapon@tni.ac.th','Surapon','Eiamprapaporn',NULL,NULL,NULL,NULL,NULL,NULL),(916,'surawat@tni.ac.th','Surawat','Yingsawad',NULL,NULL,NULL,NULL,NULL,NULL),(917,'suthasinee@tni.ac.th','Suthasinee','Wongsaroj',NULL,NULL,NULL,NULL,NULL,NULL),(918,'suthatip@tni.ac.th','suthatip','suthatip',NULL,NULL,NULL,NULL,NULL,NULL),(919,'suthida@tni.ac.th','Suthida','Manaswakul',NULL,NULL,NULL,NULL,NULL,NULL),(920,'sutiruk@tni.ac.th','Sutiruk','Singnok',NULL,NULL,NULL,NULL,NULL,NULL),(921,'suwannapa@tni.ac.th','Suwannapa','Reungsilpkonlakarn',NULL,NULL,NULL,NULL,NULL,NULL),(922,'suwat@tni.ac.th','Suwat','Pranimit',NULL,NULL,NULL,NULL,NULL,NULL),(923,'suwatana@tni.ac.th','Suwatana','Daengsubha',NULL,NULL,NULL,NULL,NULL,NULL),(924,'suzuki@tni.ac.th','Suzuki','Norio',NULL,NULL,NULL,NULL,NULL,NULL),(925,'tajima@tni.ac.th','tajima','tajima',NULL,NULL,NULL,NULL,NULL,NULL),(926,'takagi@tni.ac.th','takagi','tagagi',NULL,NULL,NULL,NULL,NULL,NULL),(927,'takamagari@tni.ac.th','Nahoko','TAKAMAGARI',NULL,NULL,NULL,NULL,NULL,NULL),(928,'takashi@tni.ac.th','takashi','YAMAMOTO',NULL,NULL,NULL,NULL,NULL,NULL),(929,'tanasin@tni.ac.th','Tanasin','Yatsungnoen',NULL,NULL,NULL,NULL,NULL,NULL),(930,'tanyaporn@tni.ac.th','Tanyaporn','Kanignant',NULL,NULL,NULL,NULL,NULL,NULL),(931,'tbrs@tni.ac.th','tbrs','tbrs',NULL,NULL,NULL,NULL,NULL,NULL),(932,'teerawet@tni.ac.th','teerawet','teerawet',NULL,NULL,NULL,NULL,NULL,NULL),(933,'Teetitorn@tni.ac.th','Teetitorn','Chullapram',NULL,NULL,NULL,NULL,NULL,NULL),(934,'test2@tni.ac.th','test2','test2',NULL,NULL,NULL,NULL,NULL,NULL),(935,'test3@tni.ac.th','test','Test Dummy',NULL,NULL,NULL,NULL,NULL,NULL),(936,'test@tni.ac.th','test','test',NULL,NULL,NULL,NULL,NULL,NULL),(937,'thai@tni.ac.th','thai','thai',NULL,NULL,NULL,NULL,NULL,NULL),(938,'Thanya@tni.ac.th','Thanya','Kiatiwat',NULL,NULL,NULL,NULL,NULL,NULL),(939,'Thavorn@tni.ac.th','Thavorn','Chalassathien',NULL,NULL,NULL,NULL,NULL,NULL),(940,'theantot@tni.ac.th','Theantot','Prapuetchob',NULL,NULL,NULL,NULL,NULL,NULL),(941,'theera@tni.ac.th','Theera','Sutabuta',NULL,NULL,NULL,NULL,NULL,NULL),(942,'theeranuch@tni.ac.th','Theeranuch','Raksaphongsarn',NULL,NULL,NULL,NULL,NULL,NULL),(943,'therdsak@tni.ac.th','Therdsak','Jaingam',NULL,NULL,NULL,NULL,NULL,NULL),(944,'thitima@tni.ac.th','Thitima','Somtong',NULL,NULL,NULL,NULL,NULL,NULL),(945,'thitiporn@tni.ac.th','Thitiporn','Lertrusdachakul',NULL,NULL,NULL,NULL,NULL,NULL),(946,'thitisorn@tni.ac.th','Thitisorn','Saeng-urai',NULL,NULL,NULL,NULL,NULL,NULL),(947,'thomas@tni.ac.th','thomas','thomas',NULL,NULL,NULL,NULL,NULL,NULL),(948,'thongchai@tni.ac.th','Thongchai','Kaewkiriya',NULL,NULL,NULL,NULL,NULL,NULL),(949,'thuanthong@tni.ac.th','thuanthong','thuanthong',NULL,NULL,NULL,NULL,NULL,NULL),(950,'ti.natee@tni.ac.th','Natee','Tintonglang',NULL,NULL,NULL,NULL,NULL,NULL),(951,'titichaya@tni.ac.th','titichaya','titichaya',NULL,NULL,NULL,NULL,NULL,NULL),(952,'tiwa@tni.ac.th','Aeh','Park',NULL,NULL,NULL,NULL,NULL,NULL),(953,'tni-wmc@tni.ac.th','tniwmc','tniwmc',NULL,NULL,NULL,NULL,NULL,NULL),(954,'tniac@tni.ac.th','tniac','tniac',NULL,NULL,NULL,NULL,NULL,NULL),(955,'tniinfo@tni.ac.th','TNI','Information',NULL,NULL,NULL,NULL,NULL,NULL),(956,'tniregister@tni.ac.th','TNI','Register',NULL,NULL,NULL,NULL,NULL,NULL),(957,'todsaporn@tni.ac.th','Todsaporn','Sisan',NULL,NULL,NULL,NULL,NULL,NULL),(958,'tomimuro@tni.ac.th','tomimuro','tomimuro',NULL,NULL,NULL,NULL,NULL,NULL),(959,'torkiat@tni.ac.th','Torkiat','Taithongchai',NULL,NULL,NULL,NULL,NULL,NULL),(960,'toyama@tni.ac.th','Jun','TOYAMA',NULL,NULL,NULL,NULL,NULL,NULL),(961,'triratana@tni.ac.th','Triratana','Metkarunchit',NULL,NULL,NULL,NULL,NULL,NULL),(962,'trizit@tni.ac.th','Trizit','Benjaboonyazit',NULL,NULL,NULL,NULL,NULL,NULL),(963,'u-sa@tni.ac.th','U-sa','Sudjuntak',NULL,NULL,NULL,NULL,NULL,NULL),(964,'udorn@tni.ac.th','Udorn','Junthorn',NULL,NULL,NULL,NULL,NULL,NULL),(965,'umnard@tni.ac.th','umnard','umnard',NULL,NULL,NULL,NULL,NULL,NULL),(966,'varin@tni.ac.th','Varin','Sumonpun',NULL,NULL,NULL,NULL,NULL,NULL),(967,'Virach@tni.ac.th','Virach','Phimeteetamrong',NULL,NULL,NULL,NULL,NULL,NULL),(968,'vithinut@tni.ac.th','Vithinut','Phakphonhamin',NULL,NULL,NULL,NULL,NULL,NULL),(969,'voravee@tni.ac.th','voravee','voravee',NULL,NULL,NULL,NULL,NULL,NULL),(970,'walanyakorn@tni.ac.th','Walanyakorn','Wongwangchan',NULL,NULL,NULL,NULL,NULL,NULL),(971,'wanchalerm@tni.ac.th','wanchalerm','wanchalerm',NULL,NULL,NULL,NULL,NULL,NULL),(972,'wannapha@tni.ac.th','wannapha','wannapha',NULL,NULL,NULL,NULL,NULL,NULL),(973,'wannapol@tni.ac.th','Wannapol','Suphaskuldamrong',NULL,NULL,NULL,NULL,NULL,NULL),(974,'wannipa@tni.ac.th','Wannipa','Pamakate',NULL,NULL,NULL,NULL,NULL,NULL),(975,'wanvisa@tni.ac.th','wanvisa','ketpratoom',NULL,NULL,NULL,NULL,NULL,NULL),(976,'wanwimon@tni.ac.th','Wanwimon','Roungtheera',NULL,NULL,NULL,NULL,NULL,NULL),(977,'warakom@tni.ac.th','Warakom','Nerdnoi',NULL,NULL,NULL,NULL,NULL,NULL),(978,'warakorn@tni.ac.th','Warakorn','Srichavengsup',NULL,NULL,NULL,NULL,NULL,NULL),(979,'warangkana@tni.ac.th','Warangkana','Suksom',NULL,NULL,NULL,NULL,NULL,NULL),(980,'wareerat@tni.ac.th','Wareerat','Worachan',NULL,NULL,NULL,NULL,NULL,NULL),(981,'warunee@tni.ac.th','Warunee','Ukkesureyon',NULL,NULL,NULL,NULL,NULL,NULL),(982,'wasin@tni.ac.th','Wasin','Noosandot',NULL,NULL,NULL,NULL,NULL,NULL),(983,'watcharaporn@tni.ac.th','Watcharaporn','Chantakhan',NULL,NULL,NULL,NULL,NULL,NULL),(984,'weerawan@tni.ac.th','weerawan','weerawan',NULL,NULL,NULL,NULL,NULL,NULL),(985,'weranuch@tni.ac.th','Weranuch','Bangthamai',NULL,NULL,NULL,NULL,NULL,NULL),(986,'wimol@tni.ac.th','Wimol','San-Um',NULL,NULL,NULL,NULL,NULL,NULL),(987,'wipanee@tni.ac.th','Wipanee','Pengnate',NULL,NULL,NULL,NULL,NULL,NULL),(988,'wipawadee@tni.ac.th','Wipawadee','Wongsuwan',NULL,NULL,NULL,NULL,NULL,NULL),(989,'wiroj@tni.ac.th','Wiroj','Thasana',NULL,NULL,NULL,NULL,NULL,NULL),(990,'wisanu@tni.ac.th','Wisanu','Petchthai',NULL,NULL,NULL,NULL,NULL,NULL),(991,'wisit@tni.ac.th','Wisit','Songmuang',NULL,NULL,NULL,NULL,NULL,NULL),(992,'Wiwat@tni.ac.th','Wiwat','Phanoompaitool',NULL,NULL,NULL,NULL,NULL,NULL),(993,'worawut@tni.ac.th','Worawut','Chitkchornwanit',NULL,NULL,NULL,NULL,NULL,NULL),(994,'wut@tni.ac.th','Wut','Sookcharoen',NULL,NULL,NULL,NULL,NULL,NULL),(995,'wuttichai@tni.ac.th','Wuttichai','Wisitsangtong',NULL,NULL,NULL,NULL,NULL,NULL),(996,'wuttipong@tni.ac.th','Wuttipong','Pawasarn',NULL,NULL,NULL,NULL,NULL,NULL),(997,'yamamoto@tni.ac.th','Yamamoto','Sozo',NULL,NULL,NULL,NULL,NULL,NULL),(998,'yasutake@tni.ac.th','Yasutake','Hikaru',NULL,NULL,NULL,NULL,NULL,NULL),(999,'yingyong@tni.ac.th','Yingyong','Kaewkohkiat',NULL,NULL,NULL,NULL,NULL,NULL),(1000,'yoshihara@tni.ac.th','yoshihara','yoshihara',NULL,NULL,NULL,NULL,NULL,NULL),(1001,'yuko@tni.ac.th','Yuko','Kunitake',NULL,NULL,NULL,NULL,NULL,NULL),(1002,'yuranan@tni.ac.th','Yuranan','Musor',NULL,NULL,NULL,NULL,NULL,NULL),(1003,'warakorn9z@gmail.com','Warakorn','Chanprasopchai',NULL,2,NULL,NULL,3,NULL),(1004,'ku.tharnnapat_st@tni.ac.th','Tharnnapat','Kungwarnsishsorn','083-608-3901',2,NULL,NULL,1,NULL),(1005,'kh.teerapol_st@tni.ac.th','Teerapol','Khajornkrung','083-811-6548',2,NULL,NULL,1,NULL),(1006,'pr.vorachat _st@tni.ac.th','vorachat','promkul','-',2,NULL,NULL,1,NULL),(1007,'9pi@tni.ac.th','9Pi','9Pi','-',2,NULL,NULL,1,NULL),(1011,'krunapon@kku.ac.th','Kanda',NULL,NULL,1,NULL,NULL,2,NULL),(1012,'krunapon@kku.ac.th','Kanda',NULL,NULL,2,NULL,NULL,2,NULL),(1013,'soshi9z@gmail.com',NULL,NULL,NULL,1,NULL,NULL,3,NULL),(1014,'chubz2849@gmail.com',NULL,NULL,NULL,1,NULL,NULL,3,NULL),(1015,'akibara_toya@gmail.com',NULL,NULL,NULL,1,NULL,NULL,3,NULL),(1016,'kanda.runapongsa@gmail.com',NULL,NULL,NULL,1,NULL,NULL,3,NULL),(1017,'amarin.c1@9pi.co.th',NULL,NULL,NULL,1,NULL,NULL,5,NULL),(1018,'victor.borrull@gmail.com',NULL,NULL,NULL,1,NULL,NULL,3,NULL),(1019,'ball.vong.yo.gh@gmail.com','Ball','Junrat','none',1,'none','none',3,0);
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student` (
  `student_id` int(6) NOT NULL AUTO_INCREMENT,
  `student_code` varchar(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(50) NOT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `type` int(1) DEFAULT NULL,
  `enter_year` varchar(50) DEFAULT NULL,
  `cumulative_gpa` varchar(45) DEFAULT NULL,
  `university_id` int(11) DEFAULT NULL,
  `faculty_id` int(6) DEFAULT NULL,
  PRIMARY KEY (`student_id`,`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (2,'54123007-4','kh.teerapol_st@tni.ac.th','bowran','teerapol','kajornkrung','-',1,'2554','4.00',1,NULL),(3,'54123031-5','ku.tharnnapat_st@tni.ac.th','tharnnapat','tharnnapat','kungwarnsishsorn','-',1,'2554','4.00',1,NULL);
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submittedassignment`
--

DROP TABLE IF EXISTS `submittedassignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `submittedassignment` (
  `assignment_id` int(6) NOT NULL,
  `student_id` int(6) NOT NULL,
  `description` text,
  `file_id` int(6) DEFAULT NULL,
  `score` int(4) DEFAULT NULL,
  `timestamp` time NOT NULL,
  PRIMARY KEY (`assignment_id`,`student_id`),
  KEY `student_id` (`student_id`),
  KEY `file_id` (`file_id`),
  CONSTRAINT `submittedassignment_ibfk_1` FOREIGN KEY (`assignment_id`) REFERENCES `assignment` (`assignment_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `submittedassignment_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `submittedassignment_ibfk_3` FOREIGN KEY (`file_id`) REFERENCES `file` (`file_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submittedassignment`
--

LOCK TABLES `submittedassignment` WRITE;
/*!40000 ALTER TABLE `submittedassignment` DISABLE KEYS */;
/*!40000 ALTER TABLE `submittedassignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `university`
--

DROP TABLE IF EXISTS `university`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `university` (
  `university_id` int(6) NOT NULL AUTO_INCREMENT,
  `title` varchar(250) NOT NULL,
  `couse_group` text,
  `domain` varchar(20) DEFAULT NULL,
  `payment_type` int(6) DEFAULT '1',
  `super` int(6) DEFAULT '0',
  PRIMARY KEY (`university_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `university`
--

LOCK TABLES `university` WRITE;
/*!40000 ALTER TABLE `university` DISABLE KEYS */;
INSERT INTO `university` VALUES (1,'Thai-Nichi Institute of Technology',NULL,'@tni.ac.th',1,0),(2,'Khon Kaen University',NULL,'@kku.ac.th',1,0),(3,'Google University',NULL,'@gmail.com',1,1),(5,'9Pi',NULL,'@9pi.co.th',1,1);
/*!40000 ALTER TABLE `university` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `mysql`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `mysql` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `mysql`;

--
-- Table structure for table `general_log`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `general_log` (
  `event_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_host` mediumtext NOT NULL,
  `thread_id` int(11) NOT NULL,
  `server_id` int(10) unsigned NOT NULL,
  `command_type` varchar(64) NOT NULL,
  `argument` mediumtext NOT NULL
) ENGINE=CSV DEFAULT CHARSET=utf8 COMMENT='General log';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `slow_log`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `slow_log` (
  `start_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_host` mediumtext NOT NULL,
  `query_time` time NOT NULL,
  `lock_time` time NOT NULL,
  `rows_sent` int(11) NOT NULL,
  `rows_examined` int(11) NOT NULL,
  `db` varchar(512) NOT NULL,
  `last_insert_id` int(11) NOT NULL,
  `insert_id` int(11) NOT NULL,
  `server_id` int(10) unsigned NOT NULL,
  `sql_text` mediumtext NOT NULL
) ENGINE=CSV DEFAULT CHARSET=utf8 COMMENT='Slow log';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `columns_priv`
--

DROP TABLE IF EXISTS `columns_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `columns_priv` (
  `Host` char(60) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Db` char(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `User` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Table_name` char(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Column_name` char(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Column_priv` set('Select','Insert','Update','References') CHARACTER SET utf8 NOT NULL DEFAULT '',
  PRIMARY KEY (`Host`,`Db`,`User`,`Table_name`,`Column_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `columns_priv`
--

LOCK TABLES `columns_priv` WRITE;
/*!40000 ALTER TABLE `columns_priv` DISABLE KEYS */;
/*!40000 ALTER TABLE `columns_priv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `db`
--

DROP TABLE IF EXISTS `db`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `db` (
  `Host` char(60) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Db` char(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `User` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Select_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Insert_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Update_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Delete_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Create_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Drop_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Grant_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `References_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Index_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Alter_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Create_tmp_table_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Lock_tables_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Create_view_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Show_view_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Create_routine_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Alter_routine_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Execute_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Event_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Trigger_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  PRIMARY KEY (`Host`,`Db`,`User`),
  KEY `User` (`User`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `db`
--

LOCK TABLES `db` WRITE;
/*!40000 ALTER TABLE `db` DISABLE KEYS */;
INSERT INTO `db` VALUES ('%','test','','Y','Y','Y','Y','Y','Y','N','Y','Y','Y','Y','Y','Y','Y','Y','N','N','Y','Y'),('%','test\\_%','','Y','Y','Y','Y','Y','Y','N','Y','Y','Y','Y','Y','Y','Y','Y','N','N','Y','Y');
/*!40000 ALTER TABLE `db` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entries`
--

DROP TABLE IF EXISTS `entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entries` (
  `guestName` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `entryID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`entryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entries`
--

LOCK TABLES `entries` WRITE;
/*!40000 ALTER TABLE `entries` DISABLE KEYS */;
/*!40000 ALTER TABLE `entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event` (
  `db` char(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `name` char(64) NOT NULL DEFAULT '',
  `body` longblob NOT NULL,
  `definer` char(77) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `execute_at` datetime DEFAULT NULL,
  `interval_value` int(11) DEFAULT NULL,
  `interval_field` enum('YEAR','QUARTER','MONTH','DAY','HOUR','MINUTE','WEEK','SECOND','MICROSECOND','YEAR_MONTH','DAY_HOUR','DAY_MINUTE','DAY_SECOND','HOUR_MINUTE','HOUR_SECOND','MINUTE_SECOND','DAY_MICROSECOND','HOUR_MICROSECOND','MINUTE_MICROSECOND','SECOND_MICROSECOND') DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_executed` datetime DEFAULT NULL,
  `starts` datetime DEFAULT NULL,
  `ends` datetime DEFAULT NULL,
  `status` enum('ENABLED','DISABLED','SLAVESIDE_DISABLED') NOT NULL DEFAULT 'ENABLED',
  `on_completion` enum('DROP','PRESERVE') NOT NULL DEFAULT 'DROP',
  `sql_mode` set('REAL_AS_FLOAT','PIPES_AS_CONCAT','ANSI_QUOTES','IGNORE_SPACE','NOT_USED','ONLY_FULL_GROUP_BY','NO_UNSIGNED_SUBTRACTION','NO_DIR_IN_CREATE','POSTGRESQL','ORACLE','MSSQL','DB2','MAXDB','NO_KEY_OPTIONS','NO_TABLE_OPTIONS','NO_FIELD_OPTIONS','MYSQL323','MYSQL40','ANSI','NO_AUTO_VALUE_ON_ZERO','NO_BACKSLASH_ESCAPES','STRICT_TRANS_TABLES','STRICT_ALL_TABLES','NO_ZERO_IN_DATE','NO_ZERO_DATE','INVALID_DATES','ERROR_FOR_DIVISION_BY_ZERO','TRADITIONAL','NO_AUTO_CREATE_USER','HIGH_NOT_PRECEDENCE','NO_ENGINE_SUBSTITUTION','PAD_CHAR_TO_FULL_LENGTH') NOT NULL DEFAULT '',
  `comment` char(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `originator` int(10) unsigned NOT NULL,
  `time_zone` char(64) CHARACTER SET latin1 NOT NULL DEFAULT 'SYSTEM',
  `character_set_client` char(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `collation_connection` char(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `db_collation` char(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `body_utf8` longblob,
  PRIMARY KEY (`db`,`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Events';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `func`
--

DROP TABLE IF EXISTS `func`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `func` (
  `name` char(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ret` tinyint(1) NOT NULL DEFAULT '0',
  `dl` char(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `type` enum('function','aggregate') CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User defined functions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `func`
--

LOCK TABLES `func` WRITE;
/*!40000 ALTER TABLE `func` DISABLE KEYS */;
/*!40000 ALTER TABLE `func` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `help_category`
--

DROP TABLE IF EXISTS `help_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `help_category` (
  `help_category_id` smallint(5) unsigned NOT NULL,
  `name` char(64) NOT NULL,
  `parent_category_id` smallint(5) unsigned DEFAULT NULL,
  `url` char(128) NOT NULL,
  PRIMARY KEY (`help_category_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='help categories';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `help_category`
--

LOCK TABLES `help_category` WRITE;
/*!40000 ALTER TABLE `help_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `help_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `help_keyword`
--

DROP TABLE IF EXISTS `help_keyword`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `help_keyword` (
  `help_keyword_id` int(10) unsigned NOT NULL,
  `name` char(64) NOT NULL,
  PRIMARY KEY (`help_keyword_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='help keywords';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `help_keyword`
--

LOCK TABLES `help_keyword` WRITE;
/*!40000 ALTER TABLE `help_keyword` DISABLE KEYS */;
/*!40000 ALTER TABLE `help_keyword` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `help_relation`
--

DROP TABLE IF EXISTS `help_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `help_relation` (
  `help_topic_id` int(10) unsigned NOT NULL,
  `help_keyword_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`help_keyword_id`,`help_topic_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='keyword-topic relation';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `help_relation`
--

LOCK TABLES `help_relation` WRITE;
/*!40000 ALTER TABLE `help_relation` DISABLE KEYS */;
/*!40000 ALTER TABLE `help_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `help_topic`
--

DROP TABLE IF EXISTS `help_topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `help_topic` (
  `help_topic_id` int(10) unsigned NOT NULL,
  `name` char(64) NOT NULL,
  `help_category_id` smallint(5) unsigned NOT NULL,
  `description` text NOT NULL,
  `example` text NOT NULL,
  `url` char(128) NOT NULL,
  PRIMARY KEY (`help_topic_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='help topics';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `help_topic`
--

LOCK TABLES `help_topic` WRITE;
/*!40000 ALTER TABLE `help_topic` DISABLE KEYS */;
/*!40000 ALTER TABLE `help_topic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `host`
--

DROP TABLE IF EXISTS `host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host` (
  `Host` char(60) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Db` char(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Select_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Insert_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Update_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Delete_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Create_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Drop_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Grant_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `References_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Index_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Alter_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Create_tmp_table_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Lock_tables_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Create_view_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Show_view_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Create_routine_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Alter_routine_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Execute_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Trigger_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  PRIMARY KEY (`Host`,`Db`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Host privileges;  Merged with database privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host`
--

LOCK TABLES `host` WRITE;
/*!40000 ALTER TABLE `host` DISABLE KEYS */;
/*!40000 ALTER TABLE `host` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ndb_binlog_index`
--

DROP TABLE IF EXISTS `ndb_binlog_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ndb_binlog_index` (
  `Position` bigint(20) unsigned NOT NULL,
  `File` varchar(255) NOT NULL,
  `epoch` bigint(20) unsigned NOT NULL,
  `inserts` bigint(20) unsigned NOT NULL,
  `updates` bigint(20) unsigned NOT NULL,
  `deletes` bigint(20) unsigned NOT NULL,
  `schemaops` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`epoch`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ndb_binlog_index`
--

LOCK TABLES `ndb_binlog_index` WRITE;
/*!40000 ALTER TABLE `ndb_binlog_index` DISABLE KEYS */;
/*!40000 ALTER TABLE `ndb_binlog_index` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plugin`
--

DROP TABLE IF EXISTS `plugin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin` (
  `name` varchar(64) NOT NULL DEFAULT '',
  `dl` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='MySQL plugins';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plugin`
--

LOCK TABLES `plugin` WRITE;
/*!40000 ALTER TABLE `plugin` DISABLE KEYS */;
/*!40000 ALTER TABLE `plugin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proc`
--

DROP TABLE IF EXISTS `proc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proc` (
  `db` char(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `name` char(64) NOT NULL DEFAULT '',
  `type` enum('FUNCTION','PROCEDURE') NOT NULL,
  `specific_name` char(64) NOT NULL DEFAULT '',
  `language` enum('SQL') NOT NULL DEFAULT 'SQL',
  `sql_data_access` enum('CONTAINS_SQL','NO_SQL','READS_SQL_DATA','MODIFIES_SQL_DATA') NOT NULL DEFAULT 'CONTAINS_SQL',
  `is_deterministic` enum('YES','NO') NOT NULL DEFAULT 'NO',
  `security_type` enum('INVOKER','DEFINER') NOT NULL DEFAULT 'DEFINER',
  `param_list` blob NOT NULL,
  `returns` longblob NOT NULL,
  `body` longblob NOT NULL,
  `definer` char(77) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `sql_mode` set('REAL_AS_FLOAT','PIPES_AS_CONCAT','ANSI_QUOTES','IGNORE_SPACE','NOT_USED','ONLY_FULL_GROUP_BY','NO_UNSIGNED_SUBTRACTION','NO_DIR_IN_CREATE','POSTGRESQL','ORACLE','MSSQL','DB2','MAXDB','NO_KEY_OPTIONS','NO_TABLE_OPTIONS','NO_FIELD_OPTIONS','MYSQL323','MYSQL40','ANSI','NO_AUTO_VALUE_ON_ZERO','NO_BACKSLASH_ESCAPES','STRICT_TRANS_TABLES','STRICT_ALL_TABLES','NO_ZERO_IN_DATE','NO_ZERO_DATE','INVALID_DATES','ERROR_FOR_DIVISION_BY_ZERO','TRADITIONAL','NO_AUTO_CREATE_USER','HIGH_NOT_PRECEDENCE','NO_ENGINE_SUBSTITUTION','PAD_CHAR_TO_FULL_LENGTH') NOT NULL DEFAULT '',
  `comment` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `character_set_client` char(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `collation_connection` char(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `db_collation` char(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `body_utf8` longblob,
  PRIMARY KEY (`db`,`name`,`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stored Procedures';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proc`
--

LOCK TABLES `proc` WRITE;
/*!40000 ALTER TABLE `proc` DISABLE KEYS */;
/*!40000 ALTER TABLE `proc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `procs_priv`
--

DROP TABLE IF EXISTS `procs_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `procs_priv` (
  `Host` char(60) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Db` char(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `User` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Routine_name` char(64) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `Routine_type` enum('FUNCTION','PROCEDURE') COLLATE utf8_bin NOT NULL,
  `Grantor` char(77) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Proc_priv` set('Execute','Alter Routine','Grant') CHARACTER SET utf8 NOT NULL DEFAULT '',
  `Timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Host`,`Db`,`User`,`Routine_name`,`Routine_type`),
  KEY `Grantor` (`Grantor`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Procedure privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `procs_priv`
--

LOCK TABLES `procs_priv` WRITE;
/*!40000 ALTER TABLE `procs_priv` DISABLE KEYS */;
/*!40000 ALTER TABLE `procs_priv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proxies_priv`
--

DROP TABLE IF EXISTS `proxies_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proxies_priv` (
  `Host` char(60) COLLATE utf8_bin NOT NULL DEFAULT '',
  `User` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Proxied_host` char(60) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Proxied_user` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `With_grant` tinyint(1) NOT NULL DEFAULT '0',
  `Grantor` char(77) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Host`,`User`,`Proxied_host`,`Proxied_user`),
  KEY `Grantor` (`Grantor`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User proxy privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proxies_priv`
--

LOCK TABLES `proxies_priv` WRITE;
/*!40000 ALTER TABLE `proxies_priv` DISABLE KEYS */;
INSERT INTO `proxies_priv` VALUES ('localhost','root','','',1,'','2013-08-04 15:51:32');
/*!40000 ALTER TABLE `proxies_priv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servers`
--

DROP TABLE IF EXISTS `servers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servers` (
  `Server_name` char(64) NOT NULL DEFAULT '',
  `Host` char(64) NOT NULL DEFAULT '',
  `Db` char(64) NOT NULL DEFAULT '',
  `Username` char(64) NOT NULL DEFAULT '',
  `Password` char(64) NOT NULL DEFAULT '',
  `Port` int(4) NOT NULL DEFAULT '0',
  `Socket` char(64) NOT NULL DEFAULT '',
  `Wrapper` char(64) NOT NULL DEFAULT '',
  `Owner` char(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`Server_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='MySQL Foreign Servers table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servers`
--

LOCK TABLES `servers` WRITE;
/*!40000 ALTER TABLE `servers` DISABLE KEYS */;
/*!40000 ALTER TABLE `servers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tables_priv`
--

DROP TABLE IF EXISTS `tables_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tables_priv` (
  `Host` char(60) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Db` char(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `User` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Table_name` char(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Grantor` char(77) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Table_priv` set('Select','Insert','Update','Delete','Create','Drop','Grant','References','Index','Alter','Create View','Show view','Trigger') CHARACTER SET utf8 NOT NULL DEFAULT '',
  `Column_priv` set('Select','Insert','Update','References') CHARACTER SET utf8 NOT NULL DEFAULT '',
  PRIMARY KEY (`Host`,`Db`,`User`,`Table_name`),
  KEY `Grantor` (`Grantor`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tables_priv`
--

LOCK TABLES `tables_priv` WRITE;
/*!40000 ALTER TABLE `tables_priv` DISABLE KEYS */;
/*!40000 ALTER TABLE `tables_priv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_zone`
--

DROP TABLE IF EXISTS `time_zone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_zone` (
  `Time_zone_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Use_leap_seconds` enum('Y','N') NOT NULL DEFAULT 'N',
  PRIMARY KEY (`Time_zone_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Time zones';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_zone`
--

LOCK TABLES `time_zone` WRITE;
/*!40000 ALTER TABLE `time_zone` DISABLE KEYS */;
/*!40000 ALTER TABLE `time_zone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_zone_leap_second`
--

DROP TABLE IF EXISTS `time_zone_leap_second`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_zone_leap_second` (
  `Transition_time` bigint(20) NOT NULL,
  `Correction` int(11) NOT NULL,
  PRIMARY KEY (`Transition_time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Leap seconds information for time zones';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_zone_leap_second`
--

LOCK TABLES `time_zone_leap_second` WRITE;
/*!40000 ALTER TABLE `time_zone_leap_second` DISABLE KEYS */;
/*!40000 ALTER TABLE `time_zone_leap_second` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_zone_name`
--

DROP TABLE IF EXISTS `time_zone_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_zone_name` (
  `Name` char(64) NOT NULL,
  `Time_zone_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`Name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Time zone names';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_zone_name`
--

LOCK TABLES `time_zone_name` WRITE;
/*!40000 ALTER TABLE `time_zone_name` DISABLE KEYS */;
/*!40000 ALTER TABLE `time_zone_name` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_zone_transition`
--

DROP TABLE IF EXISTS `time_zone_transition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_zone_transition` (
  `Time_zone_id` int(10) unsigned NOT NULL,
  `Transition_time` bigint(20) NOT NULL,
  `Transition_type_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`Time_zone_id`,`Transition_time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Time zone transitions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_zone_transition`
--

LOCK TABLES `time_zone_transition` WRITE;
/*!40000 ALTER TABLE `time_zone_transition` DISABLE KEYS */;
/*!40000 ALTER TABLE `time_zone_transition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_zone_transition_type`
--

DROP TABLE IF EXISTS `time_zone_transition_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_zone_transition_type` (
  `Time_zone_id` int(10) unsigned NOT NULL,
  `Transition_type_id` int(10) unsigned NOT NULL,
  `Offset` int(11) NOT NULL DEFAULT '0',
  `Is_DST` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Abbreviation` char(8) NOT NULL DEFAULT '',
  PRIMARY KEY (`Time_zone_id`,`Transition_type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Time zone transition types';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_zone_transition_type`
--

LOCK TABLES `time_zone_transition_type` WRITE;
/*!40000 ALTER TABLE `time_zone_transition_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `time_zone_transition_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `Host` char(60) COLLATE utf8_bin NOT NULL DEFAULT '',
  `User` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Password` char(41) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `Select_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Insert_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Update_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Delete_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Create_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Drop_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Reload_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Shutdown_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Process_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `File_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Grant_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `References_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Index_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Alter_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Show_db_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Super_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Create_tmp_table_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Lock_tables_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Execute_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Repl_slave_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Repl_client_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Create_view_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Show_view_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Create_routine_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Alter_routine_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Create_user_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Event_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Trigger_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Create_tablespace_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `ssl_type` enum('','ANY','X509','SPECIFIED') CHARACTER SET utf8 NOT NULL DEFAULT '',
  `ssl_cipher` blob NOT NULL,
  `x509_issuer` blob NOT NULL,
  `x509_subject` blob NOT NULL,
  `max_questions` int(11) unsigned NOT NULL DEFAULT '0',
  `max_updates` int(11) unsigned NOT NULL DEFAULT '0',
  `max_connections` int(11) unsigned NOT NULL DEFAULT '0',
  `max_user_connections` int(11) unsigned NOT NULL DEFAULT '0',
  `plugin` char(64) COLLATE utf8_bin DEFAULT '',
  `authentication_string` text COLLATE utf8_bin,
  PRIMARY KEY (`Host`,`User`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and global privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('localhost','root','','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','','','','',0,0,0,0,'',''),('127.0.0.1','root','','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','','','','',0,0,0,0,'',''),('::1','root','','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','','','','',0,0,0,0,'',''),('localhost','','','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','','','','',0,0,0,0,'',NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Flush Grant Tables 
--

/*! FLUSH PRIVILEGES */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-09-21 18:39:33
