create database supermarket;

use supermarket;


select * from ventas_visualizaciones;


#Limpiamos los nombres de las columnas
ALTER TABLE ventas_visualizaciones
    RENAME COLUMN `Modo_de_envÃ­o` TO `Modo_de_envio`,
    RENAME COLUMN `CategorÃ­a` TO `Categoria`,
    RENAME COLUMN `SubcategorÃ­a` TO `Subcategoria`,
    RENAME COLUMN `RegiÃ³n` TO `Region`;



