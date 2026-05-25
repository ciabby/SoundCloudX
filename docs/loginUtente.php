<?php
require "../config/db.php";

$mail = $_POST["login_email"];
$password = $_POST["login_password"];
// HASH PASSWORD (più sicura)
$password = password_hash($password, PASSWORD_BCRYPT);
$sql = "SELECT 1 FROM Utenti WHERE mail='$mail' AND passwords='$password'";
// Eseguiamo la query e salviamo l'oggetto risultato in $result
$result = $conn->query($sql);

// 3. Controlliamo se il numero di righe trovate (num_rows) è maggiore di 0
if ($result && $result->num_rows > 0) {
    // Nota: console_log() nel browser non si vedrà perché fai subito il reindirizzamento (header)
    header("Location: menu.html");
    echo "<script>alert('Login riuscito per: " . addslashes($mail) . "');</script>";
    exit(); // Blocca l'esecuzione dello script dopo il redirect
} else {
    header("Location: inserisciUtente.html");
    echo "<script>alert('Login fallito per: " . addslashes($mail) . "');</script>";
    exit();
}
?>