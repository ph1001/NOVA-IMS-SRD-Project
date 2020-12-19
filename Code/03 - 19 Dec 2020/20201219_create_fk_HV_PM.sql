/*tell which database you will use*/
USE shoeshop;


/* create FK for table slog_price */

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
	FOREIGN KEY (`customer_order_ID`) REFERENCES `customer_order` (`customer_order_ID`)
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
	FOREIGN KEY (`supplier_order_ID`) REFERENCES `supplier_order` (`supplier_order_ID`)
		on delete no action
        on update cascade,
ADD CONSTRAINT `fk_supplier_order_item_product`
	FOREIGN KEY (`product_ID`) REFERENCES `stock` (`product_ID`)
		ON DELETE no action
		ON UPDATE CASCADE;