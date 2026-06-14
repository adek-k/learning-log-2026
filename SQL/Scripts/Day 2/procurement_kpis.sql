-- Assumption: All values are converted to PLN using fixed exchange rates:
-- EUR/PLN = 4.235
-- USD/PLN = 3.67
-- In a production database, exchange rates should be stored in a separate exchange_rates table.

-- Task 1: Calculate total company spend.
select 
round(sum(
	case
		when po.currency = 'EUR' then (po.quantity * po.unit_price) * 4.235
		when po.currency = 'USD' then (po.quantity * po.unit_price) * 3.67
		else po.quantity * po.unit_price 
	end
),2) as company_spend
from purchase_orders po;

-- Task 2: Calculate total number of purchase orders.
select count(*) as total_number_of_po
from purchase_orders po;

-- Task 3: Calculate average purchase order value.
select 
round(avg(
	case
		when po.currency = 'EUR' then (po.quantity * po.unit_price) * 4.235
		when po.currency = 'USD' then (po.quantity * po.unit_price) * 3.67
		else po.quantity * po.unit_price 
	end
),2) as average_po_value
from purchase_orders po;

-- Task 4: Calculate total negotiated savings.
with savings as (
select po.order_id, 
	case
		when po.currency = 'EUR' then (po.quantity * po.negotiated_unit_price) * 4.235
		when po.currency = 'USD' then (po.quantity * po.negotiated_unit_price) * 3.67
		else po.quantity * po.negotiated_unit_price
	end as po_value_post_negotiation,
	case
		when po.currency = 'EUR' then (po.quantity * po.original_unit_price) * 4.235
		when po.currency = 'USD' then (po.quantity * po.original_unit_price) * 3.67
		else po.quantity * po.original_unit_price 
	end as po_value_pre_negotiation
from purchase_orders po
)
select round(sum(s.po_value_pre_negotiation - s.po_value_post_negotiation),2) as total_savings
from savings s;

-- Task 5: Calculate average savings percentage.
with savings as (
select po.order_id, 
	case
		when po.currency = 'EUR' then (po.quantity * po.negotiated_unit_price) * 4.235
		when po.currency = 'USD' then (po.quantity * po.negotiated_unit_price) * 3.67
		else po.quantity * po.negotiated_unit_price
	end as po_value_post_negotiation,
	case
		when po.currency = 'EUR' then (po.quantity * po.original_unit_price) * 4.235
		when po.currency = 'USD' then (po.quantity * po.original_unit_price) * 3.67
		else po.quantity * po.original_unit_price 
	end as po_value_pre_negotiation
from purchase_orders po
)
select avg((s.po_value_pre_negotiation- s.po_value_post_negotiation) / nullif(s.po_value_pre_negotiation, 0)) * 100 as savings_percentage
from savings s;

-- Task 6: Calculate average expected lead time.
select avg(po.expected_lead_time_days) as average_expected_lead_time
from purchase_orders po;

-- Task 7: Calculate average actual lead time.
select avg(po.actual_lead_time_days) as average_actual_lead_time
from purchase_orders po; 

-- Task 8: Count late purchase orders.
select count(*) as number_of_pos,
sum(
case
	when po.actual_lead_time_days > po.expected_lead_time_days then 1 else 0
end
) as number_of_late_pos
from purchase_orders po;

-- Task 9: Calculate late order rate as a percentage.
with po_overview as (
select 
count(*) as number_of_pos,
sum(
case
	when po.actual_lead_time_days > po.expected_lead_time_days then 1 else 0
end
) as number_of_late_pos
from purchase_orders po)
select round((pov.number_of_late_pos::numeric / pov.number_of_pos) * 100,2) as percentage_of_late_deliveries
from po_overview pov;

-- Task 10: Create a one-row KPI summary for procurement management.
with kpi_base as (
    select
        po.order_id,
        po.quantity,
        po.unit_price,
        po.original_unit_price,
        po.currency,
        po.expected_lead_time_days,
        po.actual_lead_time_days,
        case
            when po.currency = 'EUR' then (po.quantity * po.unit_price) * 4.235
            when po.currency = 'USD' then (po.quantity * po.unit_price) * 3.67
            else po.quantity * po.unit_price
        end as po_value_pln,
        case
            when po.currency = 'EUR' then (po.quantity * po.original_unit_price) * 4.235
            when po.currency = 'USD' then (po.quantity * po.original_unit_price) * 3.67
            else po.quantity * po.original_unit_price
        end as original_po_value_pln
    from purchase_orders po
)
select
    round(sum(po_value_pln), 2) as total_company_spend_pln,
    count(*) as total_purchase_orders,
    round(avg(po_value_pln), 2) as average_purchase_order_value_pln,
    round(sum(original_po_value_pln - po_value_pln), 2) as total_negotiated_savings_pln,
    round(avg((original_po_value_pln - po_value_pln) / nullif(original_po_value_pln, 0) * 100), 2) as average_savings_percentage,
    round(avg(expected_lead_time_days), 2) as average_expected_lead_time_days,
    round(avg(actual_lead_time_days), 2) as average_actual_lead_time_days,
    sum(case when actual_lead_time_days > expected_lead_time_days then 1 else 0 end) as late_purchase_orders,
    round(
        sum(case when actual_lead_time_days > expected_lead_time_days then 1 else 0 end)::numeric / nullif(count(*), 0) * 100,
        2
    ) as late_order_rate_percentage
from kpi_base;
