-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jun 17, 2015 at 08:52 PM
-- Server version: 5.5.27
-- PHP Version: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `library_management`
--

-- --------------------------------------------------------

--
-- Table structure for table `book_category`
--

CREATE TABLE IF NOT EXISTS `book_category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(45) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `book_category`
--

INSERT INTO `book_category` (`category_id`, `category_name`) VALUES
(1, 'Java'),
(2, 'Object Oriented Analysis and Design'),
(3, 'Software Architecture'),
(4, 'XML'),
(5, 'Python'),
(6, 'JQuery'),
(7, 'Javascript');

-- --------------------------------------------------------

--
-- Table structure for table `book_details`
--

CREATE TABLE IF NOT EXISTS `book_details` (
  `book_id` int(11) NOT NULL AUTO_INCREMENT,
  `book_name` varchar(45) NOT NULL,
  `book_isbn` varchar(45) NOT NULL,
  `book_author` varchar(45) NOT NULL,
  `book_edition` int(11) NOT NULL,
  `book_category_id` int(11) NOT NULL,
  PRIMARY KEY (`book_id`,`book_category_id`),
  KEY `fk_book_details_book_category_idx` (`book_category_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=115 ;

--
-- Dumping data for table `book_details`
--

INSERT INTO `book_details` (`book_id`, `book_name`, `book_isbn`, `book_author`, `book_edition`, `book_category_id`) VALUES
(101, 'Class of Java', ' 978-3-16-148410-0', 'Pravin Jain', 3, 1),
(102, 'Head Start Python', '978-1-4493-8267-4', 'Paul Barry', 3, 5),
(103, 'Head Start Java', '978-3-16-148410-0', 'Silvester Barry', 2, 1),
(104, 'Learning UML', '978-1-4493-8267-4', 'O''Rielley', 2, 2),
(105, 'Learning XML', '978-3-16-148410-0', 'Atul Kahate', 4, 4),
(108, 'XML Tracnologies', '0-123456-47-9', 'Atul Kahate', 4, 4),
(109, 'Head First JQuery', '0-123456-47-9', 'Atul Kahate', 2, 6),
(110, 'Head First JQuery', '0-123456-47-9', 'Atul Kahate', 2, 6),
(112, 'Thinking in Java', '0-123456-47-9', 'Robert Brown', 3, 1),
(113, 'Art of Software Architecture', '978-1-44-938267-4', 'B. Gomez', 2, 3),
(114, 'Javascript-The Good Parts', '978-1-44-938267-4', 'Hazel Gull', 3, 7);

-- --------------------------------------------------------

--
-- Table structure for table `book_issue_return`
--

CREATE TABLE IF NOT EXISTS `book_issue_return` (
  `return_id` int(11) NOT NULL AUTO_INCREMENT,
  `issue_date` date NOT NULL,
  `expected_return_date` date NOT NULL,
  `actual_return_date` date DEFAULT NULL,
  `book_id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `status` varchar(10) NOT NULL,
  PRIMARY KEY (`return_id`,`book_id`,`member_id`),
  KEY `fk_book_return_book_details1_idx` (`book_id`),
  KEY `fk_book_return_member_details1_idx` (`member_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `book_issue_return`
--

INSERT INTO `book_issue_return` (`return_id`, `issue_date`, `expected_return_date`, `actual_return_date`, `book_id`, `member_id`, `status`) VALUES
(1, '2015-03-10', '2015-03-17', '2015-03-14', 101, 1, 'returned'),
(2, '2015-03-07', '2015-03-14', '2015-03-16', 102, 1, 'returned'),
(3, '2015-03-12', '2015-03-19', '2015-03-21', 102, 2, 'returned'),
(4, '2015-03-13', '2015-03-20', '2015-03-18', 101, 3, 'returned'),
(5, '2015-03-13', '2015-03-20', NULL, 105, 4, 'issued'),
(6, '2015-03-14', '2015-03-21', '2015-03-25', 103, 1, 'returned'),
(8, '2015-03-15', '2015-03-22', '2015-03-24', 108, 2, 'returned'),
(9, '2015-03-22', '2015-03-29', '2015-03-24', 108, 2, 'returned');

-- --------------------------------------------------------

--
-- Table structure for table `member_details`
--

CREATE TABLE IF NOT EXISTS `member_details` (
  `member_id` int(11) NOT NULL AUTO_INCREMENT,
  `member_first_name` varchar(45) NOT NULL,
  `member_last_name` varchar(45) NOT NULL,
  `member_email` varchar(45) NOT NULL,
  `member_phno` varchar(45) NOT NULL,
  `member_username` varchar(45) NOT NULL,
  `member_password` varchar(45) NOT NULL,
  `member_role_id` int(11) NOT NULL,
  PRIMARY KEY (`member_id`,`member_role_id`),
  KEY `fk_member_details_member_role1_idx` (`member_role_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `member_details`
--

INSERT INTO `member_details` (`member_id`, `member_first_name`, `member_last_name`, `member_email`, `member_phno`, `member_username`, `member_password`, `member_role_id`) VALUES
(1, 'Bansari', 'Trivedi', 'btrivedi@gmail.com', '9714521478', 'btrivedi', 'btrivedi', 1),
(2, 'Peyton', 'Sawyer', 'psawyer@gmail.com', '7452014896', 'psawyer', 'psawyer', 2),
(3, 'Lucas', 'Scott', 'lucas@gmail.com', '9857147896', 'lscott', 'lscott', 2),
(4, 'Haley', 'James', 'hjames@gmail.com', '7582104568', 'hjames', 'hjames', 2),
(5, 'Dean', 'Winchester', 'dean@yahoo.com', '9827012385', 'dean', 'dean', 2),
(6, 'Nathan', 'Scott', 'nathan@yahoo.com', '7582104568', 'nscott', 'nscott', 2),
(7, 'Marvin', 'McFadden', 'marvin@yahoo.in', '9627541032', 'marvin', 'marvin', 2);

-- --------------------------------------------------------

--
-- Table structure for table `member_role`
--

CREATE TABLE IF NOT EXISTS `member_role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(45) NOT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `member_role`
--

INSERT INTO `member_role` (`role_id`, `role_name`) VALUES
(1, 'Librarian'),
(2, 'Member');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `book_details`
--
ALTER TABLE `book_details`
  ADD CONSTRAINT `fk_book_details_book_category` FOREIGN KEY (`book_category_id`) REFERENCES `book_category` (`category_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `book_issue_return`
--
ALTER TABLE `book_issue_return`
  ADD CONSTRAINT `fk_book_return_book_details1` FOREIGN KEY (`book_id`) REFERENCES `book_details` (`book_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_book_return_member_details1` FOREIGN KEY (`member_id`) REFERENCES `member_details` (`member_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `member_details`
--
ALTER TABLE `member_details`
  ADD CONSTRAINT `fk_member_details_member_role1` FOREIGN KEY (`member_role_id`) REFERENCES `member_role` (`role_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
