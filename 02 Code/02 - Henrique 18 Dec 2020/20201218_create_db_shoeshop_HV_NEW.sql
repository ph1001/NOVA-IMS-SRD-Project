/* First draft for implementing the shoe shop database */

/*
To do:
- Understand and implement foreign keys and their "on update", "on delete", etc. behaviour
- Make sure that no quantities higher than the stocked quantities are ordered
*/

DROP database IF EXISTS shoeshop;

CREATE DATABASE `shoeshop` DEFAULT CHARACTER SET = 'utf8' DEFAULT COLLATE 'utf8_general_ci';

USE shoeshop;

/* Product */
drop table if exists `product`;
CREATE TABLE IF NOT EXISTS `product` (
	`product_ID` integer unsigned auto_increment NOT NULL,
    `name` varchar(30) DEFAULT NULL,
    `type` varchar(30) DEFAULT NULL,
    `available_quantity` INTEGER unsigned NOT NULL,
    `unit_price` decimal(8,2) NOT NULL,
    `tax` INT not null,
    primary key (`product_ID`)
);


/* Customer */
drop table if exists `customer`;
create table if not exists `customer` (
	`customer_ID` integer unsigned auto_increment not null,
    `name` varchar(30) default null,
    `phone_number` integer unsigned default null,
    `email_address` varchar(50) not null,
    `address` varchar(100) not null,
    primary key (`customer_ID`)
);


/* Customer Invoice */
drop table if exists `customer_invoice`;
create table if not exists `customer_invoice`(
	`customer_invoice_ID` integer unsigned auto_increment not null,
	`customer_ID` integer unsigned not null,
	`product_ID` integer unsigned NOT NULL,
    `quantity` integer unsigned not null,
    `unit_price` decimal(8,2) NOT NULL,
    `tax` INT not null,
	`invoice_date` date not null, 
    `address` varchar(100) not null,
    primary key (`customer_invoice_ID`)
);

#############

/* Supplier */
drop table if exists `supplier`;
create table if not exists `supplier`(
	`supplier_ID` integer unsigned auto_increment not null,
    `name` varchar(100) default null,
    `phone_number` integer unsigned default null,
    `email_address` varchar(50) default null,
    `address` varchar(100) not null,
    primary key (`supplier_ID`)
);


/* Supplier Invoice */
drop table if exists `supplier_invoice`;
create table if not exists `supplier_invoice`(
	`supplier_invoice_ID` integer unsigned auto_increment not null,
	`supplier_ID` integer unsigned not null,
    `product_ID` integer unsigned NOT NULL,
    `quantity` integer unsigned not null,
    `total_amount` decimal(8,2) NOT NULL,
	`invoice_date` date not null,
    `address` varchar(100) not null,
    primary key (`supplier_invoice_ID`)
);

########

/* Log Price */
drop table if exists `log_price`;
CREATE TABLE IF NOT EXISTS `log_price` (
	`log_ID` INTEGER unsigned auto_increment NOT NULL,
    `product_ID` INTEGER unsigned NOT NULL,
    `old_unit_price` decimal(8,2) NOT NULL,
    `new_unit_price` decimal(8,2) NOT NULL,
    `update_date` date not null,
    primary key (`log_ID`)
);