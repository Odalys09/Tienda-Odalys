<?php
require_once __DIR__ . '/conexion.php';

$sqlTotal = "SELECT SUM(total) as total_dia, COUNT(id) as total_ventas 
             FROM ventas 
             WHERE DATE(fecha_venta) = CURDATE()";
$resTotal = $conexion->query($sqlTotal)->fetch_assoc();
$totalDia = $resTotal['total_dia'] ?? 0;
$totalVentas = $resTotal['total_ventas'] ?? 0;

$sqlVentas = "SELECT v.*, u.nombre as vendedor 
              FROM ventas v 
              JOIN usuarios u ON v.id_usuario = u.id 
              WHERE DATE(v.fecha_venta) = CURDATE() 
              ORDER BY v.fecha_venta DESC";
$ventas = $conexion->query($sqlVentas)->fetch_all(MYSQLI_ASSOC);
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tienda de Odalys | Ventas del Día</title>
    <link rel="stylesheet" href="estilos.css">
</head>
<body>
    <header class="site-header">
        <div class="header-content">
            <a href="index.php" class="brand">
                <span class="brand-badge">O</span>
                <span>Tienda de Odalys</span>
            </a>
            <div class="nav-links">
                <a href="index.php" class="nav-btn">🛒 Punto de Venta</a>
                <a href="admin_productos.php" class="nav-btn">⚙️ Administrar Productos</a>
                <a href="ventas_dia.php" class="nav-btn active">📊 Ventas del Día</a>
            </div>
        </div>
    </header>

    <main class="main-layout" style="grid-template-columns: 1fr;">
        <section class="catalog-section">
            <h1 style="font: 900 24px var(--font); margin: 0 0 20px; color: var(--azul-cielo);">Reporte de Ventas de Hoy</h1>

            <div style="display: flex; gap: 20px; margin-bottom: 24px;">
                <div style="background: #141414; border: 2px solid var(--fiusha); border-radius: 12px; padding: 20px; flex: 1;">
                    <div style="font-size: 13px; color: var(--fiusha); font-weight: 800; text-transform: uppercase;">TOTAL VENDIDO HOY</div>
                    <div style="font-size: 32px; font-weight: 900; color: #fff;">$<?php echo number_format($totalDia, 2); ?></div>
                </div>
                <div style="background: #141414; border: 2px solid var(--azul-cielo); border-radius: 12px; padding: 20px; flex: 1;">
                    <div style="font-size: 13px; color: var(--azul-cielo); font-weight: 800; text-transform: uppercase;">NÚMERO DE TRANSACCIONES</div>
                    <div style="font-size: 32px; font-weight: 900; color: #fff;"><?php echo $totalVentas; ?> ventas</div>
                </div>
            </div>

            <div class="table-frame">
                <table>
                    <thead>
                        <tr>
                            <th>ID Venta</th>
                            <th>Hora</th>
                            <th>Vendedor</th>
                            <th>Monto Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if (count($ventas) === 0): ?>
                            <tr>
                                <td colspan="4" style="text-align: center; color: var(--texto-mutado); padding: 24px;">No se han registrado ventas el día de hoy.</td>
                            </tr>
                        <?php else: ?>
                            <?php foreach ($ventas as $v): ?>
                                <tr>
                                    <td>#<?php echo $v['id']; ?></td>
                                    <td><?php echo date('H:i:s', strtotime($v['fecha_venta'])); ?></td>
                                    <td><?php echo htmlspecialchars($v['vendedor']); ?></td>
                                    <td style="font-weight: 900; color: var(--azul-cielo);">$<?php echo number_format($v['total'], 2); ?></td>
                                </tr>
                            <?php endforeach; ?>
                        <?php endif; ?>
                    </tbody>
                </table>
            </div>
        </section>
    </main>
</body>
</html>
