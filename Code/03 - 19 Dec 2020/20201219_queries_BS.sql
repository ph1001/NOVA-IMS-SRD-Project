use shoeshop;

# G.1
select customer.name,order_date,stock.name
from customer
join customer_order on customer.customer_ID = customer_order.customer_ID 
join customer_order_item on customer_order_item.customer_order_ID = customer_order.customer_order_ID
join stock on stock.product_ID = customer_order_item.product_ID
where customer_order.order_date between '2020-12_19' and '2020-12_27'
group by customer.name;


#G.2
select customer.name, sum(stock.unit_price)
from customer
join customer_order on customer.customer_ID = customer_order.customer_ID 
join customer_order_item on customer_order_item.customer_order_ID = customer_order.customer_order_ID
join stock on stock.product_ID = customer_order_item.product_ID
group by customer.name
order by sum(stock.unit_price) desc
limit 3;

# G.3
select concat(min(customer_order.order_date),'  &  ',min(customer_order.order_date)) as PeriodOfSales , 
concat(stock.unit_price,' €') as TotalSales,
concat(sum(stock.unit_price)/(year(max(customer_order.order_date)) - year(min(customer_order.order_date))),' €') as YearlyAverage,
concat(sum(stock.unit_price)/((datediff(max(customer_order.order_date),min(customer_order.order_date)))/30),' €') as MonthlyAverage # temporary
from customer_order
join customer_order_item on customer_order_item.customer_order_ID = customer_order.customer_order_ID
join stock on stock.product_ID = customer_order_item.product_ID;

# G.4
select substring_index(shipping_address, ',', -2) as City, sum(stock.unit_price)
from customer_order 
join customer_order_item on customer_order_item.customer_order_ID = customer_order.customer_order_ID
join stock on stock.product_ID = customer_order_item.product_ID
group by City;


# G.5
select substring_index(shipping_address, ',', -2) as City, rating
from customer_order
join customer_order_item on customer_order_item.customer_order_ID = customer_order.customer_order_ID
join stock on stock.product_ID = customer_order_item.product_ID
group by City;
