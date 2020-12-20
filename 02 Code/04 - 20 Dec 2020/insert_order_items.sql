/* Insert shoe shop data */

use shoeshop;

/* Items are added according to the specification above */
insert into `customer_order_item`(`customer_order_and_invoice_ID`, `product_ID`, `quantity`) values
((select customer_order_and_invoice_ID from customer_order ORDER BY customer_order_ID DESC LIMIT 1), @item_1_ID, @item_1_quantity),
((select customer_order_and_invoice_ID from customer_order ORDER BY customer_order_ID DESC LIMIT 1), @item_2_ID, @item_2_quantity);

