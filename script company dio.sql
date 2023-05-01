create database company;
use company;

CREATE INDEX idx_funcionarios_departamento 
ON funcionarios (departamento, COUNT(*));

CREATE INDEX idx_departamentos_cidade 
ON departamentos (cidade, nome);

CREATE INDEX idx_funcionarios_departamento 
ON funcionarios (departamento, nome);

DELIMITER //

CREATE PROCEDURE manipular_dados(
  IN opcao INT,
  IN id INT,
  IN nome VARCHAR(50),
  IN preco FLOAT,
  IN nota FLOAT,
  IN departamento VARCHAR(50)
)
BEGIN
  IF opcao = 1 THEN
    INSERT INTO universidade (id, nome, nota, departamento)
    VALUES (id, nome, nota, departamento);
  ELSEIF opcao = 2 THEN
    UPDATE e_commerce
    SET nome = nome, preco = preco
    WHERE id
