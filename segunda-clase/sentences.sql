DROP DATABASE IF EXISTS bootcamp;
CREATE DATABASE bootcamp;

USE bootcamp;

DROP DATABASE IF EXISTS users;
DROP DATABASE IF EXISTS products;
DROP DATABASE IF EXISTS categories;
DROP DATABASE IF EXISTS product_categories; -- Pendiente
DROP DATABASE IF EXISTS shopping_cart; -- Pendiente
DROP DATABASE IF EXISTS shopping_cart_products; -- Pendiente

CREATE TABLE IF NOT EXISTS users(
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,  
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS products(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    price INT UNSIGNED DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS categories(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS shopping_cart(
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE -- SI elimina elemento en shpping cart el elemeneto en users se elimina
);

CREATE TABLE IF NOT EXISTS shopping_cart_products(
    id INT PRIMARY KEY AUTO_INCREMENT,
    shopping_cart_id INT NOT NULL,
    product_id INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY(shopping_cart_id) REFERENCES shopping_cart(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS product_categories(
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    category_id INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY(category_id) REFERENCES categories(id) ON DELETE CASCADE 
);

-- Users
INSERT INTO users(username, email) VALUES('user1', 'user1@example.com'); -- Carrito de compras
INSERT INTO users(username, email) VALUES('user2', 'user2@example.com'); -- Carrito de compras
INSERT INTO users(username, email) VALUES('user3', 'user3@example.com');
INSERT INTO users(username, email) VALUES('user4', 'user4@example.com');

-- Products
INSERT INTO products(name, price) VALUES('Manzana', 1);
INSERT INTO products(name, price) VALUES('Coco', 2);

INSERT INTO products(name, price) VALUES('Smartphone', 400);
INSERT INTO products(name, price) VALUES('Laptop', 600);
INSERT INTO products(name, price) VALUES('Monitor', 300);

INSERT INTO products(name, price) VALUES('Playera', 30);
INSERT INTO products(name, price) VALUES('Camisa', 40);
INSERT INTO products(name, price) VALUES('Sudadera', 40);
INSERT INTO products(name, price) VALUES('Gorra', 2); -- 9

INSERT INTO products(name, price) VALUES('Lentes', 20); -- 10

-- Categories
INSERT INTO categories(name) VALUES('Comida');
INSERT INTO categories(name) VALUES('Tecnología');
INSERT INTO categories(name) VALUES('Ropa');
INSERT INTO categories(name) VALUES('Autos');


-- Product Categories
INSERT INTO product_categories(product_id, category_id) VALUES(1, 1);
INSERT INTO product_categories(product_id, category_id) VALUES(2, 1);

INSERT INTO product_categories(product_id, category_id) VALUES(3, 2);
INSERT INTO product_categories(product_id, category_id) VALUES(4, 2);
INSERT INTO product_categories(product_id, category_id) VALUES(5, 2);

INSERT INTO product_categories(product_id, category_id) VALUES(6, 3);
INSERT INTO product_categories(product_id, category_id) VALUES(7, 3);
INSERT INTO product_categories(product_id, category_id) VALUES(8, 3);
INSERT INTO product_categories(product_id, category_id) VALUES(9, 3);
-- Shopping cart

INSERT INTO shopping_cart(user_id) VALUES (1);
INSERT INTO shopping_cart(user_id) VALUES (2);
INSERT INTO shopping_cart(user_id) VALUES (3);

-- shopping_cart_products

INSERT INTO shopping_cart_products(shopping_cart_id, product_id) VALUES (1, 1);
INSERT INTO shopping_cart_products(shopping_cart_id, product_id) VALUES (1, 2);
INSERT INTO shopping_cart_products(shopping_cart_id, product_id) VALUES (1, 3);

INSERT INTO shopping_cart_products(shopping_cart_id, product_id) VALUES (2, 1);
INSERT INTO shopping_cart_products(shopping_cart_id, product_id) VALUES (2, 2);
INSERT INTO shopping_cart_products(shopping_cart_id, product_id) VALUES (2, 3);
INSERT INTO shopping_cart_products(shopping_cart_id, product_id) VALUES (2, 4);
INSERT INTO shopping_cart_products(shopping_cart_id, product_id) VALUES (2, 5);


-- Obtener la suma total de precios de todos los productos con categorías 1 y 2.
''' correcto 
SELECT
SUM(products.price) AS total
FROM products
INNER JOIN product_categories ON products.id = product_categories.product_id
WHERE product_categories.category_id IN (1,2); '''

-- Obtener el nombre de la categoría con más productos.
'''
SELECT categories.name, COUNT(*) as total
FROM categories
INNER JOIN product_categories ON categories.id = product_categories.category_id
GROUP BY categories.id
ORDER BY total DESC LIMIT 1;
'''

-- Obtener todos los productos sin categoría.
'''
SELECT products.name
FROM products
LEFT JOIN product_categories ON products.id = product_categories.product_id
WHERE product_categories.id IS NULL;'''



-- Obtener todos aquellos productos en un carrito de compras
''' SELECT DISTINCT products.name
FROM products
INNER JOIN shopping_cart_products ON products.id = shopping_cart_products.product_id; '''

-- Listar todos los productos del usuario cuyo id es 1.
'''
SELECT products.name
FROM products 
INNER JOIN shopping_cart_products ON products.id = shopping_cart_products.product_id
INNER JOIN shopping_cart ON shopping_cart_products.shopping_cart_id = shopping_cart.id
WHERE shopping_cart.user_id=1;'''


-- Muestra en pantalla la cantidad de productos del usario 1

'''
SELECT COUNT(*) AS total
FROM shopping_cart_products 
INNER JOIN shopping_cart ON shopping_cart_products.shopping_cart_id = shopping_cart.id
WHERE shopping_cart.user_id=1;'''

-- Mostrar en pantalla el total del carrito de compras del usuarios cuyo id es 2.
'''
SELECT SUM(products.price)
FROM products
INNER JOIN  shopping_cart_products ON shopping_cart_products.product_id = products.id
INNER JOIN  shopping_cart ON shopping_cart_products.shopping_cart_id = shopping_cart.id
WHERE shopping_cart.user_id = 2;'''

-- Mostrar en pantalla el nombre de las categorías con por lo menos 4 productos
'''
SELECT categories.name, COUNT(*) AS total
FROM categories
INNER JOIN product_categories ON categories.id = product_categories.category_id
GROUP BY categories.id
HAVING total >= 4;'''

-- Mostrar el total de todos los carritos de compras. 
'''
SELECT COUNT(*) as total
FROM users
INNER JOIN shopping_cart ON users.id = shopping_cart.user_id
ORDER BY users.id;'''


-- Obtener el nombre de todos los usuarios que no poseen un carrito de compras.
'''
SELECT users.username
FROM users 
LEFT JOIN shopping_cart ON users.id = shopping_cart.user_id
WHERE shopping_cart.id IS NULL;'''

-- Obtener el nombre de todos los usuarios con carritos de compras vacíos.
'''
SELECT users.username FROM users 
LEFT JOIN shopping_cart ON users.id = shopping_cart.user_id
WHERE shopping_cart.id IS NULL;'''