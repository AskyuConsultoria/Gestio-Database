DROP DATABASE askyu;

SET FOREIGN_KEY_CHECKS = 0;

CREATE DATABASE  IF NOT EXISTS `askyu` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `askyu`;
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: askyu
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `agendamento`
--

DROP TABLE IF EXISTS `agendamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agendamento` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `data_inicio` datetime NOT NULL,
  `data_fim` datetime NOT NULL,
  `localizacao` varchar(255) DEFAULT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `etapa_id` int NOT NULL,
  `usuario_id` int NOT NULL,
  `cliente_id` int DEFAULT NULL,
  `ativo` tinyint(1) DEFAULT '1',
  `endereco_id` int DEFAULT NULL,
  `telefone_id` int DEFAULT NULL,
  PRIMARY KEY (`id`,`etapa_id`,`usuario_id`),
  KEY `fk_etapa_agendamento` (`etapa_id`),
  KEY `fk_usuario_agendamento` (`usuario_id`),
  KEY `fk_cliente_agendamento` (`cliente_id`),
  KEY `fk_agendamento_endereco` (`endereco_id`),
  KEY `fk_telefone_agendamento` (`telefone_id`),
  CONSTRAINT `fk_agendamento_endereco` FOREIGN KEY (`endereco_id`) REFERENCES `endereco` (`id`),
  CONSTRAINT `fk_cliente_agendamento` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`),
  CONSTRAINT `fk_etapa_agendamento` FOREIGN KEY (`etapa_id`) REFERENCES `etapa` (`id`),
  CONSTRAINT `fk_telefone_agendamento` FOREIGN KEY (`telefone_id`) REFERENCES `telefone` (`id`),
  CONSTRAINT `fk_usuario_agendamento` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=249 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agendamento`
--
-- ORDER BY:  `id`,`etapa_id`,`usuario_id`
/*!40000 ALTER TABLE `agendamento` DISABLE KEYS */;
INSERT INTO `agendamento` VALUES (248,'Agendamento','2024-12-20 17:29:00','2024-12-20 18:29:00',NULL,NULL,2,1,3,1,4,3),(250,'Agendamento','2024-12-19 17:22:00','2024-12-19 18:22:00',NULL,NULL,3,1,4,1,2,4),(247,'Agendamento','2024-11-18 17:29:00','2024-11-18 18:29:00',NULL,NULL,4,1,1,1,1,1),(249,'Agendamento','2024-11-21 17:22:00','2024-11-21 18:22:00',NULL,NULL,1,1,2,1,1,2);
/*!40000 ALTER TABLE `agendamento` ENABLE KEYS */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`askyu`@`%`*/ /*!50003 TRIGGER `tg_agendamento_update` AFTER UPDATE ON `agendamento` FOR EACH ROW BEGIN

IF OLD.etapa_id <> NEW.etapa_id THEN
    INSERT INTO log_agendamento VALUES 
    (default, OLD.id, OLD.data_inicio, OLD.data_fim, OLD.localizacao, OLD.descricao, OLD.etapa_id, OLD.usuario_id, OLD.cliente_id);
END IF;
    
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `sobrenome` varchar(45) NOT NULL,
  `dt_nasc` date DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `responsavel_id` int DEFAULT NULL,
  `usuario_id` int NOT NULL,
  `ativo` tinyint(1) NOT NULL DEFAULT '1',
  `responsavel` int DEFAULT NULL,
  `data_criacao` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`,`usuario_id`),
  KEY `fk_responsavel` (`responsavel_id`),
  KEY `fk_cliente_usuario` (`usuario_id`),
  CONSTRAINT `fk_cliente_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`),
  CONSTRAINT `fk_responsavel` FOREIGN KEY (`responsavel_id`) REFERENCES `cliente` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--
-- ORDER BY:  `id`,`usuario_id`

/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'Carlos','Joarez',NULL,'carlos.joarez@gmail.com',NULL,1,1,NULL,'2024-06-09 19:54:35'),(2,'Lucas','Silva','1990-01-15','lucas.silva@example.com',NULL,1,1,NULL,'2024-06-09 19:54:35'),(3,'Mariana','Santos','1985-03-22','mariana.santos@example.com',NULL,1,1,NULL,'2024-06-09 19:54:35'),(4,'Lucas','Santos','1992-07-30','mariana.santos@example.com',1,1,1,NULL,'2024-06-09 19:54:35'),(5,'Fernanda','Costa','1988-12-05','fernanda.costa@example.com',NULL,1,1,NULL,'2024-06-09 19:54:35'),(6,'Roberto','Souza','1979-08-14','roberto.souza@example.com',NULL,1,1,NULL,'2024-06-09 19:54:35'),(7,'Patricia','Almeida','1995-04-10','patricia.almeida@example.com',NULL,1,1,NULL,'2024-06-09 19:54:35');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
--
-- Table structure for table `colecao_tecido`
--
DROP TABLE IF EXISTS `colecao_tecido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `colecao_tecido` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tecido_id` int NOT NULL,
  `item_pedido_id` int NOT NULL,
  `cliente_id` int NOT NULL,
  `usuario_id` int NOT NULL,
  `peca_id` int NOT NULL,
  `ativo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`,`tecido_id`,`item_pedido_id`,`cliente_id`,`usuario_id`,`peca_id`),
  KEY `fk_tecido_colecao_tecido` (`tecido_id`),
  KEY `fk_item_pedido_colecao_tecido` (`item_pedido_id`),
  KEY `fk_cliente_colecao_tecido` (`cliente_id`),
  KEY `fk_usuario_colecao_tecido` (`usuario_id`),
  KEY `fk_peca_colecao_tecido` (`peca_id`),
  CONSTRAINT `fk_cliente_colecao_tecido` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`),
  CONSTRAINT `fk_item_pedido_colecao_tecido` FOREIGN KEY (`item_pedido_id`) REFERENCES `item_pedido` (`id`),
  CONSTRAINT `fk_peca_colecao_tecido` FOREIGN KEY (`peca_id`) REFERENCES `peca` (`id`),
  CONSTRAINT `fk_tecido_colecao_tecido` FOREIGN KEY (`tecido_id`) REFERENCES `tecido` (`id`),
  CONSTRAINT `fk_usuario_colecao_tecido` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `colecao_tecido`
--
-- ORDER BY:  `id`,`tecido_id`,`item_pedido_id`,`cliente_id`,`usuario_id`,`peca_id`

/*!40000 ALTER TABLE `colecao_tecido` DISABLE KEYS */;
INSERT INTO `colecao_tecido` VALUES (60,20001,102,4,1,100,1),(61,20001,103,8,1,200,1),(62,20001,104,4,1,200,1),(63,20000,105,4,1,100,1),(64,20001,106,8,1,100,1),(65,20001,107,10,1,100,1),(66,20002,107,10,1,100,1),(67,20000,107,10,1,100,1);
/*!40000 ALTER TABLE `colecao_tecido` ENABLE KEYS */;

