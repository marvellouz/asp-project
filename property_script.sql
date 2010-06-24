-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.1.47-community


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema property
--

CREATE DATABASE IF NOT EXISTS property;
USE property;

--
-- Temporary table structure for view `place_info`
--
DROP TABLE IF EXISTS `place_info`;
DROP VIEW IF EXISTS `place_info`;
CREATE TABLE `place_info` (
  `id` int(11),
  `Seller_User_email` varchar(100),
  `meters` mediumint(9),
  `additional_info` text,
  `Type_name` varchar(100),
  `Material_name` varchar(100),
  `Customer_user_email` varchar(100),
  `created_at` timestamp,
  `street` varchar(255),
  `number` int(11),
  `floor` int(11),
  `city_name` varchar(255),
  `Neighbourhood_name` varchar(255),
  `price` decimal(13,2)
);

--
-- Definition of table `address`
--

DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `street` varchar(255) DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  `floor` int(11) DEFAULT NULL,
  `appartment` int(11) DEFAULT NULL,
  `entrance` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=189 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `address`
--

/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` (`id`,`street`,`number`,`floor`,`appartment`,`entrance`) VALUES 
 (186,'Цар Иван Асен ІІ',4,NULL,NULL,NULL),
 (187,'Цар Борис',NULL,NULL,NULL,NULL),
 (188,'Цар Борис',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `address` ENABLE KEYS */;


--
-- Definition of table `address_has_city`
--

DROP TABLE IF EXISTS `address_has_city`;
CREATE TABLE `address_has_city` (
  `Address_id` int(11) NOT NULL,
  `City_name` varchar(255) NOT NULL,
  PRIMARY KEY (`Address_id`),
  KEY `fk_Address_has_City_Address` (`Address_id`),
  KEY `fk_Address_has_City_City` (`City_name`),
  CONSTRAINT `fk_Address_has_City_Address` FOREIGN KEY (`Address_id`) REFERENCES `address` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Address_has_City_City` FOREIGN KEY (`City_name`) REFERENCES `city` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `address_has_city`
--

/*!40000 ALTER TABLE `address_has_city` DISABLE KEYS */;
INSERT INTO `address_has_city` (`Address_id`,`City_name`) VALUES 
 (186,'Айтос'),
 (187,'Банкя'),
 (188,'Велико Търново');
/*!40000 ALTER TABLE `address_has_city` ENABLE KEYS */;


--
-- Definition of table `address_has_neighbourhood`
--

