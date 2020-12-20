/* Insert shoe shop data */

use shoeshop;

/* Two products are added to the shop */
insert into `stock` (`name`, `type`, `available_quantity`, `unit_price`) values
('Nike_34', 'sneaker', 10, 61.50),
('Timberland_73', 'boot', 3, 73.20);


insert into `log_price` (`product_ID`,`old_unit_price`, `new_unit_price`, `update_date`) values
((select product_ID from stock ORDER BY product_ID DESC LIMIT 1),55.00, 11.50,'2020-12_05'),
((select product_ID from stock ORDER BY product_ID DESC LIMIT 1),32.00, 7.20,'2020-12_05');



##########

/* A customer creates an account */
insert into `customer` (`name`, `phone_number`, `phone_number_country_prefix`, `email_address`, `home_address`) values
('Kanna Haniya', '822829974', '+353', 'KannaHaniya@email.com', 'Drury St, 18 D02 W017, Dublin, Ireland');

##########

/* This customer places an order */

/* Check available quantity before the order is placed */
select product_ID, name, available_quantity from stock;

/* Specify which products are ordered and their quantity */
set @item_1_ID = 1;
set @item_1_quantity = 2;
set @item_2_ID = 2;
set @item_2_quantity = 1;

/* Order is created */
insert into `customer_order` (`order_date`, `shipping_date`, `customer_ID`, `shipping_address`, `payment_received`, `invoice_date`, `invoice_address`, `tax_rate_percent`,`rating`) values
('2020-12_19', null, (select customer_ID from customer ORDER BY customer_ID DESC LIMIT 1), 'Drury St, 18 D02 W017, Dublin, Ireland', false, '2020-12_01', 'Drury St, 18 D02 W017, Dublin, Ireland', 8.00, 4.1);



/* Items are added according to the specification above */
insert into `customer_order_item`(`customer_order_ID`, `product_ID`, `quantity`) values
((select customer_order_ID from customer_order ORDER BY customer_order_ID DESC LIMIT 1), @item_1_ID, @item_1_quantity),
((select customer_order_ID from customer_order ORDER BY customer_order_ID DESC LIMIT 1), @item_2_ID, @item_2_quantity);

/* Check available quantity after the order is placed */
select product_ID, name, available_quantity from stock;