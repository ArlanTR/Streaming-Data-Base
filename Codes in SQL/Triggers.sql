-- Exemplos de Triggers --
use Streaming;
-- Triggers 1 -- 
-- Este trigger impede que usuários tenha senhas com menos de 6 dígitos ou com o próprio nome do usuário --
-- DROP TRIGGER Controle_Criacao_senha
DELIMITER $$
CREATE TRIGGER Controle_Criacao_senha 
BEFORE INSERT ON usuario FOR EACH ROW
BEGIN 
	IF (LENGTH(NEW.senha) < 6 OR NEW.senha = NEW.nome) 
	THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Sua senha é muito fraca, ou igual ao nome de usuario!';
	END IF;
END;
$$

-- Tentativa de inserir senhas de padrão não permitido
INSERT INTO usuario (email, cpf, celular, nome, senha, cartao) VALUES ('senhafraca1@gmail.com', '99999998', '124313213', 'Ana MariaL', '00321', '190747948348');
INSERT INTO usuario (email, cpf, celular, nome, senha, cartao) VALUES ('senhafraca2@gmail.com', '112222113', '33444433333', 'Ana Benta', 'Ana Benta', '112321313123');

-- Triggers 2 -- 
-- Este trigger verifica se a nova senha criada é igual a anterior ou se tem menos de 6 dígitos --
DELIMITER $$
-- DROP TRIGGER Alteração_De_Senha
CREATE TRIGGER Alteração_De_Senha  
BEFORE UPDATE ON usuario FOR EACH ROW
BEGIN 
	IF (LENGTH(NEW.senha) < 6 OR OLD.senha = NEW.senha) 
	THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Sua nova senha é muito fraca, ou igual a senha anterior!';
	END IF;
END;
$$

-- Tenta atualizar a senha para senhas não permitidas 
-- UPDATE usuario SET senha = '12345' WHERE email = 'vitor@hotmail.com';
UPDATE usuario SET senha = '12345' WHERE email = 'gustavo@hotmail.com';
UPDATE usuario SET senha = '123456' WHERE email = 'anaclara@gmail.com';

-- Triggers 3 -- 
-- Este trigger impede de apagar uma mensalidade se ela está dentro da data limite de exclusão --
DELIMITER $$
-- DROP TRIGGER Data_Limite_Exclusão
CREATE TRIGGER Data_Limite_Exclusão 
BEFORE DELETE ON mensalidade FOR EACH ROW
BEGIN 
	IF (curdate() < DATE_ADD(OLD.data_Debito, INTERVAL 365 DAY)) 
	THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Fora da data limite de exclusão';
	END IF;
END;
$$

-- Tentativa de apagar a mensalidade --
-- Só é permitido apagar histórico de mensalidades acima de 1 ano -- 
DELETE FROM mensalidade WHERE email = 'cecilia@gmail.com';
DELETE FROM mensalidade WHERE email = 'gustavo@hotmail.com';