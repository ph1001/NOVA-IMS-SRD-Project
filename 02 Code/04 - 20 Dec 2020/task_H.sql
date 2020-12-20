/*
Create two views to recreate the information on the INVOICE (one for the head and totals, and another for the details).
*/

CREATE OR REPLACE VIEW shoeshop.invoice_head_totals
AS

select
customer_order_and_invoice_ID as 'INVOICE NUMBER',
invoice_date as 'DATE OF ISSUE',
(
(select distinct (1 + co.tax_rate_percent/100) from customer_order_item coi , customer_order co where coi.customer_order_and_invoice_ID = co.customer_order_and_invoice_ID) # (1 + tax_rate)
* (select (sum(s.unit_price * coi.quantity - coi.discount_percent/100 * s.unit_price * coi.quantity)) from  stock s, customer_order_item coi where s.product_ID = coi.product_ID) # ((unit_costs * quantities) - discounts)
) as 'INVOICE TOTAL'
from customer_order;

/*
select * from customer_order_item;
select * from stock;
*/

select * from invoice_head_totals