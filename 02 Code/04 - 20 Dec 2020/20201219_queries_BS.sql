use shoeshop;


# G.1
select customer.name,order_date,stock.name as Name_of_the_Product
from customer
join customer_order on customer.customer_ID = customer_order.customer_ID 
join customer_order_item on customer_order_item.customer_order_and_invoice_ID = customer_order.customer_order_and_invoice_ID
join stock on stock.product_ID = customer_order_item.product_ID
where customer_order.order_date between '2020-10_01' and '2020-12_30'
group by customer.name;


#G.2
select customer.name as Best_Customers, concat(sum(customer_order_item.value_at_time), ' €') as Purchase_Amount
from customer
join customer_order on customer.customer_ID = customer_order.customer_ID 
join customer_order_item on customer_order_item.customer_order_and_invoice_ID = customer_order.customer_order_and_invoice_ID
group by customer.name
order by sum(customer_order_item.value_at_time) desc
limit 3;

# G.3
select concat(min(customer_order.order_date),'  &  ',max(customer_order.order_date)) as PeriodOfSales , 
concat(sum(stock.unit_price),' €') as TotalSales,
concat(round(sum(stock.unit_price)/(year(max(customer_order.order_date)) - year(min(customer_order.order_date))),2),' €') as YearlyAverage,
concat(round(sum(stock.unit_price)/((datediff(max(customer_order.order_date),min(customer_order.order_date)))/30),2),' €') as MonthlyAverage # temporary
from customer_order
join customer_order_item on customer_order_item.customer_order_and_invoice_ID = customer_order.customer_order_and_invoice_ID
join stock on stock.product_ID = customer_order_item.product_ID;

# G.4
select substring_index(shipping_address, ',', -2) as City, concat(sum(customer_order_item.value_at_time), ' €') as Total_Sales
from customer_order 
join customer_order_item on customer_order_item.customer_order_and_invoice_ID = customer_order.customer_order_and_invoice_ID
group by City;


# G.5
select substring_index(shipping_address, ',', -2) as City, round(avg(rating),2) as Average_Rating
from customer_order
join customer_order_item on customer_order_item.customer_order_and_invoice_ID = customer_order.customer_order_and_invoice_ID
group by City;
