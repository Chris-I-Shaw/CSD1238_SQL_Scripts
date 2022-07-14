/*
*Part 1
*/

/*
*Question 1
*/

DROP
PROCEDURE IF EXISTS test;
DELIMITER
    //
CREATE PROCEDURE test()
BEGIN
    DECLARE
        total_products INT ;
    SELECT
        COUNT(*)
    INTO total_products
FROM
    products ; IF total_products < 7 THEN
SELECT
    'The number of products is less than 7' ; ELSE
SELECT
    'The number of products is greater than or equal to 7' ;
END IF ;
END //
DELIMITER
    ;
CALL
    test();

/*
*Question 2
*/

DROP
PROCEDURE IF EXISTS test;
DELIMITER
    //
CREATE PROCEDURE test()
BEGIN
    DECLARE
        total_products INT ; DECLARE average_list_price DECIMAL(9, 2) ;
    SELECT
        COUNT(*)
    INTO total_products
FROM
    products ;
SELECT
    AVG(list_price)
INTO average_list_price
FROM
    products ; IF total_products >= 7 THEN
SELECT
    average_list_price,
    total_products ; ELSE
SELECT
    'The number of products is less than 7' ;
END IF ;
END //
DELIMITER
    ;
CALL
    test();

/*
*Question 3
*/



/*
*Question 4
*/



/*
*Question 5
*/

DROP
PROCEDURE IF EXISTS test;
DELIMITER
    //
CREATE PROCEDURE test()
BEGIN
    DECLARE
        duplicate_entry TINYINT DEFAULT FALSE ; DECLARE CONTINUE
    HANDLER FOR
        1062
    SET
        duplicate_entry = TRUE ;
    INSERT INTO categories
VALUES(130, ' Not Guitars') ; IF duplicate_entry = TRUE THEN
SELECT
    'Row was not inserted, duplicate value' AS message ; ELSE
SELECT
    '1 row was inserted' AS message ;
END IF ;
END //
DELIMITER
    //
CALL
    test() 

/*
*Part 2
*/



/*
*Question 1
*/

DROP PROCEDURE IF EXISTS insert_category;
DELIMITER //
CREATE PROCEDURE insert_category(category_name CHAR(30) )
BEGIN
DECLARE category_name_value CHAR(30);

 DECLARE
        duplicate_entry TINYINT DEFAULT FALSE ; DECLARE CONTINUE
    HANDLER FOR
        1062
    SET
        duplicate_entry = TRUE ;
    INSERT INTO categories
VALUES(category_name) ; IF duplicate_entry = TRUE THEN
SELECT
    'Row was not inserted, duplicate value' AS message ; ELSE
SELECT
    '1 row was inserted' AS message ;
END IF ;

END//
DELIMITER ;
CALL insert_category('Stuff');

/*
*Question 2
*/

DROP FUNCTION IF EXISTS
    discount_price;
DELIMITER
    //
CREATE FUNCTION discount_price(item_id_param INT) RETURNS DECIMAL(9, 2) BEGIN
    DECLARE
        discount_info DECIMAL(9, 2) ;
    SELECT
        item_price - discount_amount
    INTO discount_info
FROM
    order_items
WHERE
    item_id = item_id_param ; RETURN discount_info ;
END //
DELIMITER
    ;
SELECT
    item_id,
    item_price,
    discount_amount,
    discount_price(item_id) AS discounted_total
FROM
    order_items
WHERE
    item_id = 10;

/*
*Question 3
*/

DROP FUNCTION IF EXISTS
    item_total;
DELIMITER
    //
CREATE FUNCTION item_total(item_id_param INT)
RETURNS DECIMAL(9, 2)
    BEGIN
    DECLARE total_price DECIMAL(9, 2);
    
    SELECT quantity * discount_price(item_id_param)
    INTO total_price
    FROM order_items
    WHERE item_id_param= item_id;
    
    
    RETURN total_price;
END //
DELIMITER
    ;
    
    
SELECT
    item_id,
    item_price,
    discount_amount,
    discount_price(item_id) AS discounted_total,
    item_total(item_id) AS total_price
FROM
    order_items
WHERE
    item_id = 5;

/*
*Question 4
*/

DROP PROCEDURE IF EXISTS update_product_discount;

DELIMITER //

CREATE PROCEDURE update_product_discount(product_id_param INT, new_discount_percent DECIMAL(9, 2))
BEGIN

IF new_discount_percent<0 THEN 
SIGNAL SQLSTATE '22003'
SET MESSAGE_TEXT = 'Negative value percentage',
MYSQL_ERRNO =1264;
END IF;




UPDATE products
SET discount_percent = new_discount_percent
WHERE product_id=product_id_param;

END //
DELIMITER ;
CALL update_product_discount(5, 22.00);
-- CALL update_product_discount(6, -12);

/*
*Question 5
*/

DROP
PROCEDURE IF EXISTS test;
DELIMITER
    //
CREATE PROCEDURE test()
BEGIN
    DECLARE
        sql_error TINYINT DEFAULT FALSE ; DECLARE CONTINUE
    HANDLER FOR SQLEXCEPTION
SET
    sql_error = TRUE ;
START TRANSACTION
    ;
DELETE
FROM
    addresses
WHERE
    customer_id = 8 ;
DELETE
FROM
    customers
WHERE
    customer_id = 8 ; IF sql_error = TRUE THEN
ROLLBACK
    ;
SELECT
    'Transaction rolled back.' ; ELSE
COMMIT
    ;
SELECT
    'Transaction committed.' ;
END IF ;
END //
DELIMITER
    ;
CALL
    test();