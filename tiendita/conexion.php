<?php  
$host = 'localhost';  
$usuario = 'root';  
$contrasena = '';  
$baseDatos = 'tiendita';

mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

try {  
    $conexion = new mysqli($host, $usuario, $contrasena, $baseDatos);  
    $conexion->set_charset('utf8mb4');  
} catch (mysqli_sql_exception $error) {  
    error_log('Error de conexión a MySQL: ' . $error->getMessage());  
    http_response_code(500);  
    exit('Error de conexión con la base de datos. Verifica la configuración en conexion.php.');  
}
