-- TODO: This query will return a table with the top 10 least revenue categories 
-- in English, the number of orders and their total revenue. The first column 
-- will be Category, that will contain the top 10 least revenue categories; the 
-- second one will be Num_order, with the total amount of orders of each 
-- category; and the last one will be Revenue, with the total revenue of each 
-- catgory.
-- HINT: All orders should have a delivered status and the Category and actual 
-- delivery date should be not null.
SELECT
    pct.product_category_name_english AS Category,
    COUNT(DISTINCT oi.order_id) AS Num_order,
    SUM(op.payment_value) AS Revenue
FROM
    olist_order_items oi
JOIN
    olist_orders o ON oi.order_id = o.order_id
JOIN
    olist_order_payments op ON oi.order_id = op.order_id
JOIN
    olist_products p ON oi.product_id = p.product_id
JOIN
    product_category_name_translation pct ON p.product_category_name = pct.product_category_name
WHERE
    o.order_status = 'delivered'
    AND o.order_delivered_customer_date IS NOT NULL
    AND pct.product_category_name_english IS NOT NULL
GROUP BY
    Category
ORDER BY
    Revenue ASC
LIMIT 10;
