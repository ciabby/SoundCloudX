<?php
require "../config/db.php";

$titolo = $_POST["titolo_brano"];
$artista = $_POST["Ascolti"];
$durata = $_POST["durata_sec"];
$album = $_POST["id_album"];

$sql = "INSERT INTO Brani (titolo_brano, Ascolti, durata_sec, id_album) 
        VALUES ('$titolo', '$artista', '$durata', '$album')";

if ($conn->query($sql) === TRUE) {
    // 2. Se l'inserimento ha successo, mostri l'alert e reindirizzi
    echo "<script>
    window.location.href = 'menu.html';
    alert('Brano inserito con successo: " . addslashes($titolo) . "');
    </script>";
    exit(); // Blocca ulteriore codice PHP inutile
} else {
    // 3. Gestione di un eventuale errore nel database
    echo "Errore durante l'inserimento del brano: " . $conn->error;
}


//Dopo aver inserito l'utente potrei fare diverse cose
//scelgo di reindirizzare alla stessa pagina di inserimento html.
header("Location: inserisciBrano.html");
?>