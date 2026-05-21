<?php
require "../config/db.php";
$titolo = $_POST["titolo"];
$Anno_uscita = $_POST["Anno_uscita"];
$artista = $_POST["id_artista"];

$sql = "INSERT INTO Album (Titolo, Anno_uscita, id_artista) 
        VALUES ('$titolo','$Anno_uscita', '$artista')";

$conn ->query($sql);

header("Location: InserisciAlbum.html");
?>