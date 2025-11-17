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

-- =============================================
-- TASK 3 — Employees Earning Above Department Average
-- =============================================

-- Step 1: Compute average salary per department
-- Step 2: Join employees + departments to those averages
-- Step 3: Filter to employees whose salary > their department's average

SELECT
    e.first_name,
    e.last_name,
    d.name AS department_name,
    e.salary AS employee_salary,
    ROUND(da.dept_avg_salary, 2) AS department_avg
FROM employees AS e
JOIN departments AS d
    ON e.department_id = d.id
JOIN (
    SELECT
        department_id,
        AVG(salary) AS dept_avg_salary
    FROM employees
    GROUP BY department_id
) AS da
    ON da.department_id = e.department_id
WHERE e.salary > da.dept_avg_salary
ORDER BY
    department_name,
    employee_salary DESC;


-- =============================================
-- TASK 4 — Cities with the Most Loyal Customers (Gold)
-- =============================================

SELECT
    city,
    COUNT(*) AS gold_customer_count
FROM customers
WHERE loyalty_level = 'Gold'
GROUP BY city
ORDER BY
    gold_customer_count DESC,
    city ASC;

-- =============================================
-- TASK 4 EXTENSION — Loyalty Distribution by City
-- =============================================

SELECT
    city,
    loyalty_level,
    COUNT(*) AS customer_count
FROM customers
GROUP BY
    city,
    loyalty_level
ORDER BY
    city ASC,
    loyalty_level ASC;