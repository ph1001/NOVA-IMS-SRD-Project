/* First draft for inserting some shoe shop data */

use shoeshop;

/* Insert some product data */
insert into `product` (`name`, `type`, `available_quantity`, `price`) values
('sneaker_1', 'sneaker', 1, 51.61),
('sneaker_2', 'sneaker', 2, 52.62),
('boot_1', 'boot', 3, 53.63),
('boot_2', 'boot', 4, 54.64);

/* Insert some address data */
insert into `address` (`street`, `house_number`, `house_number_addition`, `postal_code`, `city`, `country_town`) values
('Drury St', 18, null, 'D02 W017', 'Dublin', 'Ireland'),
('Bötzowstraße', 5, null, '10407', 'Berlin', 'Germany'),
('Rue Rambuteau', 72, null, '75001', 'Paris', 'France'),
('R. Angela Pinto', 40, 'D', '1900-221', 'Lisboa', 'Portugal');

/* Insert some customer data */
insert into `customer` (`name`, `phone_number`, `phone_number_country_prefix`, `email_address`, `address_ID`) values
('Customer 1', '10000000', '+49', 'customer1@email.com', 1),
('Customer 2', '10000001', '+1', 'customer2@email.com', 2);

/* Insert some customer order details data with shipping dates */
insert into `customer_order_details` (`order_date`, `shipping_date`, `customer_ID`, `customer_invoice_ID`, `address_ID`) values
('2020-12_01', '2003-12-03', 1, 1, 1);

/* Insert some customer order details data without shipping dates*/
insert into `customer_order_details` (`order_date`, `customer_ID`, `customer_invoice_ID`, `address_ID`) values
('2020-12-09', 2, 2, 2);

/* Insert some customer order content data */
insert into customer_order_content (`customer_order_ID`, `product_ID`, `quantity`) values
(1, 1, 2),
(1, 2, 3),
(1, 3, 1),
(2, 2, 1),
(2, 4, 4);

/* Insert some customer invoice data */
insert into `customer_invoice` (`customer_order_ID`, `invoice_date`, `payment_received`, `address_ID`) values
(1, '2020-12_02', true, 1),
(2, '2020-12-10', false, 2); 

/* Insert some supplier data */
insert into `supplier` (`name`, `phone_number`, `email_address`, `address_ID`) values
('Supplier One', '20000000', 'supplier1@email.com', 3),
('Supplier Two', '20000001', 'supplier2@email.com', 4);

/* Insert some supplier order details data */
insert into `supplier_order_details` (`order_date`, `products_received`, `supplier_ID`, `supplier_invoice_ID`) values
('2020-12_01', false, 1, 1),
('2020-12-09', true, 2, 2);

/* Insert some supplier order content data */
insert into supplier_order_content (`supplier_order_ID`, `product_ID`, `quantity`) values
(1, 1, 2),
(1, 2, 3),
(1, 3, 1),
(2, 2, 1),
(2, 4, 4);

/* Insert some supplier invoice data */
insert into `supplier_invoice` (`supplier_order_ID`, `invoice_date`, `paid`) values
(1, '2020-12_02', true),
(2, '2020-12-10', false); 