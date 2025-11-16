-- =============================================
-- Coding Challenge — SQLite Analytics
-- =============================================

-- =============================================
-- TASK 1 — Top 5 Customers by Total Spend
-- =============================================

SELECT
    c.first_name || ' ' || c.last_name AS customer_name,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_spend
FROM customers AS c
JOIN orders AS o
    ON o.customer_id = c.id
JOIN order_items AS oi
    ON oi.order_id = o.id
GROUP BY c.id
ORDER BY total_spend DESC
LIMIT 5;

-- =============================================
-- TASK 2 — Total Revenue by Product Category
-- =============================================

SELECT
    p.category,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_revenue
FROM products AS p
JOIN order_items AS oi
    ON oi.product_id = p.id
GROUP BY p.category
ORDER BY total_revenue DESC;




