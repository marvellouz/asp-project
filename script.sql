SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';
SET NAMES 'utf8';
CREATE SCHEMA IF NOT EXISTS `property` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

USE `property`;

-- -----------------------------------------------------
-- Table `property`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `property`.`User` ;

CREATE  TABLE IF NOT EXISTS `property`.`User` (
  `email` VARCHAR(255) NOT NULL ,
  `password` VARCHAR(45) NOT NULL ,
  `first_name` VARCHAR(45) NOT NULL ,
  `last_name` VARCHAR(45) NOT NULL ,
  `is_admin` BOOLEAN NOT NULL DEFAULT FALSE ,
  PRIMARY KEY (`email`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `property`.`Seller`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `property`.`Seller` ;

CREATE  TABLE IF NOT EXISTS `property`.`Seller` (
  `User_email` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`User_email`) ,
  CONSTRAINT `fk_Seller_User`
    FOREIGN KEY (`User_email` )
    REFERENCES `property`.`User` (`email` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Seller_User` ON `property`.`Seller` (`User_email` ASC) ;


-- -----------------------------------------------------
-- Table `property`.`Customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `property`.`Customer` ;

CREATE  TABLE IF NOT EXISTS `property`.`Customer` (
  `User_email` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`User_email`) ,
  CONSTRAINT `fk_Customer_User`
    FOREIGN KEY (`User_email` )
    REFERENCES `property`.`User` (`email` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Customer_User` ON `property`.`Customer` (`User_email` ASC) ;


-- -----------------------------------------------------
-- Table `property`.`Type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `property`.`Type` ;

CREATE  TABLE IF NOT EXISTS `property`.`Type` (
  `name` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`name`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `property`.`Material`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `property`.`Material` ;

CREATE  TABLE IF NOT EXISTS `property`.`Material` (
  `name` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`name`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `property`.`Address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `property`.`Address` ;

CREATE  TABLE IF NOT EXISTS `property`.`Address` (
  `id` INT NOT NULL ,
  `street` VARCHAR(255) NULL ,
  `number` INT NULL ,
  `floor` INT NULL ,
  `appartment` INT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `property`.`Place`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `property`.`Place` ;

CREATE  TABLE IF NOT EXISTS `property`.`Place` (
  `Address_id` INT NOT NULL ,
  `Seller_User_email` VARCHAR(100) NOT NULL ,
  `meters` MEDIUMINT NOT NULL ,
  `price` DECIMAL(13,2) NOT NULL ,
  `additional_info` TEXT NULL ,
  `Type_name` VARCHAR(100) NULL ,
  `Material_name` VARCHAR(100) NULL ,
  PRIMARY KEY (`Seller_User_email`, `Address_id`) ,
  CONSTRAINT `fk_Place_Seller`
    FOREIGN KEY (`Seller_User_email` )
    REFERENCES `property`.`Seller` (`User_email` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Place_Type`
    FOREIGN KEY (`Type_name` )
    REFERENCES `property`.`Type` (`name` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Place_Material`
    FOREIGN KEY (`Material_name` )
    REFERENCES `property`.`Material` (`name` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Place_Address`
    FOREIGN KEY (`Address_id` )
    REFERENCES `property`.`Address` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Place_Seller` ON `property`.`Place` (`Seller_User_email` ASC) ;

CREATE INDEX `fk_Place_Type` ON `property`.`Place` (`Type_name` ASC) ;

CREATE INDEX `fk_Place_Material` ON `property`.`Place` (`Material_name` ASC) ;

CREATE INDEX `fk_Place_Address` ON `property`.`Place` (`Address_id` ASC) ;


-- -----------------------------------------------------
-- Table `property`.`Customer_has_Place`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `property`.`Customer_has_Place` ;

CREATE  TABLE IF NOT EXISTS `property`.`Customer_has_Place` (
  `Customer_User_email` VARCHAR(100) NOT NULL ,
  `Place_Seller_User_email` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`Customer_User_email`, `Place_Seller_User_email`) ,
  CONSTRAINT `fk_Customer_has_Place_Customer`
    FOREIGN KEY (`Customer_User_email` )
    REFERENCES `property`.`Customer` (`User_email` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Customer_has_Place_Place`
    FOREIGN KEY (`Place_Seller_User_email` )
    REFERENCES `property`.`Place` (`Seller_User_email` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_Customer_has_Place_Customer` ON `property`.`Customer_has_Place` (`Customer_User_email` ASC) ;

CREATE INDEX `fk_Customer_has_Place_Place` ON `property`.`Customer_has_Place` (`Place_Seller_User_email` ASC) ;


-- -----------------------------------------------------
-- Table `property`.`Extra`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `property`.`Extra` ;

CREATE  TABLE IF NOT EXISTS `property`.`Extra` (
  `name` INT NOT NULL ,
  PRIMARY KEY (`name`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `property`.`City`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `property`.`City` ;

CREATE  TABLE IF NOT EXISTS `property`.`City` (
  `name` VARCHAR(255) NOT NULL ,
  PRIMARY KEY (`name`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `property`.`Neighbourhood`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `property`.`Neighbourhood` ;

CREATE  TABLE IF NOT EXISTS `property`.`Neighbourhood` (
  `name` VARCHAR(255) NOT NULL ,
  PRIMARY KEY (`name`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `property`.`Address_has_Neighbourhood`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `property`.`Address_has_Neighbourhood` ;

CREATE  TABLE IF NOT EXISTS `property`.`Address_has_Neighbourhood` (
  `Address_id` INT NOT NULL ,
  `Neighbourhood_name` VARCHAR(255) NOT NULL ,
  PRIMARY KEY (`Address_id`) ,
  CONSTRAINT `fk_Address_has_Neighbourhood_Address`
    FOREIGN KEY (`Address_id` )
    REFERENCES `property`.`Address` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Address_has_Neighbourhood_Neighbourhood`
    FOREIGN KEY (`Neighbourhood_name` )
    REFERENCES `property`.`Neighbourhood` (`name` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_Address_has_Neighbourhood_Address` ON `property`.`Address_has_Neighbourhood` (`Address_id` ASC) ;

CREATE INDEX `fk_Address_has_Neighbourhood_Neighbourhood` ON `property`.`Address_has_Neighbourhood` (`Neighbourhood_name` ASC) ;


-- -----------------------------------------------------
-- Table `property`.`Address_has_City`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `property`.`Address_has_City` ;

CREATE  TABLE IF NOT EXISTS `property`.`Address_has_City` (
  `Address_id` INT NOT NULL ,
  `City_name` VARCHAR(255) NOT NULL ,
  PRIMARY KEY (`Address_id`) ,
  CONSTRAINT `fk_Address_has_City_Address`
    FOREIGN KEY (`Address_id` )
    REFERENCES `property`.`Address` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Address_has_City_City`
    FOREIGN KEY (`City_name` )
    REFERENCES `property`.`City` (`name` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_Address_has_City_Address` ON `property`.`Address_has_City` (`Address_id` ASC) ;

CREATE INDEX `fk_Address_has_City_City` ON `property`.`Address_has_City` (`City_name` ASC) ;


-- -----------------------------------------------------
-- Table `property`.`Place_has_Extra`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `property`.`Place_has_Extra` ;

CREATE  TABLE IF NOT EXISTS `property`.`Place_has_Extra` (
  `Place_Seller_User_email` VARCHAR(100) NOT NULL ,
  `Place_Address_id` INT NOT NULL ,
  `Extra_name` INT NOT NULL ,
  PRIMARY KEY (`Place_Seller_User_email`, `Place_Address_id`, `Extra_name`) ,
  CONSTRAINT `fk_Place_has_Extra_Place`
    FOREIGN KEY (`Place_Seller_User_email` , `Place_Address_id` )
    REFERENCES `property`.`Place` (`Seller_User_email` , `Address_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Place_has_Extra_Extra`
    FOREIGN KEY (`Extra_name` )
    REFERENCES `property`.`Extra` (`name` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_Place_has_Extra_Place` ON `property`.`Place_has_Extra` (`Place_Seller_User_email` ASC, `Place_Address_id` ASC) ;

CREATE INDEX `fk_Place_has_Extra_Extra` ON `property`.`Place_has_Extra` (`Extra_name` ASC) ;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
