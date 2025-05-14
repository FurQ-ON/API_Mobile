<?php
header('Content-Type: application/json');
header('access-control-allow-origin: *');
header('Access-Control-Allow-Headers: *');
include "dbsql.php";
$nim = $_POST['nim'];
$nama = $_POST['nama'];
$progdi = $_POST['progdi'];
$stmt = $db->prepare("UPDATE mahasiswa SET nama = ?, progdi = ? WHERE nim = ?");
$result = $stmt->execute([$nama, $progdi, $nim]);
echo json_encode(['success' => $result]);
?>