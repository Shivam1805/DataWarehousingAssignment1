-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Nova_Scotia_Co-operatives`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Nova_Scotia_Co-operatives` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Nova_Scotia_Co-operatives` (
  `RegistryID` INT NOT NULL,
  `Co-Op Name` VARCHAR(100) NULL,
  `Incoporation year` INT NULL,
  `Address` VARCHAR(100) NULL,
  `Town` VARCHAR(45) NULL,
  `Province` VARCHAR(45) NULL,
  `Postal Code` VARCHAR(45) NULL,
  `TypeOfCoOperative` VARCHAR(45) NULL,
  PRIMARY KEY (`RegistryID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Canada_Location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Canada_Location` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Canada_Location` (
  `ComID` VARCHAR(45) NOT NULL,
  `Place` VARCHAR(45) NULL,
  PRIMARY KEY (`ComID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Business_Establishment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Business_Establishment` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Business_Establishment` (
  `Location_ComID` VARCHAR(45) NOT NULL,
  `Place` VARCHAR(45) NULL,
  `TypeOFBusiness` VARCHAR(200) NULL,
  `Year` INT NULL,
  `TotalEmployees` INT NULL,
  INDEX `fk_Business_Establishment_Location_idx` (`Location_ComID` ASC) VISIBLE,
  CONSTRAINT `fk_Business_Establishment_Location`
    FOREIGN KEY (`Location_ComID`)
    REFERENCES `mydb`.`Canada_Location` (`ComID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Aquaculture`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Aquaculture` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Aquaculture` (
  `Location_ComID` VARCHAR(45) NOT NULL,
  `Place` VARCHAR(45) NULL,
  `Type` VARCHAR(45) NULL,
  `Year` INT NULL,
  `Amount` INT NULL,
  `Weight` INT NULL,
  INDEX `fk_Aquaculture_Location1_idx` (`Location_ComID` ASC) VISIBLE,
  CONSTRAINT `fk_Aquaculture_Location1`
    FOREIGN KEY (`Location_ComID`)
    REFERENCES `mydb`.`Canada_Location` (`ComID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Agriculture_Funding_Program`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Agriculture_Funding_Program` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Agriculture_Funding_Program` (
  `Location_ComID` VARCHAR(45) NOT NULL,
  `Program_Name` VARCHAR(150) NULL,
  `Recipient` VARCHAR(200) NULL,
  `Amount` VARCHAR(45) NULL,
  `FiscalYear` VARCHAR(45) NULL,
  INDEX `fk_Agriculture_Funding_Program_Location1_idx` (`Location_ComID` ASC) VISIBLE,
  CONSTRAINT `fk_Agriculture_Funding_Program_Location1`
    FOREIGN KEY (`Location_ComID`)
    REFERENCES `mydb`.`Canada_Location` (`ComID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Halifax_Location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Halifax_Location` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Halifax_Location` (
  `ID` VARCHAR(45) NOT NULL,
  `Description` VARCHAR(200) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ProjectsInfo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ProjectsInfo` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ProjectsInfo` (
  `Proj_Num` VARCHAR(45) NOT NULL,
  `ProjectName` VARCHAR(100) NULL,
  PRIMARY KEY (`Proj_Num`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Capital_Projects`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Capital_Projects` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Capital_Projects` (
  `ObjectID` INT NOT NULL,
  `Halifax_Location_ID` VARCHAR(45) NOT NULL,
  `Description` VARCHAR(200) NULL,
  `ProjectsInfo_Proj_Num` VARCHAR(45) NOT NULL,
  `Cateogry` VARCHAR(45) NULL,
  `Year` INT NULL,
  PRIMARY KEY (`ObjectID`),
  INDEX `fk_Capital_Projects_ProjectsInfo1_idx` (`ProjectsInfo_Proj_Num` ASC) VISIBLE,
  INDEX `fk_Capital_Projects_Halifax_Location1_idx` (`Halifax_Location_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Capital_Projects_ProjectsInfo1`
    FOREIGN KEY (`ProjectsInfo_Proj_Num`)
    REFERENCES `mydb`.`ProjectsInfo` (`Proj_Num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Capital_Projects_Halifax_Location1`
    FOREIGN KEY (`Halifax_Location_ID`)
    REFERENCES `mydb`.`Halifax_Location` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AllCanadaLocation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`AllCanadaLocation` ;

CREATE TABLE IF NOT EXISTS `mydb`.`AllCanadaLocation` (
  `ComID` VARCHAR(45) NOT NULL,
  `LocationName` VARCHAR(200) NULL,
  PRIMARY KEY (`ComID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`LabourbyIndustry`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`LabourbyIndustry` ;

CREATE TABLE IF NOT EXISTS `mydb`.`LabourbyIndustry` (
  `AllCanadaLocation_ComID` VARCHAR(45) NOT NULL,
  `Type` VARCHAR(100) NULL,
  `AmountOFEmployees` INT NULL,
  `Year` INT NULL,
  INDEX `fk_LabourbyIndustry_AllCanadaLocation1_idx` (`AllCanadaLocation_ComID` ASC) VISIBLE,
  CONSTRAINT `fk_LabourbyIndustry_AllCanadaLocation1`
    FOREIGN KEY (`AllCanadaLocation_ComID`)
    REFERENCES `mydb`.`AllCanadaLocation` (`ComID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`LabourbyOccupation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`LabourbyOccupation` ;

CREATE TABLE IF NOT EXISTS `mydb`.`LabourbyOccupation` (
  `AllCanadaLocation_ComID` VARCHAR(45) NOT NULL,
  `Occupationtype` VARCHAR(300) NULL,
  `Year` INT NULL,
  `NumOfFemale` INT NULL,
  `NumOfMale` INT NULL,
  INDEX `fk_LabourbyOccupation_AllCanadaLocation1_idx` (`AllCanadaLocation_ComID` ASC) VISIBLE,
  CONSTRAINT `fk_LabourbyOccupation_AllCanadaLocation1`
    FOREIGN KEY (`AllCanadaLocation_ComID`)
    REFERENCES `mydb`.`AllCanadaLocation` (`ComID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Area`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Area` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Area` (
  `idArea` INT NOT NULL,
  `AreaName` VARCHAR(45) NULL,
  PRIMARY KEY (`idArea`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`BoardSchool`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`BoardSchool` ;

CREATE TABLE IF NOT EXISTS `mydb`.`BoardSchool` (
  `idBoard` INT NOT NULL,
  `BoardName` VARCHAR(45) NULL,
  PRIMARY KEY (`idBoard`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`School`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`School` ;

CREATE TABLE IF NOT EXISTS `mydb`.`School` (
  `idSchool` INT NOT NULL,
  `SchoolName` VARCHAR(200) NOT NULL,
  `Address` VARCHAR(200) NULL,
  `Postal Code` VARCHAR(10) NULL,
  `Telephone` VARCHAR(20) NULL,
  `Email` VARCHAR(45) NULL,
  `BoardSchool_idBoard` INT NOT NULL,
  `Area_idArea` INT NOT NULL,
  PRIMARY KEY (`idSchool`, `SchoolName`),
  INDEX `fk_School_BoardSchool1_idx` (`BoardSchool_idBoard` ASC) VISIBLE,
  INDEX `fk_School_Area1_idx` (`Area_idArea` ASC) VISIBLE,
  CONSTRAINT `fk_School_BoardSchool1`
    FOREIGN KEY (`BoardSchool_idBoard`)
    REFERENCES `mydb`.`BoardSchool` (`idBoard`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_School_Area1`
    FOREIGN KEY (`Area_idArea`)
    REFERENCES `mydb`.`Area` (`idArea`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CrimeTypes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`CrimeTypes` ;

CREATE TABLE IF NOT EXISTS `mydb`.`CrimeTypes` (
  `idCrimeTypes` INT NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`idCrimeTypes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Crime`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Crime` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Crime` (
  `idCrime` INT NOT NULL,
  `Location` VARCHAR(45) NULL,
  `Zone` VARCHAR(3) NULL,
  `CrimeTypes_idCrimeTypes` INT NOT NULL,
  PRIMARY KEY (`idCrime`),
  INDEX `fk_Crime_CrimeTypes1_idx` (`CrimeTypes_idCrimeTypes` ASC) VISIBLE,
  CONSTRAINT `fk_Crime_CrimeTypes1`
    FOREIGN KEY (`CrimeTypes_idCrimeTypes`)
    REFERENCES `mydb`.`CrimeTypes` (`idCrimeTypes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Parks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Parks` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Parks` (
  `idParks` INT NOT NULL,
  `ParkName` VARCHAR(200) NULL,
  `ParkType` VARCHAR(15) NULL,
  `Developed` VARCHAR(3) NULL,
  PRIMARY KEY (`idParks`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
