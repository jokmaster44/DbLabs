CREATE TABLE users (
    user_id SERIAL PRIMARY KEY ,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) Not Null ,
    email varchar(100) not null unique ,
    phone varchar(50),
    password varchar(100) not null ,
    created_at date not null default current_date
);

CREATE TABLE addresses (
    address_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    country VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    street VARCHAR(100) NOT NULL,
    house_number VARCHAR(20) NOT NULL,
    postal_code VARCHAR(20),
    CONSTRAINT fk_addresses_users
        FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price NUMERIC(10, 2) NOT NULL CHECK (price > 0),
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0),
    category_id INT NOT NULL,
    CONSTRAINT fk_products_categories
        FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    address_id INT NOT NULL,
    order_date DATE NOT NULL DEFAULT CURRENT_DATE,
    status VARCHAR(30) NOT NULL DEFAULT 'new',
    total_amount NUMERIC(10, 2) NOT NULL CHECK (total_amount >= 0),
    CONSTRAINT fk_orders_users
        FOREIGN KEY (user_id) REFERENCES users(user_id),
    CONSTRAINT fk_orders_addresses
        FOREIGN KEY (address_id) REFERENCES addresses(address_id)
);

CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    price_at_purchase NUMERIC(10, 2) NOT NULL CHECK (price_at_purchase > 0),
    CONSTRAINT fk_order_items_orders
        FOREIGN KEY (order_id) REFERENCES orders(order_id),
    CONSTRAINT fk_order_items_products
        FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL UNIQUE,
    payment_method VARCHAR(50) NOT NULL,
    payment_status VARCHAR(30) NOT NULL,
    payment_date DATE,
    amount NUMERIC(10, 2) NOT NULL CHECK (amount >= 0),
    CONSTRAINT fk_payments_orders
        FOREIGN KEY (order_id) REFERENCES orders(order_id)
);


INSERT INTO users (first_name, last_name, email, phone, password)
VALUES
('Ivan', 'Petrenko', 'ivan.petrenko@gmail.com', '+380501112233', 'pass123'),
('Olena', 'Shevchenko', 'olena.shevchenko@gmail.com', '+380672223344', 'pass456'),
('Andrii', 'Koval', 'andrii.koval@gmail.com', '+380933334455', 'pass789'),
('Kostiantyn' , 'Provodenko', 'kostya.provod49@gmail.com', '+491753720503', 'pass8153');

INSERT INTO categories (category_name, description)
VALUES
('Electronics', 'Electronic devices and accessories'),
('PC Components', 'Computer parts and components'),
('Home Appliances', 'Appliances for home use'),
('Gaming', 'Gaming devices and accessories'),
('Smartphones', 'Mobile phones and accessories'),
('Audio', 'Audio devices and headphones');

INSERT INTO products (name, description, price, stock_quantity, category_id)
VALUES
('Smartphone', 'Modern smartphone with 128GB storage', 15999.00, 20, 1),
('Laptop', 'Laptop for work and study', 32999.00, 10, 1),
('SSD 1TB', 'Solid state drive for PC', 2999.00, 30, 2),
('Keyboard', 'Mechanical keyboard', 1999.00, 25, 2),
('Microwave Oven', 'Microwave oven for kitchen', 4999.00, 8, 3),
('PlayStation 5', 'Gaming console', 25999.00, 7, 4),
('Gaming Mouse', 'RGB gaming mouse', 1499.00, 40, 4),
('iPhone 15', 'Apple smartphone', 45999.00, 5, 5),
('Samsung Galaxy S24', 'Samsung smartphone', 38999.00, 8, 5),
('AirPods Pro 2 ', 'Wireless headphones', 9999.00, 15, 6),
('JBL Speaker', 'Portable speaker', 3499.00, 20, 6),
('Gaming Chair', 'Comfortable gaming chair', 7999.00, 10, 4);

INSERT INTO addresses (user_id, country, city, street, house_number, postal_code)
VALUES
(1, 'Ukraine', 'Kyiv', 'Khreshchatyk', '10', '01001'),
(2, 'Ukraine', 'Lviv', 'Shevchenka', '25', '79000'),
(3, 'Ukraine', 'Odesa', 'Deribasivska', '5', '65000'),
(4, 'Germany', 'Munchen' , 'HeimgartenStrasse', '19', '81539');

INSERT INTO orders (user_id, address_id, status, total_amount)
VALUES
(1, 1, 'paid', 17998.00),
(2, 2, 'new', 32999.00),
(3, 3, 'paid', 4999.00),
(4, 4, 'paid', 2999.00),
(1, 1, 'paid', 25999.00),
(2, 2, 'paid', 45999.00),
(3, 3, 'new', 1499.00);

INSERT INTO order_items (order_id, product_id, quantity, price_at_purchase)
VALUES
(1, 1, 1, 15999.00),
(1, 4, 1, 1999.00),
(2, 2, 1, 32999.00),
(3, 5, 1, 4999.00),
(4, 3, 1, 2999.00),
(5, 6, 1, 25999.00),
(6, 8, 1, 45999.00),
(7, 7, 1, 1499.00);

INSERT INTO payments (order_id, payment_method, payment_status, payment_date, amount)
VALUES
(1, 'card', 'completed', CURRENT_DATE, 17998.00),
(2, 'apple_pay', 'pending', NULL, 32999.00),
(3, 'google_pay', 'completed', CURRENT_DATE, 4999.00),
(4, 'card', 'completed', CURRENT_DATE, 2999.00);

SELECT * FROM users;
SELECT * FROM categories;

SELECT * FROM products
ORDER BY price DESC;

SELECT * FROM addresses;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM payments;


SELECT c.category_name,
       COUNT(p.product_id) AS product_count
FROM categories c
LEFT JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_name;

SELECT c.category_name,
       AVG(p.price) AS average_price
FROM categories c
JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_name;

SELECT c.category_name,
       SUM(p.price * p.stock_quantity) AS total_stock_value
FROM categories c
JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_name;

SELECT c.category_name,
       MIN(p.price) AS min_price,
       MAX(p.price) AS max_price
FROM categories c
JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_name;

SELECT c.category_name,
       COUNT(p.product_id) AS product_count
FROM categories c
JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_name
HAVING COUNT(p.product_id) > 1;

SELECT c.category_name,
       SUM(oi.quantity * oi.price_at_purchase) AS category_sales
FROM categories c
JOIN products p ON c.category_id = p.category_id
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY c.category_name
ORDER BY category_sales DESC;

SELECT c.category_name,
       SUM(oi.quantity) AS sold_quantity
FROM categories c
JOIN products p ON c.category_id = p.category_id
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY c.category_name
ORDER BY sold_quantity DESC;

SELECT name,
       price
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products );

SELECT c.category_name,
       AVG(p.price) AS average_price
FROM categories c
JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_name
HAVING AVG(p.price) > (
    SELECT AVG(price)
    FROM products );

SELECT c.category_name,
       COUNT(p.product_id) AS product_count
FROM categories c
JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_name
ORDER BY product_count DESC
LIMIT 1;

ALTER USER postgres PASSWORD '0000';