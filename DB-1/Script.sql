CREATE DATABASE my_first_db;
USE my_first_db;



CREATE TABLE Category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100)
);

INSERT INTO Category ( category_name)
VALUES
( 'Electronics'),
( 'Clothing'),
('Home & Kitchen'),
( 'Books'),
( 'Sports'),
( 'Beauty');



CREATE TABLE Product (
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description text ,
  stock_quantity INT,
  price DECIMAL(10, 2),
  category_id INT,
  
  foreign key (category_id)
          REFERENCES Category(category_id)

);


INSERT INTO Product
( name, description, stock_quantity, price, category_id)
VALUES
( 'Wireless Mouse', 'Bluetooth wireless mouse', 25, 350.00, 1),
( 'Mechanical Keyboard', 'RGB gaming keyboard', 12, 1250.00, 1),
( 'USB-C Cable', 'Fast charging cable', 0, 180.00, 1),
( 'Bluetooth Headphones', 'Noise cancelling headphones', 8, 1650.00, 1),

( 'Cotton T-Shirt', 'Black cotton t-shirt', 40, 450.00, 2),
( 'Denim Jeans', 'Blue slim fit jeans', 15, 1100.00, 2),

( 'Coffee Mug', 'Ceramic coffee mug', 50, 220.00, 3),
( 'Desk Lamp', 'Adjustable LED desk lamp', 11, 780.00, 3),

( 'SQL Basics', 'Introduction to SQL', 20, 600.00, 4),
( 'Clean Code', 'Software development book', 5, 950.00, 4),

( 'Yoga Mat', 'Exercise yoga mat', 17, 700.00, 5),
( 'Dumbbell Set', 'Home workout dumbbells', 6, 2200.00, 5),

( 'Laptop Stand', 'Adjustable aluminum stand', 9, 900.00, 1);



CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);


INSERT  INTO Customer
( name, Email, password)
VALUES
( 'Ahmed Ali', 'ahmed@example.com', 'dummy_hash_301'),
( 'Sara Hassan', 'sara@example.com', 'dummy_hash_302'),
( 'Omar Khaled', 'omar@example.com', 'dummy_hash_303'),
( 'Mona Ibrahim', 'mona@example.com', 'dummy_hash_304'),
( 'Youssef Adel', 'youssef@example.com', 'dummy_hash_305'),
( 'Nour Samir', 'nour@example.com', 'dummy_hash_306'),
( 'Layla Mahmoud', 'layla@example.com', 'dummy_hash_307'),
( 'Karim Mostafa', 'karim@example.com', 'dummy_hash_308');


CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(12,2),
    customer_id INT NOT NULL,

        FOREIGN KEY (customer_id)
        REFERENCES Customer(customer_id)
);

INSERT INTO Orders
( order_date, total_amount, customer_id)
VALUES
( '2026-10-02 10:30:00', 1300.00, 1),
( '2026-10-03 14:20:00', 2000.00, 2),
( '2026-10-05 09:15:00', 1790.00, 1),
( '2026-10-07 18:45:00', 1660.00, 3),
( '2026-10-09 12:10:00', 3600.00, 4),
( '2026-10-12 16:30:00', 950.00, 5),
( '2026-10-13 11:00:00', 2000.00, 2),
( '2026-10-16 20:15:00', 2150.00, 6),
( '2026-10-19 13:40:00', 1790.00, 3),
( '2026-10-21 17:25:00', 1140.00, 7);



CREATE TABLE OrderDetail (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    order_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,

        FOREIGN KEY (product_id)
        REFERENCES Product(product_id),

        FOREIGN KEY (order_id)
        REFERENCES Orders(order_id)
);


INSERT INTO OrderDetail
(product_id, order_id, quantity, unit_price)
VALUES (1, 1, 2, 350.00),
(9, 1, 1, 600.00)،
(5, 2, 2, 450.00),
(6, 2, 1, 1100.00),
(2, 3, 1, 1250.00),
(3, 3, 3, 180.00),
(7, 4, 4, 220.00),
(8, 4, 1, 780.00),
(12, 5, 1, 2200.00),
(11, 5, 2, 700.00),
(10, 6, 1, 950.00),
(4, 7, 1, 1650.00),
(1, 7, 1, 350.00),
(9, 8, 2, 600.00),
(10, 8, 1, 950.00),
(5, 9, 3, 450.00),
(7, 9, 2, 220.00),
(8, 10, 1, 780.00),
(3, 10, 2, 180.00);



select sum(total_amount) as daily_revenue
from Orders
where DATE(order_date) = '2026-10-02';


select
 od.product_id,
    p.name AS productName,
    SUM(od.quantity) AS total_quantity
from OrderDetail  od INNER JOIN Product  p 
on p.product_id = od.product_id 
INNER JOIN Orders o 
on o.order_id = od.order_id
where MONTH(o.order_date) = 10
group by od.product_id 
order by total_quantity DESC 


select c.name , sum(o.total_amount) as allAmount
from Customer c left join Orders o 
on c.customer_id = o.customer_id 
where month(o.order_date )=10 
group by c.name
HAVING  SUM(o.total_amount) > 3000


