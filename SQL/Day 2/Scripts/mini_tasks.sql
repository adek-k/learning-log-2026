-- Mini Task 1: Show all purchase orders with supplier name, category, order value, and delivery status.
select s.supplier_name, 
po.category, 
po.unit_price * po.quantity as order_value_net,
po.status 
from purchase_orders po 
join suppliers s 
on s.supplier_id = po.supplier_id;

-- Mini Task 2: Show only high-value purchase orders above 5000 PLN.
select s.supplier_name, 
po.category, 
po.unit_price * po.quantity as order_value_net,
po.status 
from purchase_orders po 
join suppliers s 
on s.supplier_id = po.supplier_id 
where po.unit_price * po.quantity > 5000;

-- Mini Task 3: Show suppliers with lead time above 14 days.
select s.supplier_name, 
s.expected_lead_time_days 
from suppliers s 
where s.expected_lead_time_days > 14;

-- Mini Task 4: Show purchase orders that were delivered late.
select po.order_id, 
po.order_date, 
po.expected_lead_time_days, 
po.actual_lead_time_days,
case
	when po.expected_lead_time_days < po.actual_lead_time_days  then 'Late Delivery'
	else 'On Time'
end as delivery_status
from purchase_orders po
where po.expected_lead_time_days < po.actual_lead_time_days;

-- Mini Task 5: Show the top 5 purchase orders by value. 
select po.order_id,
po.category,
po.unit_price,
po.quantity, 
po.unit_price * po.quantity as order_value
from purchase_orders po
order by order_value desc
limit 5;

-- Mini Task 6: Show all purchase orders from one selected category.
select po.order_id,
po.category,
po.unit_price,
po.quantity, 
po.unit_price * po.quantity as order_value
from purchase_orders po
where po.category = 'Automation'
order by order_value desc;

-- Mini Task 7: Calculate negotiated savings for each purchase order.
select po.order_id, 
po.category, 
po.original_unit_price, 
po.negotiated_unit_price,
po.quantity,
po.original_unit_price * po.quantity as order_value_pre_negotiation,
po.negotiated_unit_price * po.quantity as order_value_post_negotiation,
po.original_unit_price * po.quantity - po.negotiated_unit_price * po.quantity as monetary_saving,
round((po.original_unit_price  - po.negotiated_unit_price) / nullif(po.original_unit_price, 0) * 100.0, 2) as percentage_savings
from purchase_orders po
order by monetary_saving desc;

-- Mini Task 8: Create a simple procurement risk view using supplier name, category, lead time, order value, and delivery status.
select s.supplier_name,
s.country, 
po.category,
s.expected_lead_time_days,
avg(po.actual_lead_time_days) as average_lead_time,
sum(po.unit_price * po.quantity) as total_order_value,
count(*) as total_orders,
sum(case when po.actual_lead_time_days > po.expected_lead_time_days then 1 else 0 end) as late_orders,
case
	when avg(po.actual_lead_time_days) > s.expected_lead_time_days and sum(po.unit_price * po.quantity) > 20000 then 'High: Mostly Late and High Spend'
	when avg(po.actual_lead_time_days) > s.expected_lead_time_days then 'Medium: Mostly Late'
	else 'Low: On time'
end as delivery_performance_risk
from purchase_orders po
join suppliers s 
on po.supplier_id = s.supplier_id
group by s.supplier_id, po.category, s.country, s.supplier_name, s.expected_lead_time_days
order by total_order_value desc;

-- Mini Task 9: Write a final business summary explaining what the queries reveal about spend, supplier risk, and delivery performance.
-- Assumption: We are a company based in Poland.

-- Based on the query results, several suppliers show delivery delays and high order value.
-- Suppliers with high spend and frequent delays should be prioritized for supplier performance review.
-- The procurement team should investigate root causes of delays and assess whether alternative suppliers are required.