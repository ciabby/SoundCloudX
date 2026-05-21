<?php
require "../config/db.php";

// Query con JOIN per ottenere titolo brano, ascolti, nome album e nome d'arte dell'artista
$sql = "SELECT b.id_brano, b.titolo_brano, b.durata_sec, b.ascolti, a.titolo AS nome_album, art.nome_arte 
        FROM Brani b
        LEFT JOIN Album a ON b.id_album = a.id_album
        LEFT JOIN Artisti art ON a.id_artista = art.id_artista
        ORDER BY b.id_brano DESC";

$result = $conn->query($sql);
$brani = [];

if ($result) {
    while ($row = $result->fetch_assoc()) {
        // Convertiamo la durata da secondi a formato MM:SS prima di mandarla a JS
        $minuti = floor($row['durata_sec'] / 60);
        $secondi = $row['durata_sec'] % 60;
        $row['durata_formattata'] = $minuti . ":" . str_pad($secondi, 2, "0", STR_PAD_LEFT);
        
        $brani[] = $row;
    }
}

header('Content-Type: application/json');
echo json_encode($brani);
exit();
?>