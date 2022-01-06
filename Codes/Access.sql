-- H -- 
-- Exemplos de criação de Usuário e suas permissões de acesso-- 
-- Criação de Usuário 1 (Jake) -- 
CREATE USER 'jake'@'localhost' IDENTIFIED BY '111111';
-- Concede ao usuário 'jake' em 'localhost' o direito de SELECT, INSERT e UPDATE na tabela Usuário --
GRANT SELECT, INSERT, UPDATE ON Streaming.Usuario TO 'jake'@'localhost';
-- Concede ao usuário 'jake' em 'localhost' o direito de SELECT e INSERT na tabela Mensalidade --
GRANT SELECT, INSERT ON Streaming.Mensalidade TO 'jake'@'localhost';
-- Concede ao usuário 'jake' em 'localhost' o direito de alterar a coluna 'data_Debito' na tabela Mensalidade --
GRANT UPDATE (data_Debito) ON Streaming.Mensalidade TO 'jake'@'localhost';
-- Concede ao usuário 'jake'  em 'localhost' o direito de SELECT na tabela Acessa --
GRANT SELECT ON Streaming.Acessa TO 'jake'@'localhost';
-- Revoga do usuário 'jake' em 'localhost' o direito de SELECT na tabela Acessa --
REVOKE SELECT ON Streaming.Acessa FROM 'jake'@'localhost';

-- Criação de Usuário 2 (Amy)-- 
CREATE USER 'amy'@'localhost' IDENTIFIED BY '222222';
-- Concede ao usuário 'amy' em 'localhost' o direito de SELECT, INSERT e UDPATE na tabela Ator --
GRANT SELECT, INSERT, UPDATE ON Streaming.Ator TO 'amy'@'localhost';
-- Concede ao usuário 'amy' em 'localhost' o direito de SELECT a tabela Possui --
GRANT SELECT ON Streaming.Possui TO 'amy'@'localhost';
-- Concede ao usuário 'amy' em 'localhost' o direito alterar a coluna 'nome_Ator' na tabela Possui --
GRANT UPDATE (nome_Ator) ON Streaming.Possui TO 'amy'@'localhost';
-- Concede ao usuário 'amy' em 'localhost' o direito de SELECT a tabela Video --
GRANT SELECT ON Streaming.Video TO 'amy'@'localhost';
-- Concede ao usuário 'amy' em 'localhost' o direito de SELECT a tabela Serie --
GRANT SELECT ON Streaming.Serie TO 'amy'@'localhost';
-- Concede ao usuário 'amy' em 'localhost' o direito de SELECT a tabela Plataforma --
GRANT SELECT ON Streaming.Plataforma TO 'amy'@'localhost';
-- Revoga do usuário 'amy' em 'localhost' o direito de SELECT a tabela Plataforma --
REVOKE SELECT ON Streaming.Plataforma FROM 'amy'@'localhost';

-- Criação de Usuário 3 (Raymond)--
CREATE USER 'raymond'@'localhost' IDENTIFIED BY '333333';
-- Condece ao usuário 'raymond' em 'localhost' todos os privilégios 
GRANT ALL ON Streaming.* TO 'raymond'@'localhost';
-- Revoga do usuário 'raymond' em 'localhost' todos os privilégios.
REVOKE ALL, GRANT OPTION FROM 'raymond'@'localhost';
-- Exclui o usuário 'raymond' em 'localhost'
DROP USER 'raymond'@'localhost';