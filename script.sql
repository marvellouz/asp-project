SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `mydb`;

-- -----------------------------------------------------
-- Table `mydb`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`User` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`User` (
  `email` VARCHAR(255) NOT NULL ,
  `password` VARCHAR(45) NOT NULL ,
  `first_name` VARCHAR(45) NOT NULL ,
  `last_name` VARCHAR(45) NOT NULL ,
  `is_admin` BOOLEAN NOT NULL DEFAULT FALSE ,
  PRIMARY KEY (`email`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Seller`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Seller` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Seller` (
  `User_email` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`User_email`) ,
  CONSTRAINT `fk_Seller_User`
    FOREIGN KEY (`User_email` )
    REFERENCES `mydb`.`User` (`email` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Seller_User` ON `mydb`.`Seller` (`User_email` ASC) ;


-- -----------------------------------------------------
-- Table `mydb`.`Customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Customer` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Customer` (
  `User_email` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`User_email`) ,
  CONSTRAINT `fk_Customer_User`
    FOREIGN KEY (`User_email` )
    REFERENCES `mydb`.`User` (`email` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Customer_User` ON `mydb`.`Customer` (`User_email` ASC) ;


-- -----------------------------------------------------
-- Table `mydb`.`Type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Type` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Type` (
  `name` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`name`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Material`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Material` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Material` (
  `name` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`name`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Address` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Address` (
  `id` INT NOT NULL ,
  `street` VARCHAR(255) NULL ,
  `number` INT NULL ,
  `floor` INT NULL ,
  `appartment` INT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Place`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Place` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Place` (
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
    REFERENCES `mydb`.`Seller` (`User_email` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Place_Type`
    FOREIGN KEY (`Type_name` )
    REFERENCES `mydb`.`Type` (`name` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Place_Material`
    FOREIGN KEY (`Material_name` )
    REFERENCES `mydb`.`Material` (`name` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Place_Address`
    FOREIGN KEY (`Address_id` )
    REFERENCES `mydb`.`Address` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Place_Seller` ON `mydb`.`Place` (`Seller_User_email` ASC) ;

CREATE INDEX `fk_Place_Type` ON `mydb`.`Place` (`Type_name` ASC) ;

CREATE INDEX `fk_Place_Material` ON `mydb`.`Place` (`Material_name` ASC) ;

CREATE INDEX `fk_Place_Address` ON `mydb`.`Place` (`Address_id` ASC) ;


-- -----------------------------------------------------
-- Table `mydb`.`Customer_has_Place`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Customer_has_Place` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Customer_has_Place` (
  `Customer_User_email` VARCHAR(100) NOT NULL ,
  `Place_Seller_User_email` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`Customer_User_email`, `Place_Seller_User_email`) ,
  CONSTRAINT `fk_Customer_has_Place_Customer`
    FOREIGN KEY (`Customer_User_email` )
    REFERENCES `mydb`.`Customer` (`User_email` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Customer_has_Place_Place`
    FOREIGN KEY (`Place_Seller_User_email` )
    REFERENCES `mydb`.`Place` (`Seller_User_email` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_Customer_has_Place_Customer` ON `mydb`.`Customer_has_Place` (`Customer_User_email` ASC) ;

CREATE INDEX `fk_Customer_has_Place_Place` ON `mydb`.`Customer_has_Place` (`Place_Seller_User_email` ASC) ;


-- -----------------------------------------------------
-- Table `mydb`.`Extra`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Extra` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Extra` (
  `name` INT NOT NULL ,
  PRIMARY KEY (`name`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`City`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`City` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`City` (
  `name` VARCHAR(255) NOT NULL ,
  PRIMARY KEY (`name`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Neighbourhood`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Neighbourhood` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Neighbourhood` (
  `name` VARCHAR(255) NOT NULL ,
  PRIMARY KEY (`name`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Address_has_Neighbourhood`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Address_has_Neighbourhood` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Address_has_Neighbourhood` (
  `Address_id` INT NOT NULL ,
  `Neighbourhood_name` VARCHAR(255) NOT NULL ,
  PRIMARY KEY (`Address_id`) ,
  CONSTRAINT `fk_Address_has_Neighbourhood_Address`
    FOREIGN KEY (`Address_id` )
    REFERENCES `mydb`.`Address` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Address_has_Neighbourhood_Neighbourhood`
    FOREIGN KEY (`Neighbourhood_name` )
    REFERENCES `mydb`.`Neighbourhood` (`name` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_Address_has_Neighbourhood_Address` ON `mydb`.`Address_has_Neighbourhood` (`Address_id` ASC) ;

CREATE INDEX `fk_Address_has_Neighbourhood_Neighbourhood` ON `mydb`.`Address_has_Neighbourhood` (`Neighbourhood_name` ASC) ;


-- -----------------------------------------------------
-- Table `mydb`.`Address_has_City`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Address_has_City` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Address_has_City` (
  `Address_id` INT NOT NULL ,
  `City_name` VARCHAR(255) NOT NULL ,
  PRIMARY KEY (`Address_id`) ,
  CONSTRAINT `fk_Address_has_City_Address`
    FOREIGN KEY (`Address_id` )
    REFERENCES `mydb`.`Address` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Address_has_City_City`
    FOREIGN KEY (`City_name` )
    REFERENCES `mydb`.`City` (`name` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_Address_has_City_Address` ON `mydb`.`Address_has_City` (`Address_id` ASC) ;

CREATE INDEX `fk_Address_has_City_City` ON `mydb`.`Address_has_City` (`City_name` ASC) ;


-- -----------------------------------------------------
-- Table `mydb`.`Place_has_Extra`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Place_has_Extra` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Place_has_Extra` (
  `Place_Seller_User_email` VARCHAR(100) NOT NULL ,
  `Place_Address_id` INT NOT NULL ,
  `Extra_name` INT NOT NULL ,
  PRIMARY KEY (`Place_Seller_User_email`, `Place_Address_id`, `Extra_name`) ,
  CONSTRAINT `fk_Place_has_Extra_Place`
    FOREIGN KEY (`Place_Seller_User_email` , `Place_Address_id` )
    REFERENCES `mydb`.`Place` (`Seller_User_email` , `Address_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Place_has_Extra_Extra`
    FOREIGN KEY (`Extra_name` )
    REFERENCES `mydb`.`Extra` (`name` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_Place_has_Extra_Place` ON `mydb`.`Place_has_Extra` (`Place_Seller_User_email` ASC, `Place_Address_id` ASC) ;

CREATE INDEX `fk_Place_has_Extra_Extra` ON `mydb`.`Place_has_Extra` (`Extra_name` ASC) ;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
