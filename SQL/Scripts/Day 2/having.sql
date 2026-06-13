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
	s.supplier_id
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
select s.supplier_name, count(po.*) as purchase_orders_count
from suppliers s 
join purchase_orders po
on s.supplier_id = po.supplier_id 
group by s.supplier_id
having count(po.*) > 5
order by purchase_orders desc;

-- Task 4: Show categories with more than 5 purchase orders.
select po.category, count(*) as purchase_orders_count
from purchase_orders po
group by po.category 
having count(*) > 5
order by purchase_orders_count desc;

-- Task 5: Show suppliers with average lead time above 14 days.
-- Task 6: Show suppliers with at least one late delivery.
-- Task 7: Show supplier-category combinations with total spend above 5000 PLN.
-- Task 8: Show categories where average order value is above 3000 PLN.
-- Task 9: Compare WHERE and HAVING in a short SQL comment.