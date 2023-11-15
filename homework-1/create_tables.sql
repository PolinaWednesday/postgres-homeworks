CREATE TABLE employees (

   employee_id int PRIMARY KEY,
   first_name text,
   last_name text,
   title varchar(100) NOT NULL,
   birth_date date NOT NULL,
   notes varchar(1000) NOT NULL
);

SELECT * FROM employees;

CREATE TABLE customers (

    customer_id text UNIQUE,
	company_name text,
	contact_name text

);

SELECT * FROM customers;

CREATE TABLE orders (

    order_id int PRIMARY KEY,
	customer_id text REFERENCES customers(customer_id),
	employee_id int REFERENCES employees(employee_id),
	order_date date NOT NULL,
	ship_city text

);

SELECT * FROM orders;
