#In relation to the products:
-- What categories of tech products does Magist have?

#SELECT p.product_category_name,pt.product_category_name_english,
select COUNT(p.product_id),
CASE
WHEN pt.product_category_name_english IN ('food','food_drink','drinks') THEN 'Food & Drink'
WHEN pt.product_category_name_english IN ('auto') THEN 'Automotive'
WHEN pt.product_category_name_english IN ('art','arts_and_craftmanship','party_supplies','christmas_supplies') THEN 'Art & Craft'
WHEN pt.product_category_name_english IN ('electronics','computers_accessories','pc_gamer','computers','consoles_games','telephony','watches_gifts') THEN 'Tech'
WHEN pt.product_category_name_english IN ('sports_leisure','fashion_bags_accessories','fashion_shoes','fashion_sport','fashio_female_clothing','fashion_male_clothing','fashion_childrens_clothes','fashion_underwear_beach','luggage_accessories') THEN 'Fashion'
WHEN pt.product_category_name_english IN ('bed_bath_table','home_confort','home_comfort_2','air_conditioning','home_appliances','home_appliances_2','small_appliances','garden_tools','flowers','la_cuisine','furniture_mattress_and_upholstery','office_furniture','furniture_bedroom','furniture_living_room','small_appliances_home_oven_and_coffee','portable_kitchen_food_processors','housewares','kitchen_dining_laundry_garden_furniture','furniture_decor') THEN 'Home & Living'
WHEN pt.product_category_name_english IN ('home_construction','construction_tools_construction','costruction_tools_tools','construction_tools_lights','costruction_tools_garden','construction_tools_safety') THEN 'Construction'
WHEN pt.product_category_name_english IN ('books_imported','books_general_interest','books_technical') THEN 'Book'
WHEN pt.product_category_name_english IN ('baby','health_beauty','toys','diapers_and_hygiene','perfumery') THEN 'Beauty & Baby'
WHEN pt.product_category_name_english IN ('agro_industry_and_commerce','industry_commerce_and_business') THEN 'Industry'
WHEN pt.product_category_name_english IN ('audio','cds_dvds_musicals','cine_photo','dvds_blu_ray','musical_instruments','music','tablets_printing_image') THEN 'Audio & Photo'
WHEN pt.product_category_name_english IN ('cool_stuff','market_place','others','stationery','pet_shop','security_and_services','fixed_telephony','signaling_and_security') THEN 'Other'
END AS 'Categories'
FROM product_category_name_translation pt
INNER JOIN products p ON pt.product_category_name = p.product_category_name
GROUP BY Categories;

-- How many products of these tech categories have been sold (within the time window of the database snapshot)? 
SELECT COUNT(DISTINCT(oi.product_id)) AS tech_products_sold
FROM order_items oi
LEFT JOIN products p 
	USING (product_id)
LEFT JOIN product_category_name_translation pt
	USING (product_category_name)
WHERE product_category_name_english = "watches_gifts"
OR product_category_name_english =  "electronics"
OR product_category_name_english =  "computers_accessories"
OR product_category_name_english =  "pc_gamer"
OR product_category_name_english =  "computers"
OR product_category_name_english =  "consoles_games"
OR product_category_name_english =  "telephony";

select * from order_items;

-- What percentage does that represent from the overall number of products sold?
SELECT COUNT(DISTINCT(product_id)) AS products_sold FROM order_items;
-- In Report
select (4969 /32951) * 100;

-- What’s the average price of the products being sold?
SELECT Round(AVG(price),2) as avg_price FROM order_items;

-- Are expensive tech products popular? 
SELECT COUNT(oi.product_id) as products_count, 
	CASE 
		WHEN price > 1000 THEN "Expensive"
		WHEN price > 100 THEN "Mid-Ranged"
		ELSE "Cheap"
	END AS price_range
FROM order_items oi
LEFT JOIN products p
	ON p.product_id = oi.product_id
LEFT JOIN product_category_name_translation pt
	USING (product_category_name)
WHERE pt.product_category_name_english IN ("watches_gifts", "electronics", "computers_accessories", "pc_gamer", "computers", "consoles_games", "telephony")
GROUP BY price_range
ORDER BY 1 DESC;

-- In relation to the sellers:
#How many months of data are included in the magist database?
SELECT 
    TIMESTAMPDIFF(MONTH,
        MIN(order_purchase_timestamp),
        MAX(order_purchase_timestamp)) as Magist_Months
FROM
    orders;
#How many sellers are there?
SELECT COUNT(*) FROM sellers;

#How many Tech sellers are there?
SELECT COUNT(DISTINCT s.seller_id) as tech_sellers
FROM sellers s
INNER JOIN order_items oi ON s.seller_id = oi.seller_id
INNER JOIN products p ON oi.product_id = p.product_id
INNER JOIN product_category_name_translation pt ON p.product_category_name = pt.product_category_name
WHERE pt.product_category_name_english IN ('electronics','computers_accessories','pc_gamer','computers','consoles_games','telephony','watches_gifts');

#What percentage of overall sellers are Tech sellers?
-- in Report

#What is the total amount earned by all sellers?
#Note : We will use price from order_items not payment_value from order_payments becoz order may contain tech and non tech products. With payment_value we can not find difference between items in an order
SELECT 
    ROUND(SUM(oi.price),2) AS total_amount
