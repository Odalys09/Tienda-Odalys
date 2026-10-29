<?php  
require_once __DIR__ . '/conexion.php';

$categorias = $conexion->query("SELECT * FROM categorias ORDER BY nombre ASC")->fetch_all(MYSQLI_ASSOC);

$sql = "SELECT p.*, c.nombre as categoria_nombre 
        FROM productos p 
        JOIN categorias c ON p.id_categoria = c.id 
        ORDER BY p.id ASC";
$productos = $conexion->query($sql)->fetch_all(MYSQLI_ASSOC);
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tienda de Odalys | Punto de Venta</title>
    <link rel="stylesheet" href="estilos.css">
    <script src="script.js" defer></script>
</head>
<body>
    <header class="site-header">
        <div class="header-content">
            <a href="index.php" class="brand">
                <span class="brand-badge">O</span>
                <span>Tienda de Odalys</span>
            </a>
            <div class="nav-links">
                <a href="index.php" class="nav-btn active">🛒 Punto de Venta</a>
                <a href="admin_productos.php" class="nav-btn">⚙️ Administrar Productos</a>
                <a href="ventas_dia.php" class="nav-btn">📊 Ventas del Día</a>
            </div>
        </div>
    </header>

    <main class="main-layout">
        <section class="catalog-section">
            <div class="section-top">
                <h1 style="font: 900 24px var(--font); margin: 0; color: var(--azul-cielo);">Catálogo de Productos</h1>
                <input type="search" id="search-box" class="search-input" placeholder="🔍 Buscar producto...">
            </div>

            <div class="category-bar">
                <button class="cat-chip active" data-cat="all">Todos (<?php echo count($productos); ?>)</button>
                <?php foreach ($categorias as $cat): ?>
                    <button class="cat-chip" data-cat="<?php echo htmlspecialchars($cat['nombre']); ?>">
                        <?php echo htmlspecialchars($cat['nombre']); ?>
                    </button>
                <?php endforeach; ?>
            </div>

            <div class="products-grid" id="products-container">
                <?php foreach ($productos as $prod): ?>
                    <?php 
                        $imgName = trim($prod['imagen']);
                        $imgSrc = 'img/' . $imgName;
                        
                        // Si la imagen en BD no tiene extensión, busca el archivo existente en img/
                        if (!pathinfo($imgName, PATHINFO_EXTENSION)) {
                            foreach (['.jfif', '.png', '.jpg', '.jpeg'] as $ext) {
                                if (file_exists(__DIR__ . '/img/' . $imgName . $ext)) {
                                    $imgSrc = 'img/' . $imgName . $ext;
                                    break;
                                }
                            }
                        }
                    ?>
                    <div class="product-card" data-category="<?php echo htmlspecialchars($prod['categoria_nombre']); ?>" data-name="<?php echo strtolower(htmlspecialchars($prod['producto'])); ?>">
                        <div>
                            <img src="<?php echo htmlspecialchars($imgSrc); ?>" alt="<?php echo htmlspecialchars($prod['producto']); ?>" class="product-thumb" onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1542838132-92c53300491e?w=400&q=80';">
                            <h3 class="product-title"><?php echo htmlspecialchars($prod['producto']); ?></h3>
                            <div class="product-price">$<?php echo number_format($prod['precio'], 2); ?></div>
                            <div class="product-stock">Disponible: <strong><?php echo $prod['cantidad']; ?> pcs</strong></div>
                        </div>
                        <button class="btn-add" onclick='addToCart(<?php echo json_encode($prod); ?>)'>+ AGREGAR</button>
                    </div>
                <?php endforeach; ?>
            </div>
        </section>

        <section class="cart-section">
            <h2 class="cart-title">Orden de Venta</h2>
            <div class="cart-items" id="cart-items">
                <p style="color: var(--texto-mutado); text-align: center; margin-top: 40px;">No hay productos en la orden.</p>
            </div>
            <div class="cart-total">
                <span>TOTAL:</span>
                <span id="cart-total-amount">$0.00</span>
            </div>
            <button class="btn-checkout" onclick="processSale()">Completar Venta & Ticket</button>
        </section>
    </main>
</body>
</html>
