CREATE DATABASE Farmacia;

USE Farmacia;

CREATE TABLE Usuario (
    ID_Usuario INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(50) NOT NULL,
    Email VARCHAR(50) NOT NULL,
    Senha VARCHAR(20) NOT NULL,
    Endereco VARCHAR(100),
    Celular VARCHAR(20),
    Tipo ENUM('Administrador', 'Cliente') NOT NULL
);

CREATE TABLE Categoria (
    ID_Categoria INT PRIMARY KEY AUTO_INCREMENT,
    Nome_Categoria VARCHAR(20) NOT NULL
);

CREATE TABLE Produto (
    ID_Produto INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(50) NOT NULL,
    Descricao TEXT,
    Preco DECIMAL(10,2) NOT NULL,
    Estoque INT NOT NULL,
    Codigo_Barras VARCHAR(50),
    fk_Categoria_ID_Categoria INT,
    CONSTRAINT FK_Produto_Categoria
        FOREIGN KEY (fk_Categoria_ID_Categoria)
        REFERENCES Categoria (ID_Categoria)
        ON DELETE RESTRICT
);

CREATE TABLE Pedido (
    ID_Pedido INT PRIMARY KEY AUTO_INCREMENT,
    ID_Usuario INT NOT NULL,
    Data_Pedido DATETIME NOT NULL,
    Status ENUM('Pendente', 'Enviado', 'Entregue', 'Cancelado') NOT NULL,
    Total DECIMAL(10,2) NOT NULL,
    fk_Usuario_ID_Usuario INT,
    CONSTRAINT FK_Pedido_Usuario
        FOREIGN KEY (fk_Usuario_ID_Usuario)
        REFERENCES Usuario (ID_Usuario)
        ON DELETE RESTRICT
);

CREATE TABLE Contem (
    fk_Pedido_ID_Pedido INT,
    fk_Produto_ID_Produto INT,
    PRIMARY KEY (fk_Pedido_ID_Pedido, fk_Produto_ID_Produto),
    CONSTRAINT FK_Contem_Pedido
        FOREIGN KEY (fk_Pedido_ID_Pedido)
        REFERENCES Pedido (ID_Pedido)
        ON DELETE RESTRICT,
    CONSTRAINT FK_Contem_Produto
        FOREIGN KEY (fk_Produto_ID_Produto)
        REFERENCES Produto (ID_Produto)
        ON DELETE RESTRICT
);

INSERT INTO Usuario (Nome, Email, Senha, Endereco, Celular, Tipo)
VALUES
('João Silva', 'joao@gmail.com', 'senha123', 'Rua A, 123', '11999999999', 'Cliente'),
('Maria Oliveira', 'maria@gmail.com', 'senha456', 'Rua B, 456', '11988888888', 'Cliente'),
('Pedro Souza', 'pedro@gmail.com', 'senha789', 'Rua C, 789', '11977777777', 'Cliente'),
('Ana Santos', 'ana@gmail.com', 'senhaabc', 'Rua D, 101', '11966666666', 'Cliente'),
('Carlos Lima', 'carlos@gmail.com', 'senhaxyz', 'Rua E, 102', '11955555555', 'Cliente'),
('Paula Ribeiro', 'paula@gmail.com', 'senha098', 'Rua F, 103', '11944444444', 'Cliente'),
('Lucas Alves', 'lucas@gmail.com', 'senha345', 'Rua G, 104', '11933333333', 'Cliente'),
('Carla Pereira', 'carla@gmail.com', 'senha567', 'Rua H, 105', '11922222222', 'Cliente'),
('Ricardo Costa', 'ricardo@gmail.com', 'senha1234', 'Rua I, 106', '11911111111', 'Cliente'),
('Administrador', 'admin@farmacia.com', 'adminsenha', 'Rua Admin, 100', '11900000000', 'Administrador');

INSERT INTO Categoria (Nome_Categoria)
VALUES
('Medicamentos'),
('Suplementos'),
('Cosméticos'),
('Equipamentos'),
('Higiene'),
('Fraldas'),
('Produtos Naturais'),
('Dermocosméticos'),
('Ortopedia'),
('Nutrição');

