/* First draft for implementing the shoe shop database */

DROP database IF EXISTS shoeshop;

CREATE DATABASE `shoeshop` DEFAULT CHARACTER SET = 'utf8' DEFAULT COLLATE 'utf8_general_ci';

USE shoeshop;

/* Product */
CREATE TABLE IF NOT EXISTS `product` (
	`product_number` INTEGER NOT NULL,
    `product_name` varchar(30) DEFAULT NULL,
    `product_type` varchar(30) DEFAULT NULL,
    `available_quantity` INTEGER NOT NULL,
    `product_price` decimal(8,2) NOT NULL
);