-- Task 1: Select all purchase orders where the order value is greater than 1000 PLN.
select * from purchase_orders po 
where (po.quantity * po.unit_price) > 1000;

-- Task 2: Select all purchase orders where the category is "Components".
select * from purchase_orders po 
where po.category = 'Components';

-- Task 3: Select all suppliers from Poland.
select s.supplier_name  from suppliers s 
where s.country = 'Poland';

-- Task 4: Select all suppliers where lead time is greater than 14 days.
select distinct s.supplier_name from suppliers s 
join purchase_orders po 
on po.supplier_id = s.supplier_id
where po.actual_lead_time_days > 14;

-- Task 5: Select all purchase orders with status "Delivered".
select * from purchase_orders po 
where po.status = 'Delivered';

-- Task 6: Select all purchase orders that were delivered late.
select * from purchase_orders po 
where po.actual_lead_time_days > po.expected_lead_time_days;

-- Task 7: Select all purchase orders from one selected supplier.
select po.order_id,
       s.supplier_name,
       po.category,
       po.quantity,
       po.unit_price,
       po.quantity * po.unit_price AS order_value,
       po.currency,
       po.status
from purchase_orders po 
join suppliers s 
on po.supplier_id = s.supplier_id
where s.supplier_name like 'Pol-Metal%';

-- Task 8: Select all purchase orders where the order value is between 500 and 5000 PLN.
select * from purchase_orders po 
where (po.quantity * po.unit_price) between 500 and 5000;

-- Task 9: Select all suppliers from either Poland or Germany.
select * from suppliers s 
where s.country in ('Germany', 'Poland');

-- Task 10: Write a short comment explaining why filtering data is critical in procurement analysis.
-- Filtering is critical in procurement analysis because raw datasets often contain thousands of purchase orders,
-- suppliers, categories, and delivery records.
-- By filtering the data, an analyst can focus only on the records needed to answer a specific business question,
-- such as identifying high-value orders, late deliveries, risky suppliers, or spend in a selected category.
-- Without filtering, the analysis becomes noisy, unfocused, and less useful for decision-making.

