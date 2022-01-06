<?php
require 'config.php';

if(isset($_POST['cadastrar'])){
    $email = $_POST['email'];
    $cpf = $_POST['cpf'];
    $celular = $_POST['celular'];
    $nome = $_POST['nome'];
    $senha = $_POST['senha'];
    $cartao = $_POST['cartao'];
    $query = mysqli_query($mysqli,"INSERT INTO usuario (email,cpf,celular,nome,senha,cartao) VALUES('$email','$cpf','$celular','$nome','$senha','$cartao')");
    if($query){
        echo 'Cadastro realizado com sucesso';
    }else{
        echo 'Não foi possivel realizar o cadastro';
    }
}
?>
<html>
    <head>
        <title>Cadastrar Usuario</title>
    </head>
    <body>
        <form method="post">
            <label>Email</label><br/>
            <input type="text" name="email"><br/>
            <label>CPF</label><br/>
            <input type="text" name="cpf"><br/>
            <label>Celular</label><br/>
            <input type="text" name="celular"><br/>
            <label>Nome de Usuario</label><br/>
            <input type="text" name="nome"><br/>
            <label>Senha</label><br/>
            <input type="password" name="senha"><br/>
            <label>Cartao</label><br/>
            <input type="text" name="cartao"><br/>
            <button name="cadastrar">Cadastrar</button>
        </form>
    </body>
    <a href="index.php"> Voltar pra pagina Inicial </a>
</html>