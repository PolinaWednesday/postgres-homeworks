-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)

SELECT customers.company_name, concat(employees.first_name, ' ', employees.last_name) as employee
FROM orders
INNER JOIN customers USING(customer_id)
INNER JOIN employees USING(employee_id)
INNER JOIN shippers on orders.ship_via = shippers.shipper_id
WHERE shippers.company_name = 'United Package' and customers.city = 'London' and employees.city = 'London';

-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.

SELECT p.product_name, p.units_in_stock, s.contact_name, s.phone
FROM products AS p
JOIN suppliers AS s ON p.supplier_id = s.supplier_id
WHERE p.discontinued = 0
    AND p.units_in_stock < 25
    AND p.category_id IN (
        SELECT category_id
        FROM categories
        WHERE category_name IN ('Dairy Products', 'Condiments')
    )
ORDER BY p.units_in_stock ASC;


-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа

SELECT company_name
FROM customers
WHERE customer_id NOT IN (SELECT customer_id FROM orders);


-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.

SELECT DISTINCT p.product_name
FROM products p
WHERE EXISTS
(SELECT 1 FROM order_details o
WHERE p.product_id = o.product_id AND o.quantity = 10)