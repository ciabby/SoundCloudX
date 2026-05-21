<?php
require "../config/db.php";

$nome_arte = $_POST["nome"];
$stato = $_POST["stato"];

$sql = "INSERT INTO Artisti (nome_arte, stato) 
        VALUES ('$nome_arte', '$stato')";
// 2. Se l'inserimento ha successo, mostri l'alert e reindirizzi
if ($conn->query($sql) === TRUE) {
    // 2. Se l'inserimento ha successo, mostri l'alert e reindirizzi
    echo "<script>
    window.location.href = 'menu.html';
    alert('Artista inserito con successo: " . addslashes($nome_arte) . "');
    </script>";
    exit(); // Blocca ulteriore codice PHP inutile
} else {
    // 3. Gestione di un eventuale errore nel database
    echo "Errore durante l'inserimento dell'artista: " . $conn->error;
}
?>