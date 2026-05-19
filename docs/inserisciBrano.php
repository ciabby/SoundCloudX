<?php
require "../config/db.php";

$titolo = $_POST["titolo_brano"];
$artista = $_POST["Ascolti"];
$durata = $_POST["durata_sec"];

$sql = "INSERT INTO brani (titolo_brano, Ascolti, durata_sec) 
        VALUES ('$titolo', '$artista', '$durata')";

$conn->query($sql);

//Dopo aver inserito l'utente potrei fare diverse cose
$sql = "SELECT id_artista,nome_arte FROM artisti ORDER BY nome_arte";
$result = $conn->query($sql);
$options = "";
while ($row = $result->fetch_assoc()) {
    $options .= "<option value='" . $row["id_artista"] . "'>" . $row["nome_arte"] . "</option>";
}
//scelgo di reindirizzare alla stessa pagina di inserimento html.
header("Location: inserisciBrano.html");
?>