-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-10-2026 a las 05:30:29
-- Versión del servidor: 10.11.16-MariaDB
-- Versión de PHP: 8.3.36

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `tiendita`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `nombre`, `descripcion`) VALUES
(1, 'Lácteos', 'Leche, quesos, cremas y yogures'),
(2, 'Semillas y Granos', 'Frijol, arroz, semillas y frutos secos'),
(3, 'Comida y Enlatados', 'Atún, sopas, salsas y enlatados'),
(4, 'Chatarra y Dulces', 'Papas, galletas, golosinas y chocolates'),
(5, 'Bebidas', 'Refrescos, jugos y aguas preparadas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_ventas`
--

CREATE TABLE `detalle_ventas` (
  `id` int(11) NOT NULL,
  `id_venta` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_ventas`
--

INSERT INTO `detalle_ventas` (`id`, `id_venta`, `id_producto`, `cantidad`, `precio_unitario`, `subtotal`) VALUES
(1, 1, 24, 1, 19.00, 19.00),
(2, 1, 22, 1, 58.00, 58.00),
(3, 1, 21, 1, 26.00, 26.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` int(11) NOT NULL,
  `codigo_barras` varchar(50) DEFAULT NULL,
  `producto` varchar(100) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `costo` decimal(10,2) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `cantidad` int(11) NOT NULL DEFAULT 0,
  `imagen` varchar(255) DEFAULT 'default.png'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `codigo_barras`, `producto`, `id_categoria`, `costo`, `precio`, `cantidad`, `imagen`) VALUES
(21, NULL, 'Leche Entera 1L', 1, 20.00, 26.00, 19, '1793246656_6ae2c5c02b0a6.jfif'),
(22, NULL, 'Queso', 1, 50.00, 58.00, 9, '1793246695_6ae2c5e797b71.jfif'),
(23, NULL, 'Yogurt Fresa', 1, 20.00, 36.00, 15, '1793246741_6ae2c61549ee5.jfif'),
(24, NULL, 'Crema', 1, 15.00, 19.00, 11, '1793246803_6ae2c6539a146.jfif'),
(25, NULL, 'Frijol', 2, 30.00, 38.00, 25, '1793246848_6ae2c6804a256.jfif'),
(26, NULL, 'Arroz', 2, 27.00, 30.00, 30, '1793246875_6ae2c69b8b9f1.jfif'),
(27, NULL, 'Lenteja', 2, 22.00, 27.00, 18, '1793246931_6ae2c6d3ef902.jfif'),
(28, NULL, 'Semillas', 2, 15.00, 25.00, 40, '1793246969_6ae2c6f96d718.jfif'),
(29, NULL, 'Atun en Agua', 3, 35.00, 45.00, 15, '1793247013_6ae2c72564857.jfif'),
(30, NULL, 'Sopa de Fideo', 3, 15.00, 20.00, 60, '1793247087_6ae2c76f80180.jfif'),
(31, NULL, 'Salsa', 3, 12.00, 17.00, 35, '1793247114_6ae2c78a25e6f.jfif'),
(32, NULL, 'Maiz', 2, 19.00, 24.00, 22, '1793247140_6ae2c7a42cf48.jfif'),
(33, NULL, 'Papas', 4, 15.00, 25.00, 17, '1793247189_6ae2c7d560d11.jfif'),
(34, NULL, 'Galletas', 4, 20.00, 40.00, 28, '1793247239_6ae2c807226a2.jfif'),
(35, NULL, 'Chocolate', 4, 15.00, 25.00, 45, '1793247262_6ae2c81ed49a5.jfif'),
(36, NULL, 'Gomitas', 4, 16.00, 20.00, 30, '1793247292_6ae2c83ca2e61.jfif'),
(37, NULL, 'Refresco', 5, 18.00, 25.00, 40, '1793247332_6ae2c8643620f.jfif'),
(38, NULL, 'Jugo de Naranja', 5, 20.00, 28.00, 20, '1793247364_6ae2c8847cf82.jfif'),
(39, NULL, 'Agua', 5, 15.00, 35.00, 100, '1793247395_6ae2c8a307f5a.jfif'),
(40, NULL, 'Energizante', 5, 30.00, 40.00, 15, '1793247423_6ae2c8bfdb748.jfif');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `gmail` varchar(100) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `tipo` enum('admin','vendedor') NOT NULL DEFAULT 'vendedor',
  `fecha_creacion` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `gmail`, `contrasena`, `tipo`, `fecha_creacion`) VALUES
(1, 'Odalys (Administradora)', 'admin@odalys.com', 'admin123', 'admin', '2026-10-29 04:00:46'),
(2, 'Vendedor Turno', 'vendedor@odalys.com', 'vend123', 'vendedor', '2026-10-29 04:00:46');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `fecha_venta` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id`, `id_usuario`, `total`, `fecha_venta`) VALUES
(1, 1, 103.00, '2026-10-29 04:27:27');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_venta` (`id_venta`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `codigo_barras` (`codigo_barras`),
  ADD KEY `id_categoria` (`id_categoria`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `gmail` (`gmail`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  ADD CONSTRAINT `detalle_ventas_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `detalle_ventas_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
