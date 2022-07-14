/*Chris Shaw SQL Assignment 2*/
    /*Question1*/
SELECT
    category_name,
    product_name,
    list_price
FROM
    products a
JOIN categories b ON
    a.category_id = b.category_id
ORDER BY
    category_name,
    product_name ASC;
    /*Question2*/
SELECT
    first_name,
    last_name,
    line1,
    city,
    zip_code
FROM
    addresses a
JOIN customers b WHERE
    b.email_address = 'allan.sherwood@yahoo.com';
    /*Question3*/
SELECT
    first_name,
    last_name,
    line1,
    city,
    state,
    zip_code
FROM
    addresses a
JOIN customers b ON
    a.customer_id = b.customer_id
WHERE
    b.shipping_address_id = a.address_id;
    /*Question4*/
SELECT
    last_name,
    first_name,
    order_date,
    product_name,
    item_price,
    discount_amount,
    quantity
FROM
    customers a
JOIN orders b ON
    a.customer_id = b.customer_id
JOIN order_items c ON
    b.order_id = c.order_id
JOIN products d ON
    c.product_id = d.product_id
ORDER BY
    last_name,
    order_date,
    product_name
DESC
    ;
    /*Question5*/
    /* Did not finish
SELECT product_name, list_price
FROM products a JOIN list_price b
ON a.list_price = b.list_price
WHERE NOT a.product_id = b.product_id
ORDER BY product_name DESC;
*/
    /*Question6*/
SELECT
    category_name,
    product_id
FROM
    products a
LEFT JOIN categories b ON
    a.category_id = b.category_id
WHERE
    product_id IS NULL;
    /*product_id did not contain any null values*/
	
    /*Question7*/
SELECT
    'SHIPPED' AS ship_status,
    order_id,
    order_date
FROM
    orders
WHERE
    ship_date IS NOT NULL
UNION
SELECT
    'NOT SHIPPED' AS ship_status,
    order_id,
    order_date
FROM
    orders
WHERE
    ship_date IS NULL
ORDER BY
    order_date ASC;