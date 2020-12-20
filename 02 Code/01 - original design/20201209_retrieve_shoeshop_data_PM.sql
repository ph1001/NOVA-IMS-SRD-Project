/* Script to check if shoe shop data is there and can be retrieved */

use shoeshop;

select *
from product;

select *
from customer;

select *
from address;

select *
from customer c, address a
where c.address_ID = a.address_ID;

select *
from customer_order_details;

select *
from customer c, customer_order_details cod, address a
where c.customer_ID = cod.customer_ID 
and cod.address_ID = a.address_ID;

select *
from customer_order_content;

select *
from customer_order_content
where customer_order_ID=1;

select *
from customer_order_details cod, customer_order_content coc, address a
where cod.customer_order_ID = coc.customer_order_ID
and cod.address_ID = a.address_ID
and cod.customer_order_ID=1;

select *
from customer_order_invoice coi, address a
where coi.address_ID = a.address_ID;