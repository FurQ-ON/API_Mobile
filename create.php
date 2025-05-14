<?php
header('Content-Type: application/json');
header('access-control-allow-origin: *');
header('Access-Control-Allow-Headers: *');
include "dbsql.php";
// $age = (int) $_POST['age'];
$nim = $_POST['nim'];
$nama = $_POST['nama'];
$progdi = $_POST['progdi'];
$stmt = $db->prepare("INSERT INTO mahasiswa (nim, nama, progdi) VALUES (?, ?, ?)");
$result = $stmt->execute([$nim, $nama, $progdi]);
echo json_encode(['success' => $result]);
?>