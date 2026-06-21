-- Task 1: Show all suppliers and their purchase orders using LEFT JOIN.
select s.supplier_id, s.supplier_name, po.order_id 
from suppliers s
left join purchase_orders po
on s.supplier_id = po.supplier_id;

-- Task 2: Show only suppliers without any purchase orders.
select s.supplier_id, s.supplier_name, po.order_id 
from suppliers s
left join purchase_orders po
on s.supplier_id = po.supplier_id
where po.order_id is NULL;

-- Task 3: Count total purchase orders per supplier using LEFT JOIN.
select s.supplier_id, s.supplier_name, count(po.order_id) as order_count
from suppliers s
left join purchase_orders po
on s.supplier_id = po.supplier_id
group by s.supplier_id, s.supplier_name
order by count(order_id) desc; 

-- Task 4: Use COALESCE to show 0 instead of NULL for suppliers without orders.
select s.supplier_id, s.supplier_name, coalesce(count(po.order_id), 0) as order_count
from suppliers s
left join purchase_orders po
on s.supplier_id = po.supplier_id
group by s.supplier_id, s.supplier_name
order by order_count desc;

-- Task 5: Create supplier_activity_status: "Active" if supplier has orders, otherwise "Inactive".
select s.supplier_id, s.supplier_name,
   case 
	   when count(po.order_id) > 0 then 'Active'
       else 'Inactive'
   end as supplier_activity_status
from suppliers s
left join purchase_orders po
on s.supplier_id = po.supplier_id
group by s.supplier_id, s.supplier_name
order by supplier_activity_status, s.supplier_name;

-- Task 6: Write a short SQL comment explaining the difference between INNER JOIN and LEFT JOIN.
-- INNER JOIN returns only rows where there is a matching record in both tables.
-- LEFT JOIN returns all rows from the left table and matching rows from the right table.
-- If there is no matching record in the right table, the right table columns return NULL.

-- Task 7: Write a short SQL comment explaining why NULL is not the same as 0.
-- NULL means missing or unknown value, while 0 is an actual numeric value.
-- COUNT(column_name) ignores NULL values, but COUNT(*) counts all rows, including rows where some columns contain NULL.
-- SUM() and AVG() ignore NULL values, but they include 0 as a real value in calculations.