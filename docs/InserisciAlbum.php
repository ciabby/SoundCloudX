<?php
require "config/db.php";
$titolo = $_POST["titolo"];
$Anno_uscita = $_POST["Anno_uscita"];

$sql = "INSERT INTO Album (Titolo, Anno_uscita) 
        VALUES ('$titolo','$Anno_uscita')";

$conn ->query($sql);

header("Location: InserisciAlbum.html");
?>