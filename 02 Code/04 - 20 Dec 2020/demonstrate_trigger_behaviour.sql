/* Check that the triggers work - for this purpose simulate an order and a price update */

/* Simulation of a customer placing an order */

/* Check available quantity before the order is placed */
select product_ID, name, available_quantity from stock;

/* Specify which products are ordered and their quantity */
set @item_1_ID = 1;
set @item_1_quantity = 2;
set @item_2_ID = 2;
set @item_2_quantity = 1;

/* Order is created */
insert into `customer_order` (`order_date`, `shipping_date`, `customer_ID`, `shipping_address`, `payment_received`, `invoice_date`, `invoice_address`, `tax_rate_percent`) values
('2020-12_20', null, 1, 'Drury St, 18 D02 W017, Dublin, Ireland', false, '2020-12_20', 'Drury St, 18 D02 W017, Dublin, Ireland', 10.00);

/* Items are added according to the specification above */
insert into `customer_order_item`(`customer_order_and_invoice_ID`, `product_ID`, `quantity`) values
((select customer_order_and_invoice_ID from customer_order ORDER BY customer_order_and_invoice_ID DESC LIMIT 1), @item_1_ID, @item_1_quantity),
((select customer_order_and_invoice_ID from customer_order ORDER BY customer_order_and_invoice_ID DESC LIMIT 1), @item_2_ID, @item_2_quantity);

/* Check available quantity after the order is placed */
select product_ID, name, available_quantity from stock;

##########

/* The unit price of 'Nike_34' is changed */

/* Check the log */
select * from log_price;

/* Update the unit price */
set SQL_SAFE_UPDATES = 0;
update stock
set unit_price = 50.0
where name = 'Nike_34';
set SQL_SAFE_UPDATES = 1;

/* Check the new unit price */
select name, unit_price 
from stock
where name = 'Nike_34';

/* Check the log again */
select * from log_price;