FROM
    order_items oi
        LEFT JOIN
    orders o USING (order_id)
WHERE
    o.order_status NOT IN ('unavailable' , 'canceled');
    
#What is the total amount earned by all Tech sellers?
SELECT 
    ROUND(SUM(oi.price),2) AS total
FROM
    order_items oi
        LEFT JOIN
    orders o USING (order_id)
        LEFT JOIN
    products p USING (product_id)
        LEFT JOIN
    product_category_name_translation pt USING (product_category_name)
WHERE
    o.order_status NOT IN ('unavailable' , 'canceled')
        AND pt.product_category_name_english IN ('electronics','computers_accessories','pc_gamer','computers','consoles_games','telephony','watches_gifts');

# the average monthly income of all sellers?
-- In Report

#the average monthly income of Tech sellers?
-- In Report

#In relation to the delivery time:
-- What’s the average time between the order being placed and the product being delivered for all products category?
SELECT AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)) as Avg_time
FROM orders;

#How many orders are delivered on time vs orders delivered with a delay?
#Note : comparison in % we will show in Report
SELECT 
	CASE 
		WHEN DATE(order_delivered_customer_date) <= DATE(order_estimated_delivery_date) THEN 'On time'
		ELSE 'Delayed'
    END AS delivery_status, 
COUNT(order_id) AS orders_count
FROM orders
WHERE order_status = 'delivered'
GROUP BY delivery_status;

#Is there any pattern for delayed orders, e.g. big products being delayed more often?
SELECT
	CASE 
		WHEN DATEDIFF(order_estimated_delivery_date, order_delivered_customer_date) > 60 THEN " 2 months delayed"
        WHEN DATEDIFF(order_estimated_delivery_date, order_delivered_customer_date) >= 7 AND DATEDIFF(order_estimated_delivery_date, order_delivered_customer_date) < 60 THEN "1 week to 2 months delayed"
		WHEN DATEDIFF(order_estimated_delivery_date, order_delivered_customer_date) > 3 AND DATEDIFF(order_estimated_delivery_date, order_delivered_customer_date) < 8 THEN "3 - 7 days delayed"
		WHEN DATEDIFF(order_estimated_delivery_date, order_delivered_customer_date) > 1 THEN "1 - 3 days delayed"
		ELSE "only 1 day delay"
	END AS "delayed_range", 
COUNT(*) AS product_count 
FROM orders a
LEFT JOIN order_items b
	ON a.order_id = b.order_id
LEFT JOIN products c
	ON b.product_id = c.product_id
WHERE DATEDIFF(order_estimated_delivery_date, order_delivered_customer_date) > 0
GROUP BY delayed_range
ORDER BY product_count DESC;

-- Products with highest income in TECH category

  SELECT pt.product_category_name_english, ROUND(SUM(oi.price),2) AS seller_with_highest_income
FROM sellers s
INNER JOIN order_items oi ON s.seller_id = oi.seller_id
INNER JOIN orders o ON oi.order_id = o.order_id
INNER JOIN products p ON oi.product_id = p.product_id
INNER JOIN product_category_name_translation pt ON p.product_category_name = pt.product_category_name
WHERE pt.product_category_name_english IN ('Watches_gifts','electronics','computers_accessories','pc_gamer','computers','consoles_games','telephony')
GROUP BY pt.product_category_name_english
ORDER BY SUM(oi.price) DESC;


-- Revenue of Eniac for the financial year (2017-18): 40,044,542 €, Now find out Magist Revenue
select ROUND(sum(price),2) as total_revenue from order_items; 
-- 13,591,643.7

-- Avg monthly revenue of Eniac for the financial year (2017-18): 1,011,256 €, find out the same for Magist

SELECT mix.monthyear, ROUND(AVG(mix.seller_monthly_income),2) AS 'Average monthly income' 
FROM (
SELECT s.seller_id, SUM(price) AS seller_monthly_income, date_format(o.order_purchase_timestamp, '%M %Y') AS monthyear
FROM sellers s
INNER JOIN order_items oi ON s.seller_id = oi.seller_id
INNER JOIN orders o ON oi.order_id = o.order_id
GROUP BY s.seller_id, date_format(order_purchase_timestamp, '%M %Y')
ORDER BY year(order_purchase_timestamp),month(order_purchase_timestamp)
)
AS mix
where mix.monthyear >= 'April 2017' and mix.monthyear <= 'March 2018'
GROUP BY mix.monthyear;

-- Avg order price of Eniac : 710 €
select avg(payment_value) from  order_payments; 
-- group by order_id;

-- Avg item price: 540 €
select ROUND(avg(price),2) from order_items;

-- Products Review
SELECT orw.review_score AS 'Review score', COUNT(*) AS 'Total number of products' FROM products p
INNER JOIN order_items oi ON p.product_id=oi.product_id
INNER JOIN order_reviews orw ON oi.order_id=orw.order_id
INNER JOIN product_category_name_translation pt ON pt.product_category_name = p.product_category_name
WHERE pt.product_category_name_english 
IN ('electronics','computers_accessories','pc_gamer','computers','consoles_games','telephony','watches_gifts')
-- AND oi.seller_id = '53243585a1d6dc2643021fd1853d8905'
GROUP BY orw.review_score
ORDER BY orw.review_score DESC;



