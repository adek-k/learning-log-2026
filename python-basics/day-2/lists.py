# Task 1: Create a list of supplier names.
# Task 2: Create a list of purchase order values in PLN.
# Task 3: Calculate the total spend from the list of purchase order values.
# Task 4: Find the highest and lowest purchase order value.
# Task 5: Calculate the average purchase order value.
# Task 6: Add a new supplier to the supplier list.
# Task 7: Remove one supplier from the supplier list.
# Task 8: Sort the purchase order values from lowest to highest.
# Task 9: Print the top three highest purchase order values.
# Task 10: Create a list of categories and print how many categories are being tracked.


# Task 1:
suppliers = ['Thomson', 'Bobson', 'Stevenson', 'Peterson', 'Lukason']
# Task 2:
po_values = [10000, 5000, 8000, 9811, 358]
# Task 3:
total_spend_value = sum(po_values)
# Task 4:
highest_value = max(po_values)
lowest_value = min(po_values)

# Task 5:
average_po_value = total_spend_value / len(po_values)

# Task 6:
suppliers.append('Netson')

# Task 7:
suppliers.remove('Luikason')

# Task 8:
po_values.sort()

# Task 9:
top_three_highest_values = sorted(po_values, reverse=True)[:3]
print(top_three_highest_values)

# Task 10:
categories = ['Screws', 'Bolts', 'Office', 'Tubes']
categories_count = len(categories)
print(f'We\'re currently tracking {categories_count} categories' )

print(f"Total spend: {total_spend_value} PLN")
print(f"Highest purchase order value: {highest_value} PLN")
print(f"Lowest purchase order value: {lowest_value} PLN")
print(f"Average purchase order value: {round(average_po_value, 2)} PLN")
print(f"Current suppliers: {suppliers}")
print(f"Purchase order values sorted from lowest to highest: {po_values}")
print(f"Top three highest purchase order values: {top_three_highest_values}")

