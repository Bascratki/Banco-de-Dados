CREATE DATABASE LAB_02;

USE LAB_02;

CREATE TABLE Disciplina (
    id_discip INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    ementa TEXT,
    creditos INT NOT NULL,
    periodo INT NOT NULL,
    CONSTRAINT PRIMARY KEY (id_discip)
);

INSERT INTO Disciplina VALUES (1, 'Banco de Dados', NULL, 4, 2);
INSERT INTO Disciplina VALUES (2, 'Redes', 'Básico de redes de computadores', 4, 3);

INSERT INTO Disciplina (id_discip, nome, ementa, creditos, periodo)
VALUES
    (3, 'Matemática Discreta', 'Conjuntos, relações, grafos e algoritmos.', 4, 1),
    (4, 'Estruturas de Dados', 'Filas, pilhas, listas, árvores e grafos.', 6, 2),
    (5, 'Sistemas Operacionais', 'Processos, memória, sistemas de arquivos e dispositivos.', 5, 3),
    (6, 'Engenharia de Software', 'Modelagem de software, processos de desenvolvimento, análise de requisitos.', 4, 4),
    (7, 'Redes de Computadores', 'Protocolos de comunicação, arquitetura de redes, segurança em redes.', 6, 4);

SELECT * FROM Disciplina;

CREATE TABLE Professor (
    id_prof INT AUTO_INCREMENT PRIMARY KEY, -- chave primária auto-incrementada
    nome VARCHAR(50) NOT NULL, 
    dt_nascimento DATE,
    apelido VARCHAR(50) GENERATED ALWAYS AS (SUBSTRING_INDEX(nome, " ", 1)) -- atributo derivado
);

INSERT INTO Professor (nome, dt_nascimento)
VALUES ('Maria das Flores', STR_TO_DATE('23-12-1990', '%d-%m-%Y'));

SELECT * FROM Professor;

INSERT INTO Professor (nome, dt_nascimento) 
VALUES
    ('José da Silva', STR_TO_DATE('20/02/1985', '%d/%m/%Y')),
    ('Paulo Soares', STR_TO_DATE('10/12/1995', '%d/%m/%Y')),
    ('Ana Rita', STR_TO_DATE('20/02/2000', '%d/%m/%Y'));

SELECT nome, dt_nascimento AS 'Data de Nascimento', 
    TIMESTAMPDIFF(YEAR, dt_nascimento, CURDATE()) AS Idade
FROM Professor;

CREATE TABLE Turma (
    id_turma INT AUTO_INCREMENT PRIMARY KEY, -- PK auto-incrementada 
    ano INT NOT NULL,
    semestre INT NOT NULL,
    id_discip INT NOT NULL,
    id_prof INT NOT NULL,
    CONSTRAINT CK_Sem CHECK (semestre BETWEEN 1 AND 2), -- semestre apenas aceita valores 1 e 2
    CONSTRAINT UN_Ofeta UNIQUE (ano, semestre, id_discip, id_prof), -- Prof.Disc.Ano.Sem = exclusivo
    CONSTRAINT FK_Prof FOREIGN KEY (id_prof) REFERENCES Professor (id_prof), -- FK Professor
    CONSTRAINT FK_Discip FOREIGN KEY (id_discip) REFERENCES Disciplina(id_discip) -- FK Disciplina
);

INSERT INTO Turma (ano, semestre, id_prof, id_discip) 
VALUES
    (2020, 1, 2, 2),
    (2020, 2, 2, 2),
    (2021, 1, 3, 1),
    (2024, 1, 2, 2),
    (2023, 2, 2, 2);

SELECT * FROM Turma;

-- Consulta cruzada entre Professor, Disciplina e Turma com PK e FK
SELECT t.ano, t.semestre, p.nome AS 'Professor', d.nome AS 'Disciplina'
FROM Turma AS t
JOIN Professor AS p ON t.id_prof = p.id_prof
JOIN Disciplina AS d ON t.id_discip = d.id_discip;

-- Consulta filtrando turmas do primeiro semestre
SELECT t.ano, t.semestre, p.nome AS 'Professor', d.nome AS 'Disciplina'
FROM Turma AS t
JOIN Professor AS p ON t.id_prof = p.id_prof
JOIN Disciplina AS d ON t.id_discip = d.id_discip
WHERE t.semestre = 1;

-- Consulta ordenada por ano ascendente e semestre descendente
SELECT t.ano, t.semestre, p.nome AS 'Professor', d.nome AS 'Disciplina'
FROM Turma AS t
JOIN Professor AS p ON t.id_prof = p.id_prof
JOIN Disciplina AS d ON t.id_discip = d.id_discip
ORDER BY t.ano ASC, t.semestre DESC;

-- Consulta de professores com nome começando com "J"
SELECT p.nome AS 'Professor', d.nome AS 'Disciplina', t.ano
FROM Turma AS t
JOIN Professor AS p ON t.id_prof = p.id_prof
JOIN Disciplina AS d ON t.id_discip = d.id_discip
WHERE p.nome LIKE 'J%';

-- Criação da tabela Colaborador com restrições
CREATE TABLE Colaborador (
    id_emp INT NOT NULL PRIMARY KEY CONSTRAINT ID_val CHECK (id_emp BETWEEN 0 AND 1000),
    nome VARCHAR(30) NOT NULL,
    salario FLOAT NOT NULL CONSTRAINT SL_val CHECK (salario >= 1000)
);

INSERT INTO Colaborador (id_emp, nome, salario)
VALUES 
    (500, 'Josué', 1500.56),
    (1000, 'Lucas', 3500.56),
    (100, 'Antônio', 1350.56);

SELECT * FROM Colaborador;
