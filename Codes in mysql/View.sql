-- G --
-- Exemplo de criação de View --
-- Mostra todos os pagamentos das mensalidades realizadas pelos usuário --
CREATE VIEW Pagamento AS
SELECT id_Mensalidade, nome, data_Debito, valor
FROM Usuario NATURAL JOIN Mensalidade;
-- Exemplo mostrando o total pago por um usuário --
SELECT nome, SUM(valor) AS 'Total Pago'
FROM Pagamento
GROUP BY nome;

-- Mostra todos os episodios pertencentes as séries --
CREATE VIEW SerieInfo AS
SELECT  qtd_Temporada AS 'Qtd de Temporada', titulo AS "Nome episodio", nome_Serie AS Serie
FROM Serie NATURAL JOIN Episodio NATURAL JOIN Video;
-- Exemplo mostrando o quantidade de episodios pertencentes a uma serie --
SELECT Serie, COUNT('nome episodio') AS 'Qtd Episodio' 
FROM SerieInfo
WHERE Serie = 'The Queens Gambit'
GROUP BY Serie;

-- Mostra o acesso dos usuarios pela plataforma e quais videos assistiram --
CREATE VIEW UsuarioAcesso AS
SELECT email, tipo_Plataforma , titulo
FROM Acessa NATURAL JOIN Plataforma NATURAL JOIN Video;
-- Exemplo mostrando quantidade de vídeos assistidos por cada usuário --
SELECT email AS 'Usuario', COUNT(titulo) AS 'Qtd video'
FROM UsuarioAcesso
GROUP BY email;