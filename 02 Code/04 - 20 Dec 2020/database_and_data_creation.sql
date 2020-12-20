/* Database creation*/

/* Drop outdated version if it exists */
DROP database IF EXISTS shoeshop;

/* Create the database */
CREATE DATABASE `shoeshop` DEFAULT CHARACTER SET = 'utf8' DEFAULT COLLATE 'utf8_general_ci';

/*tell which database to use*/
USE shoeshop;

#######################################

/* Create the database's tables */

/* General tables */

/* Stock */
drop table if exists `stock`;
CREATE TABLE IF NOT EXISTS `stock` (
	`product_ID` INTEGER unsigned auto_increment NOT NULL,
    `name` varchar(30) DEFAULT NULL,
    `type` varchar(30) DEFAULT NULL,
    `available_quantity` INTEGER unsigned NOT NULL, # 'unsigned' ensures that no 'customer_order_item' rows are created that would decrease 'available_quantity below zero.
    `unit_price` decimal(8,2) NOT NULL,
    primary key (`product_ID`)
);

/* Customer */
drop table if exists `customer`;
create table if not exists `customer` (
	`customer_ID` integer unsigned auto_increment not null,
    `name` varchar(100) default null,
    `phone_number` integer unsigned default null,
    `phone_number_country_prefix` varchar(5) default null,
    `email_address` varchar(100) not null,
    `home_address` varchar(100) default null,
    `age` TINYINT unsigned default null,
    `spending_score` tinyint unsigned default null,
    `spending_category` varchar(10) default null,
    primary key (`customer_ID`)
);

/* Log Price 
This table fills automatically when a price is changed
This behaviour is defined in a trigger */
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

/* Customer-related tables */

/* Customer Order */
drop table if exists `customer_order`;
create table if not exists `customer_order`(
	`customer_order_and_invoice_ID` integer unsigned auto_increment not null,
    `order_date` date not null,
    `shipping_date` date default null,
    `customer_ID` integer unsigned not null,
    `shipping_address` varchar(100) not null,
    `payment_received` boolean default false,
    `invoice_date` date not null,
    `invoice_address` varchar(100) not null,
	`tax_rate_percent` decimal(3,2) not null,
    primary key (`customer_order_and_invoice_ID`)
);

/* Customer Order Item */
drop table if exists `customer_order_item`;
create table if not exists `customer_order_item`(
	`order_item_ID` bigint unsigned auto_increment not null,
	`customer_order_and_invoice_ID` integer unsigned not null,
    `product_ID` INTEGER unsigned NOT NULL,
    `quantity` integer unsigned not null,
    `discount_percent` TINYINT unsigned default 0,
    `rating` decimal(3,1) default null,
    primary key (`order_item_ID`)
);

#######################################

/* Supplier-related tables */

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
	`supplier_order_and_invoice_ID` integer unsigned auto_increment not null,
    `order_date` date not null,
    `products_received` boolean default false,
    `supplier_ID` integer unsigned not null,
    `invoice_date` date not null,
    `paid` boolean default false,
    primary key (`supplier_order_and_invoice_ID`)
);

/* Supplier Order Item */
drop table if exists `supplier_order_item`;
create table if not exists `supplier_order_item`(
	`order_item_ID` bigint unsigned auto_increment not null,
	`supplier_order_and_invoice_ID` integer unsigned not null,
    `product_ID` INTEGER unsigned NOT NULL,
    `quantity` integer unsigned not null,
    primary key (`order_item_ID`)
);

############################################################################################################################################

/* Create foreign keys for the database */

/* create FK for table log_price */
ALTER TABLE `log_price`
ADD CONSTRAINT `fk_log_price_product`
  FOREIGN KEY (`product_ID`) REFERENCES `stock` (`product_ID`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;

/* create FK for table customer_order */
ALTER TABLE `customer_order`
ADD CONSTRAINT `fk_customer_order_customer`
	foreign key (`customer_ID`) references `customer` (`customer_ID`)
		on delete no action
		on update cascade;
  
/* create FK for table customer_order_item */
ALTER TABLE `customer_order_item`
ADD CONSTRAINT `fk_customer_order_item_product`
  FOREIGN KEY (`product_ID`) REFERENCES `stock` (`product_ID`),
ADD CONSTRAINT `fk_customer_order_item_customer_order`
	FOREIGN KEY (`customer_order_and_invoice_ID`) REFERENCES `customer_order` (`customer_order_and_invoice_ID`)
		ON DELETE no action
		ON UPDATE CASCADE;
  
/* create FK for table supplier_order */
ALTER TABLE `supplier_order`
ADD CONSTRAINT `fk_supplier_order_supplier`
	FOREIGN KEY (`supplier_ID`) REFERENCES `supplier` (`supplier_ID`)
		on delete no action
		on update cascade;

/* create FK for table supplier_order_item */
ALTER TABLE `supplier_order_item`
ADD CONSTRAINT `fk_supplier_order_item_supplier_order`
	FOREIGN KEY (`supplier_order_and_invoice_ID`) REFERENCES `supplier_order` (`supplier_order_and_invoice_ID`)
		on delete no action
        on update cascade,
ADD CONSTRAINT `fk_supplier_order_item_product`
	FOREIGN KEY (`product_ID`) REFERENCES `stock` (`product_ID`)
		ON DELETE no action
		ON UPDATE CASCADE;
        
############################################################################################################################################

/* Two products are added to the shop */
insert into `stock` (`name`, `type`, `available_quantity`, `unit_price`) values
('Nike_34', 'sneaker', 10, 61.50),
('Timberland_73', 'boot', 3, 73.20),
('Adidas_48', 'sneaker', 3, 58.20),
('Adidas_35', 'sneaker', 2, 50.70),
('Adidas_40', 'sneaker', 4, 55.25),
('Timberland_70', 'boot', 2, 70.20),
('Nike_38', 'sneaker', 5, 79.20),
('Nike_40', 'sneaker', 6, 80.20),
('Caterpillar_50', 'boot', 2, 68.20),
('Caterpillar_60', 'boot', 1, 73.80),
('Caterpillar_70', 'boot', 4, 75.60),
('New_Balance_30', 'sneaker', 5, 50.20),
('New_Balance_40', 'sneaker', 4, 65.80),
('New_Balance_35', 'sneaker', 6, 70.00),
('Skechers_34', 'sneaker', 5, 75.50),
('Skechers_38', 'sneaker', 4, 60.00),
('Skechers_40', 'sneaker', 6, 64.40),
('Burberry_35', 'high_heels', 5, 95.20),
('Burberry_38', 'high_heels', 4, 90.65),
('Burberry_36', 'high_heels', 4, 93.50)
;

############################################################################################################################################
        
/* Task C. - create triggers */

/* Create the first trigger for task C. */

DROP TRIGGER if exists stock_update;
delimiter $$
create trigger stock_update after insert
on customer_order_item
for each row
begin
	update stock s
    set s.available_quantity = s.available_quantity - NEW.quantity
    where s.product_ID = NEW.product_ID;
end $$
delimiter ;

/* Create the second trigger for task C. */

DROP TRIGGER if exists insert_price_update_log;
delimiter $$
create trigger insert_price_update_log after update
on stock
for each row
begin
	if OLD.unit_price != NEW.unit_price then
		insert into log_price(`product_ID`, `old_unit_price`, `new_unit_price`, `update_date`) values
		(NEW.product_ID, OLD.unit_price, NEW.unit_price, now());
    end if;
end $$
delimiter ;