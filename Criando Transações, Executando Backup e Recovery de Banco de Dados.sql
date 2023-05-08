START TRANSACTION;
SET autocommit=0;

SELECT * FROM tabela WHERE coluna = valor FOR UPDATE;
UPDATE tabela SET coluna = novo_valor WHERE coluna = valor;

COMMIT;

ROLLBACK;

DELIMITER //
CREATE PROCEDURE nome_procedure()
BEGIN
    DECLARE erro INT DEFAULT 0;
    
    START TRANSACTION;
    SET autocommit=0;
    
    -- instruções SQL
    
    IF erro = 1 THEN
        ROLLBACK;
    ELSE
        COMMIT;
    END IF;
END //
DELIMITER ;

CALL nome_procedure();

mysqldump -u [usuario] -p[senha] [banco_de_dados] > backup.sql

mysql -u [usuario] -p[senha] [banco_de_dados] < backup.sql
