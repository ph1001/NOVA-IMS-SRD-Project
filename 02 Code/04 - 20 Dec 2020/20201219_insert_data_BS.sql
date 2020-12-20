/* Insert shoe shop data */

use shoeshop;

/* Two products are added to the shop */
insert into `stock` (`name`, `type`, `available_quantity`, `unit_price`) values
('Nike_34', 'sneaker', 10, 61.50),
('Timberland_73', 'boot', 3, 73.20),
('Adidas_48', 'sneaker', 3, 58.20),
('Adidas_35', 'sneaker', 2, 50.70),
('Adidas_40', 'sneaker', 4, 55.25),
('Timberland_70', 'boot', 2, 70.20),
('Nike_38', 'sneaker', 5, 79.20),
('Nike_40', 'sneaker', 6, 80.20),
('Caterpillar_50', 'boot', 2, 68.20),
('Caterpillar_60', 'boot', 1, 73.80),
('Caterpillar_70', 'boot', 4, 75.60),
('New_Balance_30', 'sneaker', 5, 50.20),
('New_Balance_40', 'sneaker', 4, 65.80),
('New_Balance_35', 'sneaker', 6, 70.00),
('Skechers_34', 'sneaker', 5, 75.50),
('Skechers_38', 'sneaker', 4, 60.00),
('Skechers_40', 'sneaker', 6, 64.40),
('Burberry_35', 'high_heels', 5, 95.20),
('Burberry_38', 'high_heels', 4, 90.65),
('Burberry_36', 'high_heels', 4, 93.50)
;


##########

/* A customer creates an account */
insert into `customer` (`name`, `phone_number`, `phone_number_country_prefix`, `email_address`, `home_address`) values
('Kanna Haniya', '822829974', '+353', 'KannaHaniya@email.com', 'Drury St, 18 D02 W017, Dublin, Ireland'),
('Jorden Hodges', '995877685', '+31', 'dolor@aliquet.org', '348-8958 Feugiat Rd., Utrecht, Netherlands'),
('Keefe Bonner', '599699909', '+353', 'ullamcorper.velit@velitQuisquevarius.edu', 'P.O. Box 475, 5958 Gravida St., Galway, Ireland'),
('Sara Sellers', '745813683', '+44', 'tortor.nibh.sit@Curabitur.net', 'P.O. Box 399, 886 Ullamcorper Road, Kidwelly, United Kingdom'),
('Audra Larsen', '729972735', '+44', 'Curabitur.vel.lectus@laoreetlectus.net', '9140 Etiam Ave, Stranraer, United Kingdom'),
('Dean Giles', '633506725', '+353', 'facilisis@tempus.com', 'Ap #366-8809 Auctor St., Dublin, Ireland'),
('Jacqueline Randolph', '814493759', '+353', 'semper@magnaUttincidunt.edu', 'Evet St. 18, Belfast, Ireland'),
('Ronan Maynard', '808213602', '+44', 'sodales@justonecante.com', '237 Nisi Rd., Aberdeen, United Kingdom'),
('Jana Joyce', '899266181', '+32', 'ipsum@nec.co.uk', '224-7722 Velit Ave, Hulshout, Belgium'),
('Ira Berger', '857278686', '+31', 'eleifend.egestas.Sed@fringilla.com', 'P.O. Box 941, 1926 Sed St., Hilversum, Netherlands'),
('Uma Parks', '347749363', '+31', 'egestas.a.dui@dolorQuisque.co.uk', 'P.O. Box 606, 8076 Purus St., Lelystad, Netherlands'),
('Lael Willis', '904200138', '+32', 'suscipit.nonummy.Fusce@blanditmattisCras.co.uk', 'Ap #779-6050 Faucibus St., WagnelŽe, Belgium'),
('Delilah Golden', '821885741', '+31', 'cursus.Integer.mollis@magna.net', '497-9085 Lacus. Street, Huissen, Netherlands'),
('McKenzie Greene', '869564481', '+31', 'Integer.sem@Proin.edu', 'Ap #150-131 Eget Rd., Zutphen, Netherlands'),
('Summer Ball', '077798695', '+31', 'purus.Duis@enim.co.uk', '343-6872 Orci. Ave, Zutphen, Netherlands'),
('Chanda Newton', '856986328', '+353', 'Nam@Ut.org', '4069 Turpis. Ave, Cork, Ireland'),
('Delilah Golden', '821885741', '+31', 'cursus.Integer.mollis@magna.net', '497-9085 Lacus. Street, Huissen, Netherlands'),
('McKenzie Greene', '869564481', '+353', 'Integer.sem@Proin.edu', '343-6872 Orci. Ave, Dublin, Ireland'),
('Chanda Newton', '856986328', '+353', 'Nam@Ut.org', 'Ap #150-131 Eget Rd., Broechem, Belgium'),
('Castor Rose', '081345722', '+44', 'ac@ligulaconsectetuerrhoncus.ca', '836-3802 Blandit Street, Lerwick, United Kingdom')
;



