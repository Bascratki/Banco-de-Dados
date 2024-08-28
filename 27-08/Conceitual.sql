DROP DATABASE IF EXISTS TSTBSI_TB;

CREATE DATABASE TSTBSI_TB;

USE TSTBSI_TB;

/* Lógico_1: */

CREATE TABLE Colaborador (
    Matricula INT PRIMARY KEY,
    Nome VARCHAR(50),
    CPF VARCHAR(20),
    Logradouro VARCHAR(100),
    Numero INT,
    CEP VARCHAR(20),
    Dt_Nascimento DATE
);

SELECT * FROM Colaborador;
INSERT INTO Colaborador (Matricula, Nome, CPF,Logradouro, Numero, CEP, Dt_Nascimento)
VALUES                  (123,'Maria','456789','R.XV'    ,1000,'80.000-123','1990-10-22'),
                        (124,'Pedro','789123','R.Muricy',180, '80.100-000','1995-05-20'),
                        (125,'João', '345678','Av.Torres',5000,'80.200-500','2000-02-29');
SELECT * FROM Colaborador;
SELECT Matricula, Nome, Dt_Nascimento AS Nascimento, 
       TIMESTAMPDIFF(YEAR, Dt_Nascimento, NOW()) AS Idade
FROM   Colaborador;

CREATE TABLE Dependente (
    ID_Dep INT PRIMARY KEY,
    Nome VARCHAR(50),
    Parentesco VARCHAR(20),
    Dt_Nasc DATE,
    fk_Colaborador_Matricula INT
);
 
ALTER TABLE Dependente ADD CONSTRAINT FK_Dependente_2
    FOREIGN KEY (fk_Colaborador_Matricula)
    REFERENCES Colaborador (Matricula)
    ON DELETE CASCADE;

INSERT INTO Dependente (ID_Dep, Nome, Parentesco, Dt_Nasc, fk_Colaborador_Matricula)
VALUES                 (200,'Huguinho','Filho','2020-05-10',123),
                       (300,'Zezinho','Filho','2021-08-04',123),
                       (400,'Luizinho', 'Enteado','2022-02-28',125);
                       
SELECT * FROM DEPENDENTE;

SELECT Nome AS Crianca, Parentesco, 
       TIMESTAMPDIFF(YEAR, Dt_Nasc, NOW()) AS'Idade Crianca',
       fk_Colaborador_Matricula AS 'Mat.Progenitor'
FROM   Dependente;

SELECT Matricula, C.Nome AS Responsavel,
       TIMESTAMPDIFF(YEAR, Dt_Nascimento, NOW()) AS 'Idade Responsável',
       D.Nome AS Crianca, Parentesco, 
       TIMESTAMPDIFF(YEAR, Dt_Nasc, NOW()) AS'Idade Crianca',
       fk_Colaborador_Matricula AS 'Mat.Responsável'
FROM   Colaborador AS C, Dependente AS D
WHERE  C.Matricula = D.fk_Colaborador_Matricula;


CREATE TABLE Projeto (
    ID_Proj INT PRIMARY KEY,
    Nome_Proj VARCHAR(50)
);

CREATE TABLE Trabalha (
    ID_Trab INT PRIMARY KEY,
    Dt_Inicio DATE,
    Dt_Fim DATE,
    fk_Projeto_ID_Proj INT,
    fk_Colaborador_Matricula INT
);

ALTER TABLE Trabalha ADD CONSTRAINT FK_Trabalha_2
    FOREIGN KEY (fk_Colaborador_Matricula)
    REFERENCES Colaborador (Matricula)
    ;
 
ALTER TABLE Trabalha ADD CONSTRAINT FK_Trabalha_3
    FOREIGN KEY (fk_Projeto_ID_Proj)
    REFERENCES Projeto (ID_Proj)
    ;
