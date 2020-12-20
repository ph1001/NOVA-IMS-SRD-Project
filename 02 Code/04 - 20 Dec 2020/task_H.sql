/*
Task H.:
Create two views to recreate the information on the INVOICE (one for the head and totals, and another for the details).
*/

/* The orders for which the invoice views should be created are specified in each views' 'where' statements */

/* Create the view for the invoice header and totals */

CREATE OR REPLACE VIEW shoeshop.invoice_head_totals
AS
select
customer_order_and_invoice_ID as 'INVOICE NUMBER',
invoice_date as 'DATE OF ISSUE',
invoice_address as 'BILLED TO',
'Shoes24, Rua do Forno do Tijolo 73-65, 1170-172 Lisbon, Portugal, +351 639 230 003, shoes24@email.com, shoes24.com' as 'our info',
# Subtotal = (unit_costs * quantities)
(
select sum(s.unit_price * coi.quantity) 
from  stock s, customer_order_item coi 
where s.product_ID = coi.product_ID
) as 'SUBTOTAL',
# Discount [EUR] = discount [%] / 100 * subtotal
(
select sum(coi.discount_percent/100 * s.unit_price * coi.quantity)
from  stock s, customer_order_item coi 
where s.product_ID = coi.product_ID
) as 'DISCOUNT',
# Tax rate
(
select distinct (co.tax_rate_percent/100) 
from customer_order_item coi , customer_order co 
where coi.customer_order_and_invoice_ID = co.customer_order_and_invoice_ID
) as '(TAX RATE)',
# Tax
(
(select distinct (co.tax_rate_percent/100) from customer_order_item coi , customer_order co where coi.customer_order_and_invoice_ID = co.customer_order_and_invoice_ID)
* (select (sum(s.unit_price * coi.quantity - coi.discount_percent/100 * s.unit_price * coi.quantity)) from  stock s, customer_order_item coi where s.product_ID = coi.product_ID)
) as 'TAX',
# Total = (1 + tax_rate) * ((unit_costs * quantities) - discounts)
(
(select distinct (1 + co.tax_rate_percent/100) from customer_order_item coi , customer_order co where coi.customer_order_and_invoice_ID = co.customer_order_and_invoice_ID)
* (select (sum(s.unit_price * coi.quantity - coi.discount_percent/100 * s.unit_price * coi.quantity)) from  stock s, customer_order_item coi where s.product_ID = coi.product_ID)
) as 'INVOICE TOTAL'
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
