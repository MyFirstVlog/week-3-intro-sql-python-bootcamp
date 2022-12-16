
-- Obtener el nombre de todos los productos cuya categoría sea id 1.
SELECT
products.name
FROM products
INNER JOIN product_categories ON products.id = product_categories.product_id
WHERE product_categories.category_id = 1;
-- user_id - user_id <USING>

-- Obtener la suma total de precios de todos los productos con categorías 1 y 2.
SELECT
    SUM(products.price) AS total
FROM products
INNER JOIN product_categories ON products.id = product_categories.product_id
WHERE product_categories.category_id IN (1, 2);


-- Obtener el nombre de la categoría con más productos.
SELECT 
categories.name,
COUNT(*) AS total
FROM categories
INNER JOIN product_categories ON categories.id = product_categories.category_id
GROUP BY categories.id
ORDER BY total DESC
LIMIT 1;


-- Obtener todos los productos sin categoría.
SELECT
* 
FROM products -- A
LEFT JOIN product_categories ON products.id = product_categories.product_id -- B
WHERE product_id IS NULL;

-- Obtener todos aquellos productos en un carrito de compras.

SELECT
    products.name
FROM products
INNER JOIN shopping_cart_products ON products.id = shopping_cart_products.product_id
GROUP BY products.name;

SELECT 
DISTINCT
    products.name
FROM products
INNER JOIN shopping_cart_products ON products.id = shopping_cart_products.product_id;

-- Listar todos los productos del usuario cuyo id es 1.

SELECT
    products.name
FROM products
INNER JOIN shopping_cart_products ON products.id = shopping_cart_products.product_id
INNER JOIN shopping_cart ON shopping_cart_products.shopping_cart_id = shopping_cart.id
WHERE shopping_cart.user_id = 1;


SELECT
    products.name
FROM products
INNER JOIN shopping_cart_products ON products.id = shopping_cart_products.product_id
INNER JOIN shopping_cart ON shopping_cart_products.shopping_cart_id = shopping_cart.id
INNER JOIN users ON shopping_cart.user_id = users.id
WHERE users.id = 1;

-- Muestra en pantalla la cantidad de productos del usario 1

SELECT
    COUNT(*)
FROM shopping_cart
INNER JOIN shopping_cart_products ON shopping_cart.id = shopping_cart_products.shopping_cart_id
WHERE shopping_cart.user_id = 1;

-- Mostrar en pantalla el total del carrito de compras del usuarios cuyo id es 2.

SELECT
    SUM(products.price)
FROM products
INNER JOIN shopping_cart_products ON products.id = shopping_cart_products.product_id
INNER JOIN shopping_cart ON shopping_cart_products.shopping_cart_id = shopping_cart.id
WHERE shopping_cart.user_id = 2;

-- Mostrar en pantalla el nombre de las categorías con por lo menos 4 productos
-- 1.- Obtiene la información - WHERE
-- 2.- Agrupar -> Se puede crear nuevas columnas -> HAVING
-- 3.- Order
-- 4.- LIMIT

SELECT
    categories.name,
    count(*) as total
FROM categories
INNER JOIN product_categories ON categories.id = product_categories.category_id
GROUP BY categories.name
HAVING total >= 4 ;
