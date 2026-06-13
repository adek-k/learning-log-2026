-- Task 1: Select all columns from the suppliers table.
select * from suppliers;

-- Task 2: Select only supplier_name, country, and category from the suppliers table.
select supplier_name, country, category from suppliers;

-- Task 3: Select all columns from the purchase_orders table.
select * from purchase_orders;

-- Task 4: Select only order_id, supplier_name, category, and order_value from purchase_orders.
select order_id, supplier_id, category, unit_price * quantity as order_value from purchase_orders;

-- Task 5: Rename selected columns using aliases so the output looks like a business report.
select order_id as order_number, supplier_id as supplier, category, unit_price * quantity as order_value from purchase_orders;

-- Task 6: Select unique supplier countries from the suppliers table.
select distinct country as all_countries from suppliers;

-- Task 7: Select unique procurement categories from the purchase_orders table.
select distinct category as all_categories from purchase_orders;

-- Task 8: Write a short comment explaining what information a procurement manager could get from this query.
-- A procurement manager can use these queries to understand supplier coverage, purchase order values,
-- procurement categories, and basic spending patterns.This information helps identify which suppliers, categories, or orders may require further analysis.