joins
1.
SELECT *
FROM invoice i
JOIN invoice_line il ON il.invoice_id = i.invoice_id
WHERE il.unit_price > 0.99;

2.
SELECT i.invoice_date, c.first_name, c.last_name, i.total
FROM invoice i
JOIN customer c ON i.customer_id = c.customer_id

3.
SELECT c.first_name, c.last_name, e.first_name, e.last_name
FROM customer c
JOIN employee e ON c.support_rep_id = e.employee_id;

4.
SELECT al.title, ar.name
FROM artist ar
JOIN album al ON al.artist_id = ar.artist_id

5.
SELECT plt.track_id
FROM playlist_track plt
JOIN playlist pl ON plt.playlist_id = pl.playlist_id 
WHERE pl.name = 'Music'

6.
SELECT t.name
FROM track t
JOIN playlist_track plt ON plt.track_id = t.track_id
WHERE plt.playlist_id = 5

7.
SELECT t.name, pl.name
FROM track t
JOIN playlist_track plt ON t.track_id = plt.track_id
JOIN playlist pl ON plt.playlist_id = pl.playlist_id

8.
SELECT t.name, a.title
FROM track t
JOIN album a ON t.album_id = a.album_id
JOIN genre g ON g.genre_id = t.genre_id 
WHERE g.name = 'Alternative & Punk'

nested queries
1.
SELECT *
FROM invoice
WHERE invoice_id IN (SELECT invoice_id FROM invoice_line WHERE unit_price > .99);

2.
SELECT *
FROM playlist_track
WHERE playlist_id IN (SELECT playlist_id FROM playlist WHERE name = 'Music')

3.
SELECT name
FROM track
WHERE track_id IN (SELECT track_id FROM playlist_track WHERE playlist_id = 5)

4.
SELECT *
FROM track
WHERE genre_id IN (SELECT genre_id FROM genre WHERE name = 'Comedy')

5.
SELECT *
FROM track
WHERE album_id IN (SELECT album_id FROM album WHERE title = 'Fireball')

6.
SELECT *
FROM track
WHERE album_id IN (
    SELECT album_id FROM album WHERE artist_id IN (
        SELECT artist_id FROM artist WHERE name='Queen'
    ))

updating rows
1.
UPDATE customer
SET fax = NULL
WHERE fax IS NOT NULL;

2.
UPDATE customer
SET company = 'Self'
WHERE company IS NULL;

3.
UPDATE customer
SET last_name = 'Thompson'
WHERE (first_name = 'Julia' AND last_name = 'Barnett')

4.
UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl'

5.
UPDATE track
SET composer = 'The darkness around us'
WHERE genre_id = (SELECT genre_id FROM genre WHERE name = 'Metal')
AND composer IS NULL

group by
1.
SELECT COUNT(*), g.name
FROM track t
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name;

2.
SELECT COUNT(*), g.name
FROM track t
JOIN genre g ON t.genre_id = g.genre_id
WHERE g.name = 'Pop' OR g.name = 'Rock'
GROUP BY g.name

3.
SELECT COUNT(*), ar.name
FROM album al
JOIN artist ar ON al.artist_id = ar.artist_id
GROUP BY ar.name

use distinct
1.
SELECT DISTINCT composer
FROM track

2.
SELECT DISTINCT billing_postal_code
FROM invoice

3.
SELECT DISTINCT company
FROM customer

delete rows
1.
DELETE FROM practice_delete WHERE type = 'bronze'

2.
DELETE FROM practice_delete WHERE type = 'silver'

3.
DELETE FROM practice_delete WHERE value = 150;

eCommerce simulation
1.
CREATE TABLE users(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL, 
    email VARCHAR(255)
)

CREATE TABLE products(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL, 
    price NUMERIC NOT NULL
)

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    product_id INT,
    FOREIGN KEY (product_id) REFERENCES products (id)
)

INSERT INTO products (name, price)
VALUES ('George Foreman Grill', 40)
INSERT INTO products (name, price)
VALUES ('Green Socks', 15)
INSERT INTO products (name, price)
VALUES ('Ice Tray', 1)
INSERT INTO users (name, email)
VALUES ('Bobby', 'bobby12@gmail.com')
INSERT INTO users (name, email)
VALUES ('Larry', 'larrybones@outlook.com')
INSERT INTO users (name, email)
VALUES ('Karen', 'letmespeaktoyourmanager77@yahoo.com')
INSERT INTO orders (product_id)
VALUES (1)
INSERT INTO orders (product_id)
VALUES (2)
INSERT INTO orders (product_id)
VALUES (3)

SELECT *
FROM products p
JOIN orders o ON o.product_id = p.id
WHERE o.id = 1

SELECT *
FROM products p
JOIN orders o ON o.product_id = p.id

SELECT sum(price)
FROM products p
JOIN orders o ON o.product_id = p.id

ALTER TABLE oders ADD COLUMN order_id INT
ALTER TABLE users ADD FOREIGN KEY (order_id) REFERENCES orders (id)

SELECT *
FROM products p
JOIN orders o ON p.id = o.user_id

ALTER TABLE users
ADD COLUMN order_id INTEGER REFERENCES orders(id);

UPDATE users 
SET order_id = id;

ALTER TABLE users
ADD COLUMN order_id INTEGER REFERENCES orders(id);

SELECT * FROM users
WHERE order_id = 1

SELECT COUNT(*) FROM users
WHERE order_id = 1