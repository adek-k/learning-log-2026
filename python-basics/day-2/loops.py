# Task 1: Loop through a list of suppliers and print each supplier name.
# Task 2: Loop through a list of purchase order values and calculate the total spend manually.
# Task 3: Loop through purchase order values and print only orders above 1000 PLN.
# Task 4: Loop through supplier lead times and identify which deliveries are late.
# Task 5: Create a simple procurement summary using a loop: supplier name, order value, and delivery status.

suppliers = ['Tomex', 'Bobex', 'Listex', 'Loopex', 'Metex', 'Lepex']
po_values = [500, 800, 1548, 5481, 9941, 1513]
expected_leadtimes = [7,6,8,18,15,18]
actual_leadtimes = [5,8,9,10,15,45]

# Task 1
for i in suppliers:
    print(i)

# Task 2
po_values_sum = 0
for i in po_values:
    po_values_sum = po_values_sum + i

print(f'The sum of PO values is: {po_values_sum}')

# Task 3
for i in po_values:
    if i > 1000:
        print(i)

# Task 4
for i in range(len(expected_leadtimes)):
    if actual_leadtimes[i] > expected_leadtimes[i]:
        print(f'Delivery {i + 1}: Late. Expected: {expected_leadtimes[i]} days, actual: {actual_leadtimes[i]} days.')
    elif actual_leadtimes[i] == expected_leadtimes[i]:
        print(f'Delivery {i + 1}: On-time. Expected: {expected_leadtimes[i]} days, actual: {actual_leadtimes[i]} days.')
    else:
        print(f'Delivery {i + 1}: Early. Expected: {expected_leadtimes[i]} days, actual: {actual_leadtimes[i]} days.')

# Task 5
for i in range(len(suppliers)):
    supplier = suppliers[i]
    expected = expected_leadtimes[i]
    actual = actual_leadtimes[i]
    value = po_values[i]

    if actual > expected:
        delivery_status = 'Late'
    elif actual == expected:
        delivery_status = 'On-Time'
    else:
        delivery_status = 'Early'

    print(f'{supplier}: {delivery_status}. Expected: {expected} days, actual: {actual} days. Order value: {value} PLN')