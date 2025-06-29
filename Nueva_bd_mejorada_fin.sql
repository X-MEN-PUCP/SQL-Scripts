-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema universidad
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `universidad` ;

-- -----------------------------------------------------
-- Schema universidad
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `universidad` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `universidad` ;

-- -----------------------------------------------------
-- Table `universidad`.`Usuarios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `universidad`.`usuario` ;

CREATE TABLE IF NOT EXISTS `universidad`.`usuario` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `tipo_documento` ENUM('DNI', 'CE') NOT NULL,
  `nro_documento` VARCHAR(20) NOT NULL,
  `contrasenha` VARCHAR(255) NOT NULL,
  `nombre` VARCHAR(50) NOT NULL,
  `apellido_paterno` VARCHAR(50) NOT NULL,
  `apellido_materno` VARCHAR(50) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `correo_electronico` VARCHAR(100) NULL DEFAULT NULL,
  `num_celular` VARCHAR(15) NULL DEFAULT NULL,
  `cod_medico` VARCHAR(20) NULL DEFAULT NULL,
  `genero` ENUM('FEMENINO', 'MASCULINO', 'OTRO') NOT NULL,
  `estado_general` TINYINT NOT NULL DEFAULT 1,
  `estado_logico` TINYINT NOT NULL DEFAULT 1,
  `estado` ENUM('activo', 'inactivo','pendiente_verificacion') NOT NULL DEFAULT 'activo',
  `usuario_creacion` INT NULL DEFAULT NULL,
  `fecha_creacion` DATETIME NULL DEFAULT NULL,
  `usuario_modificacion` INT NULL DEFAULT NULL,
  `fecha_modificacion` DATETIME NULL DEFAULT NULL,
  `codigo_verificacion` VARCHAR(10) NULL DEFAULT NULL,
  `fecha_expiracion_codigo` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE INDEX `nro_documento` (`nro_documento` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `universidad`.`Turno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `universidad`.`turno` ;

