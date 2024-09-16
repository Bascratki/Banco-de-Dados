USE LAB_01;

CREATE TABLE CARRO (
    CodCarro INT PRIMARY KEY,
    Marca VARCHAR(100),
    Modelo VARCHAR(100),
    AnoFabricacao INT,
    Kilometragem FLOAT,
    Cor VARCHAR(50)
);

INSERT INTO CARRO (CodCarro, Marca, Modelo, AnoFabricacao, Kilometragem, Cor)
VALUES 
    (1, 'Toyota', 'Corolla', 2020, 15000.5, 'Preto'),
    (2, 'Honda', 'Civic', 2019, 22000.0, 'Prata'),
    (3, 'Ford', 'Focus', 2018, 35000.7, 'Branco'),
    (4, 'Chevrolet', 'Cruze', 2021, 12000.9, 'Azul'),
    (5, 'Volkswagen', 'Golf', 2017, 45000.2, 'Vermelho');
    
SELECT * FROM CARRO;

UPDATE CARRO
SET COR = 'Azul Turquesa'
WHERE CodCarro = 1;

UPDATE CARRO
SET AnoFabricacao = '1999'
WHERE CodCarro = 2;

SELECT * FROM CARRO;

DELETE FROM CARRO
WHERE CodCarro = 3;

SELECT * FROM CARRO;