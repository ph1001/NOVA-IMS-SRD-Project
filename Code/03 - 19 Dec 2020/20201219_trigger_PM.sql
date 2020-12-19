use shoeshop;

/* Create the triggers for task C. */

delimiter $$
create trigger stock_update after insert
on customer_order_item
for each row
begin
	update stock s
    set s.available_quantity = s.available_quantity - NEW.quantity
    where s.product_ID = NEW.product_ID;
end $$