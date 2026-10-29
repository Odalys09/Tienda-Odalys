-- Base de Datos para "Tienda de Odalys"
CREATE DATABASE IF NOT EXISTS `tiendita` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `tiendita`;

CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `nombre` VARCHAR(100) NOT NULL,
  `gmail` VARCHAR(100) NOT NULL UNIQUE,
  `contrasena` VARCHAR(255) NOT NULL,
  `tipo` ENUM('admin', 'vendedor') NOT NULL DEFAULT 'vendedor',
  `fecha_creacion` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `categorias` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `nombre` VARCHAR(50) NOT NULL UNIQUE,
  `descripcion` VARCHAR(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `productos` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `codigo_barras` VARCHAR(50) UNIQUE DEFAULT NULL,
  `producto` VARCHAR(100) NOT NULL,
  `id_categoria` INT NOT NULL,
  `costo` DECIMAL(10,2) NOT NULL,
  `precio` DECIMAL(10,2) NOT NULL,
  `cantidad` INT NOT NULL DEFAULT 0,
  `imagen` VARCHAR(255) DEFAULT 'default.png',
  FOREIGN KEY (`id_categoria`) REFERENCES `categorias`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `ventas` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `id_usuario` INT NOT NULL,
  `total` DECIMAL(10,2) NOT NULL,
  `fecha_venta` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`id_usuario`) REFERENCES `usuarios`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `detalle_ventas` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `id_venta` INT NOT NULL,
  `id_producto` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `precio_unitario` DECIMAL(10,2) NOT NULL,
  `subtotal` DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (`id_venta`) REFERENCES `ventas`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`id_producto`) REFERENCES `productos`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `usuarios` (`nombre`, `gmail`, `contrasena`, `tipo`) VALUES
('Odalys (Administradora)', 'admin@odalys.com', 'admin123', 'admin'),
('Vendedor Turno', 'vendedor@odalys.com', 'vend123', 'vendedor')
ON DUPLICATE KEY UPDATE `id`=`id`;

INSERT INTO `categorias` (`id`, `nombre`, `descripcion`) VALUES
(1, 'Lácteos', 'Leche, quesos, cremas y yogures'),
(2, 'Semillas y Granos', 'Frijol, arroz, semillas y frutos secos'),
(3, 'Comida y Enlatados', 'Atún, sopas, salsas y enlatados'),
(4, 'Chatarra y Dulces', 'Papas, galletas, golosinas y chocolates'),
(5, 'Bebidas', 'Refrescos, jugos y aguas preparadas')
ON DUPLICATE KEY UPDATE `nombre`=`nombre`;

INSERT INTO `productos` (`id`, `codigo_barras`, `producto`, `id_categoria`, `costo`, `precio`, `cantidad`, `imagen`) VALUES
(1, '75010001', 'Leche Entera 1L', 1, 21.00, 26.00, 20, 'leche.jfif'),
(2, '75010002', 'Queso Panela 400g', 1, 45.00, 58.00, 10, 'queso.jfif'),
(3, '75010003', 'Yogurt Fresa 1L', 1, 28.00, 36.00, 15, 'yogurt.jfif'),
(4, '75010004', 'Crema Acida 200g', 1, 14.00, 19.00, 12, 'crema.jfif'),
(5, '75010005', 'Frijol Negro 1kg', 2, 28.00, 38.00, 25, 'frijol.jfif'),
(6, '75010006', 'Arroz Blanco 1kg', 2, 20.00, 27.00, 30, 'arroz.jfif'),
(7, '75010007', 'Lenteja Extra 500g', 2, 16.00, 22.00, 18, 'lenteja.jfif'),
(8, '75010008', 'Semillas de Girasol 100g', 2, 10.00, 15.00, 40, 'semillas.jfif'),
(9, '75010009', 'Atun en Agua 140g', 3, 15.00, 21.00, 50, 'atun.jfif'),
(10, '75010010', 'Sopa de Fideo 95g', 3, 6.00, 9.50, 60, 'sopa.jfif'),
(11, '75010011', 'Salsa de Tomate 210g', 3, 8.00, 12.00, 35, 'salsa.jfif'),
(12, '75010012', 'Maiz en Grano 400g', 3, 14.00, 19.50, 22, 'maiz.jfif'),
(13, '75010013', 'Papas Saladas 170g', 4, 30.00, 42.00, 15, 'papas.jfif'),
(14, '75010014', 'Galletas Chocolate 150g', 4, 14.00, 20.00, 28, 'galletas.jfif'),
(15, '75010015', 'Chocolatina con Leche', 4, 10.00, 15.00, 45, 'chocolate.jfif'),
(16, '75010016', 'Gomitas Enchiladas 80g', 4, 11.00, 16.50, 30, 'gomitas.jfif'),
(17, '75010017', 'Refresco Cola 600ml', 5, 13.50, 18.00, 40, 'refresco.jfif'),
(18, '75010018', 'Jugo de Naranja 1L', 5, 20.00, 28.00, 20, 'jugo.jfif'),
(19, '75010019', 'Agua Purificada 1.5L', 5, 9.00, 14.00, 50, 'agua.jfif'),
(20, '75010020', 'Bebida Energizante 473ml', 5, 26.00, 38.00, 15, 'energizante.jfif')
ON DUPLICATE KEY UPDATE 
  `imagen` = VALUES(`imagen`),
  `producto` = VALUES(`producto`);
