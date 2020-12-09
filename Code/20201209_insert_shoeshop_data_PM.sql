/* First draft for inserting some shoe shop data */

use shoeshop;

/* Insert some product data */
insert into `product` (`product_ID`, `name`, `type`, `available_quantity`, `price`) values
(1111, 'sneaker_1', 'sneaker', 1, 51.61),
(1112, 'sneaker_2', 'sneaker', 2, 52.62),
(1113, 'boot_1', 'boot', 3, 53.63),
(1114, 'boot_2', 'boot', 4, 54.64);

/* Insert some customer data */
insert into `customer` (`customer_ID`, `name`, `phone_number`, `email_address`, `address_ID`) values
(1111, 'Person One', '123456789', 'a@b.c', 1),
(1112, 'Person Two', '234567890', 'd@e.f', 2);

/* Insert some customer data */
insert into `address` (`address_ID`, `street`, `house_number`, `postal_code`, `city`, `country_town`) values
(1, 'Drury St', 18, 'D02 W017', 'Dublin', 'Ireland'),
(2, 'Bötzowstraße', 5, '10407', 'Berlin', 'Germany');

/* Insert some customer data with shipping dates */
insert into `customer_order_details` (`customer_order_ID`, `customer_order_date`, `shipping_date`, `customer_ID`, `customer_invoice_ID`, `address_ID`) values
(1, '2020-12_01', '2003-12-03', 1111, 1111, 1);

/* Insert some customer data without shipping dates*/
insert into `customer_order_details` (`customer_order_ID`, `customer_order_date`, `customer_ID`, `customer_invoice_ID`, `address_ID`) values
(2, '2020-12-09', 1112, 1112, 2);

/* Insert some customer order content data */
insert into customer_order_content (`customer_order_ID`, `product_ID`, `quantity`) values
(1, 12, 2),
(1, 13, 3),
(1, 14, 1),
(2, 22, 1),
(2, 23, 4);
