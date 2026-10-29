# Plan de Trabajo y Estimación Comercial: Sistema Punto de Venta "Tienda de Odalys"

## 1. Resumen del Proyecto
El proyecto **"Tienda de Odalys"** es un sistema web de Punto de Venta (POS) e inventario diseñado para pequeños establecimientos. Permite gestionar transacciones rápidas, control de inventarios automatizado, administración de productos y categorías, reportes de ventas y gestión de usuarios diferenciados (Vendedor y Administrador).

---

## 2. Plan de Trabajo (Fases de Desarrollo)

### Fase 1: Arquitectura y Base de Datos (Completada)
- [x] Diseño del modelo Entidad-Relación (E-R) optimizado.
- [x] Creación de tablas: `usuarios`, `categorias`, `productos`, `ventas` y `detalle_ventas`.
- [x] Inserción de 20 productos iniciales divididos en 5 categorías principales.

### Fase 2: Módulo Punto de Venta (Vendedor)
- [x] Interfaz de búsqueda de productos con filtrado dinámico.
- [x] Carrito de compras en tiempo real con validación estricta de stock.
- [x] Descuento automático de inventario al procesar ventas.
- [x] Historial e informe diario de ventas para el vendedor (`ventas_dia.php`).
- [x] Generación e impresión de ticket de venta.

### Fase 3: Módulo de Administración (Admin)
- [x] CRUD completo de productos con imágenes personalizadas.
- [x] Nueva paleta de colores vibrante (Rosa Fiusha, Negro Neón y Azul Cielo).

---

## 3. Estimación de Precio Comercial y Cotización

| Concepto | Descripción | Costo (MXN) | Costo (USD) |
| :--- | :--- | :--- | :--- |
| **Desarrollo del Sistema POS** | Módulos Vendedor + Admin, CRUDs, Stock automatizado y Tickets | $6,500 MXN | $360 USD |
| **Nombre de Dominio (.com o .com.mx)** | Registro por 1 año (ej. `tiendadeodalys.com`) | $350 MXN | $20 USD |
| **Hosting Web (Servidor MySQL/PHP)** | Plan Hosting Esencial / CPanel por 1 año | $1,200 MXN | $65 USD |
| **Capacitación e Instalación** | Configuración local (XAMPP) y entrenamiento a personal | $1,000 MXN | $55 USD |
| **TOTAL ESTIMADO** | **Proyecto Completo Llave en Mano** | **$9,050 MXN** | **$500 USD** |
