<?php

$hostname = "localhost";
$bancodedados = "streaming";
$usuario = "root";
$senha = "";

$mysqli = new mysqli($hostname, $usuario, $senha, $bancodedados);
if ($mysqli->connect_errno){
    echo "falha ao conectar: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
}