-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Netflix
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Netflix
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Netflix` DEFAULT CHARACTER SET utf8 ;
USE `Netflix` ;

-- -----------------------------------------------------
-- Table `Netflix`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Netflix`.`Usuario` (
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
-- Table `Netflix`.`Mensalidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Netflix`.`Mensalidade` (
  `id_Mensalidade` INT NOT NULL AUTO_INCREMENT,
  `data_Debito` DATE NOT NULL,
  `valor` DECIMAL(4,2) NOT NULL,
  `email` VARCHAR(40) NULL,
  PRIMARY KEY (`id_Mensalidade`),
  INDEX `fk_Mensalidade_Usuario1_idx` (`email` ASC) VISIBLE,
  CONSTRAINT `fk_Mensalidade_Usuario1`
    FOREIGN KEY (`email`)
    REFERENCES `Netflix`.`Usuario` (`email`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Netflix`.`Video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Netflix`.`Video` (
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
-- Table `Netflix`.`Plataforma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Netflix`.`Plataforma` (
  `id_Plataforma` INT NOT NULL,
  `tipo_Plataforma` CHAR(1) NOT NULL CHECK (tipo_Plataforma='C' or tipo_Plataforma='M' or tipo_Plataforma='S'),
  `id_Video` INT NOT NULL,
  PRIMARY KEY (`id_Plataforma`),
  INDEX `fk_Plataforma_Video1_idx` (`id_Video` ASC) VISIBLE,
  CONSTRAINT `fk_Plataforma_Video1`
    FOREIGN KEY (`id_Video`)
    REFERENCES `Netflix`.`Video` (`id_Video`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Netflix`.`Serie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Netflix`.`Serie` (
  `nome_Serie` VARCHAR(50) NOT NULL,
  `qtd_Temporada` INT NOT NULL,
  UNIQUE INDEX `Nome_UNIQUE` (`nome_Serie` ASC) VISIBLE,
  PRIMARY KEY (`nome_Serie`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Netflix`.`Ator`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Netflix`.`Ator` (
  `nome_Ator` VARCHAR(50) NOT NULL,
  `idade` INT NOT NULL,
  PRIMARY KEY (`nome_Ator`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Netflix`.`Acessa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Netflix`.`Acessa` (
  `email` VARCHAR(40) NOT NULL,
  `id_Plataforma` INT NOT NULL,
  PRIMARY KEY (`email`, `id_Plataforma`),
  INDEX `fk_Usuario_has_Plataforma_Plataforma1_idx` (`id_Plataforma` ASC) VISIBLE,
  INDEX `fk_Usuario_has_Plataforma_Usuario1_idx` (`email` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_has_Plataforma_Usuario1`
    FOREIGN KEY (`email`)
    REFERENCES `Netflix`.`Usuario` (`email`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Usuario_has_Plataforma_Plataforma1`
    FOREIGN KEY (`id_Plataforma`)
    REFERENCES `Netflix`.`Plataforma` (`id_Plataforma`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Netflix`.`Episodio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Netflix`.`Episodio` (
  `id_Video` INT NOT NULL,
  `nome_Serie` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_Video`),
  INDEX `fk_Episodio_Video1_idx` (`id_Video` ASC) VISIBLE,
  INDEX `fk_Episodio_Serie1_idx` (`nome_Serie` ASC) VISIBLE,
  CONSTRAINT `fk_Episodio_Video1`
    FOREIGN KEY (`id_Video`)
    REFERENCES `Netflix`.`Video` (`id_Video`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Episodio_Serie1`
    FOREIGN KEY (`nome_Serie`)
    REFERENCES `Netflix`.`Serie` (`nome_Serie`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Netflix`.`Possui`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Netflix`.`Possui` (
  `id_Video` INT NOT NULL,
  `nome_Ator` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_Video`, `nome_Ator`),
  INDEX `fk_Video_has_Ator_Ator1_idx` (`nome_Ator` ASC) VISIBLE,
  INDEX `fk_Video_has_Ator_Video1_idx` (`id_Video` ASC) VISIBLE,
  CONSTRAINT `fk_Video_has_Ator_Video1`
    FOREIGN KEY (`id_Video`)
    REFERENCES `Netflix`.`Video` (`id_Video`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Video_has_Ator_Ator1`
    FOREIGN KEY (`nome_Ator`)
    REFERENCES `Netflix`.`Ator` (`nome_Ator`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
