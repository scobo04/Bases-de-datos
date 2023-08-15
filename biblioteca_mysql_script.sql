-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema biblioteca
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema biblioteca
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `biblioteca` DEFAULT CHARACTER SET utf8 ;
USE `biblioteca` ;

-- -----------------------------------------------------
-- Table `biblioteca`.`Autor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`Autor` (
  `codi` INT NOT NULL,
  `nombre` VARCHAR(50) NOT NULL,
  `apellido1` VARCHAR(50) NOT NULL,
  `apellido2` VARCHAR(50) NULL,
  PRIMARY KEY (`codi`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`Prestatge`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`Prestatge` (
  `codi` INT NOT NULL,
  PRIMARY KEY (`codi`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`Libro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`Libro` (
  `codi` INT NOT NULL,
  `titulo` VARCHAR(50) NOT NULL,
  `isbn` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`codi`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`Escrit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`Escrit` (
  `codi_libro` INT NOT NULL,
  `codi_autor` INT NOT NULL,
  PRIMARY KEY (`codi_libro`, `codi_autor`),
  INDEX `fk_Libro_has_Autor_Autor1_idx` (`codi_autor` ASC) ,
  INDEX `fk_Libro_has_Autor_Libro_idx` (`codi_libro` ASC) ,
  CONSTRAINT `fk_Libro_has_Autor_Libro`
    FOREIGN KEY (`codi_libro`)
    REFERENCES `biblioteca`.`Libro` (`codi`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Libro_has_Autor_Autor1`
    FOREIGN KEY (`codi_autor`)
    REFERENCES `biblioteca`.`Autor` (`codi`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`Tema`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`Tema` (
  `codi` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `codi_Prestage` INT NOT NULL,
  PRIMARY KEY (`codi`),
  INDEX `fk_Tema_Prestatge1_idx` (`codi_Prestage` ASC) ,
  CONSTRAINT `fk_Tema_Prestatge1`
    FOREIGN KEY (`codi_Prestage`)
    REFERENCES `biblioteca`.`Prestatge` (`codi`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`Pertany`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`Pertany` (
  `codi_Libro` INT NOT NULL,
  `codi_Tema` INT NOT NULL,
  PRIMARY KEY (`codi_Libro`, `codi_Tema`),
  INDEX `fk_Libro_has_Tema_Tema1_idx` (`codi_Tema` ASC) ,
  INDEX `fk_Libro_has_Tema_Libro1_idx` (`codi_Libro` ASC) ,
  CONSTRAINT `fk_Libro_has_Tema_Libro1`
    FOREIGN KEY (`codi_Libro`)
    REFERENCES `biblioteca`.`Libro` (`codi`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Libro_has_Tema_Tema1`
    FOREIGN KEY (`codi_Tema`)
    REFERENCES `biblioteca`.`Tema` (`codi`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
