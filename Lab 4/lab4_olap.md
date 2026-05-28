## Запит 1 – Кількість товарів у кожній категорі

```sql
SELECT c.category_name,
       COUNT(p.product_id) AS product_count
FROM categories c
LEFT JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_name;
```

Даний запит використовується для підрахунку кількості товарів у кожній категорії.

---

## Запит 2 – Середня ціна товарів у кожній категорії

```sql
SELECT c.category_name,
       AVG(p.price) AS average_price
FROM categories c
JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_name;
```

Даний запит використовується для обчислення середньої ціни товарів у кожній категорії.

---

## Запит 3 – Загальна вартість товарів на складі по категоріях

```sql
SELECT c.category_name,
       SUM(p.price * p.stock_quantity) AS total_stock_value
FROM categories c
JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_name;
```

Даний запит використовується для обчислення загальної вартості товарів на складі для кожної категорії.

---

## Запит 4 – Мінімальна та максимальна ціна товарів у категоріях

```sql
SELECT c.category_name,
       MIN(p.price) AS min_price,
       MAX(p.price) AS max_price
FROM categories c
JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_name;
```

Даний запит використовується для визначення мінімальної та максимальної ціни товарів у кожній категорії.

---

## Запит 5 – Категорії, у яких більше одного товару

```sql
SELECT c.category_name,
       COUNT(p.product_id) AS product_count
FROM categories c
JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_name
HAVING COUNT(p.product_id) > 1;
```

Даний запит використовується для пошуку категорій, у яких знаходиться більше одного товару. У запиті використовується оператор `HAVING`, який фільтрує результати після групування.

---

## Запит 6 – Продажі по категоріях

```sql
SELECT c.category_name,
       SUM(oi.quantity * oi.price_at_purchase) AS category_sales
FROM categories c
JOIN products p ON c.category_id = p.category_id
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY c.category_name
ORDER BY category_sales DESC;
```

Даний запит використовується для обчислення загальної суми продажів для кожної категорії товарів.

---

## Запит 7 – Кількість проданих товарів по категоріях

```sql
SELECT c.category_name,
       SUM(oi.quantity) AS sold_quantity
FROM categories c
JOIN products p ON c.category_id = p.category_id
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY c.category_name
ORDER BY sold_quantity DESC;
```

Даний запит використовується для підрахунку кількості проданих товарів у кожній категорії.

---

## Запит 8 – Товари дорожчі за середню ціну

```sql
SELECT name,
       price
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);
```

Даний запит використовується для пошуку товарів, ціна яких перевищує середню ціну всіх товарів у базі даних. У запиті використовується підзапит.

---

## Запит 9 – Категорії із середньою ціною вище загальної середньої

```sql
SELECT c.category_name,
       AVG(p.price) AS average_price
FROM categories c
JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_name
HAVING AVG(p.price) > (
    SELECT AVG(price)
    FROM products
);
```

Даний запит використовується для пошуку категорій, у яких середня ціна товарів перевищує загальну середню ціну товарів у базі даних. У запиті використовується `GROUP BY`, `HAVING` та підзапит.

---

## Запит 10 – Категорія з найбільшою кількістю товарів

```sql
SELECT c.category_name,
       COUNT(p.product_id) AS product_count
FROM categories c
JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_name
ORDER BY product_count DESC
LIMIT 1;
```

Даний запит використовується для визначення категорії, яка містить найбільшу кількість товарів.

---

## Висновок

У ході виконання лабораторної роботи були реалізовані OLAP-запити для аналізу даних інтернет-магазину за допомогою PostgreSQL. Було використано агрегатні функції `COUNT`, `SUM`, `AVG`, `MIN` та `MAX`, а також оператори `GROUP BY`, `HAVING`, `JOIN` і підзапити.

У результаті виконання роботи були отримані навички аналізу даних, групування інформації та формування аналітичних звітів на основі бази даних інтернет-магазину.
