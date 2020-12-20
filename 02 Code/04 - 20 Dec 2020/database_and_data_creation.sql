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
	`tax_rate_percent` decimal(8,2) not null,
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
    `rating` decimal(8,2) default null,
    `value_at_time` decimal(8,2) default NULL,
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

/* Create a trigger that adds the correct value for 'value_euro_at_time' to a newly added 'customer_order_item */

DROP TRIGGER if exists add_euro_value_at_time;
delimiter $$
create trigger add_euro_value_at_time before insert
on customer_order_item
for each row
begin
	set new.value_at_time = new.quantity * (select unit_price from stock s where s.product_ID = new.product_ID);
end $$
delimiter ;

############################################################################################################################################

/* Insert data into database */

/* Product data */
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

/* Customer data */
insert into `customer` (`name`, `phone_number`, `phone_number_country_prefix`, `email_address`, `home_address`) values
('Kanna Haniya', '822829974', '+353', 'KannaHaniya@email.com', 'Drury St, 18 D02 W017, Dublin, Ireland'),
('Jorden Hodges', '995877685', '+31', 'dolor@aliquet.org', '348-8958 Feugiat Rd., Utrecht, Netherlands'),
('Keefe Bonner', '599699909', '+353', 'ullamcorper.velit@velitQuisquevarius.edu', 'P.O. Box 475, 5958 Gravida St., Galway, Ireland'),
('Sara Sellers', '745813683', '+44', 'tortor.nibh.sit@Curabitur.net', 'P.O. Box 399, 886 Ullamcorper Road, Kidwelly, United Kingdom'),
('Audra Larsen', '729972735', '+44', 'Curabitur.vel.lectus@laoreetlectus.net', '9140 Etiam Ave, Stranraer, United Kingdom'),
('Dean Giles', '633506725', '+353', 'facilisis@tempus.com', 'Ap #366-8809 Auctor St., Dublin, Ireland'),
('Jacqueline Randolph', '814493759', '+353', 'semper@magnaUttincidunt.edu', 'Evet St. 18, Belfast, Ireland'),
('Ronan Maynard', '808213602', '+44', 'sodales@justonecante.com', '237 Nisi Rd., Aberdeen, United Kingdom'),
('Jana Joyce', '899266181', '+32', 'ipsum@nec.co.uk', '224-7722 Velit Ave, Hulshout, Belgium'),
('Ira Berger', '857278686', '+31', 'eleifend.egestas.Sed@fringilla.com', 'P.O. Box 941, 1926 Sed St., Hilversum, Netherlands'),
('Uma Parks', '347749363', '+31', 'egestas.a.dui@dolorQuisque.co.uk', 'P.O. Box 606, 8076 Purus St., Lelystad, Netherlands'),
('Lael Willis', '904200138', '+32', 'suscipit.nonummy.Fusce@blanditmattisCras.co.uk', 'Ap #779-6050 Faucibus St., WagnelŽe, Belgium'),
('Delilah Golden', '821885741', '+31', 'cursus.Integer.mollis@magna.net', '497-9085 Lacus. Street, Huissen, Netherlands'),
('McKenzie Greene', '869564481', '+31', 'Integer.sem@Proin.edu', 'Ap #150-131 Eget Rd., Zutphen, Netherlands'),
('Summer Ball', '077798695', '+31', 'purus.Duis@enim.co.uk', '343-6872 Orci. Ave, Zutphen, Netherlands'),
('Chanda Newton', '856986328', '+353', 'Nam@Ut.org', '4069 Turpis. Ave, Cork, Ireland'),
('Delilah Golden', '821885741', '+31', 'cursus.Integer.mollis@magna.net', '497-9085 Lacus. Street, Huissen, Netherlands'),
('McKenzie Greene', '869564481', '+353', 'Integer.sem@Proin.edu', '343-6872 Orci. Ave, Dublin, Ireland'),
('Chanda Newton', '856986328', '+353', 'Nam@Ut.org', 'Ap #150-131 Eget Rd., Broechem, Belgium'),
('Castor Rose', '081345722', '+44', 'ac@ligulaconsectetuerrhoncus.ca', '836-3802 Blandit Street, Lerwick, United Kingdom')
;

