/* First draft for inserting some shoe shop data */

use shoeshop;

/* Insert some product data */
/*
insert into `product` (`product_number`, `product_name`, `product_type`, `available_quantity`, `product_price`) values
(1111, 'sneaker_1', 'sneaker', 1, 51.61),
(1112, 'sneaker_2', 'sneaker', 2, 52.62),
(1113, 'boot_1', 'boot', 3, 53.63),
(1114, 'boot_2', 'boot', 4, 54.64);
*/
 
insert into `product` (`product_name`, `product_type`, `available_quantity`, `product_price`) values
('sneaker_1', 'sneaker', 1, 51.61),
('sneaker_2', 'sneaker', 2, 52.62),
('boot_1', 'boot', 3, 53.63),
('boot_2', 'boot', 4, 54.64);