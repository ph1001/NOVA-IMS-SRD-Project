/*
Task H.:
Create two views to recreate the information on the INVOICE (one for the head and totals, and another for the details).
*/

/* The orders for which the invoice views should be created are specified in each views' 'where' statements */

/* Create the view for the invoice header and totals */

/* Create a table to store a single variable */
drop table if exists `parameter_table`;
CREATE TABLE IF NOT EXISTS `parameter_table` (
	`parameter` INTEGER unsigned NOT NULL,
    primary key (`parameter`)
);
insert into `parameter_table`(`parameter`) values (1);

CREATE OR REPLACE VIEW shoeshop.invoice_head_totals
AS
select
customer_order_and_invoice_ID as 'INVOICE NUMBER',
invoice_date as 'DATE OF ISSUE',
invoice_address as 'BILLED TO',
'Sneakersly, Rua do Forno do Tijolo 73-65, 1170-172 Lisbon, Portugal, +351 639 230 003, shoes24@email.com, shoes24.com' as 'our info',
# Subtotal = (unit_costs * quantities)
(select sum(coi.value_at_time) 
from  customer_order_item coi
where coi.customer_order_and_invoice_ID=(select * from parameter_table)) 
as 'SUBTOTAL',
# Discount [EUR] = discount [%] / 100 * subtotal
(select sum(coi.discount_percent/100 * coi.value_at_time)
from  customer_order_item coi
where coi.customer_order_and_invoice_ID=(select * from parameter_table))
as 'DISCOUNT',
# Tax rate
(select distinct (co.tax_rate_percent/100) 
from customer_order co 
where co.customer_order_and_invoice_ID = (select * from parameter_table)) 
as '(TAX RATE)',
# Tax = tax rate * (subtotal - Discounts)
((select distinct (co.tax_rate_percent/100) 
from customer_order_item coi , customer_order co 
where coi.customer_order_and_invoice_ID = co.customer_order_and_invoice_ID and co.customer_order_and_invoice_ID = (select * from parameter_table))
* (select (sum(coi.value_at_time) - sum(coi.value_at_time * coi.discount_percent/100)) 
from  customer_order_item coi 
where coi.customer_order_and_invoice_ID=(select * from parameter_table)))
as 'TAX',
# Total = (1 + tax_rate) * (subtotal - discounts)
((select distinct (1 + co.tax_rate_percent/100) 
from customer_order_item coi , customer_order co 
where coi.customer_order_and_invoice_ID = co.customer_order_and_invoice_ID and co.customer_order_and_invoice_ID = (select * from parameter_table))
* (select (sum(coi.value_at_time) - sum(coi.value_at_time * coi.discount_percent/100)) 
from  customer_order_item coi 
where coi.customer_order_and_invoice_ID=(select * from parameter_table)))
as 'INVOICE TOTAL'
from customer_order
where customer_order_and_invoice_ID = 1;

/* Select this view */
select * from invoice_head_totals;

#######################################

/* Create the view for the invoice details */

CREATE OR REPLACE VIEW shoeshop.invoice_details
AS
select 
s.name as 'DESCRIPTION',
s.unit_price as 'UNIT COST',
coi.quantity as 'QTY',
(s.unit_price * coi.quantity) as 'AMOUNT'
from stock s, customer_order_item coi 
where s.product_ID = coi.product_ID and coi.customer_order_and_invoice_ID = 1;

/* Select this view */
select * from invoice_details;
