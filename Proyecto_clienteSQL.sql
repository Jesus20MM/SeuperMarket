CREATE DATABASE proyecto_cliente;

DROP DATABASE proyecto_cliente;

USE proyecto_cliente;


#   ======= TABLA OTIGINAL =======

select * from ventas_original limit 10;#tabla cargada




#   ======= NORMALIZACION ======

CREATE TABLE envios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ship_mode VARCHAR(50) NOT NULL
);

CREATE TABLE segmentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    segment VARCHAR(50) NOT NULL
);

CREATE TABLE ubicaciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    country VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    postal_code INT,
    region VARCHAR(50) NOT NULL
);

CREATE TABLE categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category VARCHAR(50) NOT NULL,
    sub_category VARCHAR(50) NOT NULL
);

CREATE TABLE ventas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    envio_id INT NOT NULL,
    segmento_id INT NOT NULL,
    ubicacion_id INT NOT NULL,
    categoria_id INT NOT NULL,
    sales DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    discount DECIMAL(4,2) NOT NULL,
    profit DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (envio_id) REFERENCES envios(id),
    FOREIGN KEY (segmento_id) REFERENCES segmentos(id),
    FOREIGN KEY (ubicacion_id) REFERENCES ubicaciones(id),
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);


SELECT * FROM envios;
SELECT * FROM segmentos;
SELECT * FROM ubicaciones;
SELECT * FROM categorias;
SELECT * FROM ventas;




