-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Streaming
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Streaming
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Streaming` DEFAULT CHARACTER SET utf8 ;
USE `Streaming` ;

-- -----------------------------------------------------
-- Table `Streaming`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Streaming`.`Usuario` (
  `email` VARCHAR(40) NOT NULL,
  `cpf` CHAR(11) NOT NULL,
  `celular` CHAR(11) NOT NULL,
  `nome` VARCHAR(80) NOT NULL,
  `senha` VARCHAR(30) NOT NULL,
  `cartao` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`email`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Streaming`.`Mensalidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Streaming`.`Mensalidade` (
  `id_Mensalidade` INT NOT NULL AUTO_INCREMENT,
  `data_Debito` DATE NOT NULL,
  `valor` DECIMAL(4,2) NOT NULL,
  `email` VARCHAR(40) NULL,
  PRIMARY KEY (`id_Mensalidade`),
  INDEX `fk_Mensalidade_Usuario1_idx` (`email` ASC) VISIBLE,
  CONSTRAINT `fk_Mensalidade_Usuario1`
    FOREIGN KEY (`email`)
    REFERENCES `Streaming`.`Usuario` (`email`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Streaming`.`Video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Streaming`.`Video` (
  `id_Video` INT NOT NULL,
  `titulo` VARCHAR(50) NOT NULL,
  `ano` INT NOT NULL,
  `duracao` VARCHAR(6) NOT NULL,
  `descricao` VARCHAR(300) NOT NULL DEFAULT 'Video sem descrição.',
  `tipo_Video` CHAR(1) NOT NULL CHECK (tipo_Video='F' or tipo_Video='D' or tipo_Video='E'),
  PRIMARY KEY (`id_Video`),
  UNIQUE INDEX `titulo_ano_unique` (`titulo` ASC, `ano` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Streaming`.`Plataforma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Streaming`.`Plataforma` (
  `id_Plataforma` INT NOT NULL,
  `tipo_Plataforma` CHAR(1) NOT NULL CHECK (tipo_Plataforma='C' or tipo_Plataforma='M' or tipo_Plataforma='S'),
  `id_Video` INT NOT NULL,
  PRIMARY KEY (`id_Plataforma`),
  INDEX `fk_Plataforma_Video1_idx` (`id_Video` ASC) VISIBLE,
  CONSTRAINT `fk_Plataforma_Video1`
    FOREIGN KEY (`id_Video`)
    REFERENCES `Streaming`.`Video` (`id_Video`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Streaming`.`Serie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Streaming`.`Serie` (
  `nome_Serie` VARCHAR(50) NOT NULL,
  `qtd_Temporada` INT NOT NULL,
  UNIQUE INDEX `Nome_UNIQUE` (`nome_Serie` ASC) VISIBLE,
  PRIMARY KEY (`nome_Serie`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Streaming`.`Ator`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Streaming`.`Ator` (
  `nome_Ator` VARCHAR(50) NOT NULL,
  `idade` INT NOT NULL,
  PRIMARY KEY (`nome_Ator`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Streaming`.`Acessa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Streaming`.`Acessa` (
  `email` VARCHAR(40) NOT NULL,
  `id_Plataforma` INT NOT NULL,
  PRIMARY KEY (`email`, `id_Plataforma`),
  INDEX `fk_Usuario_has_Plataforma_Plataforma1_idx` (`id_Plataforma` ASC) VISIBLE,
  INDEX `fk_Usuario_has_Plataforma_Usuario1_idx` (`email` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_has_Plataforma_Usuario1`
    FOREIGN KEY (`email`)
    REFERENCES `Streaming`.`Usuario` (`email`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Usuario_has_Plataforma_Plataforma1`
    FOREIGN KEY (`id_Plataforma`)
    REFERENCES `Streaming`.`Plataforma` (`id_Plataforma`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Streaming`.`Episodio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Streaming`.`Episodio` (
  `id_Video` INT NOT NULL,
  `nome_Serie` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_Video`),
  INDEX `fk_Episodio_Video1_idx` (`id_Video` ASC) VISIBLE,
  INDEX `fk_Episodio_Serie1_idx` (`nome_Serie` ASC) VISIBLE,
  CONSTRAINT `fk_Episodio_Video1`
    FOREIGN KEY (`id_Video`)
    REFERENCES `Streaming`.`Video` (`id_Video`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Episodio_Serie1`
    FOREIGN KEY (`nome_Serie`)
    REFERENCES `Streaming`.`Serie` (`nome_Serie`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Streaming`.`Possui`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Streaming`.`Possui` (
  `id_Video` INT NOT NULL,
  `nome_Ator` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_Video`, `nome_Ator`),
  INDEX `fk_Video_has_Ator_Ator1_idx` (`nome_Ator` ASC) VISIBLE,
  INDEX `fk_Video_has_Ator_Video1_idx` (`id_Video` ASC) VISIBLE,
  CONSTRAINT `fk_Video_has_Ator_Video1`
    FOREIGN KEY (`id_Video`)
    REFERENCES `Streaming`.`Video` (`id_Video`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Video_has_Ator_Ator1`
    FOREIGN KEY (`nome_Ator`)
    REFERENCES `Streaming`.`Ator` (`nome_Ator`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
