-- Task 1: Show suppliers with total spend above 100000 PLN.
select
	s.supplier_name,
	sum(
		case
			when po.currency = 'EUR' then (po.quantity * po.unit_price) * 4.235
			when po.currency = 'USD' then (po.quantity * po.unit_price) * 3.67
			else po.quantity * po.unit_price 
		end) as total_spend
from suppliers s
join purchase_orders po 
on s.supplier_id = po.supplier_id
group by
	s.supplier_id, s.supplier_name 
having
	sum(
		case
			when po.currency = 'EUR' then (po.quantity * po.unit_price) * 4.235
			when po.currency = 'USD' then (po.quantity * po.unit_price) * 3.67
			else po.quantity * po.unit_price 
		end) > 100000
order by
	total_spend desc;

-- Task 2: Show categories with total spend above 100000 PLN.
select
	po.category,
	round(sum(
		case
			when po.currency = 'EUR' then (po.quantity * po.unit_price) * 4.235
			when po.currency = 'USD' then (po.quantity * po.unit_price) * 3.67
			else po.quantity * po.unit_price 
		end),2) as total_spend
from
	purchase_orders po
group by
	po.category
having
	sum(
		case
			when po.currency = 'EUR' then (po.quantity * po.unit_price) * 4.235
			when po.currency = 'USD' then (po.quantity * po.unit_price) * 3.67
			else po.quantity * po.unit_price 
		end) > 100000
order by
	total_spend desc;

-- Task 3: Show suppliers with more than 5 purchase orders.
select s.supplier_name, count(*) as purchase_orders_count
from suppliers s 
join purchase_orders po
on s.supplier_id = po.supplier_id 
group by s.supplier_id, s.supplier_name 
having count(*) > 5
order by purchase_orders_count desc;

-- Task 4: Show categories with more than 5 purchase orders.
select po.category, count(*) as purchase_orders_count
from purchase_orders po
group by po.category 
having count(*) > 5
order by purchase_orders_count desc;

-- Task 5: Show suppliers with average lead time above 14 days.
select s.supplier_name, round(AVG(po.actual_lead_time_days),2) as average_lead_time
from suppliers s 
join purchase_orders po 
on s.supplier_id = po.supplier_id 
group by s.supplier_id, s.supplier_name 
having AVG(po.actual_lead_time_days) > 14
order by average_lead_time desc;

-- Task 6: Show suppliers with at least two late deliveries.
select s.supplier_name, count(*) as delivery_count,
sum(
case
	when po.actual_lead_time_days > po.expected_lead_time_days then 1 else 0
end) as late_delivery_count
from suppliers s
join purchase_orders po 
on s.supplier_id = po.supplier_id 
group by s.supplier_id, s.supplier_name 
having 
sum(
case
	when po.actual_lead_time_days > po.expected_lead_time_days then 1 else 0
end) >= 2
order by delivery_count desc, late_delivery_count desc;

-- Task 7: Show supplier-category combinations with total spend above 50000 PLN.
select 
s.supplier_name, 
po.category,
round(
sum(
	case
			when po.currency = 'EUR' then (po.quantity * po.unit_price) * 4.235
			when po.currency = 'USD' then (po.quantity * po.unit_price) * 3.67
			else po.quantity * po.unit_price 
	end	
),2) as total_order_value
from suppliers s
left join purchase_orders po 
on s.supplier_id = po.supplier_id
group by s.supplier_id, po.category 
having 
sum(
	case
			when po.currency = 'EUR' then (po.quantity * po.unit_price) * 4.235
			when po.currency = 'USD' then (po.quantity * po.unit_price) * 3.67
			else po.quantity * po.unit_price 
	end	
) > 50000
order by total_order_value desc, po.category;

-- Task 8: Show categories where average order value is above 3000 PLN.
select po.category,
round(avg(
	case
			when po.currency = 'EUR' then (po.quantity * po.unit_price) * 4.235
			when po.currency = 'USD' then (po.quantity * po.unit_price) * 3.67
			else po.quantity * po.unit_price 
	end	
),2) as average_order_value
from purchase_orders po
group by po.category
having 
avg(
	case
			when po.currency = 'EUR' then (po.quantity * po.unit_price) * 4.235
			when po.currency = 'USD' then (po.quantity * po.unit_price) * 3.67
			else po.quantity * po.unit_price 
	end	
) > 3000
order by average_order_value desc;

-- Task 9: Compare WHERE and HAVING in a short SQL comment.
-- WHERE filters individual rows before aggregation.
-- HAVING filters grouped results after GROUP BY.
-- Example: WHERE can filter orders above 5000 PLN, while HAVING can filter suppliers whose total spend is above 100000 PLN.