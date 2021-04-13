-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `ANIMAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ANIMAL` (
  `codigo` INT NOT NULL,
  `nome` VARCHAR(20) NULL,
  `especie` VARCHAR(45) NULL,
  `raca` VARCHAR(45) NULL,
  `reptil` TINYINT NULL,
  `mamifero` TINYINT NULL,
  `peixe` TINYINT NULL,
  `peso` FLOAT NULL,
  `data_nascimento` DATE NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CATEGORIA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CATEGORIA` (
  `codigo` INT NOT NULL,
  `descricao` VARCHAR(45) NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PRODUTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PRODUTO` (
  `codigo` INT NOT NULL,
  `tipo` VARCHAR(45) NULL,
  `valor` FLOAT NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FILIAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FILIAL` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(100) NULL,
  `cnpj` VARCHAR(19) NULL,
  `endereco` VARCHAR(200) NULL,
  `cep` VARCHAR(15) NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CLIENTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CLIENTE` (
  `codigo` INT NOT NULL,
  `nome` VARCHAR(200) NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SERVIÇO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SERVIÇO` (
  `codigo` INT NOT NULL,
  `descricao` VARCHAR(45) NULL,
  `valor` FLOAT NULL,
  `tipo` VARCHAR(45) NULL,
  `data` DATETIME NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FUNCIONARIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FUNCIONARIO` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NULL,
  PRIMARY KEY (`codigo`),
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ATENDIMENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ATENDIMENTO` (
  `codigo` INT NOT NULL,
  `data_agendamento` DATETIME NULL,
  `data_atendimento` DATETIME NULL,
  `codigo_animal` INT NOT NULL,
  `codigo_filial` INT NOT NULL,
  `codigo_funcionario` INT NOT NULL,
  `cpf_cliente` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`codigo`),
  INDEX `fk_ATENDIMENTO_ANIMAL1_idx` (`codigo_animal` ASC),
  INDEX `fk_ATENDIMENTO_FILIAL1_idx` (`codigo_filial` ASC),
  INDEX `fk_ATENDIMENTO_FUNCIONARIO1_idx` (`codigo_funcionario` ASC),
  INDEX `fk_ATENDIMENTO_CLIENTE1_idx` (`cpf_cliente` ASC),
  CONSTRAINT `fk_ATENDIMENTO_ANIMAL1`
    FOREIGN KEY (`codigo_animal`)
    REFERENCES `ANIMAL` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ATENDIMENTO_FILIAL1`
    FOREIGN KEY (`codigo_filial`)
    REFERENCES `FILIAL` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ATENDIMENTO_FUNCIONARIO1`
    FOREIGN KEY (`codigo_funcionario`)
    REFERENCES `FUNCIONARIO` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ATENDIMENTO_CLIENTE1`
    FOREIGN KEY (`cpf_cliente`)
    REFERENCES `CLIENTE` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PAGAMENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PAGAMENTO` (
  `codigo` INT NOT NULL,
  `valor` FLOAT NULL,
  `tipo` VARCHAR(45) NULL,
  `data` DATETIME NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FUNCIONARIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FUNCIONARIO` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NULL,
  PRIMARY KEY (`codigo`),
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `COMANDA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `COMANDA` (
  `codigo` INT NOT NULL,
  `data` TIMESTAMP NULL,
  `mesa` INT NULL,
  `codigo_funcionario` INT NOT NULL,
  PRIMARY KEY (`codigo`),
  INDEX `fk_COMANDA_FUNCIONARIO1_idx` (`codigo_funcionario` ASC),
  CONSTRAINT `fk_COMANDA_FUNCIONARIO1`
    FOREIGN KEY (`codigo_funcionario`)
    REFERENCES `FUNCIONARIO` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PAGAMENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PAGAMENTO` (
  `codigo` INT NOT NULL,
  `valor` FLOAT NULL,
  `tipo` VARCHAR(45) NULL,
  `data` DATETIME NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PRODUTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PRODUTO` (
  `codigo` INT NOT NULL,
  `tipo` VARCHAR(45) NULL,
  `valor` FLOAT NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `COMANDA_PAGAMENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `COMANDA_PAGAMENTO` (
  `codigo_comanda` INT NOT NULL,
  `codigo_pagamento` INT NOT NULL,
  `codigo` INT NOT NULL,
  PRIMARY KEY (`codigo`),
  INDEX `fk_COMANDA_has_PAGAMENTO_PAGAMENTO1_idx` (`codigo_pagamento` ASC),
  INDEX `fk_COMANDA_has_PAGAMENTO_COMANDA_idx` (`codigo_comanda` ASC),
  CONSTRAINT `fk_PAGAMENTO_COMANDA`
    FOREIGN KEY (`codigo_comanda`)
    REFERENCES `COMANDA` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_COMANDA_PAGAMENTO`
    FOREIGN KEY (`codigo_pagamento`)
    REFERENCES `PAGAMENTO` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `COMANDA_PRODUTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `COMANDA_PRODUTO` (
  `COMANDA_codigo` INT NOT NULL,
  `PRODUTO_codigo` INT NOT NULL,
  `valor_total_produto` FLOAT NULL,
  `quantidade` INT NULL,
  PRIMARY KEY (`COMANDA_codigo`, `PRODUTO_codigo`),
  INDEX `fk_COMANDA_has_PRODUTO_PRODUTO1_idx` (`PRODUTO_codigo` ASC),
  INDEX `fk_COMANDA_has_PRODUTO_COMANDA1_idx` (`COMANDA_codigo` ASC),
  CONSTRAINT `fk_COMANDA_has_PRODUTO_COMANDA1`
    FOREIGN KEY (`COMANDA_codigo`)
    REFERENCES `COMANDA` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_COMANDA_has_PRODUTO_PRODUTO1`
    FOREIGN KEY (`PRODUTO_codigo`)
    REFERENCES `PRODUTO` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CLIENTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CLIENTE` (
  `codigo` INT NOT NULL,
  `nome` VARCHAR(200) NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `COMANDA_CLIENTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `COMANDA_CLIENTE` (
  `codigo_comanda` INT NOT NULL,
  `codigo_cliente` INT NOT NULL,
  PRIMARY KEY (`codigo_comanda`, `codigo_cliente`),
  INDEX `fk_COMANDA_has_CLIENTE_CLIENTE1_idx` (`codigo_cliente` ASC),
  INDEX `fk_COMANDA_has_CLIENTE_COMANDA1_idx` (`codigo_comanda` ASC),
  CONSTRAINT `fk_COMANDA_has_CLIENTE_COMANDA1`
    FOREIGN KEY (`codigo_comanda`)
    REFERENCES `COMANDA` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_COMANDA_has_CLIENTE_CLIENTE1`
    FOREIGN KEY (`codigo_cliente`)
    REFERENCES `CLIENTE` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CLIENTE_TELEFONE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CLIENTE_TELEFONE` (
  `codigo` INT NOT NULL,
  `telefone` VARCHAR(20) NULL,
  `cpf_cliente` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`codigo`),
  INDEX `fk_CLIENTE_TELEFONE_CLIENTE1_idx` (`cpf_cliente` ASC),
  CONSTRAINT `fk_CLIENTE_TELEFONE_CLIENTE1`
    FOREIGN KEY (`cpf_cliente`)
    REFERENCES `CLIENTE` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SERVIÇO_ANIMAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SERVIÇO_ANIMAL` (
  `codigo_servico` INT NOT NULL,
  `codigo_animal` INT NOT NULL,
  PRIMARY KEY (`codigo_servico`, `codigo_animal`),
  INDEX `fk_SERVIÇO_has_ANIMAL_ANIMAL1_idx` (`codigo_animal` ASC),
  INDEX `fk_SERVIÇO_has_ANIMAL_SERVIÇO1_idx` (`codigo_servico` ASC),
  CONSTRAINT `fk_SERVIÇO_has_ANIMAL_SERVIÇO1`
    FOREIGN KEY (`codigo_servico`)
    REFERENCES `SERVIÇO` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SERVIÇO_has_ANIMAL_ANIMAL1`
    FOREIGN KEY (`codigo_animal`)
    REFERENCES `ANIMAL` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ATENDIMENTO_PRODUTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ATENDIMENTO_PRODUTO` (
  `codigo_produto` INT NOT NULL,
  `codigo_atendimento` INT NOT NULL,
  PRIMARY KEY (`codigo_produto`, `codigo_atendimento`),
  INDEX `fk_PRODUTO_has_ATENDIMENTO_ATENDIMENTO1_idx` (`codigo_atendimento` ASC),
  INDEX `fk_PRODUTO_has_ATENDIMENTO_PRODUTO1_idx` (`codigo_produto` ASC),
  CONSTRAINT `fk_PRODUTO_has_ATENDIMENTO_PRODUTO1`
    FOREIGN KEY (`codigo_produto`)
    REFERENCES `PRODUTO` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRODUTO_has_ATENDIMENTO_ATENDIMENTO1`
    FOREIGN KEY (`codigo_atendimento`)
    REFERENCES `ATENDIMENTO` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FILIAL_PRODUTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FILIAL_PRODUTO` (
  `codigo_filial` INT NOT NULL,
  `codigo_produto` INT NOT NULL,
  PRIMARY KEY (`codigo_filial`, `codigo_produto`),
  INDEX `fk_FILIAL_has_PRODUTO_PRODUTO1_idx` (`codigo_produto` ASC),
  INDEX `fk_FILIAL_has_PRODUTO_FILIAL1_idx` (`codigo_filial` ASC),
  CONSTRAINT `fk_FILIAL_has_PRODUTO_FILIAL1`
    FOREIGN KEY (`codigo_filial`)
    REFERENCES `FILIAL` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FILIAL_has_PRODUTO_PRODUTO1`
    FOREIGN KEY (`codigo_produto`)
    REFERENCES `PRODUTO` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FILIAL_CATEGORIA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FILIAL_CATEGORIA` (
  `codigo_filial` INT NOT NULL,
  `codigo_categoria` INT NOT NULL,
  PRIMARY KEY (`codigo_filial`, `codigo_categoria`),
  INDEX `fk_FILIAL_has_CATEGORIA_CATEGORIA1_idx` (`codigo_categoria` ASC),
  INDEX `fk_FILIAL_has_CATEGORIA_FILIAL1_idx` (`codigo_filial` ASC),
  CONSTRAINT `fk_FILIAL_has_CATEGORIA_FILIAL1`
    FOREIGN KEY (`codigo_filial`)
    REFERENCES `FILIAL` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FILIAL_has_CATEGORIA_CATEGORIA1`
    FOREIGN KEY (`codigo_categoria`)
    REFERENCES `CATEGORIA` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ATENDIMENTO_PAGAMENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ATENDIMENTO_PAGAMENTO` (
  `codigo_atendimento` INT NOT NULL,
  `codigo_pagamento` INT NOT NULL,
  PRIMARY KEY (`codigo_atendimento`, `codigo_pagamento`),
  INDEX `fk_ATENDIMENTO_has_PAGAMENTO_PAGAMENTO1_idx` (`codigo_pagamento` ASC),
  INDEX `fk_ATENDIMENTO_has_PAGAMENTO_ATENDIMENTO1_idx` (`codigo_atendimento` ASC),
  CONSTRAINT `fk_ATENDIMENTO_has_PAGAMENTO_ATENDIMENTO1`
    FOREIGN KEY (`codigo_atendimento`)
    REFERENCES `ATENDIMENTO` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ATENDIMENTO_has_PAGAMENTO_PAGAMENTO1`
    FOREIGN KEY (`codigo_pagamento`)
    REFERENCES `PAGAMENTO` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FUNCIONARIO_FILIAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FUNCIONARIO_FILIAL` (
  `codigo_funcionario` INT NOT NULL,
  `codigo_filial` INT NOT NULL,
  PRIMARY KEY (`codigo_funcionario`, `codigo_filial`),
  INDEX `fk_FUNCIONARIO_has_FILIAL_FILIAL1_idx` (`codigo_filial` ASC),
  INDEX `fk_FUNCIONARIO_has_FILIAL_FUNCIONARIO1_idx` (`codigo_funcionario` ASC),
  CONSTRAINT `fk_FUNCIONARIO_has_FILIAL_FUNCIONARIO1`
    FOREIGN KEY (`codigo_funcionario`)
    REFERENCES `FUNCIONARIO` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FUNCIONARIO_has_FILIAL_FILIAL1`
    FOREIGN KEY (`codigo_filial`)
    REFERENCES `FILIAL` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SERVIÇO_FUNCIONARIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SERVIÇO_FUNCIONARIO` (
  `codigo_servico` INT NOT NULL,
  `codigo_funcionario` INT NOT NULL,
  PRIMARY KEY (`codigo_servico`, `codigo_funcionario`),
  INDEX `fk_SERVIÇO_has_FUNCIONARIO_FUNCIONARIO1_idx` (`codigo_funcionario` ASC),
  INDEX `fk_SERVIÇO_has_FUNCIONARIO_SERVIÇO1_idx` (`codigo_servico` ASC),
  CONSTRAINT `fk_SERVIÇO_has_FUNCIONARIO_SERVIÇO1`
    FOREIGN KEY (`codigo_servico`)
    REFERENCES `SERVIÇO` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SERVIÇO_has_FUNCIONARIO_FUNCIONARIO1`
    FOREIGN KEY (`codigo_funcionario`)
    REFERENCES `FUNCIONARIO` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `ANIMAL`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `ANIMAL` (`codigo`, `nome`, `especie`, `raca`, `reptil`, `mamifero`, `peixe`, `peso`, `data_nascimento`) VALUES (1, 'Max', 'Cão', 'Pug', NULL, NULL, NULL, 10 KG, '20-06-2006');

COMMIT;


-- -----------------------------------------------------
-- Data for table `CATEGORIA`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `CATEGORIA` (`codigo`, `descricao`) VALUES (1, 'Ração para cão');
INSERT INTO `CATEGORIA` (`codigo`, `descricao`) VALUES (2, 'Ração para gato');
INSERT INTO `CATEGORIA` (`codigo`, `descricao`) VALUES (3, 'Ração para peixes');
INSERT INTO `CATEGORIA` (`codigo`, `descricao`) VALUES (4, 'Ração para reptils');

COMMIT;


-- -----------------------------------------------------
-- Data for table `PRODUTO`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `PRODUTO` (`codigo`, `nome`, `preco`, `valor`, `data`, `codigo_categoria`) VALUES (1, 'Ração Pedigri ', 15 KG, 40,00, '01-01-2018', 1);
INSERT INTO `PRODUTO` (`codigo`, `nome`, `preco`, `valor`, `data`, `codigo_categoria`) VALUES (2, 'Ração Iscas', 500 G, 10,00, '01-01-2018', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `FILIAL`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `FILIAL` (`codigo`, `descricao`, `cnpj`, `endereco`, `cep`) VALUES (1, 'SmartPet - Zona Sul ', '123.123.123.0001/12', 'Rua wenceslau 710', '9000232-25');

COMMIT;


-- -----------------------------------------------------
-- Data for table `CLIENTE`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `CLIENTE` (`cpf`, `nome`, `email`, `endereco`, `cep`) VALUES ('001.002.003-04', 'Gabriel', 'Guima@gmail.com.br', 'juca batista', '923321-98');

COMMIT;


-- -----------------------------------------------------
-- Data for table `SERVIÇO`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `SERVIÇO` (`codigo`, `descricao`, `valor`, `tipo`, `data`) VALUES (1, 'Banho Animal Grande', 50,00, 'BANHO', '01-01-2018');
INSERT INTO `SERVIÇO` (`codigo`, `descricao`, `valor`, `tipo`, `data`) VALUES (2, 'Banho Animal Medio', 35,00, 'BANHO', '01-01-2018');
INSERT INTO `SERVIÇO` (`codigo`, `descricao`, `valor`, `tipo`, `data`) VALUES (3, 'Banho Animal Pequeno', 25,00, 'BANHO', '01-01-2018');

COMMIT;


-- -----------------------------------------------------
-- Data for table `FUNCIONARIO`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `FUNCIONARIO` (`codigo`, `nome`) VALUES (1, 'Bernabeu ');
INSERT INTO `FUNCIONARIO` (`codigo`, `nome`) VALUES (2, 'Fagudes');
INSERT INTO `FUNCIONARIO` (`codigo`, `nome`) VALUES (3, 'Guima');

COMMIT;


-- -----------------------------------------------------
-- Data for table `ATENDIMENTO`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `ATENDIMENTO` (`codigo`, `data_agendamento`, `data_atendimento`, `codigo_animal`, `codigo_filial`, `codigo_funcionario`, `cpf_cliente`) VALUES (1, '', '13-06-2018', 1, 1, 1, '001.002.003-04');

COMMIT;


-- -----------------------------------------------------
-- Data for table `PAGAMENTO`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `PAGAMENTO` (`codigo`, `tipo`, `data`, `valor`) VALUES (1, 'DEBITO', '13-11-2018', 65,00);

COMMIT;


-- -----------------------------------------------------
-- Data for table `SERVIÇO_ANIMAL`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `SERVIÇO_ANIMAL` (`codigo_servico`, `codigo_animal`) VALUES (3, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `ATENDIMENTO_PRODUTO`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `ATENDIMENTO_PRODUTO` (`codigo_produto`, `codigo_atendimento`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `FILIAL_PRODUTO`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `FILIAL_PRODUTO` (`codigo_filial`, `codigo_produto`) VALUES (1, 1);
INSERT INTO `FILIAL_PRODUTO` (`codigo_filial`, `codigo_produto`) VALUES (1, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `FILIAL_CATEGORIA`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `FILIAL_CATEGORIA` (`codigo_filial`, `codigo_categoria`) VALUES (1, 1);
INSERT INTO `FILIAL_CATEGORIA` (`codigo_filial`, `codigo_categoria`) VALUES (1, 2);
INSERT INTO `FILIAL_CATEGORIA` (`codigo_filial`, `codigo_categoria`) VALUES (1, 3);
INSERT INTO `FILIAL_CATEGORIA` (`codigo_filial`, `codigo_categoria`) VALUES (1, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `FUNCIONARIO_FILIAL`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `FUNCIONARIO_FILIAL` (`codigo_funcionario`, `codigo_filial`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `SERVIÇO_FUNCIONARIO`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `SERVIÇO_FUNCIONARIO` (`codigo_servico`, `codigo_funcionario`) VALUES (1, 1);
INSERT INTO `SERVIÇO_FUNCIONARIO` (`codigo_servico`, `codigo_funcionario`) VALUES (2, 1);
INSERT INTO `SERVIÇO_FUNCIONARIO` (`codigo_servico`, `codigo_funcionario`) VALUES (3, 1);

COMMIT;