DROP TABLE IF EXISTS `address_has_neighbourhood`;
CREATE TABLE `address_has_neighbourhood` (
  `Address_id` int(11) NOT NULL,
  `Neighbourhood_name` varchar(255) NOT NULL,
  PRIMARY KEY (`Address_id`),
  KEY `fk_Address_has_Neighbourhood_Address` (`Address_id`),
  KEY `fk_Address_has_Neighbourhood_Neighbourhood` (`Neighbourhood_name`),
  CONSTRAINT `fk_Address_has_Neighbourhood_Address` FOREIGN KEY (`Address_id`) REFERENCES `address` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Address_has_Neighbourhood_Neighbourhood` FOREIGN KEY (`Neighbourhood_name`) REFERENCES `neighbourhood` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `address_has_neighbourhood`
--

/*!40000 ALTER TABLE `address_has_neighbourhood` DISABLE KEYS */;
INSERT INTO `address_has_neighbourhood` (`Address_id`,`Neighbourhood_name`) VALUES 
 (188,'Вароша'),
 (186,'Център'),
 (187,'Център');
/*!40000 ALTER TABLE `address_has_neighbourhood` ENABLE KEYS */;


--
-- Definition of table `city`
--

DROP TABLE IF EXISTS `city`;
CREATE TABLE `city` (
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `city`
--

/*!40000 ALTER TABLE `city` DISABLE KEYS */;
INSERT INTO `city` (`name`) VALUES 
 ('Айтос'),
 ('Аксаково'),
 ('Алфатар'),
 ('Антоново'),
 ('Априлци'),
 ('Ардино'),
 ('Асеновград'),
 ('Ахелой'),
 ('Ахтопол'),
 ('Балчик'),
 ('Банкя'),
 ('Банско'),
 ('Баня'),
 ('Батак'),
 ('Батановци'),
 ('Белене'),
 ('Белица'),
 ('Белово'),
 ('Белоградчик'),
 ('Белослав'),
 ('Берковица'),
 ('Благоевград'),
 ('Бобовдол'),
 ('Бобошево'),
 ('Божурище'),
 ('Бойчиновци'),
 ('Болярово'),
 ('Борово'),
 ('Ботевград'),
 ('Брацигово'),
 ('Брегово'),
 ('Брезник'),
 ('Брезово'),
 ('Брусарци'),
 ('Бургас'),
 ('Бухово'),
 ('Българово'),
 ('Бяла'),
 ('Бяла Слатина'),
 ('Бяла черква'),
 ('Варна'),
 ('Велики Преслав'),
 ('Велико Търново'),
 ('Велинград'),
 ('Ветово'),
 ('Ветрен'),
 ('Видин'),
 ('Враца'),
 ('Вълчедръм'),
 ('Върбица'),
 ('Вършец'),
 ('Габрово'),
 ('Генерал Тошево'),
 ('Главиница'),
 ('Глоджево'),
 ('Годеч'),
 ('Горна Оряховица'),
 ('Гоце Делчев'),
 ('Грамада'),
 ('Гулянци'),
 ('Гурково'),
 ('Гълъбово'),
 ('Две могили'),
 ('Дебелец'),
 ('Девин'),
 ('Девня'),
 ('Джебел'),
 ('Димитровград'),
 ('Димово'),
 ('Добринище'),
 ('Добрич'),
 ('Долна баня'),
 ('Долна Митрополия'),
 ('Долна Оряховица'),
 ('Долни Дъбник'),
 ('Долничифлик'),
 ('Доспат'),
 ('Драгоман'),
 ('Дряново'),
 ('Дулово'),
 ('Дунавци'),
 ('Дупница'),
 ('Дългопол'),
 ('Елена'),
 ('Елин Пелин'),
 ('Елхово'),
 ('Етрополе'),
 ('Завет'),
 ('Земен'),
 ('Златарица'),
 ('Златица'),
 ('Златоград'),
 ('Ивайловград'),
 ('Искър'),
 ('Исперих'),
 ('Ихтиман'),
 ('Каблешково'),
 ('Каварна'),
 ('Казанлък'),
 ('Калофер'),
 ('Камено'),
 ('Каолиново'),
 ('Карлово'),
 ('Карнобат'),
 ('Каспичан'),
 ('Кермен'),
 ('Килифарево'),
 ('Китен'),
 ('Клисура'),
 ('Кнежа'),
 ('Козлодуй'),
 ('Койнаре'),
 ('Копривщица'),
 ('Костандово'),
 ('Костенец'),
 ('Костинброд'),
 ('Котел'),
 ('Кочериново'),
 ('Кресна'),
 ('Криводол'),
 ('Кричим'),
 ('Крумовград'),
 ('Кубрат'),
 ('Куклен'),
 ('Кула'),
 ('Кърджали'),
 ('Кюстендил'),
 ('Левски'),
 ('Летница'),
 ('Ловеч'),
 ('Лозница'),
 ('Лом'),
 ('Луковит'),
 ('Лъки'),
 ('Любимец'),
 ('Лясковец'),
 ('Мадан'),
 ('Маджарово'),
 ('Малко Търново'),
 ('Мартен'),
 ('Мездра'),
 ('Мелник'),
 ('Меричлери'),
 ('Мизия'),
 ('Момин проход'),
 ('Момчилград'),
 ('Монтана'),
 ('Мъглиж'),
 ('Неделино'),
 ('Несебър'),
 ('Николаево'),
 ('Никопол'),
 ('Нова Загора'),
 ('Нови Искър'),
 ('Новипазар'),
 ('Обзор'),
 ('Омуртаг'),
 ('Опака'),
 ('Оряхово'),
 ('Павелбаня'),
 ('Павликени'),
 ('Пазарджик'),
 ('Панагюрище'),
 ('Перник'),
 ('Перущица'),
 ('Петрич'),
 ('Пещера'),
 ('Пирдоп'),
 ('Плачковци'),
 ('Плевен'),
 ('Плиска'),
 ('Пловдив'),
 ('Полски Тръмбеш'),
 ('Поморие'),
 ('Попово'),
 ('Пордим'),
 ('Правец'),
 ('Приморско'),
 ('Провадия'),
 ('Първомай'),
 ('Раднево'),
 ('Радомир'),
 ('Разград'),
 ('Разлог'),
 ('Ракитово'),
 ('Раковски'),
 ('Рила'),
 ('Роман'),
 ('Рудозем'),
 ('Русе'),
 ('Садово'),
 ('Самоков'),
 ('Сандански'),
 ('Сапарева баня'),
 ('Свети Влас'),
 ('Свиленград'),
 ('Свищов'),
 ('Своге'),
 ('Севлиево'),
 ('Сеново'),
 ('Септември'),
 ('Силистра'),
 ('Симеоновград'),
 ('Симитли'),
 ('Славяново'),
 ('Сливен'),
 ('Сливница'),
 ('Сливополе'),
 ('Смолян'),
 ('Смядово'),
 ('Созопол'),
 ('Сопот'),
 ('София'),
 ('Средец'),
 ('Стамболийски'),
 ('Стара Загора'),
 ('Стражица'),
 ('Стралджа'),
 ('Стрелча'),
 ('Суворово'),
 ('Сунгурларе'),
 ('Сухин дол'),
 ('Съединение'),
 ('Сърница'),
 ('Твърдица'),
 ('Тервел'),
 ('Тетевен'),
 ('Тополовград'),
 ('Троян'),
 ('Трън'),
 ('Тръстеник'),
 ('Трявна'),
 ('Тутракан'),
 ('Търговище'),
 ('Угърчин'),
 ('Хаджидимово'),
 ('Харманли'),
 ('Хасково'),
 ('Хисаря'),
 ('Цар Калоян'),
 ('Царево'),
 ('Чепеларе'),
 ('Червенбряг'),
 ('Черноморец'),
 ('Чипровци'),
 ('Чирпан'),
 ('Шабла'),
 ('Шивачево'),
 ('Шипка'),
 ('Шумен'),
 ('Ябланица'),
 ('Якоруда'),
 ('Ямбол');
/*!40000 ALTER TABLE `city` ENABLE KEYS */;


--
-- Definition of table `customer`
--

DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `User_email` varchar(100) NOT NULL,
  PRIMARY KEY (`User_email`),
  KEY `fk_Customer_User` (`User_email`),
  CONSTRAINT `fk_Customer_User` FOREIGN KEY (`User_email`) REFERENCES `user` (`email`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customer`
--

/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` (`User_email`) VALUES 
 ('emils@fmi.uni-sofia.bg');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;


--
-- Definition of table `customer_has_place`
--

DROP TABLE IF EXISTS `customer_has_place`;
CREATE TABLE `customer_has_place` (
  `Customer_User_email` varchar(100) NOT NULL,
  `Place_Address_id` int(11) NOT NULL,
  PRIMARY KEY (`Customer_User_email`,`Place_Address_id`),
  KEY `fk_Customer_has_Place_Customer1` (`Customer_User_email`),
  KEY `fk_Customer_has_Place_Place1` (`Place_Address_id`),
  CONSTRAINT `fk_Customer_has_Place_Customer1` FOREIGN KEY (`Customer_User_email`) REFERENCES `customer` (`User_email`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Customer_has_Place_Place1` FOREIGN KEY (`Place_Address_id`) REFERENCES `place` (`Address_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customer_has_place`
--

/*!40000 ALTER TABLE `customer_has_place` DISABLE KEYS */;
INSERT INTO `customer_has_place` (`Customer_User_email`,`Place_Address_id`) VALUES 
 ('emils@fmi.uni-sofia.bg',186),
 ('emils@fmi.uni-sofia.bg',188);
/*!40000 ALTER TABLE `customer_has_place` ENABLE KEYS */;


--
-- Definition of table `extra`
--

DROP TABLE IF EXISTS `extra`;
CREATE TABLE `extra` (
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `extra`
--

/*!40000 ALTER TABLE `extra` DISABLE KEYS */;
/*!40000 ALTER TABLE `extra` ENABLE KEYS */;


--
-- Definition of table `material`
--

DROP TABLE IF EXISTS `material`;
CREATE TABLE `material` (
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `material`
--

/*!40000 ALTER TABLE `material` DISABLE KEYS */;
INSERT INTO `material` (`name`) VALUES 
 ('Гредоред'),
 ('ЕПК'),
 ('Масивна конструкция'),
 ('Метална конструкция'),
 ('панел'),
 ('тухла');
/*!40000 ALTER TABLE `material` ENABLE KEYS */;


--
-- Definition of table `neighbourhood`
--

DROP TABLE IF EXISTS `neighbourhood`;
CREATE TABLE `neighbourhood` (
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `neighbourhood`
--

/*!40000 ALTER TABLE `neighbourhood` DISABLE KEYS */;
INSERT INTO `neighbourhood` (`name`) VALUES 
 ('Вароша'),
 ('Център');
/*!40000 ALTER TABLE `neighbourhood` ENABLE KEYS */;


--
-- Definition of table `place`
--

DROP TABLE IF EXISTS `place`;
CREATE TABLE `place` (
  `Address_id` int(11) NOT NULL,
  `Seller_User_email` varchar(100) NOT NULL,
  `meters` mediumint(9) NOT NULL,
  `price` decimal(13,2) NOT NULL,
  `additional_info` text,
  `Type_name` varchar(100) DEFAULT NULL,
  `Material_name` varchar(100) DEFAULT NULL,
  `Customer_User_email` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Address_id`),
  KEY `fk_Place_Seller` (`Seller_User_email`),
  KEY `fk_Place_Type` (`Type_name`),
  KEY `fk_Place_Material` (`Material_name`),
  KEY `fk_Place_Address` (`Address_id`),
  KEY `fk_Place_Customer` (`Customer_User_email`),
  CONSTRAINT `fk_Place_Address` FOREIGN KEY (`Address_id`) REFERENCES `address` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Place_Customer` FOREIGN KEY (`Customer_User_email`) REFERENCES `customer` (`User_email`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Place_Material` FOREIGN KEY (`Material_name`) REFERENCES `material` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Place_Seller` FOREIGN KEY (`Seller_User_email`) REFERENCES `seller` (`User_email`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Place_Type` FOREIGN KEY (`Type_name`) REFERENCES `type` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `place`
--

/*!40000 ALTER TABLE `place` DISABLE KEYS */;
INSERT INTO `place` (`Address_id`,`Seller_User_email`,`meters`,`price`,`additional_info`,`Type_name`,`Material_name`,`Customer_User_email`,`created_at`) VALUES 
 (186,'valentina@hardlink.eu',150,'25000.00',' ','Вила','тухла','emils@fmi.uni-sofia.bg','2010-06-23 22:26:02'),
 (187,'valentina@hardlink.eu',12,'12000.00',' ','Магазин','панел',NULL,'2010-06-23 23:41:26'),
 (188,'valentina@hardlink.eu',123,'22000.00',' ','Къща',NULL,NULL,'2010-06-24 00:23:39');
/*!40000 ALTER TABLE `place` ENABLE KEYS */;


--
-- Definition of table `place_has_extra`
--

DROP TABLE IF EXISTS `place_has_extra`;
CREATE TABLE `place_has_extra` (
  `Place_Seller_User_email` varchar(100) NOT NULL,
  `Extra_name` varchar(255) NOT NULL,
  PRIMARY KEY (`Place_Seller_User_email`,`Extra_name`),
  KEY `fk_Place_has_Extra_Place` (`Place_Seller_User_email`),
  KEY `fk_Place_has_Extra_Extra` (`Extra_name`),
  CONSTRAINT `fk_Place_has_Extra_Extra` FOREIGN KEY (`Extra_name`) REFERENCES `extra` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Place_has_Extra_Place` FOREIGN KEY (`Place_Seller_User_email`) REFERENCES `place` (`Seller_User_email`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `place_has_extra`
--

/*!40000 ALTER TABLE `place_has_extra` DISABLE KEYS */;
/*!40000 ALTER TABLE `place_has_extra` ENABLE KEYS */;


--
-- Definition of table `seller`
--

DROP TABLE IF EXISTS `seller`;
CREATE TABLE `seller` (
  `User_email` varchar(100) NOT NULL,
  PRIMARY KEY (`User_email`),
  KEY `fk_Seller_User` (`User_email`),
  CONSTRAINT `fk_Seller_User` FOREIGN KEY (`User_email`) REFERENCES `user` (`email`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `seller`
--

/*!40000 ALTER TABLE `seller` DISABLE KEYS */;
INSERT INTO `seller` (`User_email`) VALUES 
 ('valentina@hardlink.eu');
/*!40000 ALTER TABLE `seller` ENABLE KEYS */;


--
-- Definition of table `type`
--

DROP TABLE IF EXISTS `type`;
CREATE TABLE `type` (
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `type`
--

/*!40000 ALTER TABLE `type` DISABLE KEYS */;
INSERT INTO `type` (`name`) VALUES 
 ('Ателие, Таван'),
 ('Вила'),
 ('Гараж'),
 ('Двустаен'),
 ('Едностатен'),
 ('Заведение'),
 ('Къща'),
 ('Магазин'),
 ('Мезонет'),
 ('Многостаен'),
 ('Офис'),
 ('Склад'),
 ('Тристаен'),
 ('Четиристаен');
/*!40000 ALTER TABLE `type` ENABLE KEYS */;


--
-- Definition of table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`email`,`password`,`first_name`,`last_name`,`is_admin`) VALUES 
 ('emils@fmi.uni-sofia.bg','f629fb1ddeb2a06793129d38824bfe55','Емил','Станчев',0),
 ('valentina@hardlink.eu','b915d4b9d7d52e73c92614af8bb29f8f','Валентина','Динкова',1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;


--
-- Definition of view `place_info`
--

DROP TABLE IF EXISTS `place_info`;
DROP VIEW IF EXISTS `place_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `place_info` AS select `a`.`id` AS `id`,`p`.`Seller_User_email` AS `Seller_User_email`,`p`.`meters` AS `meters`,`p`.`additional_info` AS `additional_info`,`p`.`Type_name` AS `Type_name`,`p`.`Material_name` AS `Material_name`,`p`.`Customer_User_email` AS `Customer_user_email`,`p`.`created_at` AS `created_at`,`a`.`street` AS `street`,`a`.`number` AS `number`,`a`.`floor` AS `floor`,`ac`.`City_name` AS `city_name`,`an`.`Neighbourhood_name` AS `Neighbourhood_name`,`p`.`price` AS `price` from (((`place` `p` join `address` `a` on((`p`.`Address_id` = `a`.`id`))) join `address_has_city` `ac` on((`a`.`id` = `ac`.`Address_id`))) join `address_has_neighbourhood` `an` on((`ac`.`Address_id` = `an`.`Address_id`)));



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
