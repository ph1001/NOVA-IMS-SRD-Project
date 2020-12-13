/*tell which database you will use*/
USE shoeshop;

/* create FK for table customer */

ALTER TABLE `customer`
ADD CONSTRAINT `fk_customer_adress`
  FOREIGN KEY (`address_ID`) REFERENCES `address` (`address_ID`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;
  
  
  /* create FK for table customer_order_details */
  
ALTER TABLE `customer_order_details`
ADD CONSTRAINT `fk_customer_order_details_customer`
  FOREIGN KEY (`customer_ID`) REFERENCES `customer` (`customer_ID`),
ADD CONSTRAINT `fk_customer_order_details_address`
  FOREIGN KEY (`address_ID`) REFERENCES `address` (`address_ID`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;

  
    /* create FK for table customer_order_content */

ALTER TABLE `customer_order_content`
ADD CONSTRAINT `fk_customer_order_content_product`
  FOREIGN KEY (`product_ID`) REFERENCES `product` (`product_ID`),
ADD CONSTRAINT `fk_customer_order_content_customer_order`
  FOREIGN KEY (`customer_order_ID`) REFERENCES `customer_order_details` (`customer_order_ID`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;
  
  
  /* create FK for table customer_invoice */

ALTER TABLE `customer_invoice`
ADD CONSTRAINT `fk_customer_invoice_customer_order`
  FOREIGN KEY (`customer_order_ID`) REFERENCES `customer_order_content` (`customer_order_ID`),
ADD CONSTRAINT `fk_customer_invoice_address`
  FOREIGN KEY (`address_ID`) REFERENCES `address` (`address_ID`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;
  
  
    /* create FK for table supplier */

ALTER TABLE `supplier`
ADD CONSTRAINT `fk_supplier_adress`
  FOREIGN KEY (`address_ID`) REFERENCES `address` (`address_ID`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;
  
  
      /* create FK for table supplier_order_details */

ALTER TABLE `supplier_order_details`
ADD CONSTRAINT `fk_supplier_order_details_supplier`
  FOREIGN KEY (`supplier_ID`) REFERENCES `supplier` (`supplier_ID`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;


    /* create FK for table supplier_order_content */

ALTER TABLE `supplier_order_content`
ADD CONSTRAINT `fk_supplier_order_content_supplier_order`
  FOREIGN KEY (`supplier_order_ID`) REFERENCES `supplier_order_details` (`supplier_order_ID`),
ADD CONSTRAINT `fk_supplier_order_content_product`
  FOREIGN KEY (`product_ID`) REFERENCES `product` (`product_ID`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;
  
  
      /* create FK for table supplier_invoice */

ALTER TABLE `supplier_order_content`
ADD CONSTRAINT `fk_supplier_invoice_supplier_order`
  FOREIGN KEY (`supplier_order_ID`) REFERENCES `supplier_order_details` (`supplier_order_ID`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;
 