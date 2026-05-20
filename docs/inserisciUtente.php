<?php
require "../config/db.php";

$nome = $_POST["nome"];
$mail = $_POST["email"];
$password = $_POST["password"];

$sql = "INSERT INTO utenti (nome, mail, password) 
        VALUES ('$nome', '$mail', '$password'x)";

$conn->query($sql);

//Dopo aver inserito l'utente potrei fare diverse cose
//scelgo di reindirizzare al menu con tutte le altre pagine.
header("Location: menu.html");
?>