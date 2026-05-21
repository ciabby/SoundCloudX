<?php
require "../config/db.php";
$titolo = $_POST["titolo"];
$Anno_uscita = $_POST["Anno_uscita"];
$artista = $_POST["id_artista"];

$sql = "INSERT INTO Album (titolo, anno_uscita, id_artista) 
        VALUES ('$titolo','$Anno_uscita', '$artista')";

if ($conn->query($sql) === TRUE) {
    // 2. Se l'inserimento ha successo, mostri l'alert e reindirizzi
    echo "<script>
    window.location.href = 'menu.html';
    alert('Album inserito con successo: " . addslashes($titolo) . "');
    </script>";
    exit(); // Blocca ulteriore codice PHP inutile
} else {
    // 3. Gestione di un eventuale errore nel database
    echo "Errore durante l'inserimento dell'album: " . $conn->error;
}

header("Location: InserisciAlbum.html");
?>