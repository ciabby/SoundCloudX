<?php
// RiceviArtisti.php
header('Content-Type: application/json');
require "../config/db.php";

$sql = "SELECT id_artista, nome_arte FROM artisti";
$result = $conn->query($sql);

$artisti = [];

if ($result && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $artisti[] = $row;
    }
}

// Questa deve essere l'UNICA cosa stampata a schermo dal file
echo json_encode($artisti);
?>