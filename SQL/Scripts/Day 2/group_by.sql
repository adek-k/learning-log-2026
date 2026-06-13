-- Assumption: Fixed exchange rates are used for learning purposes.
-- EUR to PLN = 4.30
-- GBP to PLN = 5.00
-- PLN values are not converted.
-- Assumption: No other currency is available in the dataset except EUR, GBP and PLN
-- Task 1: Calculate total spend by supplier.
select
	s.supplier_name,
	round(
	sum(
case 
	when po.currency = 'EUR' then (po.unit_price * po.quantity) * 4.3
	when po.currency = 'GBP' then (po.unit_price * po.quantity) * 5
	else po.unit_price * po.quantity
end), 2) as total_spend_pln
from
	purchase_orders po
join suppliers s
on
	po.supplier_id = s.supplier_id
group by
	s.supplier_id,
	s.supplier_name
order by
	total_spend_pln desc;
-- Task 2: Calculate total spend by procurement category.

select
	po.category,
	round(sum(
case 
	when po.currency = 'EUR' then (po.unit_price * po.quantity) * 4.3
	when po.currency = 'GBP' then (po.unit_price * po.quantity) * 5
	else po.unit_price * po.quantity
end), 2) as total_spend_pln
from
	purchase_orders po
group by
	po.category
order by
	total_spend_pln desc;
-- Task 3: Count the number of purchase orders by supplier.
select
	s.supplier_name,
	count(po.order_id) as order_count
from
	purchase_orders po
join suppliers s
on
	s.supplier_id = po.supplier_id
group by
	s.supplier_id,
	s.supplier_name
order by
	order_count desc;
-- Task 4: Count the number of purchase orders by category.
select
	po.category,
	count(po.order_id) as order_count
from
	purchase_orders po
group by
	po.category
order by
	order_count desc;
-- Task 5: Calculate average order value by supplier.
select
	s.supplier_name,
	round(
avg(
case 
	when po.currency = 'EUR' then (po.unit_price * po.quantity) * 4.3
	when po.currency = 'GBP' then (po.unit_price * po.quantity) * 5
	else po.unit_price * po.quantity
end), 2) as average_order_value_pln
from
	purchase_orders po
join suppliers s
on
	s.supplier_id = po.supplier_id
group by
	s.supplier_id,
	s.supplier_name
order by
	average_order_value_pln desc;
-- Task 6: Calculate average lead time by supplier.
select
	s.supplier_name,
	round(AVG(po.actual_lead_time_days), 2) as average_actual_lead_time
from
	purchase_orders po
join suppliers s 
on
	s.supplier_id = po.supplier_id
group by
	s.supplier_id,
	s.supplier_name
order by
	average_lead_time desc;
-- Task 7: Count purchase orders by delivery status.
select
	po.status,
	count(*) as order_count
from
	purchase_orders po
group by
	po.status;
-- Task 8: Calculate total spend by supplier and category.
select
	s.supplier_name,
	po.category,
	round(sum(
case 
	when po.currency = 'EUR' then (po.unit_price * po.quantity) * 4.3
	when po.currency = 'GBP' then (po.unit_price * po.quantity) * 5
	else po.unit_price * po.quantity
end), 2) as total_spend_pln
from
	purchase_orders po
join suppliers s
on
	po.supplier_id = s.supplier_id
group by
	s.supplier_id,
	po.category,
	s.supplier_name
order by
	po.category,
	total_spend_pln desc ;
-- Task 9: Write a short comment explaining why GROUP BY is useful in procurement analytics.
-- GROUP BY is useful in procurement analytics because it allows us to summarize many purchase order rows into business-level groups such as supplier, category, or delivery status.
-- For example, if one supplier has multiple purchase orders in different currencies, we can first convert each order value into PLN and then use GROUP BY to calculate the supplier's total spend.