--
-- Table structure for table `complemento`
--

DROP TABLE IF EXISTS `complemento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `complemento` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ativo` bit(1) DEFAULT NULL,
  `complemento` varchar(255) DEFAULT NULL,
  `numero` int DEFAULT NULL,
  `endereco_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKep1rwok3mm2xerhy95an8sgrt` (`endereco_id`),
  CONSTRAINT `FKep1rwok3mm2xerhy95an8sgrt` FOREIGN KEY (`endereco_id`) REFERENCES `endereco` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `complemento`
--
-- ORDER BY:  `id`

/*!40000 ALTER TABLE `complemento` DISABLE KEYS */;
/*!40000 ALTER TABLE `complemento` ENABLE KEYS */;

--
-- Table structure for table `endereco`
--

DROP TABLE IF EXISTS `endereco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `endereco` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cep` varchar(255) DEFAULT NULL,
  `logradouro` varchar(255) DEFAULT NULL,
  `bairro` varchar(255) DEFAULT NULL,
  `localidade` varchar(255) DEFAULT NULL,
  `uf` varchar(2) DEFAULT NULL,
  `usuario_id` int NOT NULL,
  `ativo` tinyint(1) DEFAULT '1',
  `cliente_id` int DEFAULT NULL,
  `cidade` varchar(150) DEFAULT NULL,
  `numero` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`,`usuario_id`),
  KEY `fk_endereco_usuario` (`usuario_id`),
  KEY `fk_endereco_cliente` (`cliente_id`),
  CONSTRAINT `fk_endereco_cliente` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`),
  CONSTRAINT `fk_endereco_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `endereco`
--
-- ORDER BY:  `id`,`usuario_id`

/*!40000 ALTER TABLE `endereco` DISABLE KEYS */;
INSERT INTO `endereco` VALUES (1,'12345674','Rua Exemplo','Barramas',NULL,'SP',1,1,1,'Cidade Exemplo','123'),(2,'12345678','Rua Exemplo - Exemplo','Paulista',NULL,'SP',1,1,2,'Cidade Exemplo','123'),(3,'12345-678','Rua Exemplo','Centro','Cidade Exemplo','SP',1,1,3,'Cidade Exemplo','123'),(4,'032395013','Rua Almeida de Alimense','Nocumé',NULL,'AM',1,1,4,'Acachá','11'); 
/*!40000 ALTER TABLE `endereco` ENABLE KEYS */;

--
-- Table structure for table `etapa`
--

DROP TABLE IF EXISTS `etapa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etapa` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `ultima_etapa` tinyint(1) DEFAULT NULL,
  `usuario_id` int NOT NULL,
  `ativo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`,`usuario_id`),
  KEY `fk_etapa_usuario` (`usuario_id`),
  CONSTRAINT `fk_etapa_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etapa`
--
-- ORDER BY:  `id`,`usuario_id`

/*!40000 ALTER TABLE `etapa` DISABLE KEYS */;
INSERT INTO `etapa` VALUES (1,'Entrevista','Etapa inicial de negociação',0,1,1),(2,'Primeira Prova','Primeiro mínimo produto víavel da roupa',0,1,1),(3,'Segunda Prova','Prova para verificação do caimento da peça',0,1,1),(4,'Concluído','Peça foi entregue com sucesso ao cliente',1,1,1),(5,'Cancelado','Houve dessistência por parte do cliente',0,1,0);
/*!40000 ALTER TABLE `etapa` ENABLE KEYS */;

--
-- Table structure for table `foto`
--

DROP TABLE IF EXISTS `foto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `foto` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dado_arquivo` mediumblob,
  `nome_arquivo` varchar(255) DEFAULT NULL,
  `item_pedido_id` int DEFAULT NULL,
  `usuario_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKgxytm1f33jig82gfwhbmw0b1s` (`item_pedido_id`),
  KEY `FKkeyss3i39o47lj7jctjqpwai2` (`usuario_id`),
  CONSTRAINT `FKgxytm1f33jig82gfwhbmw0b1s` FOREIGN KEY (`item_pedido_id`) REFERENCES `item_pedido` (`id`),
  CONSTRAINT `FKkeyss3i39o47lj7jctjqpwai2` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `foto`
--
-- ORDER BY:  `id`

/*!40000 ALTER TABLE `foto` DISABLE KEYS */;
/*!40000 ALTER TABLE `foto` ENABLE KEYS */;

--
-- Table structure for table `item_pedido`
--

DROP TABLE IF EXISTS `item_pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_pedido` (
  `id` int NOT NULL AUTO_INCREMENT,
  `observacao` varchar(255) DEFAULT NULL,
  `cliente_id` int NOT NULL,
  `usuario_id` int NOT NULL,
  `peca_id` int NOT NULL,
  `ativo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`,`cliente_id`,`usuario_id`,`peca_id`),
  KEY `fk_cliente_item_pedido` (`cliente_id`),
  KEY `fk_usuario_item_pedido` (`usuario_id`),
  KEY `fK_peca_item_pedido` (`peca_id`),
  CONSTRAINT `fk_cliente_item_pedido` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`),
  CONSTRAINT `fK_peca_item_pedido` FOREIGN KEY (`peca_id`) REFERENCES `peca` (`id`),
  CONSTRAINT `fk_usuario_item_pedido` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_pedido`
--
-- ORDER BY:  `id`,`cliente_id`,`usuario_id`,`peca_id`

/*!40000 ALTER TABLE `item_pedido` DISABLE KEYS */;
INSERT INTO `item_pedido` VALUES (102,'Deu tudo certo!',4,1,100,1),(103,'Calça com a barra ajustada conforme medida: 3cm',1,1,200,1),(104,'',3,1,200,0),(105,'',5,1,100,1),(106,'',7,1,100,1),(107,'',6,1,100,1);
/*!40000 ALTER TABLE `item_pedido` ENABLE KEYS */;

--
-- Table structure for table `log_agendamento`
--

DROP TABLE IF EXISTS `log_agendamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_agendamento` (
  `id` int NOT NULL AUTO_INCREMENT,
  `agendamento_id` int DEFAULT NULL,
  `data_inicio` datetime DEFAULT NULL,
  `data_fim` datetime DEFAULT NULL,
  `localizacao` varchar(255) DEFAULT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `etapa_id` int DEFAULT NULL,
  `usuario_id` int DEFAULT NULL,
  `cliente_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_agendamento_log` (`agendamento_id`),
  KEY `fk_etapa_agendamento_log` (`etapa_id`),
  KEY `fk_usuario_agendamento_log` (`usuario_id`),
  KEY `fk_cliente_agendamento_log` (`cliente_id`),
  CONSTRAINT `fk_agendamento_log` FOREIGN KEY (`agendamento_id`) REFERENCES `agendamento` (`id`),
  CONSTRAINT `fk_cliente_agendamento_log` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`),
  CONSTRAINT `fk_etapa_agendamento_log` FOREIGN KEY (`etapa_id`) REFERENCES `etapa` (`id`),
  CONSTRAINT `fk_usuario_agendamento_log` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_agendamento`
--
-- ORDER BY:  `id`

/*!40000 ALTER TABLE `log_agendamento` DISABLE KEYS */;
INSERT INTO `log_agendamento` VALUES (1,127,'2024-08-06 16:13:00','2024-08-13 16:13:00',NULL,NULL,2,1,1),(2,127,'2024-08-06 16:13:00','2024-08-13 16:13:00',NULL,NULL,3,1,1),(3,127,'2024-08-06 16:13:00','2024-08-13 16:13:00',NULL,NULL,2,1,1),(4,127,'2024-08-06 16:13:00','2024-08-13 16:13:00',NULL,NULL,1,1,1),(5,127,'2024-08-06 16:13:00','2024-08-13 16:13:00',NULL,NULL,2,1,1),(6,127,'2024-08-06 16:13:00','2024-08-13 16:13:00',NULL,NULL,3,1,1),(7,123,'2024-08-07 16:00:00','2024-08-07 16:00:00',NULL,NULL,1,1,1),(8,124,'2024-08-13 16:13:00','2024-08-13 16:13:00',NULL,NULL,1,1,1),(9,124,'2024-08-13 16:13:00','2024-08-13 16:13:00',NULL,NULL,2,1,1),(10,124,'2024-08-13 16:13:00','2024-08-13 16:13:00',NULL,NULL,3,1,1),(11,122,'2024-09-01 10:55:00','2024-08-30 10:55:00',NULL,NULL,1,1,1),(12,122,'2024-09-01 10:55:00','2024-08-30 10:55:00',NULL,NULL,2,1,1),(13,122,'2024-09-01 10:55:00','2024-08-30 10:55:00',NULL,NULL,3,1,1),(14,189,'2024-09-24 23:21:00','2024-09-24 23:21:00',NULL,NULL,1,1,1),(15,189,'2024-09-24 23:21:00','2024-09-24 23:21:00',NULL,NULL,2,1,1),(16,192,'2024-09-18 09:23:00','2024-09-18 09:23:00',NULL,NULL,1,1,1),(17,193,'2024-09-05 18:30:00','2024-09-05 18:30:00',NULL,NULL,1,1,1),(18,194,'2024-09-18 16:24:00','2024-09-18 16:24:00',NULL,NULL,1,1,1),(19,195,'2024-09-10 16:52:00','2024-09-10 16:52:00',NULL,NULL,1,1,1),(20,190,'2024-09-18 00:38:00','2024-09-18 00:38:00',NULL,NULL,1,1,1),(21,202,'2024-10-25 13:43:00','2024-10-25 13:43:00',NULL,NULL,1,1,1),(22,200,'2024-10-03 11:40:00','2024-10-03 11:40:00',NULL,NULL,1,1,1),(23,207,'2024-10-10 18:00:00','2024-10-10 18:00:00',NULL,NULL,1,1,1),(24,208,'2024-10-03 19:14:00','2024-10-03 19:14:00',NULL,NULL,1,1,1),(25,211,'2024-11-14 17:04:00','2024-11-14 17:04:00',NULL,NULL,1,1,1),(26,221,'2024-11-14 10:36:00','2024-11-14 10:36:00',NULL,NULL,1,1,1),(27,227,'2024-11-01 11:09:00','2024-11-01 11:09:00',NULL,NULL,1,1,1),(28,213,'2024-11-14 17:03:00','2024-11-14 17:03:00',NULL,NULL,1,1,1),(29,232,'2024-11-13 10:00:00','2024-11-13 10:00:00',NULL,NULL,1,1,4),(30,233,'2024-11-13 10:03:00','2024-11-13 10:03:00',NULL,NULL,1,1,4),(31,239,'2024-11-08 16:18:00','2024-11-08 16:18:00',NULL,NULL,1,1,4);
/*!40000 ALTER TABLE `log_agendamento` ENABLE KEYS */;

--
-- Table structure for table `moradia`
--

DROP TABLE IF EXISTS `moradia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `moradia` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cliente_id` int NOT NULL,
  `endereco_id` int NOT NULL,
  `numero` varchar(8) DEFAULT NULL,
  `complemento` varchar(255) DEFAULT NULL,
  `ativo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`,`cliente_id`,`endereco_id`),
  KEY `fk_cliente_moradia` (`cliente_id`),
  KEY `fk_endereco_moradia` (`endereco_id`),
  CONSTRAINT `fk_cliente_moradia` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`),
  CONSTRAINT `fk_endereco_moradia` FOREIGN KEY (`endereco_id`) REFERENCES `endereco` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `moradia`