/* Historical customer order data */
insert into `customer_order` (`order_date`, `shipping_date`, `customer_ID`, `shipping_address`, `payment_received`, `invoice_date`, `invoice_address`, `tax_rate_percent`) values
('2018-01_01', '2018-01_03', 1, 'Drury St, 18 D02 W017, Dublin, Ireland', true, '2018-01_02', 'Drury St, 18 D02 W017, Dublin, Ireland', 10.00),
('2018-02_12', '2018-02_15', 2, '348-8958 Feugiat Rd., Utrecht, Netherlands',true, '2018-02_14','348-8958 Feugiat Rd., Utrecht, Netherlands',10.00),
('2018-05_20', '2018-05_29', 3,  'P.O. Box 475, 5958 Gravida St., Galway, Ireland',true, '2018-05_25','P.O. Box 475, 5958 Gravida St., Galway, Ireland', 10.00),
('2018-09_20', '2018-09_29', 4, 'P.O. Box 399, 886 Ullamcorper Road, Kidwelly, United Kingdom',true, '2018-09_25','P.O. Box 399, 886 Ullamcorper Road, Kidwelly, United Kingdom', 10.00),
('2018-10_06', '2018-10_10', 5, '9140 Etiam Ave, Stranraer, United Kingdom',true, '2018-10_08','9140 Etiam Ave, Stranraer, United Kingdom',12.00),
('2018-11_01', '2018-11_06', 6,  'Ap #366-8809 Auctor St., Dublin, Ireland',true, '2018-11_04','Ap #366-8809 Auctor St., Dublin, Ireland',12.00),
('2018-12_19', '2018-12_21', 7, 'Evet St. 18, Belfast, Ireland',true, '2018-12_20','Drury St, 18 D02 W017, Belfast, Ireland',12.00),
('2019-01_16', '2019-01_20', 8, '237 Nisi Rd., Aberdeen, United Kingdom',true, '2019-01_19','237 Nisi Rd., Aberdeen, United Kingdom',12.00),
('2019-05_20', '2019-05_22', 4, '224-7722 Velit Ave, Hulshout, Belgium',true, '2019-05_21','224-7722 Velit Ave, Hulshout, Belgium',12.00),
('2019-08_15', '2019-08_19', 9, 'P.O. Box 941, 1926 Sed St., Hilversum, Netherlands',true, '2019-08_18','P.O. Box 941, 1926 Sed St., Hilversum, Netherlands',12.00),
('2019-10_05', '2019-10_10', 10, 'P.O. Box 606, 8076 Purus St., Lelystad, Netherlands',true, '2019-10_08','P.O. Box 606, 8076 Purus St., Lelystad, Netherlands',12.00),
('2019-11_01', '2019-11_03', 11, 'Ap #779-6050 Faucibus St., WagnelŽe, Belgium',true, '2019-11_02','Ap #779-6050 Faucibus St., WagnelŽe, Belgium',10.00),
('2019-12_23', '2019-12_26', 12, '497-9085 Lacus. Street, Huissen, Netherlands',true, '2019-12_24','497-9085 Lacus. Street, Huissen, Netherlands',10.00),
('2020-02_13', '2020-02_15', 13, 'Ap #150-131 Eget Rd., Zutphen, Netherlands',true, '2020-02_14','Ap #150-131 Eget Rd., Zutphen, Netherlands',10.00),
('2020-03_07', '2020-03_10', 2, '343-6872 Orci. Ave, Zutphen, Netherlands',true, '2020-03_09','343-6872 Orci. Ave, Zutphen, Netherlands',10.00),
('2020-05_01', '2020-05_05', 14, '4069 Turpis. Ave, Cork, Ireland',true, '2020-05_02','4069 Turpis. Ave, Cork, Ireland',10.00),
('2020-10_18', '2020-10_19', 15, '497-9085 Lacus. Street, Huissen, Netherlands',true, '2020-10_19','497-9085 Lacus. Street, Huissen, Netherlands',10.00),
('2020-11_18', null, 16, '343-6872 Orci. Ave, Dublin, Ireland',false, '2020-11_18','343-6872 Orci. Ave, Dublin, Ireland',10.00),
('2020-12_19', '2020-12_21', 17, 'Ap #150-131 Eget Rd., Broechem, Belgium',true, '2020-12_20','Ap #150-131 Eget Rd., Broechem, Belgium',10.00),
('2020-12_19', null, 18, '836-3802 Blandit Street, Lerwick, United Kingdom',false, '2020-12_20','836-3802 Blandit Street, Lerwick, United Kingdom',10.00)
;

/* Customer order items belonging to the orders specified above */
insert into `customer_order_item`(`customer_order_and_invoice_ID`, `product_ID`, `quantity`, `discount_percent`, `rating`) values
(1, 5, 2, 10, 4.1), (1, 4, 1, null, 4.3),
(2, 5, 2, null, 3.6),
(3, 8, 1, null, 4.7), (3, 20, 1, null, 3.1), (3, 7, 1, null, 5.0),
(4, 5, 2, null, 4.2), (4, 3, 1, null, 2.1),
(5, 13, 3, null, 3.5),
(6, 15, 1, null, 5.0), (6, 9, 1, null, 4.9), (6, 1, 1, null, 4.5), (6, 4, 1, null, 3.5),
(7, 20, 1, null, 2.8),
(8, 14, 1, null, 4.2), (8, 4, 1, null, 4.0),
(9, 2, 1, null, 3.6),
(10, 17, 1, null, 4.7), (10, 8, 1, null, 4.9), (10, 6, 1, null, 5.0),
(11, 13, 1, null, 5.0),
(12, 7, 1, null, 4.3),
(13, 17, 1, null, 4.6),
(14, 14, 1, null, 3.8),
(15, 9, 1, null, 3.5), (15, 13, 1, null, 3.9), (15, 17, 1, null, 2.5), (15, 16, 1, null, 4.3),
(16, 5, 1, null, 4.4),
(17, 11, 1, null, 2.1),
(18, 4, 1, null, 5.0), (18, 8, 1, null, 4.3),
(19, 8, 1, null, 4.4),
(20, 5, 1, null, 5.0);

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