CREATE TABLE IF NOT EXISTS `universidad`.`turno` (
  `id_turno` INT NOT NULL AUTO_INCREMENT,
  `nombre_turno` VARCHAR(50) NOT NULL,
  `hora_inicio` TIME NOT NULL,
  `hora_fin` TIME NOT NULL,
  `estado_general` TINYINT NOT NULL DEFAULT 1,
  `usuario_creación` INT NULL DEFAULT NULL,
  `fecha_creacion` DATETIME NULL DEFAULT NULL,
  `usuario_modificación` INT NULL DEFAULT NULL,
  `fecha_modificacion` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id_turno`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `universidad`.`Consultorio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `universidad`.`consultorio` ;

CREATE TABLE IF NOT EXISTS `universidad`.`consultorio` (
  `id_consultorio` INT NOT NULL AUTO_INCREMENT,
  `numero_consultorio` INT NOT NULL,
  `piso` INT NOT NULL,
  `estado` TINYINT NOT NULL DEFAULT 1,
  `usuario_creación` INT NULL DEFAULT NULL,
  `fecha_creacion` DATETIME NULL DEFAULT NULL,
  `usuario_modificación` INT NULL DEFAULT NULL,
  `fecha_modificacion` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id_consultorio`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `universidad`.`Cita`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `universidad`.`cita` ;

CREATE TABLE IF NOT EXISTS `universidad`.`cita` (
  `id_cita` INT NOT NULL AUTO_INCREMENT,
  `id_medico` INT NOT NULL,
  `id_especialidad` INT NOT NULL,
  `id_turno` INT NOT NULL,
  `id_consultorio` INT NOT NULL,
  `hora_inicio` TIME NOT NULL,
  `hora_fin` TIME NOT NULL,
  `fecha_cita` DATE NOT NULL,
  `estado_cita` TINYINT NOT NULL DEFAULT 1, 
  `usuario_creación` INT NULL DEFAULT NULL,
  `fecha_creacion` DATETIME NULL DEFAULT NULL,
  `usuario_modificación` INT NULL DEFAULT NULL,
  `fecha_modificacion` DATETIME NULL DEFAULT NULL,
  `codigo_verificacion` INT NULL DEFAULT NULL,
  `fecha_expiracion_codigo` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id_cita`),
  INDEX `id_medico` (`id_medico` ASC) VISIBLE,
  INDEX `id_turno` (`id_turno` ASC) VISIBLE,
  INDEX `id_consultorio` (`id_consultorio` ASC) VISIBLE,
  INDEX `id_especialidad` (`id_especialidad` ASC) VISIBLE,
  CONSTRAINT `cita_ibfk_1`
    FOREIGN KEY (`id_medico`)
    REFERENCES `universidad`.`usuario` (`id_usuario`),
  CONSTRAINT `cita_ibfk_2`
    FOREIGN KEY (`id_turno`)
    REFERENCES `universidad`.`turno` (`id_turno`),
  CONSTRAINT `cita_ibfk_3`
    FOREIGN KEY (`id_consultorio`)
    REFERENCES `universidad`.`consultorio` (`id_consultorio`),
  CONSTRAINT `cita_ibfk_4`
    FOREIGN KEY (`id_especialidad`)
    REFERENCES `universidad`.`especialidad` (`id_especialidad`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `universidad`.`Especialidad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `universidad`.`especialidad` ;

CREATE TABLE IF NOT EXISTS `universidad`.`especialidad` (
  `id_especialidad` INT NOT NULL AUTO_INCREMENT,
  `nombre_especialidad` VARCHAR(100) NOT NULL,
  `precio_consulta` DECIMAL(10,2) NOT NULL,
  `estado` TINYINT NOT NULL DEFAULT 1,
  `usuario_creación` INT NULL DEFAULT NULL,
  `fecha_creacion` DATETIME NULL DEFAULT NULL,
  `usuario_modificación` INT NULL DEFAULT NULL,
  `fecha_modificacion` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id_especialidad`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `universidad`.`Usuario_por_especialidad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `universidad`.`usuario_por_especialidad` ;

CREATE TABLE IF NOT EXISTS `universidad`.`usuario_por_especialidad` (
  `id_especialidad` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `estado` TINYINT NOT NULL DEFAULT 1,
  `usuario_creación` INT NULL DEFAULT NULL,
  `fecha_creacion` DATETIME NULL DEFAULT NULL,
  `usuario_modificación` INT NULL DEFAULT NULL,
  `fecha_modificacion` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id_especialidad`, `id_usuario`),
  INDEX `id_usuario` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `usuario_por_especialidad_ibfk_1`
    FOREIGN KEY (`id_especialidad`)
    REFERENCES `universidad`.`especialidad` (`id_especialidad`),
  CONSTRAINT `usuario_por_especialidad_ibfk_2`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `universidad`.`usuario` (`id_usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `universidad`.`tipo_de_examen`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `universidad`.`tipo_de_examen` ;

CREATE TABLE tipo_de_examen (
    `id_tipo_de_examen` INT AUTO_INCREMENT PRIMARY KEY,
    `nombre_examen` VARCHAR(45) NOT NULL,
    `indicacion` VARCHAR(100)
);

-- -----------------------------------------------------
-- Table `universidad`.`Examen`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `universidad`.`examen` ;

CREATE TABLE IF NOT EXISTS `universidad`.`examen` (
  `id_examen` INT NOT NULL AUTO_INCREMENT,
  `nombre_examen` VARCHAR(100) NOT NULL,
  `id_tipo_de_examen` INT NOT NULL,
  `estado` TINYINT NOT NULL DEFAULT 1,
  `usuario_creación` INT NULL DEFAULT NULL,
  `fecha_creacion` DATETIME NULL DEFAULT NULL,
  `usuario_modificación` INT NULL DEFAULT NULL,
  `fecha_modificacion` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id_examen`),
  FOREIGN KEY (`id_tipo_de_examen`) 
  REFERENCES `universidad`.`tipo_de_examen`(`id_tipo_de_examen`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `universidad`.`Examen_por_cita`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `universidad`.`examen_por_cita` ;

CREATE TABLE IF NOT EXISTS `universidad`.`examen_por_cita` (
  `id_examen` INT NOT NULL,
  `id_cita` INT NOT NULL,
  `observacion` VARCHAR(100) NOT NULL,
  `estado` TINYINT NOT NULL DEFAULT 1,
  `usuario_creación` INT NULL DEFAULT NULL,
  `fecha_creacion` DATETIME NULL DEFAULT NULL,
  `usuario_modificación` INT NULL DEFAULT NULL,
  `fecha_modificacion` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id_examen`, `id_cita`),
  INDEX `id_cita` (`id_cita` ASC) VISIBLE,
  CONSTRAINT `examen_por_cita_ibfk_1`
    FOREIGN KEY (`id_examen`)
    REFERENCES `universidad`.`examen` (`id_examen`),
  CONSTRAINT `examen_por_cita_ibfk_2`
    FOREIGN KEY (`id_cita`)
    REFERENCES `universidad`.`cita` (`id_cita`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `universidad`.`HistoriaClinica`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `universidad`.`historia_clinica` ;

CREATE TABLE IF NOT EXISTS `universidad`.`historia_clinica` (
  `id_historia` INT NOT NULL AUTO_INCREMENT,
  `id_paciente` INT NOT NULL,
  `estado` TINYINT NOT NULL DEFAULT 1,
  `usuario_creación` INT NULL DEFAULT NULL,
  `fecha_creacion` DATETIME NULL DEFAULT NULL,
  `usuario_modificación` INT NULL DEFAULT NULL,
  `fecha_modificacion` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id_historia`),
  INDEX `id_paciente` (`id_paciente` ASC) VISIBLE,
  CONSTRAINT `historia_clinica_ibfk_1`
    FOREIGN KEY (`id_paciente`)
    REFERENCES `universidad`.`usuario` (`id_usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `universidad`.`Historia_clinica_por_cita`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `universidad`.`historia_clinica_por_cita` ;

CREATE TABLE IF NOT EXISTS `universidad`.`historia_clinica_por_cita` (
  `id_historia` INT NOT NULL,
  `id_cita` INT NOT NULL,
  `peso` DECIMAL(5,2) NULL COMMENT 'Peso en kilogramos, ej. 70.50',
  `talla` DECIMAL(4,2) NULL COMMENT 'Talla en metros, ej. 1.75',
  `presion_arterial` VARCHAR(10) NULL COMMENT 'Ej. 120/80',
  `temperatura` DECIMAL(4,2) NULL COMMENT 'Temperatura en grados Celsius, ej. 36.5',
  `frecuencia_cardiaca` INT NULL COMMENT 'Latidos por minuto, ej. 75',
  `motivo_consulta` VARCHAR(250) NULL,
  `tratamiento` VARCHAR(250) NULL,
  `evolucion` VARCHAR(250) NULL,
  `recomendacion` VARCHAR(250) NULL,
  `receta` VARCHAR(250) NULL DEFAULT NULL,
  `estado` TINYINT NOT NULL DEFAULT 1,  
  `usuario_creación` INT NULL DEFAULT NULL,
  `fecha_creacion` DATETIME NULL DEFAULT NULL,
  `usuario_modificación` INT NULL DEFAULT NULL,
  `fecha_modificacion` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id_historia`, `id_cita`),
  INDEX `id_historia` (`id_historia` ASC) VISIBLE,
  INDEX `id_cita` (`id_cita` ASC) VISIBLE,
  CONSTRAINT `historia_clinica_por_cita_ibfk_1`
    FOREIGN KEY (`id_historia`)
    REFERENCES `universidad`.`historia_clinica` (`id_historia`),
  CONSTRAINT `historia_clinica_por_cita_ibfk_2`
    FOREIGN KEY (`id_cita`)
    REFERENCES `universidad`.`cita` (`id_cita`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;
-- -----------------------------------------------------
-- Table `universidad`.`Interconsulta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `universidad`.`interconsulta` ;

CREATE TABLE IF NOT EXISTS `universidad`.`interconsulta` (
  `id_interconsulta` INT NOT NULL,
  `id_cita` INT NOT NULL,
  `razon_interconsulta` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id_interconsulta`, `id_cita`),
  INDEX `interconsulta_ibfk_1_idx` (`id_cita` ASC) VISIBLE,
  CONSTRAINT `interconsulta_ibfk_2`
    FOREIGN KEY (`id_cita`)
    REFERENCES `universidad`.`cita` (`id_cita`),
  CONSTRAINT `interconsulta_ibfk_1`
    FOREIGN KEY (`id_interconsulta`)
    REFERENCES `universidad`.`especialidad` (`id_especialidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `universidad`.`Rol`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `universidad`.`rol` ;

CREATE TABLE IF NOT EXISTS `universidad`.`rol` (
  `id_rol` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `estado` TINYINT NOT NULL DEFAULT 1, 
  `usuario_creación` INT NULL DEFAULT NULL,
  `fecha_creacion` DATETIME NULL DEFAULT NULL,
  `usuario_modificación` INT NULL DEFAULT NULL,
  `fecha_modificacion` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id_rol`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `universidad`.`Roles_por_usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `universidad`.`usuario_por_rol` ;

CREATE TABLE IF NOT EXISTS `universidad`.`usuario_por_rol` (
  `id_usuario` INT NOT NULL,
  `id_rol` INT NOT NULL,
  `estado` TINYINT NOT NULL DEFAULT 1, 
  `usuario_creación` INT NULL DEFAULT NULL,
  `fecha_creacion` DATETIME NULL DEFAULT NULL,
  `usuario_modificación` INT NULL DEFAULT NULL,
  `fecha_modificacion` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id_rol`, `id_usuario`),
  INDEX `id_usuario` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `rolesxusuario_ibfk_1`
    FOREIGN KEY (`id_rol`)
    REFERENCES `universidad`.`rol` (`id_rol`),
  CONSTRAINT `rolesxusuario_ibfk_2`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `universidad`.`usuario` (`id_usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `universidad`.`Diagnostico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `universidad`.`diagnostico` ;

CREATE TABLE IF NOT EXISTS `universidad`.`diagnostico` (
  `id_diagnostico` INT AUTO_INCREMENT PRIMARY KEY,
  `nombre_diagnostico` VARCHAR(255),
  `descripcion` VARCHAR(100),
  `capitulo` VARCHAR(100),
  `grupo` VARCHAR(100),
  `nivel` INT,
  `activo` BOOLEAN DEFAULT TRUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- -----------------------------------------------------
-- Table `universidad`.`Diagnostico_por_cita`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `universidad`.`diagnostico_por_cita` ;

CREATE TABLE IF NOT EXISTS `universidad`.`diagnostico_por_cita` (
  `id_cita` INT NOT NULL,
  `id_diagnostico` INT NOT NULL,
  `observacion` VARCHAR(100) NULL,
  PRIMARY KEY (`id_cita`, `id_diagnostico`),
  FOREIGN KEY (`id_cita`) 
  REFERENCES `universidad`.`cita`(`id_cita`),
  FOREIGN KEY (`id_diagnostico`)
  REFERENCES `universidad`.`diagnostico`(`id_diagnostico`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
