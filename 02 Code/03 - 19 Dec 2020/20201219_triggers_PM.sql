use shoeshop;

/* Create the first trigger for task C. */

DROP TRIGGER if exists stock_update;
delimiter $$
create trigger stock_update after insert
on customer_order_item
for each row
begin
	update stock s
    set s.available_quantity = s.available_quantity - NEW.quantity
    where s.product_ID = NEW.product_ID;
end $$
delimiter ;

/* Create the second trigger for task C. */

DROP TRIGGER if exists insert_price_update_log;
delimiter $$
create trigger insert_price_update_log after update
on stock
for each row
begin
	if OLD.unit_price != NEW.unit_price then
		insert into log_price(`product_ID`, `old_unit_price`, `new_unit_price`, `update_date`) values
		(NEW.product_ID, OLD.unit_price, NEW.unit_price, now());
    end if;
end $$
delimiter ;