##########

/* This customer places an order */

/* Check available quantity before the order is placed */
select product_ID, name, available_quantity from stock;

/* Specify which products are ordered and their quantity */
set @item_1_ID = 1;
set @item_1_quantity = 2;
set @item_2_ID = 2;
set @item_2_quantity = 1;

/* Order is created */
insert into `customer_order` (`order_date`, `shipping_date`, `customer_ID`, `shipping_address`, `payment_received`, `invoice_date`, `invoice_address`, `tax_rate_percent`) values
('2018-01_01', '2018-01_03', (select customer_ID from customer ORDER BY customer_ID DESC LIMIT 1), 'Drury St, 18 D02 W017, Dublin, Ireland', true, '2018-01_02', 'Drury St, 18 D02 W017, Dublin, Ireland', 8.00),
('2018-02_12', '2018-02_15', (select customer_ID from customer ORDER BY customer_ID DESC LIMIT 1), '348-8958 Feugiat Rd., Utrecht, Netherlands',true, '2018-02_14','348-8958 Feugiat Rd., Utrecht, Netherlands',2.00),
('2018-05_20', '2018-05_29', (select customer_ID from customer ORDER BY customer_ID DESC LIMIT 1),  'P.O. Box 475, 5958 Gravida St., Galway, Ireland',true, '2018-05_25','P.O. Box 475, 5958 Gravida St., Galway, Ireland',2.00),
('2018-09_20', '2018-09_29', (select customer_ID from customer ORDER BY customer_ID DESC LIMIT 1), 'P.O. Box 399, 886 Ullamcorper Road, Kidwelly, United Kingdom',true, '2018-09_25','P.O. Box 399, 886 Ullamcorper Road, Kidwelly, United Kingdom',4.00),
('2018-10_06', '2018-10_10', (select customer_ID from customer ORDER BY customer_ID DESC LIMIT 1), '9140 Etiam Ave, Stranraer, United Kingdom',true, '2018-10_08','9140 Etiam Ave, Stranraer, United Kingdom',8.00),
('2018-11_01', '2018-11_06', (select customer_ID from customer ORDER BY customer_ID DESC LIMIT 1),  'Ap #366-8809 Auctor St., Dublin, Ireland',true, '2018-11_04','Ap #366-8809 Auctor St., Dublin, Ireland',5.00),
('2018-12_19', '2018-12_21', (select customer_ID from customer ORDER BY customer_ID DESC LIMIT 1), 'Evet St. 18, Belfast, Ireland',true, '2018-12_20','Drury St, 18 D02 W017, Belfast, Ireland',7.00),
('2019-01_16', '2019-01_20', (select customer_ID from customer ORDER BY customer_ID DESC LIMIT 1), '237 Nisi Rd., Aberdeen, United Kingdom',true, '2019-01_19','237 Nisi Rd., Aberdeen, United Kingdom',8.00),
('2019-05_20', '2019-05_22', (select customer_ID from customer ORDER BY customer_ID DESC LIMIT 1), '224-7722 Velit Ave, Hulshout, Belgium',true, '2019-05_21','224-7722 Velit Ave, Hulshout, Belgium',6.00),
('2019-08_15', '2019-08_19', (select customer_ID from customer ORDER BY customer_ID DESC LIMIT 1), 'P.O. Box 941, 1926 Sed St., Hilversum, Netherlands',true, '2019-08_18','P.O. Box 941, 1926 Sed St., Hilversum, Netherlands',3.00),
('2019-10_05', '2019-10_10', (select customer_ID from customer ORDER BY customer_ID DESC LIMIT 1), 'P.O. Box 606, 8076 Purus St., Lelystad, Netherlands',true, '2019-10_08','P.O. Box 606, 8076 Purus St., Lelystad, Netherlands',4.00),
('2019-11_01', '2019-11_03', (select customer_ID from customer ORDER BY customer_ID DESC LIMIT 1), 'Ap #779-6050 Faucibus St., WagnelŽe, Belgium',true, '2019-11_02','Ap #779-6050 Faucibus St., WagnelŽe, Belgium',5.00),
('2019-12_23', '2019-12_26', (select customer_ID from customer ORDER BY customer_ID DESC LIMIT 1), '497-9085 Lacus. Street, Huissen, Netherlands',true, '2019-12_24','497-9085 Lacus. Street, Huissen, Netherlands',2.00),
('2020-02_13', '2020-02_15', (select customer_ID from customer ORDER BY customer_ID DESC LIMIT 1), 'Ap #150-131 Eget Rd., Zutphen, Netherlands',true, '2020-02_14','Ap #150-131 Eget Rd., Zutphen, Netherlands',2.00),
('2020-03_07', '2020-03_10', (select customer_ID from customer ORDER BY customer_ID DESC LIMIT 1), '343-6872 Orci. Ave, Zutphen, Netherlands',true, '2020-03_09','343-6872 Orci. Ave, Zutphen, Netherlands',5.00),
('2020-05_01', '2020-05_05', (select customer_ID from customer ORDER BY customer_ID DESC LIMIT 1), '4069 Turpis. Ave, Cork, Ireland',true, '2020-05_02','4069 Turpis. Ave, Cork, Ireland',7.00),
('2020-10_18', '2020-10_19', (select customer_ID from customer ORDER BY customer_ID DESC LIMIT 1), '497-9085 Lacus. Street, Huissen, Netherlands',true, '2020-10_19','497-9085 Lacus. Street, Huissen, Netherlands',4.00),
('2020-11_18', '2020-11_19', (select customer_ID from customer ORDER BY customer_ID DESC LIMIT 1), '343-6872 Orci. Ave, Dublin, Ireland',true, '2020-11_18','343-6872 Orci. Ave, Dublin, Ireland',3.00),
('2020-12_19', '2020-12_21', (select customer_ID from customer ORDER BY customer_ID DESC LIMIT 1), 'Ap #150-131 Eget Rd., Broechem, Belgium',true, '2020-12_20','Ap #150-131 Eget Rd., Broechem, Belgium',6.00),
('2020-12_19', '2020-12_21', (select customer_ID from customer ORDER BY customer_ID DESC LIMIT 1), '836-3802 Blandit Street, Lerwick, United Kingdom',true, '2020-12_20','836-3802 Blandit Street, Lerwick, United Kingdom',8.00)
;



/* Items are added according to the specification above */
insert into `customer_order_item`(`customer_order_ID`, `product_ID`, `quantity`) values
((select customer_order_ID from customer_order ORDER BY customer_order_ID DESC LIMIT 1), @item_1_ID, @item_1_quantity),
((select customer_order_ID from customer_order ORDER BY customer_order_ID DESC LIMIT 1), @item_2_ID, @item_2_quantity);

/* Check available quantity after the order is placed */
select product_ID, name, available_quantity from stock;

##########

/* The unit price of 'Nike_34' is changed */

/* Check the log */
select * from log_price;

/* Update the unit price */
set SQL_SAFE_UPDATES = 0;
update stock
set unit_price = 50.0
where name = 'Nike_34';
set SQL_SAFE_UPDATES = 1;

/* Check the new unit price */
select name, unit_price 
from stock
where name = 'Nike_34';

/* Check the log again */
select * from log_price;