-- Assumptions
-- All supplier spend values are converted to PLN.
-- EUR and GBP exchange rates are hardcoded for learning purposes.
-- Supplier risk is based on total spend and late delivery rate.
-- Risk thresholds are arbitrary and would need business validation in a real project.

-- Task 1: Show total spend by supplier.
select 
s.supplier_name,
round(sum(
	case
		when po.currency = 'EUR' then (po.negotiated_unit_price * po.quantity) * 4.235
		when po.currency = 'GBP' then (po.negotiated_unit_price * po.quantity) * 4.97
		else po.negotiated_unit_price * po.quantity 
	end
),2) as total_supplier_spend
from suppliers s 
join purchase_orders po 
on s.supplier_id = po.supplier_id 
group by s.supplier_id, s.supplier_name
order by total_supplier_spend desc;

-- Task 2: Show total number of orders by supplier.
select 
s.supplier_name,
count(*) as total_order_count
from purchase_orders po
join suppliers s 
on s.supplier_id = po.supplier_id
group by s.supplier_id, s.supplier_name
order by total_order_count desc;

-- Task 3: Show average order value by supplier.
select 
s.supplier_name,
round(avg(
	case
		when po.currency = 'EUR' then (po.negotiated_unit_price * po.quantity) * 4.235
		when po.currency = 'GBP' then (po.negotiated_unit_price * po.quantity) * 4.97
		else po.negotiated_unit_price * po.quantity 
	end
),2) as average_order_value
from suppliers s 
join purchase_orders po 
on s.supplier_id = po.supplier_id 
group by s.supplier_id, s.supplier_name
order by average_order_value desc;

-- Task 4: Show average actual lead time by supplier.
select s.supplier_name, round(avg(po.actual_lead_time_days),2) as average_po_lead_time
from suppliers s
join purchase_orders po
on s.supplier_id = po.supplier_id
group by s.supplier_id, s.supplier_name 
order by average_po_lead_time desc;

-- Task 5: Create a supplier performance summary using spend, savings, lead time, and delivery risk.
with performance_base as (
select po.supplier_id,
count(*) as order_count,
sum(case 
	when po.actual_lead_time_days > po.expected_lead_time_days then 1 else 0
end) as late_order_count,
round(sum(
	case
		when po.currency = 'EUR' then (po.negotiated_unit_price * po.quantity) * 4.235
		when po.currency = 'GBP' then (po.quantity * po.negotiated_unit_price) * 4.97
		else po.negotiated_unit_price * po.quantity 
	end
),2) as total_supplier_spend,
round(sum(
	case
		when po.currency = 'EUR' then ((po.original_unit_price - po.negotiated_unit_price) * po.quantity) * 4.235
		when po.currency = 'GBP' then ((po.original_unit_price - po.negotiated_unit_price) * po.quantity) * 4.97
		else (po.original_unit_price - po.negotiated_unit_price) * po.quantity 
	end
),2) as total_supplier_savings,
round(avg(po.actual_lead_time_days),2) as average_lead_time
from purchase_orders po 
group by po.supplier_id
), procurement_kpis as (
select s.supplier_name, 
pb.order_count,
pb.late_order_count,
round(pb.late_order_count * 100.0 / nullif(pb.order_count,0),2) as percentage_of_late_orders,
pb.total_supplier_spend,
pb.total_supplier_savings,
round(pb.total_supplier_spend / nullif(pb.order_count, 0), 2) as average_order_value,
pb.average_lead_time,
case 
	when pb.total_supplier_spend > 300000 and pb.late_order_count * 100.0 / nullif(pb.order_count, 0) >= 65 then 'High Risk'
	when pb.total_supplier_spend > 200000 or pb.late_order_count * 100.0 / nullif(pb.order_count,0) >= 20 then 'Medium Risk'
	else 'Low Risk'
end as supplier_risk_factor
from performance_base pb
join suppliers s
on pb.supplier_id = s.supplier_id
)
select * from procurement_kpis
order by 
case
	when supplier_risk_factor = 'High Risk' then 1
	when supplier_risk_factor = 'Medium Risk' then 2
	else 3
end;