--
-- ORDER BY:  `id`,`cliente_id`,`endereco_id`

/*!40000 ALTER TABLE `moradia` DISABLE KEYS */;
INSERT INTO `moradia` VALUES (1,1,1,'50','Casa verde',1);
/*!40000 ALTER TABLE `moradia` ENABLE KEYS */;

--
-- Table structure for table `nome_medida`
--

DROP TABLE IF EXISTS `nome_medida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nome_medida` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `peca_id` int NOT NULL,
  `usuario_id` int DEFAULT NULL,
  `ativo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`,`peca_id`),
  KEY `fk_peca_nome_medida` (`peca_id`),
  KEY `fk_usuario_id` (`usuario_id`),
  CONSTRAINT `fk_peca_nome_medida` FOREIGN KEY (`peca_id`) REFERENCES `peca` (`id`),
  CONSTRAINT `fk_usuario_id` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nome_medida`
--
-- ORDER BY:  `id`,`peca_id`

/*!40000 ALTER TABLE `nome_medida` DISABLE KEYS */;
INSERT INTO `nome_medida` VALUES (7,'A. Cinta',100,1,1),(8,'A. Quadris',100,1,1),(9,'Comprimento',100,1,1),(10,'Torax',100,1,1),(11,'Cinta',100,1,1),(12,'Quadris',100,1,1),(13,'Ombro',100,1,1),(14,'C. Manga',100,1,1),(15,'Costas',100,1,1),(16,'L. Coz',300,1,1),(17,'A. Joelho',300,1,1),(18,'Comp. Lateral',300,1,1),(19,'Altura',300,1,1),(20,'C.E.P',300,1,1),(21,'Cinta',300,1,1),(22,'Quadris',300,1,1),(23,'Boca',300,1,1),(24,'A.Cinta',200,1,1),(25,'Comprimento',200,1,1),(26,'Torax',200,1,1),(27,'Cinta',200,1,1),(28,'Quadris',200,1,1),(29,'Degolo',200,1,1),(30,'C.Dianteiro',200,1,1),(31,'L. do Ombro',100,1,0),(32,'L. do Ombro',100,1,0),(33,'L. do Ombro',303,1,1),(34,'L. do Ombro',305,1,1);
/*!40000 ALTER TABLE `nome_medida` ENABLE KEYS */;

--
-- Table structure for table `nota`
--

DROP TABLE IF EXISTS `nota`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nota` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) DEFAULT NULL,
  `corpo` text,
  `cor` varchar(15) DEFAULT NULL,
  `data_criacao` datetime DEFAULT CURRENT_TIMESTAMP,
  `data_atualizacao` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario_id` int NOT NULL,
  `cliente_id` int DEFAULT NULL,
  `ativo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`,`usuario_id`),
  KEY `fk_usuario_nota` (`usuario_id`),
  KEY `fk_cliente_nota` (`cliente_id`),
  CONSTRAINT `fk_cliente_nota` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`),
  CONSTRAINT `fk_usuario_nota` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nota`
--
-- ORDER BY:  `id`,`usuario_id`

/*!40000 ALTER TABLE `nota` DISABLE KEYS */;
INSERT INTO `nota` VALUES (1,'Será que vale a pena?','Será que vale a pena? será que vale apena, será que vale apena..','#008000',NULL,NULL,1,2,0),(2,'Viver ou não viver, eis a questão.','Invariavelmente, nos confins da vida, essa questão me assombra, seria o universo uma força terrível que assola a humanidade ou na absurdidade da nossa insignificância que percebemos nossa própria vontade nesse mundo e tempo finito.','#008000',NULL,NULL,1,1,1),(3,'Viver ou não viver, eis a questão.','Invariavelmente, nos confins da vida, essa questão me assombra, seria o universo uma força terrível que assola a humanidade ou na absurdidade da nossa insignificância que percebemos nossa própria vontade nesse mundo e tempo finito.','#008000',NULL,NULL,1,1,1),(4,'Viver ou não viver, eis a questão.','Invariavelmente, nos confins da vida, essa questão me assombra, seria o universo uma força terrível que assola a humanidade ou na absurdidade da nossa insignificância que percebemos nossa própria vontade nesse mundo e tempo finito.','#008000',NULL,NULL,1,1,1),(5,'Viver ou não viver, eis a questão.','Invariavelmente, nos confins da vida, essa questão me assombra, seria o universo uma força terrível que assola a humanidade ou na absurdidade da nossa insignificância que percebemos nossa própria vontade nesse mundo e tempo finito.','#008000',NULL,NULL,1,2,1),(6,'Viver ou não viver, eis a questão.','Invariavelmente, nos confins da vida, essa questão me assombra, seria o universo uma força terrível que assola a humanidade ou na absurdidade da nossa insignificância que percebemos nossa própria vontade nesse mundo e tempo finito.','#008000',NULL,NULL,2,2,1);
/*!40000 ALTER TABLE `nota` ENABLE KEYS */;

--
-- Table structure for table `peca`
--

DROP TABLE IF EXISTS `peca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `peca` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `usuario_id` int NOT NULL,
  `ativo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`,`usuario_id`),
  KEY `fk_peca_usuario` (`usuario_id`),
  CONSTRAINT `fk_peca_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=310 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `peca`
--
-- ORDER BY:  `id`,`usuario_id`

/*!40000 ALTER TABLE `peca` DISABLE KEYS */;
INSERT INTO `peca` VALUES (100,'Paletó','Um paletó com base nas medidas padrões',1,1),(200,'Calça','Uma calça com base nas medidas padrões',1,1),(300,'Colete','Um colete com base nas medidas padrões',1,1),(301,'Casaco','Um casaco',1,0),(302,'Casaco','Um casaco',1,0),(303,'Casaco','Um casaco',1,0),(304,'Casaco','Um casaco',1,0),(305,'Casaco','Um casaco',1,1),(306,'Casaco','Um casaco',1,0),(307,'Casaco','Um casaco',1,0),(308,'Casaco','Um casaco',1,0),(309,'Chapéu','Um chapéu',1,0);
/*!40000 ALTER TABLE `peca` ENABLE KEYS */;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido` (
  `id` int NOT NULL AUTO_INCREMENT,
  `item_pedido_id` int DEFAULT NULL,
  `agendamento_id` int NOT NULL,
  `etapa_id` int NOT NULL,
  `usuario_id` int NOT NULL,
  `cliente_id` int NOT NULL,
  `ativo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`,`agendamento_id`,`etapa_id`,`usuario_id`,`cliente_id`),
  KEY `fk_agendamento_pedido` (`agendamento_id`),
  KEY `fk_etapa_pedido` (`etapa_id`),
  KEY `fk_cliente_pedido` (`cliente_id`),
  KEY `fk_usuario_pedido` (`usuario_id`),
  KEY `fk_item_pedido_id` (`item_pedido_id`),
  CONSTRAINT `fk_agendamento_pedido` FOREIGN KEY (`agendamento_id`) REFERENCES `agendamento` (`id`),
  CONSTRAINT `fk_cliente_pedido` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`),
  CONSTRAINT `fk_etapa_pedido` FOREIGN KEY (`etapa_id`) REFERENCES `etapa` (`id`),
  CONSTRAINT `fk_item_pedido_id` FOREIGN KEY (`item_pedido_id`) REFERENCES `item_pedido` (`id`),
  CONSTRAINT `fk_usuario_pedido` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=184 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--
-- ORDER BY:  `id`,`agendamento_id`,`etapa_id`,`usuario_id`,`cliente_id`

/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
INSERT INTO `pedido` VALUES (173,102,213,2,1,1,1),(174,103,213,2,1,1,1),(175,105,216,1,1,1,1),(176,105,243,1,1,4,1),(177,106,244,1,1,4,1),(178,106,245,1,1,4,1),(179,102,239,2,1,4,1),(180,106,246,1,1,4,1),(181,107,246,1,1,4,1),(182,106,247,1,1,4,1),(183,107,248,1,1,4,1);
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;

--
-- Table structure for table `pedido_grafico_view`
--

DROP TABLE IF EXISTS `pedido_grafico_view`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido_grafico_view` (
  `id` binary(16) NOT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `qtd_pedidos` int NOT NULL,
  `usuario_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido_grafico_view`
--
-- ORDER BY:  `id`

/*!40000 ALTER TABLE `pedido_grafico_view` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedido_grafico_view` ENABLE KEYS */;

--
-- Table structure for table `relatorio_cliente_response`
--

DROP TABLE IF EXISTS `relatorio_cliente_response`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `relatorio_cliente_response` (
  `id` int NOT NULL AUTO_INCREMENT,
  `quantidade_cliente_mes_atual` int DEFAULT NULL,
  `quantidade_cliente_mes_passado` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relatorio_cliente_response`
--
-- ORDER BY:  `id`

/*!40000 ALTER TABLE `relatorio_cliente_response` DISABLE KEYS */;
/*!40000 ALTER TABLE `relatorio_cliente_response` ENABLE KEYS */;

--
-- Table structure for table `tecido`
--

DROP TABLE IF EXISTS `tecido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tecido` (
  `id` int NOT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `usuario_id` int NOT NULL,
  `ativo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`,`usuario_id`),
  KEY `fk_tecido_usuario` (`usuario_id`),
  CONSTRAINT `fk_tecido_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tecido`
--
-- ORDER BY:  `id`,`usuario_id`

/*!40000 ALTER TABLE `tecido` DISABLE KEYS */;
INSERT INTO `tecido` VALUES (20000,'Algodão',1,1),(20001,'Lã',1,1),(20002,'Seda',1,1),(20003,'Linho',1,0),(20004,'Poliéster',1,0),(20005,'Viscose',1,0),(20006,'Novelo',1,1),(20007,'Algodão italiano',1,0),(20008,'Jeans',1,0),(20009,'Tweed',1,0);
/*!40000 ALTER TABLE `tecido` ENABLE KEYS */;

--
-- Table structure for table `telefone`
--

DROP TABLE IF EXISTS `telefone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `telefone` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipo_telefone_id` int NOT NULL,
  `cliente_id` int NOT NULL,
  `numero` varchar(255) DEFAULT NULL,
  `ativo` tinyint(1) DEFAULT '1',
  `usuario_id` int DEFAULT NULL,
  PRIMARY KEY (`id`,`tipo_telefone_id`,`cliente_id`),
  KEY `fk_tipo_telefone` (`tipo_telefone_id`),
  KEY `fk_dono_telefone` (`cliente_id`),
  KEY `FK92q33nmw94rylnpis5mgcy3v` (`usuario_id`),
  CONSTRAINT `FK92q33nmw94rylnpis5mgcy3v` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`),
  CONSTRAINT `fk_dono_telefone` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`),
  CONSTRAINT `fk_tipo_telefone` FOREIGN KEY (`tipo_telefone_id`) REFERENCES `tipo_telefone` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `telefone`
--
-- ORDER BY:  `id`,`tipo_telefone_id`,`cliente_id`

/*!40000 ALTER TABLE `telefone` DISABLE KEYS */;
INSERT INTO `telefone` VALUES (1,1,1,'11938591934',1,1),(2,1,1,'33491839183',1,1),(3,1,4,'11934859181',1,1),(4,1,3,'11938591934',1,1);
/*!40000 ALTER TABLE `telefone` ENABLE KEYS */;

--
-- Table structure for table `tipo_telefone`
--

DROP TABLE IF EXISTS `tipo_telefone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_telefone` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `digitos` int NOT NULL,
  `usuario_id` int NOT NULL,
  `ativo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`,`usuario_id`),
  KEY `fk_tipo_telefone_usuario` (`usuario_id`),
  CONSTRAINT `fk_tipo_telefone_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_telefone`
--
-- ORDER BY:  `id`,`usuario_id`

/*!40000 ALTER TABLE `tipo_telefone` DISABLE KEYS */;
INSERT INTO `tipo_telefone` VALUES (1,'Telefone do japão',15,1,1);
/*!40000 ALTER TABLE `tipo_telefone` ENABLE KEYS */;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `usuario` varchar(45) NOT NULL,
  `senha` varchar(45) NOT NULL,
  `autenticado` tinyint(1) DEFAULT NULL,
  `ativo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--
-- ORDER BY:  `id`

/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'Jonas','jonas123',1,1),(2,'askyu','askyu123',1,1);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;

