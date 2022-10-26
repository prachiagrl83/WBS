-- Total Tech Sellers

SELECT 
    COUNT(DISTINCT seller_id)
FROM
    sellers
        LEFT JOIN
    order_items USING (seller_id)
        LEFT JOIN
    products p USING (product_id)
        LEFT JOIN
    product_category_name_translation pt USING (product_category_name)
WHERE
    pt.product_category_name_english IN ('audio' , 'electronics',
        'computers_accessories',
        'pc_gamer',
        'computers',
        'console_gamer',
        'telephony');
        
-- What is the total amount earned by all sellers?
SELECT 
    ROUND(SUM(oi.price),2) AS total
FROM
    order_items oi
        LEFT JOIN
    orders o USING (order_id)
WHERE
    o.order_status NOT IN ('unavailable' , 'canceled');

-- What is the total amount earned by all Tech sellers?
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
        AND pt.product_category_name_english IN ('audio' , 'electronics',
        'computers_accessories',
        'pc_gamer',
        'computers',
        'tablets_printing_image',
        'telephony');

-- the average monthly income of Tech sellers?
-- SELECT   Total amount earned by tech seller i think its 1666211.29 / Total tech sellers i think its 454 / no.of months data i thing its 25;
    
select 1666211.29/25; -- 66648.45
select 66648.45/454; -- Tech sellers monthly salary is 146.802753