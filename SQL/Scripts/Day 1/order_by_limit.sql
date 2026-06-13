-- Task 1: Select all purchase orders and sort them by order value from highest to lowest.
select *, po.unit_price * po.quantity as order_value from purchase_orders po 
order by order_value desc;

-- Task 2: Select all purchase orders and sort them by order value from lowest to highest.
select *, po.unit_price * po.quantity as order_value from purchase_orders po 
order by order_value asc;

-- Task 3: Show the top 5 highest-value purchase orders.
select *, po.unit_price * po.quantity as order_value from purchase_orders po 
order by order_value desc
limit 5;

-- Task 4: Show the top 3 suppliers with the longest lead time
select * from suppliers s
order by expected_lead_time_days desc
limit 3;

-- Task 5: Show the 5 most recent purchase orders.
select * from purchase_orders po
order by order_date desc
limit 5;

-- Task 6: Show the 5 oldest purchase orders.
select * from purchase_orders po 
order by order_date 
limit 5;

-- Task 7: Sort suppliers by country and then by supplier name.
select * from suppliers s 
order by country, supplier_name;

-- Task 8: Sort purchase orders by category and then by order value.
select *, po.unit_price * po.quantity as order_value from purchase_orders po 
order by po.category, order_value;

-- Task 9: Write a short comment explaining how sorting helps identify business priorities.
-- Sorting helps identify business priorities by putting the most important records first.
-- For example, sorting purchase orders by value helps quickly find the highest spend areas.
-- Sorting by lead time helps identify suppliers that may create delivery risk.
-- Without sorting, the data is harder to interpret and business insights are slower to find.