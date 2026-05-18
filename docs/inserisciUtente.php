<?php
require "config/db.php";

$nome = $_POST["nome"];
$mail = $_POST["email"];

$sql = "INSERT INTO utenti (nome, mail) 
        VALUES ('$nome', '$mail')";

$conn->query($sql);

//Dopo aver inserito l'utente potrei fare diverse cose
//scelgo di reindirizzare alla stessa pagina di inserimento html.
header("Location: inserisciUtente.html");
?>