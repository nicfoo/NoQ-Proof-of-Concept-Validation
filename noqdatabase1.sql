-- MySQL Script generated by MySQL Workbench
-- 04/17/16 17:48:05
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema noqdatabase
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema noqdatabase
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `noqdatabase` DEFAULT CHARACTER SET latin1 ;
USE `noqdatabase` ;

-- -----------------------------------------------------
-- Table `noqdatabase`.`school`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `noqdatabase`.`school` (
  `schoolID` CHAR(8) NOT NULL,
  `schoolName` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`schoolID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `noqdatabase`.`canteen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `noqdatabase`.`canteen` (
  `canteenID` CHAR(8) NOT NULL,
  `schoolID` CHAR(8) NOT NULL,
  `canteenName` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`canteenID`),
  INDEX `schoolID` (`schoolID` ASC),
  CONSTRAINT `canteen_ibfk_1`
    FOREIGN KEY (`schoolID`)
    REFERENCES `noqdatabase`.`school` (`schoolID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `noqdatabase`.`stall`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `noqdatabase`.`stall` (
  `stallID` CHAR(8) NOT NULL,
  `stallRefereeID` CHAR(8) NULL DEFAULT NULL,
  `canteenID` CHAR(8) NOT NULL,
  `stallName` VARCHAR(64) NOT NULL,
  `stallContact` CHAR(8) NULL DEFAULT NULL,
  `stallRevenue` DECIMAL(18,4) NULL DEFAULT NULL,
  `paymentDue` DECIMAL(18,4) NULL DEFAULT NULL,
  PRIMARY KEY (`stallID`),
  INDEX `stallRefereeID` (`stallRefereeID` ASC),
  INDEX `canteenID` (`canteenID` ASC),
  CONSTRAINT `stall_ibfk_1`
    FOREIGN KEY (`stallRefereeID`)
    REFERENCES `noqdatabase`.`stall` (`stallID`),
  CONSTRAINT `stall_ibfk_2`
    FOREIGN KEY (`canteenID`)
    REFERENCES `noqdatabase`.`canteen` (`canteenID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `noqdatabase`.`cpclisting`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `noqdatabase`.`cpclisting` (
  `listingID` CHAR(8) NOT NULL,
  `stallID` CHAR(8) NOT NULL,
  `numberOfClicks` INT(11) NULL DEFAULT NULL,
  `costPerClick` DECIMAL(18,4) NULL DEFAULT NULL,
  `totalCost` DECIMAL(18,4) NULL DEFAULT NULL,
  PRIMARY KEY (`listingID`),
  INDEX `stallID` (`stallID` ASC),
  CONSTRAINT `cpclisting_ibfk_1`
    FOREIGN KEY (`stallID`)
    REFERENCES `noqdatabase`.`stall` (`stallID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `noqdatabase`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `noqdatabase`.`customer` (
  `customerID` CHAR(8) NOT NULL,
  `customerRefereeID` CHAR(8) NULL DEFAULT NULL,
  `customerName` VARCHAR(64) NOT NULL,
  `customerEmail` VARCHAR(45) NULL DEFAULT NULL,
  `customerContactNo` CHAR(8) NULL DEFAULT NULL,
  `password` CHAR(8) NOT NULL,
  `storedValue` DECIMAL(18,4) NULL DEFAULT NULL,
  PRIMARY KEY (`customerID`),
  INDEX `customerRefereeID` (`customerRefereeID` ASC),
  CONSTRAINT `customer_ibfk_1`
    FOREIGN KEY (`customerRefereeID`)
    REFERENCES `noqdatabase`.`customer` (`customerID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `noqdatabase`.`quickbuy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `noqdatabase`.`quickbuy` (
  `quickBuyID` CHAR(8) NOT NULL,
  `customerID` CHAR(8) NOT NULL,
  PRIMARY KEY (`quickBuyID`),
  INDEX `customerID` (`customerID` ASC),
  CONSTRAINT `quickbuy_ibfk_1`
    FOREIGN KEY (`customerID`)
    REFERENCES `noqdatabase`.`customer` (`customerID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `noqdatabase`.`ordercancellation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `noqdatabase`.`ordercancellation` (
  `cancellationID` CHAR(8) NOT NULL,
  `cancellationDateTime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`cancellationID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `noqdatabase`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `noqdatabase`.`order` (
  `orderID` CHAR(8) NOT NULL,
  `customerID` CHAR(8) NOT NULL,
  `stallID` CHAR(8) NOT NULL,
  `quickBuyID` CHAR(8) NULL DEFAULT NULL,
  `cancellationID` CHAR(8) NULL DEFAULT NULL,
  `totalAmount` DECIMAL(18,4) NULL DEFAULT NULL,
  `orderDateTime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `takeaway` TINYINT(1) NULL DEFAULT NULL,
  `waitingTime` INT(11) NULL DEFAULT NULL,
  `orderRemark` VARCHAR(128) NULL DEFAULT NULL,
  `orderStatus` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`orderID`),
  INDEX `customerID` (`customerID` ASC),
  INDEX `stallID` (`stallID` ASC),
  INDEX `quickBuyID` (`quickBuyID` ASC),
  INDEX `cancellationID` (`cancellationID` ASC),
  CONSTRAINT `order_ibfk_1`
    FOREIGN KEY (`customerID`)
    REFERENCES `noqdatabase`.`customer` (`customerID`),
  CONSTRAINT `order_ibfk_2`
    FOREIGN KEY (`stallID`)
    REFERENCES `noqdatabase`.`stall` (`stallID`),
  CONSTRAINT `order_ibfk_3`
    FOREIGN KEY (`quickBuyID`)
    REFERENCES `noqdatabase`.`quickbuy` (`quickBuyID`),
  CONSTRAINT `order_ibfk_4`
    FOREIGN KEY (`cancellationID`)
    REFERENCES `noqdatabase`.`ordercancellation` (`cancellationID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `noqdatabase`.`productitem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `noqdatabase`.`productitem` (
  `itemCode` CHAR(8) NOT NULL,
  `stallID` CHAR(8) NOT NULL,
  `itemName` VARCHAR(64) NOT NULL,
  `unitPrice` DECIMAL(18,4) NULL DEFAULT NULL,
  `itemDescription` VARCHAR(128) NULL DEFAULT NULL,
  PRIMARY KEY (`itemCode`),
  INDEX `stallID` (`stallID` ASC),
  CONSTRAINT `productitem_ibfk_1`
    FOREIGN KEY (`stallID`)
    REFERENCES `noqdatabase`.`stall` (`stallID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `noqdatabase`.`orderline`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `noqdatabase`.`orderline` (
  `orderID` CHAR(8) NOT NULL,
  `itemCode` CHAR(8) NOT NULL DEFAULT '',
  `quantityOrdered` INT(11) NULL DEFAULT NULL,
  `unitPrice` DECIMAL(18,4) NULL DEFAULT NULL,
  `subTotal` DECIMAL(18,4) NULL DEFAULT NULL,
  PRIMARY KEY (`orderID`, `itemCode`),
  INDEX `itemCode` (`itemCode` ASC),
  CONSTRAINT `orderline_ibfk_1`
    FOREIGN KEY (`orderID`)
    REFERENCES `noqdatabase`.`order` (`orderID`),
  CONSTRAINT `orderline_ibfk_2`
    FOREIGN KEY (`itemCode`)
    REFERENCES `noqdatabase`.`productitem` (`itemCode`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `noqdatabase`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `noqdatabase`.`payment` (
  `paymentID` CHAR(8) NOT NULL,
  `stallID` CHAR(8) NOT NULL,
  `paymentDateTime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `paymentAmount` DECIMAL(18,4) NULL DEFAULT NULL,
  PRIMARY KEY (`paymentID`),
  INDEX `stallID` (`stallID` ASC),
  CONSTRAINT `payment_ibfk_1`
    FOREIGN KEY (`stallID`)
    REFERENCES `noqdatabase`.`stall` (`stallID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `noqdatabase`.`storedvaluetransaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `noqdatabase`.`storedvaluetransaction` (
  `transactionID` CHAR(8) NOT NULL,
  `customerID` CHAR(8) NOT NULL,
  `orderID` CHAR(8) NULL DEFAULT NULL,
  `transactionDateTime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `transactionType` VARCHAR(64) NULL DEFAULT NULL,
  `transactionAmount` DECIMAL(18,4) NULL DEFAULT NULL,
  PRIMARY KEY (`transactionID`),
  INDEX `customerID` (`customerID` ASC),
  INDEX `orderID` (`orderID` ASC),
  CONSTRAINT `storedvaluetransaction_ibfk_1`
    FOREIGN KEY (`customerID`)
    REFERENCES `noqdatabase`.`customer` (`customerID`),
  CONSTRAINT `storedvaluetransaction_ibfk_2`
    FOREIGN KEY (`orderID`)
    REFERENCES `noqdatabase`.`order` (`orderID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;