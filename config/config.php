<?php

define('DBUSER', 'final');
define('DBPASS', 'final');
define('DBBASE', 'final');
define('DBHOST', '127.0.0.1');
define('RESTABLECERSQL', "SET FOREIGN_KEY_CHECKS=0;
		ALTER TABLE `compras` DROP FOREIGN KEY `compras_ibfk_1`;
		ALTER TABLE `compras` DROP FOREIGN KEY `compras_ibfk_2`;
		DROP TABLE IF EXISTS `clientes`;
		DROP TABLE IF EXISTS `productos`;
		DROP TABLE IF EXISTS `compras`;
		SET FOREIGN_KEY_CHECKS=1;
		CREATE TABLE `clientes` ( `id` int(11) NOT NULL, `email` varchar(255) NOT NULL, `nombre` varchar(255) NOT NULL, `domicilio` text DEFAULT NULL) ENGINE=InnoDB DEFAULT CHARSET=utf8;
		INSERT INTO `clientes` (`id`, `email`, `nombre`, `domicilio`) VALUES (1, 'dmaradona@gmail.com', 'Diego Armando Maradona', NULL), (2, 'rebochini@hotmail.com', 'Rocardo Enrique Bochini', 'Av. Mitre 470'), (3, 'leomessi@barcelonafc.com', 'Lionel Messi', 'Viamonte 1366'), (4, 'gabigol@batistuta.com.ar', 'Gabriel Batistuta', NULL);
		CREATE TABLE `productos` ( `id` int(11) NOT NULL, `descripcion` varchar(255) NOT NULL, `precio` double NOT NULL) ENGINE=InnoDB DEFAULT CHARSET=utf8;
		INSERT INTO `productos` (`id`, `descripcion`, `precio`) VALUES (1, 'Pelota fútbol nº 5', 1400), (2, 'Botines Penalty Brasil 70', 4799.99), (3, 'Camistea entrenamiento Argentina', 5990), (4, 'Pack de medias Nike', 1799.98), (5, 'Pantalón Puma classic', 6200), (6, 'Buzo Le Coq Sportif', 8499.95);
		CREATE TABLE `compras` ( `id_cliente` int(11) NOT NULL, `id_producto` int(11) NOT NULL) ENGINE=InnoDB DEFAULT CHARSET=utf8;
		INSERT INTO `compras` (`id_cliente`, `id_producto`) VALUES (1, 2), (1, 3), (2, 4), (2, 5), (2, 6), (4, 5);
		ALTER TABLE `clientes` ADD PRIMARY KEY (`id`);
		ALTER TABLE `productos` ADD PRIMARY KEY (`id`);
		ALTER TABLE `clientes` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
		ALTER TABLE `productos` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
		ALTER TABLE `compras` ADD CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION, ADD CONSTRAINT `compras_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;");
?>