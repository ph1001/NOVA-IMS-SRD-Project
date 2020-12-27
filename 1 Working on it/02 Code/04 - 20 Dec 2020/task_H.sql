/*
Task H.:
Create two views to recreate the information on the INVOICE (one for the head and totals, and another for the details).
*/

/* The orders for which the invoice views should be created are specified in each views' 'where' statements */

/* Create the view for the invoice header and totals */

/* In order to parameterise the view, create a variable representing the ID of the order for which an invoice shall be created.
For this, first set the variable to the desired value: */
set @order_ID = 4;

/* Then, create a table to store the value of this variable. For some reason, MySQL does not allow for the variable to be passed directly
to the views. */
drop table if exists `parameter_table`;
CREATE TABLE IF NOT EXISTS `parameter_table` (
	`parameter` INTEGER unsigned NOT NULL,
    primary key (`parameter`)
);
insert into `parameter_table`(`parameter`) values (@order_ID);

/* Check the parameter */
# select * from parameter_table;

CREATE OR REPLACE VIEW shoeshop.invoice_head_totals
AS
select
customer_order_and_invoice_ID as 'INVOICE NUMBER',
invoice_date as 'DATE OF ISSUE',
invoice_address as 'BILLED TO',
'Sneakersly, Rua do Forno do Tijolo 73-65, 1170-172 Lisbon, Portugal, +351 639 230 003, sneakersly@office.com, sneakersly.com' as 'our info',
# Subtotal = sum(values at the time of purchase)
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
where customer_order_and_invoice_ID = (select * from parameter_table);

/* Select this view */
select * from invoice_head_totals;

#######################################

/* Create the view for the invoice details */

CREATE OR REPLACE VIEW shoeshop.invoice_details
AS
select 
s.name as 'DESCRIPTION',
coi.value_at_time/coi.quantity as 'UNIT COST',
coi.quantity as 'QTY',
coi.value_at_time as 'AMOUNT'
from stock s, customer_order_item coi 
where s.product_ID = coi.product_ID and coi.customer_order_and_invoice_ID = (select * from parameter_table);

/* Select this view */
select * from invoice_details;