--
-- Table structure for table `valor_medida`
--

DROP TABLE IF EXISTS `valor_medida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `valor_medida` (
  `id` int NOT NULL AUTO_INCREMENT,
  `valor` float DEFAULT NULL,
  `item_pedido_id` int NOT NULL,
  `nome_medida_id` int NOT NULL,
  `cliente_id` int NOT NULL,
  `usuario_id` int NOT NULL,
  `peca_id` int NOT NULL,
  PRIMARY KEY (`id`,`nome_medida_id`,`peca_id`,`cliente_id`,`item_pedido_id`,`usuario_id`),
  KEY `fk_item_pedido_valor_medida` (`item_pedido_id`),
  KEY `fk_nome_medida_valor_medida` (`nome_medida_id`),
  KEY `fk_cliente_valor_medida` (`cliente_id`),
  KEY `fk_usuario_valor_medida` (`usuario_id`),
  KEY `fk_peca_id_valor_medida` (`peca_id`),
  CONSTRAINT `fk_cliente_valor_medida` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`),
  CONSTRAINT `fk_item_pedido_valor_medida` FOREIGN KEY (`item_pedido_id`) REFERENCES `item_pedido` (`id`),
  CONSTRAINT `fk_nome_medida_valor_medida` FOREIGN KEY (`nome_medida_id`) REFERENCES `nome_medida` (`id`),
  CONSTRAINT `fk_peca_id_valor_medida` FOREIGN KEY (`peca_id`) REFERENCES `peca` (`id`),
  CONSTRAINT `fk_usuario_valor_medida` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=324 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `valor_medida`
