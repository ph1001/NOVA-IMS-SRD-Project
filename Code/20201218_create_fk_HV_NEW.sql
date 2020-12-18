/*tell which database you will use*/
USE shoeshop;

  /* create FK for table customer_invoice */

ALTER TABLE `customer_invoice`
ADD CONSTRAINT `fk_customer_invoice_customer`
  FOREIGN KEY (`customer_ID`) REFERENCES `customer` (`customer_ID`),
ADD CONSTRAINT `fk_customer_invoice_product`
  FOREIGN KEY (`product_ID`) REFERENCES `product` (`product_ID`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;


##########

      /* create FK for table supplier_invoice */

ALTER TABLE `supplier_invoice`
ADD CONSTRAINT `fk_supplier_invoice_supplier`
  FOREIGN KEY (`supplier_ID`) REFERENCES `supplier` (`supplier_ID`),
ADD CONSTRAINT `fk_supplier_invoice_product`
  FOREIGN KEY (`product_ID`) REFERENCES `product` (`product_ID`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;
  
  
  #########
  
        /* create FK for table slog_price */

ALTER TABLE `log_price`
ADD CONSTRAINT `fk_log_price_product`
  FOREIGN KEY (`product_ID`) REFERENCES `product` (`product_ID`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;
 
 