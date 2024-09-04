-- Criação do banco de dados e uso
CREATE DATABASE IF NOT EXISTS `lab_03` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE=utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `lab_03`;

-- Configurações de ambiente
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

-- Criação e carga da tabela `departamento`
DROP TABLE IF EXISTS `departamento`;
CREATE TABLE `departamento` (
  `ID_depto` int NOT NULL AUTO_INCREMENT,
  `sigla` varchar(5) NOT NULL,
  `nome` varchar(50) NOT NULL,
  PRIMARY KEY (`ID_depto`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `departamento` WRITE;
INSERT INTO `departamento` VALUES 
(100,'RH','Recursos Humanos'),
(101,'CTB','Contabilidade'),
(102,'VND','Vendas'),
(103,'ETQ','Estoque'),
(104,'ATM','Atendimento'),
(105,'CNG','Carteira de Negócios');
UNLOCK TABLES;

-- Criação e carga da tabela `empregado`
DROP TABLE IF EXISTS `empregado`;
CREATE TABLE `empregado` (
  `ID_emp` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `dt_nascimento` date NOT NULL,
  `ID_depto` int NOT NULL,
  `Salario` float DEFAULT NULL,
  PRIMARY KEY (`ID_emp`),
  KEY `FK_Empregado_Departamento` (`ID_depto`),
  CONSTRAINT `FK_Empregado_Departamento` FOREIGN KEY (`ID_depto`) REFERENCES `departamento` (`ID_depto`)
) ENGINE=InnoDB AUTO_INCREMENT=1008 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `empregado` WRITE;
INSERT INTO `empregado` VALUES 
(1000,'José da Silva','2000-12-20',100,2000),
(1001,'Maria das Flores','1995-05-14',101,2500),
(1002,'Antônio Lopes','1998-04-18',101,1500),
(1003,'Catarina Santos','2002-08-05',102,1500),
(1004,'Olívia Andrade','1993-07-19',102,2200),
(1005,'Arthur Coimbra','1980-10-06',103,2900),
(1006,'Jonas Alves','1990-12-13',103,2080),
(1007,'Amélia Silveira','1980-05-06',100,3005);
UNLOCK TABLES;

-- Criação e carga da tabela `empskill`
DROP TABLE IF EXISTS `empskill`;
CREATE TABLE `empskill` (
  `ID_emp` int NOT NULL,
  `ID_skill` int NOT NULL,
  `nivel` varchar(20) NOT NULL,
  PRIMARY KEY (`ID_emp`,`ID_skill`),
  KEY `FK_EmpSkill_Skill` (`ID_skill`),
  CONSTRAINT `FK_EmpSkill_Empregado` FOREIGN KEY (`ID_emp`) REFERENCES `empregado` (`ID_emp`),
  CONSTRAINT `FK_EmpSkill_Skill` FOREIGN KEY (`ID_skill`) REFERENCES `skill` (`ID_skill`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `empskill` WRITE;
INSERT INTO `empskill` VALUES 
(1000,1,'Básico'),
(1000,2,'Intermediário'),
(1000,3,'Básico'),
(1002,4,'Avançado'),
(1002,5,'Básico'),
(1004,4,'Intermediário'),
(1004,5,'Básico');
UNLOCK TABLES;

-- Criação e carga da tabela `skill`
DROP TABLE IF EXISTS `skill`;
CREATE TABLE `skill` (
  `ID_skill` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `descricao` text NOT NULL,
  PRIMARY KEY (`ID_skill`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `skill` WRITE;
INSERT INTO `skill` VALUES 
(1,'MS Word','Conhece o ambiente do editor de texto e sabe criar, salvar e modificar documentos.'),
(2,'MS Excel','Conhece o ambiente da planilha eletrônica e sabe criar, salvar e modificar documentos.'),
(3,'MS Power Point','Conhece o ambiente do editor de apresentações e sabe criar, salvar e modificar documentos.'),
(4,'Python','Conhece linguagem de programação Python e sabe criar, salvar e modificar programas na linguagem.'),
(5,'Java','Conhece linguagem de programação Java e sabe criar, salvar e modificar programas na linguagem.'),
(6,'HTML','Conhece linguagem de marcação HTML e sabe criar, salvar e modificar documentos HTML.');
UNLOCK TABLES;

-- Consultas diversas
-- 1. Seleciona nome, data de nascimento formatada e calcula idade
SELECT
    nome, 
    dt_nascimento, 
    DATE_FORMAT(dt_nascimento, '%d/%m/%Y') AS 'Aniversário',
    (
        YEAR(NOW()) - YEAR(dt_nascimento) - 
        CASE 
            WHEN (MONTH(NOW()) * 100 + DAY(NOW())) > (MONTH(dt_nascimento) * 100 + DAY(dt_nascimento)) 
            THEN 0 
            ELSE 1 
        END 
    ) AS Idade 
FROM Empregado;

-- 2. Produto Cartesiano entre Empregado e Departamento
SELECT *
FROM Empregado AS E, Departamento AS D 
WHERE E.ID_depto = D.ID_depto 
ORDER BY E.nome;

-- 3. INNER JOIN entre Empregado e Departamento
SELECT *
FROM Empregado AS E
INNER JOIN Departamento AS D 
ON E.ID_depto = D.ID_depto 
ORDER BY E.nome;

-- 4. Produto Cartesiano entre Empregado, EmpSkill e Skill
SELECT E.nome AS Empregado, ES.nivel, S.nome
FROM Empregado AS E, EmpSkill AS ES, Skill AS S 
WHERE E.ID_emp = ES.ID_emp AND 
      S.ID_skill = ES.ID_skill
ORDER BY S.nome, E.nome;

-- 5. INNER JOIN entre Empregado, EmpSkill e Skill
SELECT E.nome AS Empregado, ES.nivel, S.nome
FROM Empregado AS E
INNER JOIN EmpSkill AS ES ON E.ID_emp = ES.ID_emp 
INNER JOIN Skill AS S ON S.ID_skill = ES.ID_skill 
ORDER BY S.nome, E.nome;

-- 6. LEFT OUTER JOIN entre Empregado, EmpSkill e Skill
SELECT E.nome AS Empregado, ES.nivel, S.nome
FROM Empregado AS E
LEFT OUTER JOIN EmpSkill AS ES ON E.ID_emp = ES.ID_emp 
LEFT OUTER JOIN Skill AS S ON S.ID_skill = ES.ID_skill 
ORDER BY S.nome, E.nome;

-- 7. RIGHT OUTER JOIN entre Empregado, EmpSkill e Skill
SELECT E.nome AS Empregado, ES.nivel, S.nome
FROM Empregado AS E
RIGHT OUTER JOIN EmpSkill AS ES ON E.ID_emp = ES.ID_emp 
RIGHT OUTER JOIN Skill AS S ON S.ID_skill = ES.ID_skill 
ORDER BY S.nome, E.nome;

-- 8. UNION entre LEFT OUTER JOIN e RIGHT OUTER JOIN com ordenação por nível
(
    SELECT E.nome AS Empregado, ES.nivel, S.nome
    FROM Empregado AS E
    LEFT OUTER JOIN EmpSkill AS ES ON E.ID_emp = ES.ID_emp 
    LEFT OUTER JOIN Skill AS S ON S.ID_skill = ES.ID_skill 
)
UNION
(
    SELECT E.nome AS Empregado, ES.nivel, S.nome
    FROM Empregado AS E
    RIGHT OUTER JOIN EmpSkill AS ES ON E.ID_emp = ES.ID_emp 
    RIGHT OUTER JOIN Skill AS S ON S.ID_skill = ES.ID_skill 
)
ORDER BY nivel; 

-- 9. Seleção de empregados por departamento específico
-- Usando JOIN
SELECT E.ID_emp, E.nome
FROM Empregado AS E 
JOIN Departamento AS D ON (E.ID_depto = D.ID_depto)
WHERE D.sigla = 'CTB' OR D.sigla ='VND'
ORDER BY E.nome;

-- Alternativa utilizando subconsulta
SELECT E.ID_emp, E.nome
FROM Empregado AS E 
WHERE E.ID_depto IN
(
    SELECT D.ID_depto
    FROM Departamento AS D
    WHERE D.sigla = 'CTB' OR D.sigla ='VND'
)
ORDER BY E.nome;

-- 10. Seleciona empregados que não estão nos departamentos 'CTB' ou 'VND' usando NOT IN
SELECT E.ID_depto, E.ID_emp, E.nome
FROM Empregado AS E 
WHERE E.ID_depto NOT IN
(
    SELECT D.ID_depto
    FROM Departamento AS D
    WHERE D.sigla = 'CTB' OR D.sigla = 'VND'
)
ORDER BY E.nome;

-- Usando <> ALL
SELECT E.ID_depto, E.ID_emp, E.nome
FROM Empregado AS E 
WHERE E.ID_depto <> ALL
(
    SELECT D.ID_depto
    FROM Departamento AS D
    WHERE D.sigla = 'CTB' OR D.sigla = 'VND'
)
ORDER BY E.nome;

-- 11. Seleciona empregados nascidos a partir de 1998 que estão nos departamentos 'CTB' ou 'VND'
SELECT E.ID_depto, E.ID_emp, E.nome, E.dt_nascimento
FROM Empregado AS E 
WHERE YEAR(E.dt_nascimento) >= 1998 AND
 E.ID_depto IN
(
    SELECT D.ID_depto
    FROM Departamento AS D
    WHERE D.sigla = 'CTB' OR D.sigla ='VND'
)
ORDER BY E.nome;

-- Criação da VIEW CompetenciasEmpregados
-- Apaga a VIEW se ela já existir
DROP VIEW IF EXISTS CompetenciasEmpregados;
CREATE VIEW CompetenciasEmpregados AS
    (SELECT 
        D.sigla AS Depto,
        S.nome AS Competencia,
        ES.nivel AS Nivel,
        E.nome AS Empregado
    FROM
        Empregado AS E
            INNER JOIN
        EmpSkill AS ES ON E.ID_emp = ES.ID_emp
            INNER JOIN
        Skill AS S ON S.ID_skill = ES.ID_skill
            INNER JOIN
        Departamento AS D ON D.ID_depto = E.ID_depto);

-- Consulta da VIEW CompetenciasEmpregados
SELECT *
FROM CompetenciasEmpregados
ORDER BY Depto, Competencia, Empregado; 

-- 12. Consultas de agregação de salário
-- Consulta 1: Agregação de salário com formato padrão
SELECT
    COUNT(*) AS 'Número de Empregados',
    AVG(salario) AS 'Salário Médio', 
    MIN(salario) AS 'Menor Salário',
    MAX(salario) AS 'Maior Salário',
    SUM(salario) AS 'Total Salários'
FROM Empregado;

-- Consulta 2: Agregação de salário com formato decimal ajustado
SELECT
    COUNT(*) AS 'Número de Empregados',
    CONVERT(AVG(salario), DECIMAL(8,2)) AS 'Salário Médio', 
    MIN(salario) AS 'Menor Salário',
    MAX(salario) AS 'Maior Salário',
    SUM(salario) AS 'Total Salários'
FROM Empregado;
