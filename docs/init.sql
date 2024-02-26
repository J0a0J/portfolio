-- 아래 스크립트에서 ‘portfolio_2024’를 자신의 데이터베이스명으로 바꿔줍니다.

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Table `portfolio_2024`.`member_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `portfolio_2024`.`member_type` ;

CREATE TABLE IF NOT EXISTS `portfolio_2024`.`member_type` (
  `type_seq` INT NOT NULL AUTO_INCREMENT,
  `type_name` VARCHAR(20) NULL,
  `use_yn` CHAR(1) NULL,
  `create_date` VARCHAR(14) NULL,
  PRIMARY KEY (`type_seq`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio_2024`.`member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `portfolio_2024`.`member` ;

CREATE TABLE IF NOT EXISTS `portfolio_2024`.`member` (
  `member_idx` INT NOT NULL AUTO_INCREMENT,
  `type_seq` INT NOT NULL,
  `member_id` VARCHAR(20) NOT NULL,
  `member_pw` VARCHAR(200) NULL,
  `member_name` VARCHAR(50) NOT NULL,
  `member_nick` VARCHAR(24) NOT NULL,
  `email` VARCHAR(50) NULL,
  `create_dtm` VARCHAR(14) NOT NULL,
  `update_dtm` VARCHAR(14) NULL,
  `membercol` VARCHAR(45) NULL,
  PRIMARY KEY (`member_idx`, `type_seq`),
  INDEX `fk_member_member_type1_idx` (`type_seq` ASC),
  CONSTRAINT `fk_member_member_type1`
    FOREIGN KEY (`type_seq`)
    REFERENCES `portfolio_2024`.`member_type` (`type_seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio_2024`.`board_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `portfolio_2024`.`board_type` ;

CREATE TABLE IF NOT EXISTS `portfolio_2024`.`board_type` (
  `type_seq` INT NOT NULL AUTO_INCREMENT,
  `board_title` VARCHAR(20) NULL,
  `use_yn` CHAR(1) NULL,
  `create_dtm` VARCHAR(14) NULL,
  PRIMARY KEY (`type_seq`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio_2024`.`board`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `portfolio_2024`.`board` ;

CREATE TABLE IF NOT EXISTS `portfolio_2024`.`board` (
  `board_seq` INT NOT NULL AUTO_INCREMENT,
  `type_seq` INT NOT NULL,
  `member_id` VARCHAR(12) NOT NULL,
  `member_nick` VARCHAR(24) NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `content` VARCHAR(10000) NOT NULL,
  `has_file` CHAR(1) NULL,
  `hits` INT NOT NULL DEFAULT 0,
  `create_dtm` VARCHAR(14) NULL,
  `update_dtm` VARCHAR(14) NULL,
  PRIMARY KEY (`board_seq`, `type_seq`),
  INDEX `fk_board_board_type1_idx` (`type_seq` ASC),
  CONSTRAINT `fk_board_board_type1`
    FOREIGN KEY (`type_seq`)
    REFERENCES `portfolio_2024`.`board_type` (`type_seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio_2024`.`board_attach`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `portfolio_2024`.`board_attach` ;

CREATE TABLE IF NOT EXISTS `portfolio_2024`.`board_attach` (
  `file_idx` INT NOT NULL AUTO_INCREMENT,
  `type_seq` INT NOT NULL,
  `board_seq` INT NOT NULL,
  `file_name` VARCHAR(256) NOT NULL,
  `fake_filename` VARCHAR(256) NOT NULL,
  `file_size` INT NOT NULL,
  `file_type` VARCHAR(100) NOT NULL,
  `save_loc` VARCHAR(200) NOT NULL,
  `create_dtm` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`file_idx`),
  INDEX `fk_board_attach_board1_idx` (`board_seq` ASC, `type_seq` ASC),
  CONSTRAINT `fk_board_attach_board1`
    FOREIGN KEY (`board_seq` , `type_seq`)
    REFERENCES `portfolio_2024`.`board` (`board_seq` , `type_seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio_2024`.`email_auth`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `portfolio_2024`.`email_auth` ;

CREATE TABLE IF NOT EXISTS `portfolio_2024`.`email_auth` (
  `auth_idx` INT NOT NULL AUTO_INCREMENT,
  `member_idx` INT NOT NULL,
  `member_type_seq` INT NOT NULL,
  `member_id` VARCHAR(20) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `link` VARCHAR(200) NOT NULL,
  `send_dtm` VARCHAR(14) NULL,
  PRIMARY KEY (`auth_idx`),
  INDEX `fk_email_auth_member1_idx` (`member_idx` ASC, `member_type_seq` ASC),
  CONSTRAINT `fk_email_auth_member1`
    FOREIGN KEY (`member_idx` , `member_type_seq`)
    REFERENCES `portfolio_2024`.`member` (`member_idx` , `type_seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `portfolio_2024`.`member_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `portfolio_2024`;
INSERT INTO `portfolio_2024`.`member_type` (`type_seq`, `type_name`, `use_yn`, `create_date`) VALUES (9, '관리자', 'Y', NOW());
INSERT INTO `portfolio_2024`.`member_type` (`type_seq`, `type_name`, `use_yn`, `create_date`) VALUES (1, '일반사용자', 'Y', NOW());

COMMIT;


-- -----------------------------------------------------
-- Data for table `portfolio_2024`.`board_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `portfolio_2024`;
INSERT INTO `portfolio_2024`.`board_type` (`type_seq`, `board_title`, `use_yn`, `create_dtm`) VALUES (1, '공지사항', 'Y', NOW());
INSERT INTO `portfolio_2024`.`board_type` (`type_seq`, `board_title`, `use_yn`, `create_dtm`) VALUES (2, '자유게시판', 'Y', NOW());

COMMIT;

