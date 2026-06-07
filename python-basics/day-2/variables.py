# Task 1: Create variables for a single purchase order: supplier name, category, quantity, unit price, and currency.
# Task 2: Calculate the total order value by multiplying quantity by unit price.
# Task 3: Create variables for original price and negotiated price, then calculate the saving amount.
# Task 4: Calculate the saving percentage based on the original price and negotiated price.
# Task 5: Create variables for net price and VAT rate, then calculate the gross price.
# Task 6: Create variables for order date, expected lead time in days, and actual lead time in days.
# Task 7: Check whether the supplier delivered late by comparing actual lead time with expected lead time.
# Task 8: Print clear business-style messages showing total spend, savings, VAT, and delivery status.


# Task 1:
supplier_name = 'Metex'
category = 'Screws'
quantity = 1000
unit_price = 0.21
currency = 'EUR'

#Task 2:
total_order_value = quantity * unit_price

#Task 3:
original_price = unit_price
negotiated_price = 0.20

savings = (original_price - negotiated_price) * quantity

#Task 4:
percentage_savings = ((original_price - negotiated_price) / original_price) * 100

#Task 5:
net_price = negotiated_price * quantity
vat_rate = 0.23

gross_price = net_price + (net_price * vat_rate)

#Task 6:
order_date = '10/05/2026'
expected_lead_time = 4
actual_lead_time = 6

#Task 7:

delivery_status = ''

if actual_lead_time > expected_lead_time:
    delivery_status = 'Late'
elif expected_lead_time == actual_lead_time:
    delivery_status = 'On-time'
else:
    delivery_status = 'Early'

#Task 8:
print(f'The total spend for {category} from supplier {supplier_name}, came in at {net_price} {currency} net, {gross_price} {currency} gross with the total vat due {gross_price - net_price} {currency}. The total savings for this order have been at a {round(percentage_savings, 2)}%, which amounted to {round(savings,2)} {currency} net. Although the savings have been made the order have arrived {delivery_status}.')

