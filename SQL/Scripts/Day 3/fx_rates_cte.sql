-- Task 1: Create a CTE called fx_rates with currency and exchange_rate_to_pln.
-- Task 2: Include PLN, EUR, and GBP exchange rates.
-- Task 3: Join purchase_orders with fx_rates using currency.
-- Task 4: Calculate original_order_value_pln.
-- Task 5: Calculate negotiated_order_value_pln.
-- Task 6: Calculate savings_value_pln.
-- Task 7: Calculate savings_percentage.
-- Task 8: Show order_id, supplier_id, category, currency, exchange rate, negotiated value PLN, and savings PLN.
-- Task 9: Write a short SQL comment explaining why CTE is cleaner than repeating CASE logic.

with fx_rates (currency, exchange_rate_to_pln) as (
    values
    	('PLN', 1.0),
    	('EUR', 4.25),
    	('GBP', 4.97)
)
select 
po.order_id,
po.supplier_id,
s.supplier_name, 
po.category,
po.currency,
fr.exchange_rate_to_pln as exchange_rate,
round((po.original_unit_price * fr.exchange_rate_to_pln) * po.quantity,2) as original_order_value_pln,
round((po.negotiated_unit_price * fr.exchange_rate_to_pln) * po.quantity,2) as negotiated_order_value_pln,
round(((po.original_unit_price - po.negotiated_unit_price) * fr.exchange_rate_to_pln) * po.quantity,2) as savings_value_pln,
round((po.original_unit_price - po.negotiated_unit_price) / nullif(po.original_unit_price,0) * 100.0, 2) as savings_percentage
from purchase_orders po 
left join fx_rates fr
on fr.currency = po.currency
left join suppliers s
on s.supplier_id = po.supplier_id  
order by savings_value_pln desc;

-- Using a CTE for exchange rates is cleaner than repeating CASE logic in multiple calculations.
-- It keeps exchange rate assumptions in one place, makes the query easier to read, and reduces the risk of inconsistent currency conversion.