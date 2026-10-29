<?php
require_once __DIR__ . '/conexion.php';

$mensaje = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['guardar_producto'])) {
    $producto = trim($_POST['producto']);
    $id_categoria = (int)$_POST['id_categoria'];
    $costo = (float)$_POST['costo'];
    $precio = (float)$_POST['precio'];
    $cantidad = (int)$_POST['cantidad'];
    $nombreImagen = 'default.png';

    if (isset($_FILES['imagen']) && $_FILES['imagen']['error'] === UPLOAD_ERR_OK) {
        $ext = pathinfo($_FILES['imagen']['name'], PATHINFO_EXTENSION);
        $nombreImagen = time() . '_' . uniqid() . '.' . $ext;
        
        $directorioImg = __DIR__ . '/img/';
        if (!is_dir($directorioImg)) {
            mkdir($directorioImg, 0777, true);
        }
        
        move_uploaded_file($_FILES['imagen']['tmp_name'], $directorioImg . $nombreImagen);
    }

    $stmt = $conexion->prepare("INSERT INTO productos (producto, id_categoria, costo, precio, cantidad, imagen) VALUES (?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("siddis", $producto, $id_categoria, $costo, $precio, $cantidad, $nombreImagen);
    
    if ($stmt->execute()) {
        $mensaje = "¡Producto agregado exitosamente!";
    } else {
        $mensaje = "Error al agregar el producto.";
    }
}

$sql = "SELECT p.*, c.nombre as categoria_nombre FROM productos p JOIN categorias c ON p.id_categoria = c.id ORDER BY p.id DESC";
$productos = $conexion->query($sql)->fetch_all(MYSQLI_ASSOC);
$categorias = $conexion->query("SELECT * FROM categorias ORDER BY nombre ASC")->fetch_all(MYSQLI_ASSOC);
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tienda de Odalys | Administrar Productos</title>
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
                <a href="admin_productos.php" class="nav-btn active">⚙️ Administrar Productos</a>
                <a href="ventas_dia.php" class="nav-btn">📊 Ventas del Día</a>
            </div>
        </div>
    </header>

    <main class="main-layout">
        <section class="catalog-section">
            <h1 style="font: 900 24px var(--font); margin: 0 0 20px; color: var(--azul-cielo);">Catálogo de Productos (CRUD)</h1>
            
            <div class="table-frame">
                <table>
                    <thead>
                        <tr>
                            <th>Imagen</th>
                            <th>Producto</th>
                            <th>Categoría</th>
                            <th>Precio</th>
                            <th>Stock</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($productos as $p): ?>
                            <?php 
                                $imgName = trim($p['imagen']);
                                $imgSrc = 'img/' . $imgName;
                                if (!pathinfo($imgName, PATHINFO_EXTENSION)) {
                                    foreach (['.jfif', '.png', '.jpg', '.jpeg'] as $ext) {
                                        if (file_exists(__DIR__ . '/img/' . $imgName . $ext)) {
                                            $imgSrc = 'img/' . $imgName . $ext;
                                            break;
                                        }
                                    }
                                }
                            ?>
                            <tr>
                                <td>
                                    <img src="<?php echo htmlspecialchars($imgSrc); ?>" width="45" height="45" style="object-fit:cover; border-radius:8px;" onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1542838132-92c53300491e?w=400&q=80';">
                                </td>
                                <td><strong><?php echo htmlspecialchars($p['producto']); ?></strong></td>
                                <td><?php echo htmlspecialchars($p['categoria_nombre']); ?></td>
                                <td style="color: var(--azul-cielo); font-weight: 700;">$<?php echo number_format($p['precio'], 2); ?></td>
                                <td><?php echo $p['cantidad']; ?> pcs</td>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        </section>

        <section class="cart-section">
            <h2 class="cart-title">Agregar Nuevo Producto</h2>
            
            <?php if ($mensaje): ?>
                <p style="padding: 10px; background: var(--fiusha); color: #fff; border-radius:6px; font-weight:700;"><?php echo $mensaje; ?></p>
            <?php endif; ?>

            <form method="POST" enctype="multipart/form-data" style="display:flex; flex-direction:column; gap:12px;">
                <label>
                    <span style="font-size:12px; font-weight:700; color: var(--azul-cielo);">Nombre del Producto:</span>
                    <input type="text" name="producto" required style="width:100%; padding:10px; background:#000; color:#fff; border:1px solid var(--azul-cielo); border-radius:8px;">
                </label>
                
                <label>
                    <span style="font-size:12px; font-weight:700; color: var(--azul-cielo);">Categoría:</span>
                    <select name="id_categoria" required style="width:100%; padding:10px; background:#000; color:#fff; border:1px solid var(--azul-cielo); border-radius:8px;">
                        <?php foreach ($categorias as $cat): ?>
                            <option value="<?php echo $cat['id']; ?>"><?php echo htmlspecialchars($cat['nombre']); ?></option>
                        <?php endforeach; ?>
                    </select>
                </label>

                <div style="display:flex; gap:10px;">
                    <label style="flex:1;">
                        <span style="font-size:12px; font-weight:700; color: var(--azul-cielo);">Costo:</span>
                        <input type="number" step="0.01" name="costo" required style="width:100%; padding:10px; background:#000; color:#fff; border:1px solid var(--azul-cielo); border-radius:8px;">
                    </label>
                    <label style="flex:1;">
                        <span style="font-size:12px; font-weight:700; color: var(--azul-cielo);">Precio:</span>
                        <input type="number" step="0.01" name="precio" required style="width:100%; padding:10px; background:#000; color:#fff; border:1px solid var(--azul-cielo); border-radius:8px;">
                    </label>
                </div>

                <label>
                    <span style="font-size:12px; font-weight:700; color: var(--azul-cielo);">Cantidad en Inventario:</span>
                    <input type="number" name="cantidad" required style="width:100%; padding:10px; background:#000; color:#fff; border:1px solid var(--azul-cielo); border-radius:8px;">
                </label>

                <label>
                    <span style="font-size:12px; font-weight:700; color: var(--azul-cielo);">Seleccionar Imagen:</span>
                    <input type="file" name="imagen" accept="image/*" style="width:100%; padding:6px; color:#fff; font-size:12px;">
                </label>

                <button type="submit" name="guardar_producto" class="btn-checkout" style="margin-top:10px;">💾 Guardar Producto</button>
            </form>
        </section>
    </main>
</body>
</html>
