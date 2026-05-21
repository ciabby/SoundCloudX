<?php
require "../config/db.php";

$nome = $_POST["nome"];
$mail = $_POST["email"];
$password = $_POST["password"];

$sql = "INSERT INTO utenti (nome, mail, passwords) 
        VALUES ('$nome', '$mail', '$password')";
$conn->query($sql);
//scelgo di reindirizzare al menu con tutte le altre pagine.
header("Location: menu.html");
?>