USE ecommerce_online;


CREATE TABLE mousepad_states (
	mousepad_states_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
	state VARCHAR(30) NOT NULL,
	abbr CHAR(2) NOT NULL,
	PRIMARY KEY (mousepad_states_id)
) ENGINE = InnoDB;

INSERT INTO mousepad_states(state, abbr) VALUES
	('Alabama', 'AL'),
	('Alaska', 'AK'),
	('Arizona', 'AZ'),
	('Arkansas', 'AR'),
	('California', 'CA'),
	('Colorado', 'CO'),
	('Connecticut', 'CT'),
	('Delaware', 'DE'),
	('District of Columbia', 'DC'),
	('Florida', 'FL'),
	('Georgia', 'GA'),
	('Hawaii', 'HI'),
	('Idaho', 'ID'),
	('Illinois', 'IL'),
	('Indiana', 'IN'),
	('Iowa', 'IA'),
	('Kansas', 'KS'),
	('Kentucky', 'KY'),
	('Louisiana', 'LA'),
	('Maine', 'ME'),
	('Maryland', 'MD'),
	('Massachusetts', 'MA'),
	('Michigan', 'MI'),
	('Minnesota', 'MN'),
	('Mississippi', 'MS'),
	('Missouri', 'MO'),
	('Montana', 'MT'),
	('Nebraska', 'NE'),
	('Nevada', 'NV'),
	('New Hampshire', 'NH'),
	('New Jersey', 'NJ'),
	('New Mexico', 'NM'),
	('New York', 'NY'),
	('North Carolina', 'NC'),
	('North Dakota', 'ND'),
	('Ohio', 'OH'),
	('Oklahoma', 'OK'),
	('Oregon', 'OR'),
	('Pennsylvania', 'PA'),
	('Rhode Island', 'RI'),
	('South Carolina', 'SC'),
	('South Dakota', 'SD'),
	('Tennessee', 'TN'),
	('Texas', 'TX'),
	('Utah', 'UT'),
	('Vermont', 'VT'),
	('Virginia', 'VA'),
	('Washington', 'WA'),
	('West Virginia', 'WV'),
	('Wisconsin', 'WI'),
	('Wyoming', 'WY');

