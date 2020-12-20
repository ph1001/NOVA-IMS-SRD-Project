use shoeshop;


# G.1
SELECT customer.name, 
       order_date, 
       stock.name AS Name_of_the_Product 
FROM   customer 
       JOIN customer_order 
         ON customer.customer_id = customer_order.customer_id 
       JOIN customer_order_item 
         ON customer_order_item.customer_order_and_invoice_id = customer_order.customer_order_and_invoice_id 
       JOIN stock 
         ON stock.product_id = customer_order_item.product_id 
WHERE  customer_order.order_date BETWEEN '2020-10_01' AND '2020-12_30' 
GROUP  BY customer.name, 
          order_date, 
          stock.name; 


#G.2
# The criteria used to define the best customer is the amount wasted in purchases 
SELECT customer.name                                          AS Best_Customers, 
       Concat(Sum(customer_order_item.value_at_time), ' €') AS Purchase_Amount 
FROM   customer 
       JOIN customer_order 
         ON customer.customer_id = customer_order.customer_id 
       JOIN customer_order_item 
         ON customer_order_item.customer_order_and_invoice_id = customer_order.customer_order_and_invoice_id 
GROUP  BY customer.name 
ORDER  BY Sum(customer_order_item.value_at_time) DESC 
LIMIT  3; 


SELECT 12 * (YEAR(Max(customer_order.order_date)) - YEAR(Min(customer_order.order_date))) +
    ((MONTH(Max(customer_order.order_date)) - MONTH(Min(customer_order.order_date)))) +
    SIGN(DAY(Max(customer_order.order_date)) / DAY(Min(customer_order.order_date))) 
    from customer_order;

select DATEDIFF(MONTH, (Max(customer_order.order_date), Min(customer_order.order_date)))
from customer_order;

# G.3
SELECT Concat(Min(customer_order.order_date), '  -  ', Max(customer_order.order_date)) AS PeriodOfSales, 
       Concat(Sum(customer_order_item.value_at_time), ' €') AS TotalSales, 
       Concat(Round(Sum(customer_order_item.value_at_time) / (Year(Max(customer_order.order_date)) - Year(Min(customer_order.order_date)) ), 2), ' €') AS YearlyAverage, 
       Concat(Round(Sum(customer_order_item.value_at_time) / 
                    (SELECT 
                                    12 * 
                                 ( Year(Max(customer_order.order_date)) - 
                                   Year( 
                                   Min(customer_order.order_date)) ) + ( 
                                                                ( 
                           Month(Max( 
                           customer_order.order_date)) - 
                    Month(Min(customer_order.order_date)) )) + Sign( 
                                 Day(Max( 
                                     customer_order.order_date)) / 
              Day( 
              Min( 
                                                 customer_order.order_date))) 
              FROM   customer_order), 2), ' €') AS MonthlyAverage 
FROM   customer_order 
       JOIN customer_order_item 
         ON customer_order_item.customer_order_and_invoice_id = 
            customer_order.customer_order_and_invoice_id; 


# G.4
SELECT Substring_index(shipping_address, ',', -2)             AS City, 
       Concat(Sum(customer_order_item.value_at_time), ' €') AS Total_Sales 
FROM   customer_order 
       JOIN customer_order_item 
         ON customer_order_item.customer_order_and_invoice_id = customer_order.customer_order_and_invoice_id 
GROUP  BY city; 


# G.5
SELECT Substring_index(shipping_address, ',', -2) AS City, 
       Round(Avg(rating), 2)                      AS Average_Rating 
FROM   customer_order 
       JOIN customer_order_item 
         ON customer_order_item.customer_order_and_invoice_id = customer_order.customer_order_and_invoice_id 
GROUP  BY city; 
