-- F --
-- Exemplos de Consultas --
-- Recupera o nome e celular do usuarios que acessam a plataforma do tipo ‘S’
SELECT nome, celular 
FROM Usuario U JOIN Acessa A ON U.email = A.email JOIN Plataforma P ON A.id_Plataforma = P.id_Plataforma 
WHERE tipo_Plataforma = 'S' 
GROUP BY nome;

-- Recupera os dados de cada vídeo e de seus episódios, se o vídeo não tiver episódio, indique com valores null:
SELECT * 
FROM Video V LEFT OUTER JOIN Episodio E ON V.id_Video = E.id_Video;

-- Recupera o nome dos usuarios em que o valor da mesalidade está entre 20 e 30 reais ou que acessa a plataforma do tipo ‘M’:
SELECT nome
FROM Usuario U JOIN Mensalidade M ON U.email = M.email 
WHERE valor BETWEEN 20 AND 30 
UNION 
SELECT nome
FROM Usuario U JOIN Acessa A ON U.email = A.email JOIN Plataforma P ON A.id_Plataforma = P.id_Plataforma 
WHERE tipo_Plataforma = 'M';

-- Recupera o nome e o cpf dos usuários em ordem alfabética:
SELECT nome, cpf 
FROM Usuario 
ORDER BY nome;

-- Recupera o nome e duraçao dos vídeos do tipo ‘D’ ou do tipo ‘F’:
SELECT titulo, duracao 
FROM Video 
WHERE tipo_Video = 'D' OR tipo_Video = 'F';

-- Recupera o nome e email de Usuarios que ainda não acessaram nenhuma plataforma:
SELECT nome, email
FROM Usuario 
WHERE email NOT IN(SELECT email FROM acessa);

-- Recupera o titulo e a duracao dos vídeos por ordem descrescente de tempo de episódios 
SELECT titulo, duracao 
FROM Video V JOIN Episodio E 
WHERE V.id_Video = E.Id_Video 
ORDER BY V.duracao DESC;

-- Recupera o tipo da plataforma, o número de usuários por plataforma e a mensalidade que eles pagam
-- **
SELECT tipo_Plataforma, count(*) AS Quantidade, SUM(valor) AS 'Total Pago'
FROM Mensalidade M JOIN Acessa A ON M.email = A.email JOIN Plataforma P ON A.id_Plataforma = P.id_Plataforma 
GROUP BY valor ORDER BY tipo_Plataforma;

-- Recupera o titulo e nome do ator que participa de algum vídeo
SELECT titulo, nome_Ator 
FROM Video V JOIN Possui P 
WHERE V.id_Video = P.id_Video 
ORDER BY titulo;

-- Recupera o nome e a data de pagamento de usuarios a partir da data 2021-02-15 
SELECT nome, data_Debito 
FROM Usuario U JOIN Mensalidade M 
WHERE U.email = M.email AND M.data_Debito >= ANY(SELECT data_Debito FROM Mensalidade WHERE data_Debito >='2021-02-15') 
GROUP BY data_Debito;

-- Recupera nome de séries que contém "The" no título
SELECT nome_Serie 
FROM Serie S 
WHERE S.nome_Serie LIKE '%The%';

-- Recupera nome e o email de usuários que pagam mensalidade acima de 55 reais
SELECT nome, email 
FROM Usuario U 
WHERE EXISTS(SELECT valor FROM Mensalidade M WHERE U.email = M.email AND M.valor > 55);

-- Recupera nome dos usuarios que ainda não foi encontrado pagamento no mes atual
SELECT nome, 'Não foi encontrado pagamento do mês atual.'
FROM Usuario
WHERE EXISTS(SELECT id_Mensalidade FROM mensalidade WHERE dayofmonth(data_Debito) > dayofmonth(curdate()));

-- Recupera o titulo do vídeo que tem o ator 'Claire Foy'
SELECT titulo 
FROM Video V JOIN Possui P ON V.id_Video = P.id_Video JOIN Ator A ON P.nome_Ator = A.nome_Ator 
WHERE A.nome_Ator = 'Claire Foy';

-- Recupera todos os atributos dos atores com idade maior que 50 anos
SELECT * 
FROM Ator 
WHERE idade > 50;

-- Recupera o nome das séries que tem entre 2 e 5 temporadas:
SELECT nome_Serie 
FROM Serie 
WHERE qtd_Temporada BETWEEN 2 AND 5;

-- Recupera o nome da serie que tem o Maior numero de temporadas:
-- *
SELECT nome_Serie, qtd_Temporada
FROM Serie
WHERE qtd_Temporada = (SELECT MAX(qtd_Temporada) FROM Serie);

-- Recupera nome da série com mais de 3 temporadas
SELECT S.nome_Serie AS 'Nome da serie', S.qtd_Temporada AS 'Quantiadade Temporadas'
From serie S HAVING S.qtd_Temporada > 2;

-- Recupera todos os vídeos lançados após 2018
SELECT titulo, ano FROM video V WHERE ano > ALL (SELECT ano FROM video V WHERE V.ano = 2018) GROUP BY titulo;



