DELIMITER $
-- usando varchar pois o usuário pode digitar o cpf com "." ou "-" no meio --
CREATE FUNCTION Validador_CPF(CPF varchar(14)) RETURNS VARCHAR(14) DETERMINISTIC
BEGIN

    DECLARE n_documento CHAR(11);
    DECLARE soma INT;
    DECLARE i INT;
    DECLARE num1 INT;
    DECLARE num2 INT;
    DECLARE num_1_cpf CHAR(2);
    DECLARE num_2_cpf CHAR(2);
    DECLARE resposta VARCHAR(14);
    
    -- removendo o "." e "-" e logo depois colocando o cpf na variavel tipo char(11) // não consegui usar o replace --
    /*SET CPF = REPLACE(CPF, ".", "");
	SET CPF = REPLACE(CPF, -, "");*/

    SET n_documento = TRIM(CPF);
    IF (n_documento IN ('00000000000', '11111111111', '22222222222', '33333333333', '44444444444', '55555555555', '66666666666', '77777777777', '88888888888', '99999999999', '12345678909')) THEN
        SET resposta = "CPF FALSO";
        RETURN (resposta);
    END IF;

    SET num_1_cpf = SUBSTRING(n_documento,LENGTH(n_documento)-1,1);
    SET num_2_cpf = SUBSTRING(n_documento,LENGTH(n_documento),1);

    SET soma = 0;
    SET i = 1;
    WHILE (i <= 9) DO          
            SET soma = soma + CAST(SUBSTRING(n_documento,i,1) AS UNSIGNED) * (11 - i);             
            SET i = i + 1;      
    END WHILE;
    SET num1 = 11 - (soma % 11);      
         IF (num1 > 9) THEN
            SET num1 = 0;
         END IF;

    SET soma = 0;
    SET i = 1;
    WHILE (i <= 10) DO
        SET soma = soma + CAST(SUBSTRING(n_documento,i,1) AS UNSIGNED) * (12 - i);              
        SET i = i + 1;
    END WHILE;
    SET num2 = 11 - (soma % 11);
        IF num2 > 9 THEN
            SET num2 = 0;
        END IF;

    IF (num1 = num_1_cpf) AND (num2 = num_2_cpf) THEN
            SET resposta = "CPF VERDADEIRO";
        RETURN (resposta);
        ELSE
            SET resposta = "CPF FALSO";
            RETURN (resposta);
    END IF;
END;
$








