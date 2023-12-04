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
    `rol_id_rol` INT NOT NULL,
    PRIMARY KEY (`id_user`),
    INDEX `fk_user_rol1_idx` (`rol_id_rol` ASC),
    CONSTRAINT `fk_user_rol1`
    FOREIGN KEY (`rol_id_rol`)
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
    `svr_mac` VARCHAR(45) NULL,
    `action` VARCHAR(45) NULL,
    PRIMARY KEY (`id_regla`)
    ) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`rol_has_regla`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`rol_has_regla` (
                                                      `rol_id_rol` INT NOT NULL,
                                                      `regla_id_regla` INT NOT NULL,
                                                      INDEX `fk_rol_has_regla_regla1_idx` (`regla_id_regla` ASC),
    INDEX `fk_rol_has_regla_rol1_idx` (`rol_id_rol` ASC),
    PRIMARY KEY (`rol_id_rol`, `regla_id_regla`),
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
INSERT INTO `mydb`.`rol` (`id_rol`, `nombre_rol`) VALUES (1, 'ESTUDIANTE_FACI_TEL');
INSERT INTO `mydb`.`rol` (`id_rol`, `nombre_rol`) VALUES (2, 'PROFESOR_FACI_TEL');
INSERT INTO `mydb`.`rol` (`id_rol`, `nombre_rol`) VALUES (3, 'INVESTIGADOR_FACI_GIRA');
COMMIT;

-- -----------------------------------------------------
-- Data for table `mydb`.`user`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`user` (`id_user`, `username`, `passwd`, `mac`, `ip`, `sw_id`, `sw_port`, `session`, `time_stamp`, `rol_id_rol`) VALUES (1, 'a20195922@pucp.edu.pe', '$2b$10$A10sBleWryAzGMis2dBWwuQtanmgP/wQXgsLx1Ub08yOalBG.HJiC', 'fa:16:3e:5c:73:86', '10.0.0.1', '00:00:f2:20:f9:45:4c:4e', 'ens7', '0', NULL, 2);
INSERT INTO `mydb`.`user` (`id_user`, `username`, `passwd`, `mac`, `ip`, `sw_id`, `sw_port`, `session`, `time_stamp`, `rol_id_rol`) VALUES (2, 'a20200334@pucp.edu.pe', '$2b$10$A10sBleWryAzGMis2dBWwuQtanmgP/wQXgsLx1Ub08yOalBG.HJiC', 'fa:16:3e:6c:ff:86', '10.0.0.2', '00:00:f2:20:f9:45:4c:4e', 'ens8', '0', NULL, 3);
INSERT INTO `mydb`.`user` (`id_user`, `username`, `passwd`, `mac`, `ip`, `sw_id`, `sw_port`, `session`, `time_stamp`, `rol_id_rol`) VALUES (3, 'a20202073@pucp.edu.pe', '$2b$10$A10sBleWryAzGMis2dBWwuQtanmgP/wQXgsLx1Ub08yOalBG.HJiC', 'fa:16:3e:39:16:d8', '10.0.0.3', '00:00:f2:20:f9:45:4c:4e', 'ens9', '0', NULL, 1);
COMMIT;

-- -----------------------------------------------------
-- Data for table `mydb`.`regla`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`regla` (`id_regla`, `nombre_regla`, `descripcion`, `svr_ip`, `svr_port`, `svr_mac`, `action`) VALUES (1, 'Acceso_Git_Server', 'Acceso a los repositorios de git investigadores GIRA', '10.0.0.23', '22', 'fa:16:3e:24:ac:9f', 'ens6');
COMMIT;

-- -----------------------------------------------------
-- Data for table `mydb`.`rol_has_regla`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`rol_has_regla` (`rol_id_rol`, `regla_id_regla`) VALUES (3, 1);
COMMIT;
