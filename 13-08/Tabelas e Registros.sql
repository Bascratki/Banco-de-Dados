DROP DATABASE TSTBSI_TB;

CREATE DATABASE TSTBSI_TB;

USE TSTBSI_TB;

/* Lógico_2: */

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

INSERT INTO Colaborador (Matricula, Nome, CPF, Logradouro, Numero, CEP, Dt_Nascimento)
VALUES 	( '101', 'Maria', '12345678910', 'R.XV', 1000, '000.000-000', '2006-03-08'),
		( '102', 'Pedro', '12345678911', 'R.Muricy', 180, '000.000-001', '2006-03-08'),
		( '103', 'João', '12345678912', 'R.Avenida Torres', 5000, '000.000-002', '2006-03-08');
        
SELECT Matricula, Nome, Dt_Nascimento AS Nascimento,
	TIMESTAMPDIFF(YEAR, Dt_Nascimento, NOW()) AS Idade
		FROM Colaborador;

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
VALUES 	( '201', 'Maria', 'Filha', '2020-03-08', 101),
		( '202', 'Pedro', 'Filho', '2020-03-08', 101),
		( '203', 'João', 'Filho', '2020-03-08', 102);

SELECT * from DEPENDENTE;

SELECT Nome AS Crianca, Parentesco,
	TIMESTAMPDIFF(YEAR, Dt_Nasc, NOW()) AS 'Idade Crinaça',
    fk_Colaborador_Matricula AS 'Mat_Progenitor'
		FROM Dependente;