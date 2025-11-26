-- Base de datos para tienda de dispositivos móviles
CREATE DATABASE IF NOT EXISTS tienda_moviles CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE tienda_moviles;

-- Tabla de usuarios
CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    tipo ENUM('usuario', 'admin') DEFAULT 'usuario',
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de productos
CREATE TABLE IF NOT EXISTS productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(200) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    imagen VARCHAR(255),
    especificaciones TEXT,
    stock INT DEFAULT 0,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabla de carrito
CREATE TABLE IF NOT EXISTS carrito (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT DEFAULT 1,
    fecha_agregado TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (producto_id) REFERENCES productos(id) ON DELETE CASCADE,
    UNIQUE KEY unique_carrito (usuario_id, producto_id)
);

-- Tabla de misión y visión
CREATE TABLE IF NOT EXISTS mision_vision (
    id INT PRIMARY KEY DEFAULT 1,
    mision TEXT NOT NULL,
    vision TEXT NOT NULL,
    valores TEXT,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insertar usuario administrador por defecto (email: admin@admin.com, password: admin123)
INSERT INTO usuarios (nombre, email, password, tipo) VALUES 
('Administrador', 'admin@admin.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin');

-- Insertar algunos productos de ejemplo
INSERT INTO productos (nombre, descripcion, precio, imagen, especificaciones, stock) VALUES
('iPhone 15 Pro', 'El último iPhone con chip A17 Pro y cámara de 48MP', 1299.99, 'assets/img/iphone15.jpg', 'Pantalla: 6.1", Procesador: A17 Pro, RAM: 8GB, Almacenamiento: 256GB', 10),
('Samsung Galaxy S24 Ultra', 'Smartphone premium con S Pen y cámara de 200MP', 1199.99, 'assets/img/s24ultra.jpg', 'Pantalla: 6.8", Procesador: Snapdragon 8 Gen 3, RAM: 12GB, Almacenamiento: 512GB', 8),
('Xiaomi 14 Pro', 'Potente smartphone con pantalla AMOLED y carga rápida', 899.99, 'assets/img/xiaomi14.jpg', 'Pantalla: 6.73", Procesador: Snapdragon 8 Gen 3, RAM: 12GB, Almacenamiento: 256GB', 15),
('Google Pixel 8 Pro', 'Excelente cámara con inteligencia artificial', 999.99, 'assets/img/pixel8.jpg', 'Pantalla: 6.7", Procesador: Tensor G3, RAM: 12GB, Almacenamiento: 128GB', 12);