--
-- ORDER BY:  `id`,`nome_medida_id`,`peca_id`,`cliente_id`,`item_pedido_id`,`usuario_id`

/*!40000 ALTER TABLE `valor_medida` DISABLE KEYS */;
INSERT INTO `valor_medida` VALUES (274,24,102,7,4,1,100),(275,25,102,8,4,1,100),(276,25,102,9,4,1,100),(277,25,102,10,4,1,100),(278,25,102,11,4,1,100),(279,25,102,12,4,1,100),(280,25,102,13,4,1,100),(281,25,102,14,4,1,100),(282,25,102,15,4,1,100),(283,400,103,24,8,1,200),(284,30,103,25,8,1,200),(285,30,103,26,8,1,200),(286,30,103,27,8,1,200),(287,30,103,28,8,1,200),(288,30,103,29,8,1,200),(289,30,103,30,8,1,200),(290,24,104,24,4,1,200),(291,25,104,25,4,1,200),(292,25,104,26,4,1,200),(293,25,104,27,4,1,200),(294,25,104,28,4,1,200),(295,25,104,29,4,1,200),(296,25,104,30,4,1,200),(297,25,105,7,4,1,100),(298,24,105,8,4,1,100),(299,23,105,9,4,1,100),(300,24,105,10,4,1,100),(301,25,105,11,4,1,100),(302,12,105,12,4,1,100),(303,24,105,13,4,1,100),(304,25,105,14,4,1,100),(305,12,105,15,4,1,100),(306,24,106,7,8,1,100),(307,24,106,8,8,1,100),(308,24,106,9,8,1,100),(309,24,106,10,8,1,100),(310,24,106,11,8,1,100),(311,24,106,12,8,1,100),(312,24,106,13,8,1,100),(313,24,106,14,8,1,100),(314,25,106,15,8,1,100),(315,50,107,7,10,1,100),(316,50,107,8,10,1,100),(317,50,107,9,10,1,100),(318,50,107,10,10,1,100),(319,50,107,11,10,1,100),(320,50,107,12,10,1,100),(321,50,107,13,10,1,100),(322,50,107,14,10,1,100),(323,50,107,15,10,1,100);
/*!40000 ALTER TABLE `valor_medida` ENABLE KEYS */;

