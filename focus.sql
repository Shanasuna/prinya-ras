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
