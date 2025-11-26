<?php
if(session_status() === PHP_SESSION_NONE) {
    session_start();
}
if(!isset($_SESSION['usuario_id']) || $_SESSION['usuario_tipo'] != 'admin') {
    header("Location: /IA/views/login.php");
    exit();
}

require_once __DIR__ . '/../controllers/ProductoController.php';

$productoController = new ProductoController();
$id = $_GET['id'] ?? 0;

if($id > 0) {
    $productoController->eliminar($id);
}

header("Location: /IA/admin/index.php");
exit();
?>