--
-- Temporary view structure for view `vw_agendamento_cliente_dependente`
--

DROP TABLE IF EXISTS `vw_agendamento_cliente_dependente`;
/*!50001 DROP VIEW IF EXISTS `vw_agendamento_cliente_dependente`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_agendamento_cliente_dependente` AS SELECT 
 1 AS `id`,
 1 AS `data_inicio`,
 1 AS `data_fim`,
 1 AS `localizacao`,
 1 AS `descricao`,
 1 AS `usuario_id`,
 1 AS `etapa_id`,
 1 AS `endereco_id`,
 1 AS `telefone_id`,
 1 AS `ativo`,
 1 AS `nome`,
 1 AS `sobrenome`,
 1 AS `email`,
 1 AS `responsavel_id`,
 1 AS `clienteativo`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_card_etapa`
--

DROP TABLE IF EXISTS `vw_card_etapa`;
/*!50001 DROP VIEW IF EXISTS `vw_card_etapa`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_card_etapa` AS SELECT 
 1 AS `id`,
 1 AS `data_inicio`,
 1 AS `data_fim`,
 1 AS `nome`,
 1 AS `sobrenome`,
 1 AS `etapa_id`,
 1 AS `usuario_id`,
 1 AS `ativo`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_cliente`
--

DROP TABLE IF EXISTS `vw_cliente`;
/*!50001 DROP VIEW IF EXISTS `vw_cliente`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_cliente` AS SELECT 
 1 AS `usuario_id`,
 1 AS `id`,
 1 AS `nome`,
 1 AS `sobrenome`,
 1 AS `email`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_pedido_agendamento_peca`
--

DROP TABLE IF EXISTS `vw_pedido_agendamento_peca`;
/*!50001 DROP VIEW IF EXISTS `vw_pedido_agendamento_peca`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_pedido_agendamento_peca` AS SELECT 
 1 AS `id`,
 1 AS `data_inicio`,
 1 AS `data_fim`,
 1 AS `usuario_id`,
 1 AS `ativo`,
 1 AS `nome`,
 1 AS `sobrenome`,
 1 AS `pecanome`,
 1 AS `tecidonome`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_rank_cliente`
--

DROP TABLE IF EXISTS `vw_rank_cliente`;
/*!50001 DROP VIEW IF EXISTS `vw_rank_cliente`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_rank_cliente` AS SELECT 
 1 AS `id`,
 1 AS `nome`,
 1 AS `sobrenome`,
 1 AS `qtd_pedidos`,
 1 AS `usuario_id`,
 1 AS `data_inicio`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_rank_tecido`
--

DROP TABLE IF EXISTS `vw_rank_tecido`;
/*!50001 DROP VIEW IF EXISTS `vw_rank_tecido`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_rank_tecido` AS SELECT 
 1 AS `id`,
 1 AS `nome`,
 1 AS `qtd_tecidos`,
 1 AS `usuario_id`,
 1 AS `data_inicio`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_total_etapa`
--

DROP TABLE IF EXISTS `vw_total_etapa`;
/*!50001 DROP VIEW IF EXISTS `vw_total_etapa`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_total_etapa` AS SELECT 
 1 AS `qtd_agendamento`,
 1 AS `etapa_id`,
 1 AS `usuario_id`,
 1 AS `ativo`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'askyu'
--

--
-- Dumping routines for database 'askyu'
--
/*!50003 DROP PROCEDURE IF EXISTS `contar_pecas_vendidas_por_usuario_ano` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`askyu`@`%` PROCEDURE `contar_pecas_vendidas_por_usuario_ano`(
    IN usuario_id_input INT,
    IN ano_input INT
)
BEGIN
    -- Consulta para contar quantas peças foram vendidas neste ano, incluindo peças com 0 vendas
    SELECT p.nome AS nomePeca, 
           COALESCE(COUNT(CASE WHEN YEAR(a.data_inicio) = ano_input THEN ip.id END), 0) AS qtdVendida
    FROM peca p  -- Todas as peças
    LEFT JOIN item_pedido ip ON p.id = ip.peca_id  -- Join opcional com item_pedido
    LEFT JOIN pedido ped ON ip.id = ped.item_pedido_id  -- Join opcional com pedido
    LEFT JOIN agendamento a ON ped.agendamento_id = a.id  -- Join opcional com agendamento
    LEFT JOIN usuario u ON u.id = a.usuario_id  -- Join opcional com usuário
    WHERE (u.id = usuario_id_input OR u.id IS NULL)  -- Filtrar por usuário ou incluir nulos
    GROUP BY p.nome  -- Agrupar por nome da peça
    ORDER BY qtdVendida DESC;  -- Ordenar pela quantidade vendida, em ordem decrescente
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getComparacaoClientes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`askyu`@`%` PROCEDURE `getComparacaoClientes`(
IN usuario_id_input INT,
IN ano_escolhido INT,
IN mes_escolhido INT,
IN periodo INT,
OUT quantidade_cliente_passado INT,
OUT quantidade_cliente_atual INT
)
BEGIN

IF periodo = 1 THEN
    SET periodo = 2;
ELSE 
    SET periodo = periodo - 1;
END IF;

IF mes_escolhido = MONTH(now()) THEN
    SET @data_mes_escolhido = now(); 
    SET @data_mes_passado = DATE_SUB(now(), INTERVAL ano_escolhido YEAR);
    SET @data_periodo_atual = DATE_SUB(@data_mes_escolhido, INTERVAL periodo MONTH);
	SET @data_periodo_passado = DATE_SUB(@data_mes_passado, INTERVAL periodo MONTH);
ELSE
    SET @data_mes_escolhido = LAST_DAY(DATE(CONCAT(year(now()), '-', mes_escolhido, '-1')));
    SET @data_mes_passado = DATE_SUB(@data_mes_escolhido, INTERVAL ano_escolhido YEAR);
    SET @data_periodo_atual = DATE_SUB(LAST_DAY(@data_mes_escolhido), INTERVAL periodo MONTH);
	SET @data_periodo_passado = DATE_SUB(LAST_DAY(@data_mes_passado), INTERVAL periodo MONTH);
END IF;

SET quantidade_cliente_atual := (SELECT COUNT(*) 
                                 FROM cliente
                                 WHERE data_criacao >= @data_periodo_atual
                                 AND data_criacao <= TIMESTAMP(@data_mes_escolhido, '23:59:59') 
                                 AND usuario_id = usuario_id_input);


SET quantidade_cliente_passado := (SELECT COUNT(*) 
                                   FROM cliente
                                   WHERE data_criacao >= @data_periodo_passado
                                   AND data_criacao <= TIMESTAMP(@data_mes_passado, '23:59:59') 
                                   AND usuario_id = usuario_id_input);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getComparacaoPedidos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`askyu`@`%` PROCEDURE `getComparacaoPedidos`(
IN usuario_id_input INT,
IN ano_escolhido INT,
IN mes_escolhido INT,
IN periodo INT,
OUT quantidade_pedido_passado INT,
OUT quantidade_pedido_atual INT
)
BEGIN

IF periodo = 1 THEN
    SET periodo = 2;
ELSE 
    SET periodo = periodo - 1;
END IF;

IF mes_escolhido = MONTH(now()) THEN
    SET @data_mes_escolhido = now(); 
    SET @data_mes_passado = DATE_SUB(now(), INTERVAL ano_escolhido YEAR);
    SET @data_periodo_atual = DATE_SUB(@data_mes_escolhido, INTERVAL periodo MONTH);
	SET @data_periodo_passado = DATE_SUB(@data_mes_passado, INTERVAL periodo MONTH);
ELSE
    SET @data_mes_escolhido = LAST_DAY(DATE(CONCAT(year(now()), '-', mes_escolhido, '-1')));
    SET @data_mes_passado = DATE_SUB(@data_mes_escolhido, INTERVAL ano_escolhido YEAR);
    SET @data_periodo_atual = DATE_SUB(LAST_DAY(@data_mes_escolhido), INTERVAL periodo MONTH);
	SET @data_periodo_passado = DATE_SUB(LAST_DAY(@data_mes_passado), INTERVAL periodo MONTH);
END IF;

SET quantidade_pedido_atual:= (select count(*) from pedido
								   join agendamento on pedido.agendamento_id = agendamento.id
								   where data_inicio >= @data_periodo_atual
                                   AND data_inicio <= TIMESTAMP(@data_mes_escolhido, '23:59:59')
								   AND pedido.usuario_id = usuario_id_input);


SET quantidade_pedido_passado:= (select count(*) from pedido
									 join agendamento on pedido.agendamento_id = agendamento.id
									 where data_inicio >= @data_periodo_passado 
                                     AND data_inicio <= TIMESTAMP(@data_mes_passado, '23:59:59')
                                     AND pedido.usuario_id = usuario_id_input);
                                                                    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `listar_pedidos_ultimos_12_meses` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`askyu`@`%` PROCEDURE `listar_pedidos_ultimos_12_meses`(IN usuario_id_input INT, IN ano_input INT)
BEGIN
    -- CTE para gerar os últimos 12 meses
    WITH ultimos_meses AS (
        SELECT DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL n MONTH), '%M') AS mes_extenso, 
               MONTH(DATE_SUB(CURDATE(), INTERVAL n MONTH)) AS mes_num,
               YEAR(DATE_SUB(CURDATE(), INTERVAL n MONTH)) AS ano
        FROM (SELECT 0 AS n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL 
                     SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL 
                     SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL 
                     SELECT 9 UNION ALL SELECT 10 UNION ALL SELECT 11) AS nums
    )
    -- Seleciona todos os meses, incluindo aqueles sem pedidos
    SELECT um.mes_extenso AS mes, 
           COALESCE(COUNT(p.id), 0) AS qtdPedido
    FROM ultimos_meses um
    LEFT JOIN agendamento a ON MONTH(a.data_inicio) = um.mes_num AND YEAR(a.data_inicio) = um.ano
    LEFT JOIN pedido p ON a.id = p.agendamento_id AND p.usuario_id = usuario_id_input AND YEAR(a.data_inicio) = ano_input
    GROUP BY um.mes_extenso, um.mes_num, um.ano  
    ORDER BY um.ano, um.mes_num;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_teste` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`askyu`@`%` PROCEDURE `sp_teste`(
IN usuario_id_input INT,
IN mes_escolhido INT,
IN periodo INT,
OUT quantidade_cliente_passado INT,
OUT quantidade_cliente_atual INT
)
BEGIN

	IF periodo = 1 THEN
	   SET periodo = 2;
	ELSE 
	   SET periodo = periodo - 1;
	END IF;

	IF mes_escolhido = MONTH(now()) THEN
		SET @data_mes_escolhido =  now(); 
        SET @data_mes_passado = DATE_SUB(DATE_SUB(now(), INTERVAL periodo MONTH), INTERVAL 1 YEAR);
	ELSE
		SET @data_mes_escolhido = LAST_DAY(DATE(CONCAT(year(now()), '-', mes_escolhido, '-1', '00:00:00')));
        SET @data_mes_passado = DATE_SUB(LAST_DAY(DATE_SUB(now(), INTERVAL periodo - 1 MONTH)), INTERVAL 1 YEAR);
	END IF;
    
 SET quantidade_cliente_atual:= (select count(*) from cliente
 where data_criacao >= @data_mes_escolhido AND data_criacao <= addtime(now(), '23:59:59')
 AND usuario_id = usuario_id_input);

 SET quantidade_cliente_passado:= (select count(*) from cliente
 where data_criacao >= @data_mes_passado AND 
 data_criacao <= addtime(@data_mes_passado, '23:59:59')
 AND usuario_id = usuario_id_input);
  
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_teste2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`askyu`@`%` PROCEDURE `sp_teste2`(
IN usuario_id_input INT,
IN mes_escolhido INT,
IN periodo INT,
OUT quantidade_cliente_passado INT,
OUT quantidade_cliente_atual INT
)
BEGIN

	-- Ajuste do período
IF periodo = 1 THEN
    SET periodo = 2;
ELSE 
    SET periodo = periodo - 1;
END IF;

-- Verifica se o mês escolhido é o mês atual
IF mes_escolhido = MONTH(now()) THEN
    -- Se for o mês atual, usa a data atual
    SET @data_mes_escolhido = now(); 
    SET @data_mes_passado = DATE_SUB(DATE_SUB(now(), INTERVAL periodo MONTH), INTERVAL 1 YEAR);
ELSE
    -- Se não for o mês atual, calcula a data do último dia do mês escolhido
    -- Corrigido o uso de '00:00:00', agora não é mais necessário concatenar
    SET @data_mes_escolhido = LAST_DAY(DATE(CONCAT(year(now()), '-', mes_escolhido, '-1')));
    SET @data_mes_passado = DATE_SUB(LAST_DAY(DATE_SUB(now(), INTERVAL periodo - 1 MONTH)), INTERVAL 1 YEAR);
END IF;

-- Quantidade de clientes no período atual
SET quantidade_cliente_atual := (SELECT COUNT(*) 
                                 FROM cliente
                                 WHERE data_criacao >= @data_mes_escolhido 
                                 AND data_criacao <= TIMESTAMP(now(), '23:59:59')  -- Usa TIMESTAMP para ajustar o horário final do dia
                                 AND usuario_id = usuario_id_input);

-- Quantidade de clientes no período passado
SET quantidade_cliente_passado := (SELECT COUNT(*) 
                                   FROM cliente
                                   WHERE data_criacao >= @data_mes_passado 
                                   AND data_criacao <= TIMESTAMP(@data_mes_passado, '23:59:59')  -- Mesmo ajuste para o período passado
                                   AND usuario_id = usuario_id_input);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vw_agendamento_cliente_dependente`
--

/*!50001 DROP VIEW IF EXISTS `vw_agendamento_cliente_dependente`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`askyu`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_agendamento_cliente_dependente` AS select `agendamento`.`id` AS `id`,`agendamento`.`data_inicio` AS `data_inicio`,`agendamento`.`data_fim` AS `data_fim`,`agendamento`.`localizacao` AS `localizacao`,`agendamento`.`descricao` AS `descricao`,`agendamento`.`usuario_id` AS `usuario_id`,`agendamento`.`etapa_id` AS `etapa_id`,`agendamento`.`endereco_id` AS `endereco_id`,`agendamento`.`telefone_id` AS `telefone_id`,`agendamento`.`ativo` AS `ativo`,`cliente`.`nome` AS `nome`,`cliente`.`sobrenome` AS `sobrenome`,`cliente`.`email` AS `email`,`cliente`.`responsavel_id` AS `responsavel_id`,`cliente`.`ativo` AS `clienteativo` from ((`agendamento` join `cliente` on((`cliente`.`id` = `agendamento`.`cliente_id`))) join `cliente` `responsavel` on((`responsavel`.`id` = `cliente`.`responsavel_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_card_etapa`
--

/*!50001 DROP VIEW IF EXISTS `vw_card_etapa`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`askyu`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_card_etapa` AS select `agendamento`.`id` AS `id`,`agendamento`.`data_inicio` AS `data_inicio`,`agendamento`.`data_fim` AS `data_fim`,`cliente`.`nome` AS `nome`,`cliente`.`sobrenome` AS `sobrenome`,`agendamento`.`etapa_id` AS `etapa_id`,`agendamento`.`usuario_id` AS `usuario_id`,`agendamento`.`ativo` AS `ativo` from ((`agendamento` join `etapa` on((`agendamento`.`etapa_id` = `etapa`.`id`))) join `cliente` on((`agendamento`.`cliente_id` = `cliente`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_cliente`
--

/*!50001 DROP VIEW IF EXISTS `vw_cliente`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`askyu`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_cliente` AS select `cliente`.`usuario_id` AS `usuario_id`,`cliente`.`id` AS `id`,`cliente`.`nome` AS `nome`,`cliente`.`sobrenome` AS `sobrenome`,`cliente`.`email` AS `email` from `cliente` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_pedido_agendamento_peca`
--

/*!50001 DROP VIEW IF EXISTS `vw_pedido_agendamento_peca`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`askyu`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_pedido_agendamento_peca` AS select distinct `agendamento`.`id` AS `id`,`agendamento`.`data_inicio` AS `data_inicio`,`agendamento`.`data_fim` AS `data_fim`,`agendamento`.`usuario_id` AS `usuario_id`,`agendamento`.`ativo` AS `ativo`,`cliente`.`nome` AS `nome`,`cliente`.`sobrenome` AS `sobrenome`,`peca`.`nome` AS `pecanome`,`tecido`.`nome` AS `tecidonome` from ((((((`pedido` join `item_pedido` on((`item_pedido`.`id` = `pedido`.`item_pedido_id`))) join `peca` on((`peca`.`id` = `item_pedido`.`peca_id`))) join `agendamento` on((`agendamento`.`id` = `pedido`.`agendamento_id`))) join `cliente` on((`cliente`.`id` = `agendamento`.`cliente_id`))) join `colecao_tecido` on((`colecao_tecido`.`item_pedido_id` = `item_pedido`.`id`))) join `tecido` on((`tecido`.`id` = `colecao_tecido`.`tecido_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_rank_cliente`
--

/*!50001 DROP VIEW IF EXISTS `vw_rank_cliente`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`askyu`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_rank_cliente` AS select uuid() AS `id`,`cliente`.`nome` AS `nome`,`cliente`.`sobrenome` AS `sobrenome`,count(0) AS `qtd_pedidos`,`pedido`.`usuario_id` AS `usuario_id`, MONTH(`agendamento`.`data_inicio`) AS `data_inicio` from ((`pedido` join `cliente` on((`cliente`.`id` = `pedido`.`cliente_id`))) join `agendamento` on((`agendamento`.`id` = `pedido`.`agendamento_id`))) group by `cliente`.`nome`,`cliente`.`sobrenome`,`pedido`.`usuario_id`, MONTH(`agendamento`.`data_inicio`) order by `qtd_pedidos` desc,`qtd_pedidos` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_rank_tecido`
--

/*!50001 DROP VIEW IF EXISTS `vw_rank_tecido`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`askyu`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_rank_tecido` AS select distinct uuid() AS `id`,`tecido`.`nome` AS `nome`,count(0) AS `qtd_tecidos`,`pedido`.`usuario_id` AS `usuario_id`,YEAR(`agendamento`.`data_inicio`) AS `data_inicio` 
	from (((`pedido` join `colecao_tecido` on((`colecao_tecido`.`item_pedido_id` = `pedido`.`item_pedido_id`))) 
		join `tecido` on((`tecido`.`id` = `colecao_tecido`.`tecido_id`))) 
		join `agendamento` on((`agendamento`.`id` = `pedido`.`agendamento_id`))) 
			group by `colecao_tecido`.`tecido_id`,`tecido`.`nome`,`pedido`.`usuario_id`,YEAR(`agendamento`.`data_inicio`) 
				order by `qtd_tecidos` 
					desc,`tecido`.`nome`,`pedido`.`usuario_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_total_etapa`
--

/*!50001 DROP VIEW IF EXISTS `vw_total_etapa`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`askyu`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_total_etapa` AS select count(0) AS `qtd_agendamento`,`etapa`.`id` AS `etapa_id`,`etapa`.`usuario_id` AS `usuario_id`,`etapa`.`ativo` AS `ativo` from (`agendamento` join `etapa` on((`agendamento`.`etapa_id` = `etapa`.`id`))) group by `etapa`.`id`,`etapa`.`nome`,`etapa`.`usuario_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-02 16:40:37
SET FOREIGN_KEY_CHECKS = 1;
select * from cliente;
select * from item_pedido;

select * from telefone;

update telefone set cliente_id = 4 where id = 2;