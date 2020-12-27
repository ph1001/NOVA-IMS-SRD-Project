/* First draft for inserting some shoe shop data */

use shoeshop;

/* Insert some product data */
insert into `product` (`name`, `type`, `available_quantity`, `unit_price`, `tax`) values
('sneaker_1', 'sneaker', 1, 51.61, 23),
('sneaker_2', 'sneaker', 2, 52.62, 12),
('boot_1', 'boot', 3, 53.63, 23),
('boot_2', 'boot', 4, 54.64, 23);


/* Insert some customer data */
insert into `customer` (`name`, `phone_number`, `email_address`, `address`) values
('Customer 1', '10000000', 'customer1@email.com', 'Drury St, 18, D02 W017, Dublin, Ireland'),
('Customer 2', '10000001', 'customer2@email.com', 'Bötzowstraße, 5, 10407, Berlin, Germany');

/* Insert some customer invoice data */
insert into `customer_invoice` (`customer_ID`, `product_ID`, `quantity`, `unit_price`, `tax`, `invoice_date`, `address`) values
(1, 1, 1, 51.61, 23, '2020-12_02', 'Rue Rambuteau, 72, 75001, Paris, France'),
(2, 2, 2, 52.62, 12, '2020-12-10', 'R. Angela Pinto, 40, D, 1900-221, Lisboa, Portugal'); 

#############

/* Insert some supplier data */
insert into `supplier` (`name`, `phone_number`, `email_address`, `address`) values
('Supplier One', '20000000', 'supplier1@email.com', 3),
('Supplier Two', '20000001', 'supplier2@email.com', 4);

/* Insert some supplier invoice data */
insert into `supplier_invoice` (`supplier_ID`, `product_ID`, `quantity`, `total_amount`, `invoice_date`, `address`) values
(1, 1, 1, 10.2, '2020-12_02', 'Rue Rambuteau, 72, 75001, Paris, France'),
(2, 2, 2, 23.5, '2020-12-10', 'R. Angela Pinto, 40, D, 1900-221, Lisboa, Portugal');