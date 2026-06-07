-- Task 1: Select quantity, unit_price, and calculate total order value.
select quantity, unit_price, quantity * unit_price as order_value from purchase_orders po;

-- Task 2: Calculate the difference between original price and negotiated price.
select po.original_unit_price, 
	po.negotiated_unit_price, 
	po.original_unit_price - po.negotiated_unit_price as saving_per_unit
from purchase_orders po;

-- Task 3: Calculate savings percentage based on original price and negotiated price.
select po.order_id, 
	po.original_unit_price, 
	po.negotiated_unit_price, 
	round((po.original_unit_price - po.negotiated_unit_price) / nullif(po.original_unit_price, 0)* 100.0, 2) as percentage_saving
from purchase_orders po;

-- Task 4: Calculate gross value using net value and VAT rate.
-- Assumption: VAT rate is fixed at 23% for this exercise.
select po.unit_price,
	   po.quantity,
	   po.unit_price * po.quantity as order_value_net,
	   (po.unit_price * po.quantity) * 0.23 as order_value_vat,
	   (po.unit_price * po.quantity) * 1.23 as order_value_gross
from purchase_orders po;

-- Task 5: Calculate delivery delay by subtracting expected lead time from actual lead time.
select po.expected_lead_time_days,
po.actual_lead_time_days,
po.actual_lead_time_days - po.expected_lead_time_days as lead_time_delay
from purchase_orders po;

-- Task 6: Create a calculated column that classifies delivery as "On Time" or "Late".
select po.expected_lead_time_days,
po.actual_lead_time_days,
case 
	when po.actual_lead_time_days - po.expected_lead_time_days > 0 then 'Late'
	else 'On-Time' 
end as delivery_status
from purchase_orders po;

-- Task 7: Create a calculated column that classifies order value as "Small", "Medium", or "Large".
select po.unit_price,
	po.quantity,
	po.unit_price * po.quantity as order_value,
case 
	when po.unit_price * po.quantity < 4000 then 'Small'
	when po.unit_price * po.quantity < 8000 then 'Medium'
	else 'Large' 
end as order_size
from purchase_orders po
order by order_value desc;


-- Task 8: Create a calculated column that shows whether a supplier should be reviewed based on long lead time.
select s.supplier_name,
s.expected_lead_time_days,
AVG(po.actual_lead_time_days) as average_lead_time,
case
	when avg(po.actual_lead_time_days) > s.expected_lead_time_days then 'For Review'
	else 'Within SLA'
end as SLA_action
from purchase_orders po 
join suppliers s 
on po.supplier_id = s.supplier_id
group by s.supplier_id, s.supplier_name, s.expected_lead_time_days;

-- Task 9: Write a short comment explaining why calculated columns are useful in business analysis.
-- Calculated columns are useful because they turn raw operational data into business insights.
-- They help analysts calculate order value, savings, delivery delay, VAT, and risk indicators directly in the query.
