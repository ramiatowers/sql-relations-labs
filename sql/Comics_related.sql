SELECT DATABASE();

DROP DATABASE IF EXISTS lab_productos;
CREATE DATABASE lab_productos
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_0900_ai_ci;

SHOW DATABASES LIKE 'lab_productos';

-- Usar la BD
USE lab_productos;

-- Categorías (1 → N productos)
CREATE TABLE categorias (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(60) NOT NULL UNIQUE,
  descripcion VARCHAR(200)
) ENGINE=InnoDB;

CREATE TABLE productos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(80) NOT NULL,
  precio DECIMAL(10,2) NOT NULL,
  categoria_id INT NOT NULL,
  CONSTRAINT fk_producto_categoria
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- 3 categorías
INSERT INTO categorias (nombre, descripcion) VALUES
('Electrónica','Dispositivos y accesorios'),
('Hogar','Cocina y limpieza'),
('Libros','Ficción y no ficción');

-- 6 productos (relacionados)
INSERT INTO productos (nombre, precio, categoria_id) VALUES
('Auriculares Bluetooth', 59.90, (SELECT id FROM categorias WHERE nombre='Electrónica')),
('Teclado Mecánico',      89.00, (SELECT id FROM categorias WHERE nombre='Electrónica')),
('Freidora de aire',     139.00, (SELECT id FROM categorias WHERE nombre='Hogar')),
('Pack sábanas',          34.50, (SELECT id FROM categorias WHERE nombre='Hogar')),
('Novela negra',          18.95, (SELECT id FROM categorias WHERE nombre='Libros')),
('Manual de SQL',         24.99, (SELECT id FROM categorias WHERE nombre='Libros'));

-- Ejemplo de consulta: producto + su categoría
SELECT p.id, p.nombre, p.precio, c.nombre AS categoria
FROM productos p
JOIN categorias c ON p.categoria_id = c.id
ORDER BY c.nombre, p.nombre;

-- Consultas
SELECT DATABASE();                         
SHOW TABLES;                               
SELECT COUNT(*) FROM categorias;          
SELECT COUNT(*) FROM productos;            
SELECT p.id, p.nombre, c.nombre categoria  
FROM productos p JOIN categorias c ON p.categoria_id=c.id;