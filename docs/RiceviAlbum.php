<?php
// RiceviArtisti.php
header('Content-Type: application/json');
require "../config/db.php";

$sql = "SELECT id_album, titolo FROM Album";
$result = $conn->query($sql);

$album = [];

if ($result && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $album[] = $row;
    }
}

// Questa deve essere l'UNICA cosa stampata a schermo dal file
echo json_encode($album);
?>