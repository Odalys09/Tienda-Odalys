<?php
require_once __DIR__ . '/conexion.php';

header('Content-Type: application/json');

$data = json_decode(file_get_contents('php://input'), true);

if (!$data || empty($data['items'])) {
    echo json_encode(['success' => false, 'message' => 'Carrito vacío']);
    exit;
}

$id_usuario = 1; // ID por defecto del usuario admin
$total = (float)$data['total'];

$conexion->begin_transaction();

try {
    // 1. Registrar la venta principal
    $stmt = $conexion->prepare("INSERT INTO ventas (id_usuario, total) VALUES (?, ?)");
    $stmt->bind_param("id", $id_usuario, $total);
    $stmt->execute();
    $id_venta = $conexion->insert_id;

    // 2. Registrar cada producto de la orden y actualizar inventario
    $stmtDetalle = $conexion->prepare("INSERT INTO detalle_ventas (id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (?, ?, ?, ?, ?)");
    $stmtStock = $conexion->prepare("UPDATE productos SET cantidad = cantidad - ? WHERE id = ? AND cantidad >= ?");

    foreach ($data['items'] as $item) {
        $id_producto = (int)$item['id'];
        $cant = (int)$item['qty'];
        $precio = (float)$item['precio'];
        $subtotal = $precio * $cant;

        // Insertar en detalle_ventas
        $stmtDetalle->bind_param("iiidd", $id_venta, $id_producto, $cant, $precio, $subtotal);
        $stmtDetalle->execute();

        // Descontar inventario
        $stmtStock->bind_param("iii", $cant, $id_producto, $cant);
        $stmtStock->execute();
    }

    $conexion->commit();
    echo json_encode(['success' => true, 'id_venta' => $id_venta]);
} catch (Exception $e) {
    $conexion->rollback();
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
