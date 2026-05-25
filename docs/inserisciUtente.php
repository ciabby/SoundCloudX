<?php
require "../config/db.php";

$nome = $_POST["nome"];
$mail = $_POST["email"];
$password = $_POST["password"];
// HASH PASSWORD (più sicura)
$password = password_hash($password, PASSWORD_BCRYPT);
$sql = "INSERT INTO Utenti (nome, mail, passwords) 
        VALUES ('$nome', '$mail', '$password')";
$conn->query($sql);
//scelgo di reindirizzare al menu con tutte le altre pagine.
header("Location: menu.html");
?>