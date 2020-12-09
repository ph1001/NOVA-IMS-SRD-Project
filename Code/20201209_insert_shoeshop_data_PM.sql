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

