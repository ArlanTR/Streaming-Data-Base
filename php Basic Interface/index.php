<?php
require 'config.php';
$consulta = "SELECT email, cpf, celular, nome, cartao FROM usuario";
$con = $mysqli->query($consulta) or die($mysqli->error);

?>
<html>
    <head>
        <title>Listagem de Usuarios</title>
    </head>
    <body>
      <table border="1">
        <tr>  
          <th>Email</th>
          <th>Cpf</th>
          <th>Celular</th>
          <th>Nome</th>
          <th>Cartao</th>
        </tr>
        <?php while($dado = $con->fetch_array()) { ?>
        <tr>  
          <th><?php echo $dado['email']; ?></th>
          <th><?php echo $dado['cpf']; ?></th>
          <th><?php echo $dado['celular']; ?></th>
          <th><?php echo $dado['nome']; ?></th>
          <th><?php echo $dado['cartao']; ?></th>
        </tr>
        <?php } ?>
      </table>
    </body>
<a href="cadastrar.php"> Cadastrar Usuario </a>
</html>
