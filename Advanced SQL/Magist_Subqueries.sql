USE magist;
/*Select all the products from the health_beauty or perfumery categories that
have been paid by credit card with a payment amount of more than 1000$,
from orders that were purchased during 2018 and have a ‘delivered’ status?*/

SELECT oi.product_id,pt.product_category_name,pt.product_category_name_english,
o.order_status,op.payment_type,date_format(o.order_purchase_timestamp, '%Y') AS purchased_year
-- avg(p.product_weight_g)
FROM order_items oi
LEFT JOIN orders o
	ON o.order_id = oi.order_id
LEFT JOIN products p
	ON p.product_id = oi.product_id
LEFT JOIN product_category_name_translation pt
	USING (product_category_name)
LEFT JOIN order_payments op
	ON o.order_id = op.order_id
WHERE pt.product_category_name_english IN ("perfumery","health_beauty") and op.payment_value>1000 and op.payment_type='credit_card'
and o.order_status = 'delivered' 
ORDER BY 1 DESC;
-----------------------------------------------------------------------
CREATE TEMPORARY TABLE my_products
SELECT DISTINCT
    p.product_id
FROM
    order_items oi
        LEFT JOIN
    products p ON p.product_id = oi.product_id
        LEFT JOIN
    product_category_name_translation pt ON p.product_category_name = pt.product_category_name
        LEFT JOIN
    orders o ON oi.order_id = o.order_id
WHERE
    ((pt.product_category_name_english = 'health_beauty')
        OR (pt.product_category_name_english = 'perfumery'))
        AND (o.order_status = 'delivered')
        AND (YEAR(o.order_purchase_timestamp) = 2018)
        AND (oi.price > 500);

 SELECT 
    *
FROM
    my_products;

/*For the products that you selected, get the following information:
The average weight of those products
The cities where there are sellers that sell those products
The cities where there are customers who bought products*/

-- 1. The average weight of those products 
SELECT 
    AVG(product_weight_g)
FROM
    products
WHERE
    product_id IN (SELECT 
            product_id
        FROM
            my_products);

-- 2. The names of the cities where there are sellers that sell those products
SELECT DISTINCT
    (city)
FROM
    sellers s
        LEFT JOIN
    geo g ON s.seller_zip_code_prefix = g.zip_code_prefix
        LEFT JOIN
    order_items oi ON s.seller_id = oi.seller_id
        LEFT JOIN
    products p ON oi.product_id = p.product_id
WHERE
    p.product_id IN (SELECT 
            product_id
        FROM
            my_products);

-- 3. The cities of the customers of those products
SELECT DISTINCT
    (city)
FROM
    order_items oi
        LEFT JOIN
    orders o ON o.order_id = oi.order_id
        LEFT JOIN
    customers c ON o.customer_id = c.customer_id
        LEFT JOIN
    geo g ON c.customer_zip_code_prefix = g.zip_code_prefix
WHERE
    oi.product_id IN (SELECT 
            product_id
        FROM
            my_products);