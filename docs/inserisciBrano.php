<?php
require "../config/db.php";

$titolo = $_POST["titolo"];
$artista = $_POST["Ascolti"];
$durata = $_POST["durata_sec"];

$sql = "INSERT INTO brani (titolo_brano, Ascolti, durata_sec) 
        VALUES ('$titolo', '$artista', '$durata', '$annoUscita')";

$conn->query($sql);

//Dopo aver inserito l'utente potrei fare diverse cose
//scelgo di reindirizzare alla stessa pagina di inserimento html.
header("Location: inserisciBrano.html");
?>