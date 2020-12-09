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