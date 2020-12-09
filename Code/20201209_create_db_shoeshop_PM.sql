/* First draft for implementing the shoe shop database */

/*
To do:
- Understand and implement foreign keys and their "on update", "on delete", etc. behaviour
*/

DROP database IF EXISTS shoeshop;

CREATE DATABASE `shoeshop` DEFAULT CHARACTER SET = 'utf8' DEFAULT COLLATE 'utf8_general_ci';

USE shoeshop;

/* Product */
CREATE TABLE IF NOT EXISTS `product` (
	`product_ID` INTEGER NOT NULL,
    `name` varchar(30) DEFAULT NULL,
    `type` varchar(30) DEFAULT NULL,
    `available_quantity` INTEGER NOT NULL,
    `price` decimal(8,2) NOT NULL,
    primary key (`product_ID`)
);

/* Customer */
create table if not exists `customer` (
	`customer_ID` integer not null,
    `name` varchar(30) default null,
    `phone_number` integer default null,
    `email_address` varchar(50) not null,
    `address_ID` integer default null,
    primary key (`customer_ID`)
);

/* Address */
create table if not exists `address`(
	`address_ID` integer not null,
    `street` varchar(50) default null,
    `house_number` smallint default null,
    `postal_code` varchar(15) not null,
    `city` varchar(30) not null,
    `country_town` varchar(30) not null,
    primary key (`address_ID`)
);

/* Customer Order Details */
create table if not exists `customer_order_details`(
	`customer_order_ID` integer not null,
    `customer_order_date` date not null,
    `shipping_date` date default null,
    `customer_ID` integer not null,
    `customer_invoice_ID` integer not null,
    `address_ID` integer default null,
    primary key (`customer_order_ID`)
);

/* Customer Order Content */
create table if not exists `customer_order_content`(
	`order_item_ID` bigint unsigned auto_increment not null,
	`customer_order_ID` integer not null,
    `product_ID` INTEGER NOT NULL,
    `quantity` integer not null,
    primary key (`order_item_ID`)
);