INSERT INTO Produto (Nome, Descricao, Preco, Estoque, Codigo_Barras, fk_Categoria_ID_Categoria)
VALUES
('Paracetamol 500mg', 'Analgésico e antitérmico', 9.99, 100, '7891000100101', 1),
('Vitamina C 1g', 'Suplemento vitamínico', 19.90, 50, '7891000200202', 2),
('Protetor Solar FPS 50', 'Protetor solar de alta proteção', 29.90, 200, '7891000300303', 3),
('Termômetro Digital', 'Termômetro de medição rápida', 49.90, 30, '7891000400404', 4),
('Sabonete Antibacteriano', 'Sabonete líquido antibacteriano', 5.90, 300, '7891000500505', 5),
('Fralda Geriátrica', 'Fralda descartável tamanho G', 39.90, 80, '7891000600606', 6),
('Óleo de Coco', 'Suplemento natural com óleo de coco', 24.90, 60, '7891000700707', 7),
('Creme Anti-idade', 'Creme para redução de rugas', 89.90, 120, '7891000800808', 8),
('Muleta Ajustável', 'Muleta com altura ajustável', 99.90, 15, '7891000900909', 9),
('Shake de Proteína', 'Suplemento nutricional com proteínas', 49.90, 40, '7891001001010', 10);

INSERT INTO Pedido (ID_Usuario, Data_Pedido, Status, Total, fk_Usuario_ID_Usuario)
VALUES
(1, NOW(), 'Pendente', 59.80, 1),
(2, NOW(), 'Enviado', 29.90, 2),
(3, NOW(), 'Entregue', 19.90, 3),
(4, NOW(), 'Cancelado', 49.90, 4),
(5, NOW(), 'Pendente', 89.90, 5),
(6, NOW(), 'Enviado', 39.90, 6),
(7, NOW(), 'Entregue', 24.90, 7),
(8, NOW(), 'Cancelado', 49.90, 8),
(9, NOW(), 'Pendente', 99.90, 9),
(10, NOW(), 'Enviado', 149.70, 10);

INSERT INTO Contem (fk_Pedido_ID_Pedido, fk_Produto_ID_Produto)
VALUES
(1, 1),  -- Pedido 1 contém Produto 1 (Paracetamol)
(1, 2),  -- Pedido 1 contém Produto 2 (Vitamina C)
(2, 3),  -- Pedido 2 contém Produto 3 (Protetor Solar)
(3, 4),  -- Pedido 3 contém Produto 4 (Termômetro Digital)
(4, 5),  -- Pedido 4 contém Produto 5 (Sabonete Antibacteriano)
(5, 6),  -- Pedido 5 contém Produto 6 (Fralda Geriátrica)
(6, 7),  -- Pedido 6 contém Produto 7 (Óleo de Coco)
(7, 8),  -- Pedido 7 contém Produto 8 (Creme Anti-idade)
(8, 9),  -- Pedido 8 contém Produto 9 (Muleta Ajustável)
(9, 10); -- Pedido 9 contém Produto 10 (Shake de Proteína)

-- Selecionar todos os registros da tabela Usuario
SELECT * FROM Usuario;

-- Selecionar todos os registros da tabela Categoria
SELECT * FROM Categoria;

-- Selecionar todos os registros da tabela Produto
SELECT * FROM Produto;

-- Selecionar todos os registros da tabela Pedido
SELECT * FROM Pedido;

-- Selecionar todos os registros da tabela Contem
SELECT * FROM Contem;

-- Mostrar pedidos junto com os produtos contidos em cada pedido (usando JOIN)
SELECT 
    Pedido.ID_Pedido,
    Pedido.Status,
    Produto.Nome AS Nome_Produto,
    Produto.Preco
FROM
    Pedido
        JOIN
    Contem ON Pedido.ID_Pedido = Contem.fk_Pedido_ID_Pedido
        JOIN
    Produto ON Contem.fk_Produto_ID_Produto = Produto.ID_Produto;

-- Mostrar os produtos com suas respectivas categorias
SELECT Produto.Nome, Produto.Preco, Categoria.Nome_Categoria
FROM Produto
JOIN Categoria ON Produto.fk_Categoria_ID_Categoria = Categoria.ID_Categoria;

-- Mostrar os pedidos feitos por um cliente específico (exemplo de um cliente com ID 1)
SELECT Pedido.ID_Pedido, Pedido.Data_Pedido, Pedido.Status, Pedido.Total
FROM Pedido
WHERE Pedido.fk_Usuario_ID_Usuario = 1;
