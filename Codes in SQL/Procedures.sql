use Streaming;

/*Retorna o Nome e a descrição do video pesquisando pelo seu nome ou parte do nome*/
DELIMITER //
CREATE PROCEDURE Pesquisa_de_Video(IN nomepesquisa varchar(30))
BEGIN
	SET nomePesquisa = CONCAT('%',nomePesquisa,'%');
	SELECT titulo, descricao
	FROM Video
	WHERE titulo LIKE nomePesquisa;
END //
DELIMITER ;
/* chama procedimento para pesquisar o nome do video e retornar Nome e a descrição do mesmo*/
CALL Pesquisa_de_Video('splash');
/* chama procedimento para pesquisar o nome do video e retornar Nome e a descrição do mesmo*/
CALL Pesquisa_de_Video('The');

/*Retorna os numeros de acesso em cada uma das plataformas*/
DELIMITER //
CREATE PROCEDURE QuantidadeAcessosPlataforma()
BEGIN
	SELECT CASE 
		WHEN tipo_Plataforma = 'M' THEN 'MOBILE'
		WHEN tipo_Plataforma = 'S'THEN 'SMARTHTV'
		WHEN tipo_Plataforma = 'C'THEN 'COMPUTADOR'
	END AS Plataforma, COUNT(tipo_Plataforma) 
	AS 'Acessos a plataforma' FROM plataforma
	GROUP BY tipo_Plataforma;
END //
DELIMITER ; 
/* chama procedimento que retorna o numero de acessos em cada plataforma*/
CALL QuantidadeAcessosPlataforma();

/*Procedimento que atualiza a idade todos os Atores*/
DELIMITER //
CREATE PROCEDURE AtualizarIdade()
BEGIN
	DECLARE totalAtores INT;
    DECLARE contador INT;
    DECLARE idadeAx VARCHAR(30);
	DECLARE meuCursor CURSOR FOR SELECT a.idade FROM ator a;
    SET contador = 1;
	SET totalAtores = (select COUNT(*) FROM ator);
    OPEN meuCursor;
    WHILE (contador <= totalAtores) DO
		FETCH meuCursor INTO idadeAx;
		UPDATE ator SET idade = idade+1 WHERE ator.idade = idadeAx;
        SET contador = contador+1;
    END WHILE;
END //
DELIMITER ; 
/*Chama procedimento que atualiza a idade de todos os atores*/
CALL AtualizarIdade();
