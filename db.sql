-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb`;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8;
USE `mydb`;

-- -----------------------------------------------------
-- Table `mydb`.`rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`rol` (
  `id_rol` INT NOT NULL AUTO_INCREMENT,
  `nombre_rol` VARCHAR(45) NULL,
  PRIMARY KEY (`id_rol`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `id_user` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NULL,
  `passwd` VARCHAR(150) NULL,
  `mac` VARCHAR(45) NULL,
  `ip` VARCHAR(45) NULL,
  `sw_id` VARCHAR(45) NULL,
  `sw_port` VARCHAR(45) NULL,
  `session` VARCHAR(1) NULL,
  `time_stamp` VARCHAR(45) NULL,
  `rol_idrol` INT NOT NULL,
  PRIMARY KEY (`id_user`),
  INDEX `fk_userauth_rol_idx` (`rol_idrol` ASC),
  CONSTRAINT `fk_userauth_rol`
    FOREIGN KEY (`rol_idrol`)
    REFERENCES `mydb`.`rol` (`id_rol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`regla`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`regla` (
  `id_regla` INT NOT NULL,
  `nombre_regla` VARCHAR(45) NULL,
  `descripcion` VARCHAR(200) NULL,
  `svr_ip` VARCHAR(45) NULL,
  `svr_port` VARCHAR(45) NULL,
  `action` VARCHAR(45) NULL,
  PRIMARY KEY (`id_regla`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`rol_has_regla`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`rol_has_regla` (
  `rol_id_rol` INT NOT NULL,
  `regla_id_regla` INT NOT NULL,
  PRIMARY KEY (`rol_id_rol`, `regla_id_regla`),
  INDEX `fk_rol_has_regla_regla1_idx` (`regla_id_regla` ASC),
  INDEX `fk_rol_has_regla_rol1_idx` (`rol_id_rol` ASC),
  CONSTRAINT `fk_rol_has_regla_rol1`
    FOREIGN KEY (`rol_id_rol`)
    REFERENCES `mydb`.`rol` (`id_rol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rol_has_regla_regla1`
    FOREIGN KEY (`regla_id_regla`)
    REFERENCES `mydb`.`regla` (`id_regla`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `mydb`.`rol`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`rol` (`id_rol`, `nombre_rol`) VALUES (1, 'ESTUDIANTE_FACI');
INSERT INTO `mydb`.`rol` (`id_rol`, `nombre_rol`) VALUES (2, 'ESTUDIANTE_EEGG');
INSERT INTO `mydb`.`rol` (`id_rol`, `nombre_rol`) VALUES (3, 'PROFESOR_FACI');
INSERT INTO `mydb`.`rol` (`id_rol`, `nombre_rol`) VALUES (4, 'INVESTIGADOR_TELECOM');
COMMIT;

-- -----------------------------------------------------
-- Data for table `mydb`.`user`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`user` (`id_user`, `username`, `passwd`, `mac`, `ip`, `sw_id`, `sw_port`, `session`, `time_stamp`, `rol_idrol`) VALUES (1, 'godlucho', NULL, NULL, NULL, NULL, NULL, '0', NULL, 1);

COMMIT;
