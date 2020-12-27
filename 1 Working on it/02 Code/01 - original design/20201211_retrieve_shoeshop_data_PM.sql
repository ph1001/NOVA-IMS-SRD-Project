/* Script to check if shoe shop data is there and can be retrieved */

use shoeshop;

/* Product queries */

select *
from product;


/* Address queries */

select *
from address;


/* Customer queries */

select *
from customer;

select *
from customer c, address a
where c.address_ID = a.address_ID;


/* Customer order details queries */

select *
from customer_order_details;

select *
from customer c, customer_order_details cod, address a
where c.customer_ID = cod.customer_ID 
and cod.address_ID = a.address_ID;


/* Customer order content queries */

select *
from customer_order_content;

select *
from customer_order_content
where customer_order_ID=1;

select *
from customer_order_content coc, product p
where coc.product_ID = p.product_ID;

select *
from customer_order_details cod, customer_order_content coc, address a
where cod.customer_order_ID = coc.customer_order_ID
and cod.address_ID = a.address_ID
and cod.customer_order_ID=1;


/* Customer invoice queries */
select *
from customer_invoice;

select *
from customer_invoice coi, address a
where coi.address_ID = a.address_ID;


/* Supplier queries */

select *
from supplier;

select *
from supplier s, address a
where s.address_ID = a.address_ID;


/* Supplier order details queries */

select *
from supplier_order_details;


/* Supplier order content queries */

select *
from supplier_order_content;

select *
from supplier_order_content soc, product p
where soc.product_ID=p.product_ID;


/* Supplier invoice queries */

select *
from supplier_invoice;

