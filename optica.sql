-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Cul_de_Ampolla
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Cul_de_Ampolla
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Cul_de_Ampolla` DEFAULT CHARACTER SET utf8 ;
USE `Cul_de_Ampolla` ;

-- -----------------------------------------------------
-- Table `Cul_de_Ampolla`.`Marcas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_de_Ampolla`.`Marcas` (
  `id_marca` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_marca`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cul_de_Ampolla`.`Proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_de_Ampolla`.`Proveedor` (
  `id_proveedor` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_marca` INT UNSIGNED NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion_calle` VARCHAR(45) NOT NULL,
  `direccion_numero` VARCHAR(5) NOT NULL,
  `direccion_piso` VARCHAR(5) NULL,
  `direccion_puerta` VARCHAR(5) NULL,
  `direccion_ciudad` VARCHAR(20) NOT NULL,
  `direccion_codigo_postal` VARCHAR(5) NOT NULL,
  `direccion_pais` VARCHAR(30) NOT NULL,
  `telefono` VARCHAR(15) NOT NULL,
  `fax` VARCHAR(15) NULL,
  `nif` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_proveedor`),
  INDEX `fk_proveedor_marca_idx` (`id_marca` ASC) ,
  CONSTRAINT `fk_proveedor_marca`
    FOREIGN KEY (`id_marca`)
    REFERENCES `Cul_de_Ampolla`.`Marcas` (`id_marca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cul_de_Ampolla`.`Gafas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_de_Ampolla`.`Gafas` (
  `id_gafas` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_proveedor` INT UNSIGNED NOT NULL,
  `id_marca` INT UNSIGNED NOT NULL,
  `graduacion_izquierda` DOUBLE NOT NULL,
  `graduacion_derecha` DOUBLE NOT NULL,
  `tipo_montura` ENUM('flotante', 'pasta', 'metalica') NOT NULL,
  `color_montura` VARCHAR(10) NOT NULL,
  `color_vidrio` ENUM("vidrio_derecho", "vidrio_izquierdo") NOT NULL,
  `precio` DOUBLE NOT NULL,
  PRIMARY KEY (`id_gafas`),
  INDEX `id_proveedor_idx` (`id_proveedor` ASC) ,
  INDEX `fk_gafas_marca_idx` (`id_marca` ASC) ,
  CONSTRAINT `fk_gafas_proveedor`
    FOREIGN KEY (`id_proveedor`)
    REFERENCES `Cul_de_Ampolla`.`Proveedor` (`id_proveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_gafas_marca`
    FOREIGN KEY (`id_marca`)
    REFERENCES `Cul_de_Ampolla`.`Marcas` (`id_marca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cul_de_Ampolla`.`Recomendado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_de_Ampolla`.`Recomendado` (
  `id_recomendado` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_cliente` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_recomendado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cul_de_Ampolla`.`Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_de_Ampolla`.`Clientes` (
  `id_cliente` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_recomendado` INT UNSIGNED NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(10) NOT NULL,
  `correo_electronico` VARCHAR(45) NULL,
  `fecha_registro` DATE NOT NULL,
  PRIMARY KEY (`id_cliente`),
  INDEX `id_recomendado_idx` (`id_recomendado` ASC) ,
  CONSTRAINT `fk_clientes_recomendado`
    FOREIGN KEY (`id_recomendado`)
    REFERENCES `Cul_de_Ampolla`.`Recomendado` (`id_recomendado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cul_de_Ampolla`.`Empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_de_Ampolla`.`Empleado` (
  `id_empleado` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_empleado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cul_de_Ampolla`.`Ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_de_Ampolla`.`Ventas` (
  `id_venta` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_cliente` INT UNSIGNED NOT NULL,
  `id_empleado` INT UNSIGNED NOT NULL,
  `id_gafas` INT UNSIGNED NOT NULL,
  `fecha_venta` DATE NOT NULL,
  PRIMARY KEY (`id_venta`),
  INDEX `id_empleado_idx` (`id_empleado` ASC) ,
  INDEX `id_cliente_idx` (`id_cliente` ASC) ,
  INDEX `id_gafas_idx` (`id_gafas` ASC) ,
  CONSTRAINT `fk_ventas_empleado`
    FOREIGN KEY (`id_empleado`)
    REFERENCES `Cul_de_Ampolla`.`Empleado` (`id_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ventas_cliente`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `Cul_de_Ampolla`.`Clientes` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ventas_gafas`
    FOREIGN KEY (`id_gafas`)
    REFERENCES `Cul_de_Ampolla`.`Gafas` (`id_gafas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
