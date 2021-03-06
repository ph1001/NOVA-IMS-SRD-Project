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
	`product_ID` INTEGER unsigned auto_increment NOT NULL,
    `name` varchar(30) DEFAULT NULL,
    `type` varchar(30) DEFAULT NULL,
    `available_quantity` INTEGER unsigned NOT NULL,
    `price` decimal(8,2) NOT NULL,
    primary key (`product_ID`)
);

/* Address */
drop table if exists `address`;
create table if not exists `address`(
	`address_ID` integer unsigned auto_increment not null,
    `street` varchar(50) default null,
    `house_number` smallint unsigned default null,
    `house_number_addition` varchar(5) default null,
    `postal_code` varchar(15) not null,
    `city` varchar(30) not null,
    `country_town` varchar(30) not null,
    primary key (`address_ID`)
);

/* Customer */
drop table if exists `customer`;
create table if not exists `customer` (
	`customer_ID` integer unsigned auto_increment not null,
    `name` varchar(30) default null,
    `phone_number` integer unsigned default null,
    `phone_number_country_prefix` varchar(5) default null,
    `email_address` varchar(50) not null,
    `address_ID` integer unsigned default null,
    primary key (`customer_ID`)
);

/* Customer Order Details */
drop table if exists `customer_order_details`;
create table if not exists `customer_order_details`(
	`customer_order_ID` integer unsigned auto_increment not null,
    `order_date` date not null,
    `shipping_date` date default null,
    `customer_ID` integer unsigned not null,
    `customer_invoice_ID` integer unsigned default null,
    `address_ID` integer unsigned default null, # This is the shipping address and potentially different to the customer's address or the invoice address.
    primary key (`customer_order_ID`)
);

/* Customer Order Content */
drop table if exists `customer_order_content`;
create table if not exists `customer_order_content`(
	`order_item_ID` bigint unsigned auto_increment not null,
	`customer_order_ID` integer unsigned not null,
    `product_ID` INTEGER unsigned NOT NULL,
    `quantity` integer unsigned not null,
    primary key (`order_item_ID`)
);

/* Customer Invoice */
drop table if exists `customer_invoice`;
create table if not exists `customer_invoice`(
	`customer_invoice_ID` integer unsigned auto_increment not null,
	`customer_order_ID` integer unsigned not null,
	`invoice_date` date not null, 
    `payment_received` boolean default false,
    `address_ID` integer unsigned not null,
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
    `address_ID` integer unsigned default null,
    primary key (`supplier_ID`)
);

/* Supplier Order Details */
drop table if exists `supplier_order_details`;
create table if not exists `supplier_order_details`(
	`supplier_order_ID` integer unsigned auto_increment not null,
    `order_date` date not null,
    `products_received` boolean default false,
    `supplier_ID` integer unsigned not null,
    `supplier_invoice_ID` integer unsigned default null,
    primary key (`supplier_order_ID`)
);

/* Supplier Order Content */
drop table if exists `supplier_order_content`;
create table if not exists `supplier_order_content`(
	`order_item_ID` bigint unsigned auto_increment not null,
	`supplier_order_ID` integer unsigned not null,
    `product_ID` INTEGER unsigned NOT NULL,
    `quantity` integer unsigned not null,
    primary key (`order_item_ID`) 
);

/* Supplier Invoice */
drop table if exists `supplier_invoice`;
create table if not exists `supplier_invoice`(
	`supplier_invoice_ID` integer unsigned auto_increment not null,
	`supplier_order_ID` integer unsigned not null,
	`invoice_date` date not null, 
    `paid` boolean default false,
    primary key (`supplier_invoice_ID`)
);