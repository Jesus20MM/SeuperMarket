CREATE DATABASE proyecto_cliente;

USE proyecto_cliente;


#   ======= TABLA OTIGINAL =======

CREATE TABLE ventas_original (
    id INT AUTO_INCREMENT PRIMARY KEY,       -- Identificador único para cada registro
    ship_mode VARCHAR(50) NOT NULL,          -- Modo de envío (Second Class, Standard Class, etc.)
    segment VARCHAR(50) NOT NULL,            -- Segmento del cliente (Consumer, Corporate, Home Office)
    country VARCHAR(100) NOT NULL,           -- País (ej. United States)
    city VARCHAR(100) NOT NULL,              -- Ciudad
    state VARCHAR(100) NOT NULL,             -- Estado
    postal_code INT,                         -- Código postal (ej. 42420)
    region VARCHAR(50) NOT NULL,             -- Región (South, West, East, Central)
    category VARCHAR(50) NOT NULL,           -- Categoría del producto
    sub_category VARCHAR(50) NOT NULL,       -- Subcategoría del producto
    sales DECIMAL(10,2) NOT NULL,            -- Ventas (ej. 731.94)
    quantity INT NOT NULL,                   -- Cantidad de productos vendidos
    discount DECIMAL(4,2) NOT NULL,          -- Descuento aplicado (ej. 0.20 = 20%)
    profit DECIMAL(10,2) NOT NULL            -- Ganancia obtenida
);














#   ======= NORMALIZACION ======

CREATE TABLE ventas (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    cliente_id BIGINT NOT NULL,
    producto_id BIGINT NOT NULL,
    ubicacion_id BIGINT NOT NULL,
    sales DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    discount DECIMAL(4,2) NOT NULL,
    profit DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (producto_id) REFERENCES productos(id),
    FOREIGN KEY (ubicacion_id) REFERENCES ubicaciones(id)
);





CREATE TABLE clientes (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    segment VARCHAR(50) NOT NULL
);



CREATE TABLE productos (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    category VARCHAR(50) NOT NULL,
    sub_category VARCHAR(50) NOT NULL
);


CREATE TABLE ubicaciones (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    country VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    postal_code INT,
    region VARCHAR(50) NOT NULL,
    ship_mode VARCHAR(50) NOT NULL
);



#   ======= Insertar datos a las tablas normalizadas ======


INSERT INTO clientes (segment)
SELECT DISTINCT segment
FROM ventas_original;


INSERT INTO productos (category, sub_category)
SELECT DISTINCT category, sub_category
FROM ventas_original;


INSERT INTO ubicaciones (country, city, state, postal_code, region, ship_mode)
SELECT DISTINCT country, city, state, postal_code, region, ship_mode
FROM ventas_original;


INSERT INTO ventas (cliente_id, producto_id, ubicacion_id, sales, quantity, discount, profit)
SELECT 
    c.id AS cliente_id,
    p.id AS producto_id,
    u.id AS ubicacion_id,
    vo.sales,
    vo.quantity,
    vo.discount,
    vo.profit
FROM ventas_original vo
JOIN clientes c 
    ON vo.segment = c.segment
JOIN productos p 
    ON vo.category = p.category 
   AND vo.sub_category = p.sub_category
JOIN ubicaciones u 
    ON vo.country = u.country
   AND vo.city = u.city
   AND vo.state = u.state
   AND vo.postal_code <=> u.postal_code   -- <=> permite comparar NULL correctamente
   AND vo.region = u.region
   AND vo.ship_mode = u.ship_mode;



SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM ubicaciones;
SELECT * FROM ventas;