CREATE TABLE mousepad_customers (
	mousepad_customers_id MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT, 
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	email VARCHAR(40) NOT NULL,
	phone VARCHAR(20) NOT NULL,
	password CHAR(255) NOT NULL,
	address_1 VARCHAR(100) NOT NULL,
	address_2 VARCHAR(100),
	city VARCHAR(50) NOT NULL,
	mousepad_states_id TINYINT UNSIGNED NOT NULL,
	zip CHAR(5) NOT NULL,
	date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(mousepad_customers_id),
	INDEX ind_mousepad_states_id (mousepad_states_id),
	CONSTRAINT fk_mousepad_states_id FOREIGN KEY (mousepad_states_id) REFERENCES mousepad_states(mousepad_states_id) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = InnoDB;

create table mousepad_transactions(
	mousepad_transactions_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	amount_charged DECIMAL(6, 3) NOT NULL, 
	type VARCHAR(100) NOT NULL, 
	response_code VARCHAR(200) NOT NULL, 
	response_reason VARCHAR(200) NOT NULL, 
	response_text VARCHAR(400) NOT NULL, 
	date_created TIMESTAMP NOT NULL, 
	PRIMARY KEY(mousepad_transactions_id)
) ENGINE = InnoDB;

create table mousepad_shipping_addresses(
	mousepad_shipping_addresses_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	address_1 VARCHAR(100) NOT NULL, 
	address_2 VARCHAR(100), 
	city VARCHAR(50) NOT NULL, 
	mousepad_states_id TINYINT UNSIGNED NOT NULL, 
	zip CHAR(5) NOT NULL, 
	date_created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(mousepad_shipping_addresses_id)
) ENGINE = InnoDB;

create table mousepad_billing_addresses(
	mousepad_billing_addresses_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	address_1 VARCHAR(100) NOT NULL, 
	address_2 VARCHAR(100), 
	city VARCHAR(50) NOT NULL, 
	mousepad_states_id TINYINT UNSIGNED NOT NULL, 
	zip CHAR(5) NOT NULL, 
	date_created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(mousepad_billing_addresses_id)
) ENGINE = InnoDB;

create table mousepad_carriers_methods(
	mousepad_carriers_methods_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
	carrier VARCHAR(50) NOT NULL, 
	method VARCHAR(50) NOT NULL, 
	fee DECIMAL(6, 3) NOT NULL, 
	PRIMARY KEY(mousepad_carriers_methods_id)
) ENGINE = InnoDB;

INSERT INTO mousepad_carriers_methods (carrier, method, fee) VALUES 
('UPS', 'Ground', '4.99'),
('UPS', 'Express', '9.99'),
('USPS', 'Standard', '3.99'),
('USPS', 'Expedited', '6.99'),
('FEDEX', 'Same Day', '49.99'),
('FEDEX', 'One Day', '29.99'),
('FEDEX', 'Three Days', '9.99');

create table mousepad_orders(
	mousepad_orders_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	mousepad_customers_id MEDIUMINT UNSIGNED NOT NULL,
	mousepad_transactions_id INT UNSIGNED NOT NULL,
	mousepad_shipping_addresses_id INT UNSIGNED NOT NULL,
	mousepad_carriers_methods_id TINYINT UNSIGNED NOT NULL,
	mousepad_billing_addresses_id INT UNSIGNED NOT NULL,
	credit_no CHAR(4) NOT NULL, 
	credit_type VARCHAR(20) NOT NULL, 
	order_total DECIMAL(7, 3) NOT NULL, 
	shipping_fee DECIMAL(6, 3) NOT NULL, 
	order_date TIMESTAMP NOT NULL, 
	shipping_date TIMESTAMP NOT NULL, 
	PRIMARY KEY(mousepad_orders_id),
	INDEX ind_mousepad_customers_id (mousepad_customers_id),
	CONSTRAINT fk_mousepad_customers_id FOREIGN KEY (mousepad_customers_id) REFERENCES mousepad_customers(mousepad_customers_id)
	ON DELETE CASCADE on UPDATE CASCADE,
	INDEX ind_mousepad_transactions_id (mousepad_transactions_id),
	CONSTRAINT fk_mousepad_transactions_id FOREIGN KEY (mousepad_transactions_id) REFERENCES mousepad_transactions(mousepad_transactions_id)
	ON DELETE CASCADE on UPDATE CASCADE,
	INDEX ind_mousepad_shipping_addresses_id (mousepad_shipping_addresses_id),
	CONSTRAINT fk_mousepad_shipping_addresses_id FOREIGN KEY (mousepad_shipping_addresses_id) REFERENCES mousepad_shipping_addresses(mousepad_shipping_addresses_id)
	ON DELETE CASCADE on UPDATE CASCADE,
	INDEX ind_mousepad_carriers_methods_id (mousepad_carriers_methods_id),
	CONSTRAINT fk_mousepad_carriers_methods_id FOREIGN KEY (mousepad_carriers_methods_id) REFERENCES mousepad_carriers_methods(mousepad_carriers_methods_id)
	ON DELETE CASCADE on UPDATE CASCADE,
	INDEX ind_mousepad_billing_addresses_id (mousepad_billing_addresses_id),
	CONSTRAINT fk_mousepad_billing_addresses_id FOREIGN KEY (mousepad_billing_addresses_id) REFERENCES mousepad_billing_addresses(mousepad_billing_addresses_id)
	ON DELETE CASCADE on UPDATE CASCADE
) ENGINE = InnoDB;

create table mousepad_categories(
	mousepad_categories_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	category VARCHAR(100) NOT NULL,
	description VARCHAR(1000),
	PRIMARY KEY(mousepad_categories_id)
) ENGINE = InnoDB;

create table mousepad_sizes(
	mousepad_sizes_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
	size VARCHAR(20) NOT NULL,
	PRIMARY KEY(mousepad_sizes_id)
) ENGINE = InnoDB;

INSERT INTO mousepad_sizes (size) VALUES
	('regular'),
	('extended');
	
create table mousepad_colors(
	mousepad_colors_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
	keyword VARCHAR(20) NOT NULL,
	code VARCHAR(20) NOT NULL,
	PRIMARY KEY(mousepad_colors_id)
) ENGINE = InnoDB;

INSERT INTO mousepad_colors (keyword, code) VALUES
	('black', '#000000'),
	('white', '#ffffff'),
	('blue', '#0000FF'),
	('dark blue', '#0000A0'),
	('light blue', '#ADD8E6'),
	('red', '#FF0000'),
	('cyan', '#00FFFF'),
	('purple', '#800080'),
	('yellow', '#FFFF00'),
	('lime', '#00FF00'),
	('magenta', '#FF00FF'),
	('silver', '#C0C0C0'),
	('gray', '#808080'),
	('orange', '#FFA500'),
	('brown', '#A52A2A'),
	('maroon', '#800000'),
	('green', '#008000'),
	('olive', '#808000');

create table mousepads(
	mousepads_id MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
	mousepad_categories_id SMALLINT UNSIGNED NOT NULL,
	mousepad_sizes_id TINYINT UNSIGNED NOT NULL,
	mousepad_colors_id TINYINT UNSIGNED NOT NULL,
	price DECIMAL(6,3) NOT NULL,
	photo VARCHAR(100),
	stock_quantity MEDIUMINT UNSIGNED NOT NULL,
	date_added TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(mousepads_id),
	INDEX ind_mousepad_categories_id (mousepad_categories_id),
	CONSTRAINT fk_mousepad_categories_id FOREIGN KEY (mousepad_categories_id) REFERENCES mousepad_categories(mousepad_categories_id)
	ON DELETE CASCADE on UPDATE CASCADE,
	INDEX fk_mousepad_sizes_id (mousepad_sizes_id),
	CONSTRAINT fk_mousepad_sizes_id FOREIGN KEY (mousepad_sizes_id) REFERENCES mousepad_sizes(mousepad_sizes_id)
	ON DELETE CASCADE on UPDATE CASCADE,
	INDEX ind_mousepad_colors_id (mousepad_colors_id),
	CONSTRAINT fk_mousepad_colors_id FOREIGN KEY (mousepad_colors_id) REFERENCES mousepad_colors(mousepad_colors_id)
	ON DELETE CASCADE on UPDATE CASCADE
) ENGINE = InnoDB;

create table mousepad_orders_mousepads(
	mousepad_orders_mousepads_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
	mousepad_orders_id INT UNSIGNED NOT NULL,
	mousepads_id MEDIUMINT UNSIGNED NOT NULL,
	quantity TINYINT UNSIGNED NOT NULL,
	price DECIMAL(7,3) NOT NULL,
	PRIMARY KEY(mousepad_orders_mousepads_id),
	INDEX ind_mousepad_orders_id (mousepad_orders_id),
	CONSTRAINT fk_mousepad_orders_id FOREIGN KEY (mousepad_orders_id) REFERENCES mousepad_orders(mousepad_orders_id)
	ON DELETE CASCADE on UPDATE CASCADE,
	INDEX ind_mousepads_id (mousepads_id),
	CONSTRAINT fk_mousepads_id FOREIGN KEY (mousepads_id) REFERENCES mousepads(mousepads_id)
	ON DELETE CASCADE on UPDATE CASCADE
) ENGINE = InnoDB;


create table mousepad_carts(
	mousepad_carts_id MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
	mousepad_customers_id MEDIUMINT UNSIGNED NOT NULL, 
	mousepads_id MEDIUMINT UNSIGNED NOT NULL, 
	quantity TINYINT UNSIGNED NOT NULL, 
	date_added TIMESTAMP NOT NULL, 
	date_modified TIMESTAMP NOT NULL, 
	PRIMARY KEY(mousepad_carts_id),
	INDEX ind_mousepad_customers_id (mousepad_customers_id),
	CONSTRAINT fk_carts_mousepad_customers_id FOREIGN KEY (mousepad_customers_id) REFERENCES mousepad_customers(mousepad_customers_id)
	ON DELETE CASCADE on UPDATE CASCADE,
	INDEX ind_mousepads_id (mousepads_id),
	CONSTRAINT fk_carts_mousepads_id FOREIGN KEY (mousepads_id) REFERENCES mousepads(mousepads_id)
	ON DELETE CASCADE on UPDATE CASCADE
) ENGINE = InnoDB;

ALTER TABLE mousepad_customers MODIFY COLUMN address_2 varchar(100);
ALTER TABLE mousepad_shipping_addresses MODIFY COLUMN address_2 varchar(100);
ALTER TABLE mousepad_billing_addresses MODIFY COLUMN address_2 varchar(100);


INSERT INTO mousepad_customers (first_name, last_name, email, phone, password, address_1, address_2, city, mousepad_states_id, zip, date_created) VALUES
	('David', 'Steel', 'dsteel@ysu.edu', '330-333-4444', 'mypassword', 'One University Plaza', 'Youngstown State University - Meshel Hall #123', 'Youngstown', 36, '44555', current_timestamp),
	('Mark', 'Jordan', 'mjordan@gmail.com', '330-444-5555', 'mypassword', '123 Main Street', '', 'Youngstown', 36, '44555', current_timestamp),
	('Mary', 'Alan', 'malan@yahoo.com', '330-555-6666', 'mypassword', '5068 South Avenue', '', 'Boardman', 36, '44512', current_timestamp);

INSERT INTO mousepad_transactions (amount_charged, type, response_code, response_reason, response_text, date_created) VALUES
	(48.98, 'regular', '100', '', 'OK', current_timestamp),
	(22.98, 'regular', '100', '', 'OK', current_timestamp);

INSERT INTO mousepad_shipping_addresses (address_1, address_2, city, mousepad_states_id, zip, date_created) VALUES 
	('One University Plaza', 'Youngstown State University - Meshel Hall #123', 'Youngstown', 36, '44555', current_timestamp);

INSERT INTO mousepad_billing_addresses (address_1, address_2, city, mousepad_states_id, zip, date_created) VALUES
	('100 Lockwood Avenue', '', 'Canfield', 36, '44406', current_timestamp);	

INSERT INTO mousepad_orders (mousepad_customers_id, mousepad_transactions_id, mousepad_shipping_addresses_id, mousepad_billing_addresses_id, mousepad_carriers_methods_id, credit_no, credit_type, order_total, 
	shipping_fee, shipping_date, order_date) VALUES
	(1, 1, 1, 1, 3, '4345', 'Visa', 43.99, 4.99, current_timestamp, current_timestamp),
	(1, 2, 1, 1, 4, '4345', 'Visa', 19.99, 2.99, current_timestamp, current_timestamp);
	
select * from mousepad_customers;
select * from mousepad_transactions;
select * from mousepad_shipping_addresses;
select * from mousepad_billing_addresses;
select * from mousepad_orders;

	SELECT first_name, last_name, credit_no, credit_type FROM mousepad_customers, mousepad_orders 
	WHERE mousepad_customers.mousepad_customers_id = mousepad_orders.mousepad_customers_id;

SELECT first_name, last_name, credit_no, credit_type FROM mousepad_customers 
	INNER JOIN mousepad_orders ON mousepad_customers.mousepad_customers_id = mousepad_orders.mousepad_customers_id;

SELECT first_name, last_name, credit_no, credit_type FROM mousepad_customers 
	INNER JOIN mousepad_orders USING (mousepad_customers_id);
	
SELECT first_name, last_name, credit_no, credit_type, CONCAT_WS(' ', mousepad_shipping_addresses.address_1, mousepad_shipping_addresses.address_2, mousepad_shipping_addresses.city, state, mousepad_shipping_addresses.zip) as 'Shipping Address' FROM mousepad_customers 
	INNER JOIN mousepad_orders USING (mousepad_customers_id)
	INNER JOIN mousepad_shipping_addresses USING (mousepad_shipping_addresses_id)
	INNER JOIN mousepad_states ON mousepad_shipping_addresses.mousepad_states_id = mousepad_states.mousepad_states_id;

SELECT first_name, last_name, credit_no, credit_type, CONCAT_WS(' ', mousepad_shipping_addresses.address_1, mousepad_shipping_addresses.address_2, mousepad_shipping_addresses.city, state, mousepad_shipping_addresses.zip) as 'Shipping Address' FROM mousepad_customers 
	LEFT JOIN mousepad_orders USING (mousepad_customers_id)
	LEFT JOIN mousepad_shipping_addresses USING (mousepad_shipping_addresses_id)
	LEFT JOIN mousepad_states ON mousepad_shipping_addresses.mousepad_states_id = mousepad_states.mousepad_states_id 
	WHERE mousepad_shipping_addresses.city = 'Youngstown'
	ORDER BY last_name ASC;
	
SELECT first_name, last_name, credit_no, credit_type, CONCAT_WS(' ', mousepad_shipping_addresses.address_1, mousepad_shipping_addresses.address_2, mousepad_shipping_addresses.city, state, mousepad_shipping_addresses.zip) as 'Shipping Address' FROM mousepad_states 
	RIGHT JOIN mousepad_shipping_addresses ON mousepad_shipping_addresses.mousepad_states_id = mousepad_states.mousepad_states_id 
	RIGHT JOIN mousepad_orders USING (mousepad_shipping_addresses_id)
	RIGHT JOIN mousepad_customers USING (mousepad_customers_id);
	
INSERT INTO mousepad_categories (category, description) 
	VALUES
	('Regular', 'A regular sized 250x510x2mm mousepad good for everyday use in surfing the web, working, or gaming.'),
	('Extended', 'A larger sized 900x400x4mm mousepad that covers more of your desk and gives traction to your keyboard too. Good for surfing the web, working, or gaming.');

SELECT * from mousepad_categories;

INSERT INTO mousepads (mousepad_categories_id, photo, stock_quantity, price, date_added, mousepad_sizes_id, mousepad_colors_id)
	VALUES
	(1, './images/black_regular.jpg', 38, 29.99, current_timestamp(), 1, 1),
	(2, './images/black_extended.jpg', 127, 9.99,current_timestamp(), 2, 1);

SELECT * FROM mousepads;	

INSERT INTO mousepad_orders_mousepads (mousepad_orders_id, mousepads, quantity, price)
	VALUES
	(3, 1, 1, 19.99),
	(3, 2, 1, 34.99);

/*View user account info*/
SELECT first_name, last_name, email, phone, CONCAT_WS(' ',address_1, adddress_2, city, abbr, zip) ass address, date_created
	from mousepad_customers
	INNER JOIN mousepad_states USING(mousepad_states_id);

/*View Available mousepads including
category, size, color, price, photo*/

SELECT category, description, size, keyword, code, price, stock_quantity, date_added, photo
	FROM mousepads
	INNER JOIN mousepad_categories USING (mousepad_categories_id)
	INNER JOIN mousepad_sizes USING (mousepad_sizes_id)
	INNER JOIN mousepad_colors USING (mousepad_colors_id)
	ORDER BY $order_by $asc_desc;

/*
View previous orders including
category, size, color, price, photo, shipping address, billing address, credit_card, shipping_date, order_date, order_total, shipping_cost
*/

SELECT mousepad_orders_mousepads.mousepad_orders_id, CONCAT_WS(' ',mousepad_shipping_addresses.address_1, mousepad_shipping_addresses.address_2, mousepad_shipping_addresses.city, state, mousepad_shipping_addresses.zip) as 'Shipping Address', CONCAT_WS(' ',mousepad_billing_addresses.address_1, mousepad_billing_addresses.address_2, mousepad_billing_addresses.city, state, mousepad_billing_addresses.zip) as 'Billing Address', GROUP_CONCAT(category SEPARATOR '<br><hr>') as category, GROUP_CONCAT(size SEPARATOR '<br><hr>') as size, GROUP_CONCAT(keyword SEPARATOR '<br><hr>') as keyword, GROUP_CONCAT(mousepad_orders_mousepads.quantity SEPARATOR '<br><hr>') as quantity, GROUP_CONCAT(mousepad_orders_mousepads.price SEPARATOR '<br><hr>') as price, credit_no, credit_type, order_total, shipping_fee, order_date, shipping_date
	FROM mousepad_customers
	INNER JOIN mousepad_states USING (mousepad_states_id)
	INNER JOIN mousepad_orders USING (mousepad_customers_id)
	INNER JOIN mousepad_shipping_addresses USING (mousepad_shipping_addresses_id)
	INNER JOIN mousepad_billing_addresses USING (mousepad_billing_addresses_id)
	INNER JOIN mousepad_orders_mousepads USING (mousepad_orders_id)
	INNER JOIN mousepads USING (mousepads_id)
	INNER JOIN mousepad_categories USING (mousepad_categories_id)
	INNER JOIN mousepad_sizes USING (mousepad_sizes_id)
	INNER JOIN mousepad_colors USING (mousepad_colors_id)
	WHERE mousepad_customers_id = 1
	GROUP BY mousepad_orders_mousepads.mousepad_orders_id
	ORDER BY $order_by $asc_desc;

/* Update mousepad_colors table */

UPDATE mousepad_colors set code = '#800080' WHERE mousepad_colors_id = 8;
UPDATE mousepad_colors set code = '#FFFF00' WHERE mousepad_colors_id = 9; 
UPDATE mousepad_colors set code = '#00FF00' WHERE mousepad_colors_id = 10;
UPDATE mousepad_colors set code = '#FF00FF' WHERE mousepad_colors_id = 11;
UPDATE mousepad_colors set code = '#C0C0C0' WHERE mousepad_colors_id = 12;
UPDATE mousepad_colors set code = '#808080' WHERE mousepad_colors_id = 13;
UPDATE mousepad_colors set code = '#FFA500' WHERE mousepad_colors_id = 14;
UPDATE mousepad_colors set code = '#A52A2A' WHERE mousepad_colors_id = 15;
UPDATE mousepad_colors set code = '#800000' WHERE mousepad_colors_id = 16;
UPDATE mousepad_colors set code = '#008000' WHERE mousepad_colors_id = 17;
UPDATE mousepad_colors set code = '#808000' WHERE mousepad_colors_id = 18;

ALTER table mousepad_carriers_methods add column fee decimal(6, 3) not null; 
UPDATE mousepad_carriers_methods set fee = '4.99' WHERE mousepad_carriers_methods_id = 1;
UPDATE mousepad_carriers_methods set fee = '9.99' WHERE mousepad_carriers_methods_id = 2;
UPDATE mousepad_carriers_methods set fee = '3.99' WHERE mousepad_carriers_methods_id = 3;
UPDATE mousepad_carriers_methods set fee = '6.99' WHERE mousepad_carriers_methods_id = 4;
UPDATE mousepad_carriers_methods set fee = '49.99' WHERE mousepad_carriers_methods_id = 5;
UPDATE mousepad_carriers_methods set fee = '29.99' WHERE mousepad_carriers_methods_id = 6;
UPDATE mousepad_carriers_methods set fee = '9.99' WHERE mousepad_carriers_methods_id = 7;
 
/*
 = equal to 
 != not equal to
 < less than
 > greater than
 <= less than or equal to
 >= greater than or equal to
 IS NULL
 IS NOT NULL 
 BETWEEN
 NOT BETWEEN
 IN
 
 Logical operators
 AND / &&
 OR / ||
 
 LIKE NOT LIKE -> _ and % 
 _ one single character of anything
 % 0 or more of any character
 select first_name, last_name from mousepad_customers where first_name LIKE 'A___' ORDER BY last_name asc;
 select first_name, last_name from mousepad_customers where first_name LIKE 'A%' order by first_name asc, last_name DESC;
 select state, abbr from mousepad_states order by state asc limit 5;
 UPDATE mousepad_customers SET first_name = 'David' WHERE mousepad_customers_id = 1;
 DELETE from mousepad_customers WHERE mousepad_customers_id = 1 LIMIT 1; 
 */