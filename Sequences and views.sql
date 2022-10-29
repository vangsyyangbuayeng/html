
use BSP5C

CREATE VIEW sales.daily_sales
AS
SELECT
    year(order_date) AS y,
    month(order_date) AS m,
    day(order_date) AS d,
    p.product_id,
    product_name,
    quantity * i.list_price AS sales
FROM
    sales.orders AS o
INNER JOIN sales.order_items AS i
    ON o.order_id = i.order_id
INNER JOIN production.products AS p
    ON p.product_id = i.product_id;

select *from sales.daily_sales


CREATE OR ALTER  view sales.daily_sales (
    year,
    month,
    day,
    customer_name,
    product_id,
    product_name,
    sales
)
AS
SELECT
    year(order_date),
    month(order_date),
    day(order_date),
    concat(
        first_name,
        ' ',
        last_name
    ),
    p.product_id,
    product_name,
    quantity * i.list_price
FROM
    sales.orders AS o
    INNER JOIN
        sales.order_items AS i
    ON o.order_id = i.order_id
    INNER JOIN
        production.products AS p
    ON p.product_id = i.product_id
    INNER JOIN sales.customers AS c
    ON c.customer_id = o.customer_id;

SELECT 
 * 
FROM 
 sales.daily_sales
ORDER BY
 year, month, day, product_name;


SELECT * FROM sales.daily_sales ORDER BY year, month, day, customer_name;

CREATE VIEW sales.product_info
AS
SELECT
 product_name, 
 brand_name, 
 list_price
FROM
 production.products p
INNER JOIN production.brands b 
 ON b.brand_id = p.brand_id;

 CREATE VIEW sales.staff_sales (
 first_name, 
 last_name,
 year, 
 amount
)
AS 
 SELECT 
 first_name,
 last_name,
 YEAR(order_date),
 SUM(list_price * quantity) amount
 FROM
 sales.order_items i
 INNER JOIN sales.orders o
 ON i.order_id = o.order_id
 INNER JOIN sales.staffs s
 ON s.staff_id = o.staff_id
 GROUP BY 
 first_name, 
 last_name, 
 YEAR(order_date);

 SELECT 
 * 
FROM 
 sales.staff_sales
ORDER BY 
first_name,
last_name,
year;

CREATE VIEW sales.product_catalog
AS
SELECT 
 product_name, 
 category_name, 
brand_name,
 list_price
FROM 
 production.products p
INNER JOIN production.categories c 
 ON c.category_id = p.category_id
INNER JOIN production.brands b
ON b.brand_id = p.brand_id;


create schema procurement;
go

CREATE TABLE procurement.purchase_orders(
    order_id INT PRIMARY KEY,
    vendor_id int NOT NULL,
    order_date date NOT NULL
);

select *from procurement.purchase_orders

CREATE SEQUENCE procurement.order_number 
AS INT
START WITH 1
INCREMENT BY 1;


INSERT INTO procurement.purchase_orders
    (order_id,
    vendor_id,
    order_date)
VALUES
    (NEXT VALUE FOR procurement.order_number,1,'2019-04-30');


INSERT INTO procurement.purchase_orders
    (order_id,
    vendor_id,
    order_date)
VALUES
    (NEXT VALUE FOR procurement.order_number,2,'2019-05-01');


INSERT INTO procurement.purchase_orders
    (order_id,
    vendor_id,
    order_date)
VALUES
    (NEXT VALUE FOR procurement.order_number,3,'2019-05-02');


SELECT 
    order_id, 
    vendor_id, 
    order_date
FROM 
    procurement.purchase_orders;

select *from procurement.purchase_orders


CREATE SEQUENCE procurement.receipt_no
START WITH 1
INCREMENT BY 1;


CREATE TABLE procurement.goods_receipts
(
    receipt_id   INT	PRIMARY KEY 
        DEFAULT (NEXT VALUE FOR procurement.receipt_no), 
    order_id     INT NOT NULL, 
    full_receipt BIT NOT NULL,
    receipt_date DATE NOT NULL,
    note NVARCHAR(100),
);


CREATE TABLE procurement.invoice_receipts
(
    receipt_id   INT PRIMARY KEY
        DEFAULT (NEXT VALUE FOR procurement.receipt_no), 
    order_id     INT NOT NULL, 
    is_late      BIT NOT NULL,
    receipt_date DATE NOT NULL,
    note NVARCHAR(100)
);



INSERT INTO procurement.goods_receipts(
    order_id, 
    full_receipt,
    receipt_date,
    note
)
VALUES(
    1,
    1,
    '2019-05-12',
    'Goods receipt completed at warehouse'
);
INSERT INTO procurement.goods_receipts( order_id,   full_receipt,receipt_date,  note
)
VALUES(
    1,
    0,
    '2019-05-12',
    'Goods receipt has not completed at warehouse'
);

INSERT INTO procurement.invoice_receipts( order_id,   is_late, receipt_date,   note
)
VALUES(
    1,
    0,
    '2019-05-13',
    'Invoice duly received'
);
INSERT INTO procurement.invoice_receipts( order_id,  is_late, receipt_date,note
)
VALUES(
    2,
    0,
    '2019-05-15',
    'Invoice duly received'
);

select *from procurement.goods_receipts
select *from procurement.invoice_receipts


