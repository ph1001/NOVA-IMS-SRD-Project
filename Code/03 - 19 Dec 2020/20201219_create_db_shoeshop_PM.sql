/* Simplified shoe shop database */


/* Drop outdated version if it exists */
DROP database IF EXISTS shoeshop;

/* Create the database */
CREATE DATABASE `shoeshop` DEFAULT CHARACTER SET = 'utf8' DEFAULT COLLATE 'utf8_general_ci';

/*tell which database you will use*/
USE shoeshop;

#######################################

/* Create the database's tables */

/* Stock */
drop table if exists `stock`;
CREATE TABLE IF NOT EXISTS `stock` (
	`product_ID` INTEGER unsigned auto_increment NOT NULL,
    `name` varchar(30) DEFAULT NULL,
    `type` varchar(30) DEFAULT NULL,
    `available_quantity` INTEGER unsigned NOT NULL, # 'unsigned' ensures that no 'customer_order_item' rows are created that would decreate 'available_quantity below zero.
    `unit_price` decimal(8,2) NOT NULL,
    primary key (`product_ID`)
);

/* Customer */
drop table if exists `customer`;
create table if not exists `customer` (
	`customer_ID` integer unsigned auto_increment not null,
    `name` varchar(30) default null,
    `phone_number` integer unsigned default null,
    `phone_number_country_prefix` varchar(5) default null,
    `email_address` varchar(50) default null,
    `home_address` varchar(100) default null,
    `age` TINYINT unsigned default null,
    `spending_score` tinyint unsigned default null,
    `spending category` tinyint unsigned default null,
    primary key (`customer_ID`)
);

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

#######################################

/* Customer Order */
drop table if exists `customer_order`;
create table if not exists `customer_order`(
	`customer_order_ID` integer unsigned auto_increment not null,
    `order_date` date not null,
    `shipping_date` date default null,
    `customer_ID` integer unsigned not null,
    `shipping_address` varchar(100) not null,
    `payment_received` boolean default false,
    `invoice_date` date not null,
    `invoice_address` varchar(100) not null,
	`tax_rate_percent` decimal(3,2) not null,
    `rating` decimal(3,1) default null,
    primary key (`customer_order_ID`)
);

/* Customer Order Item */
drop table if exists `customer_order_item`;
create table if not exists `customer_order_item`(
	`order_item_ID` bigint unsigned auto_increment not null,
	`customer_order_ID` integer unsigned not null,
    `product_ID` INTEGER unsigned NOT NULL,
    `quantity` integer unsigned not null,
    `discount_percent` TINYINT unsigned default 0,
    primary key (`order_item_ID`)
);

#######################################

/* Supplier */
drop table if exists `supplier`;
create table if not exists `supplier`(
	`supplier_ID` integer unsigned auto_increment not null,
    `name` varchar(100) default null,
    `phone_number` integer unsigned default null,
    `email_address` varchar(50) default null,
    `business_address` varchar(100) default null,
    primary key (`supplier_ID`)
);

/* Supplier Order */
drop table if exists `supplier_order`;
create table if not exists `supplier_order`(
	`supplier_order_ID` integer unsigned auto_increment not null,
    `order_date` date not null,
    `products_received` boolean default false,
    `supplier_ID` integer unsigned not null,
    `invoice_date` date not null,
    `paid` boolean default false,
    primary key (`supplier_order_ID`)
);

/* Supplier Order Item */
drop table if exists `supplier_order_item`;
create table if not exists `supplier_order_item`(
	`order_item_ID` bigint unsigned auto_increment not null,
	`supplier_order_ID` integer unsigned not null,
    `product_ID` INTEGER unsigned NOT NULL,
    `quantity` integer unsigned not null,
    primary key (`order_item_ID`)
);