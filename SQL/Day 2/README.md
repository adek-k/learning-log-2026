```markdown
# SQL Day 2 Summary

## Topic

Today I practiced basic SQL queries using a simple procurement dataset.

The main focus was on selecting data, filtering rows, sorting results, calculating order values, identifying late deliveries, and creating a simple procurement risk view.

## Files completed

- `select_basics.sql`
- `where_filters.sql`
- `order_by_limit.sql`
- `basic_calculations.sql`
- `mini_tasks.sql`

## Skills practiced

- `SELECT`
- Choosing specific columns
- Column aliases using `AS`
- `WHERE` filtering
- `ORDER BY`
- `LIMIT`
- Basic calculations in SQL
- `JOIN`
- `CASE`
- `SUM`
- `AVG`
- `COUNT`
- `GROUP BY`
- Basic supplier and purchase order analysis

## Business context

The exercises were based on procurement and supplier performance data.

The SQL queries were used to answer simple business questions such as:

- Which purchase orders have the highest value?
- Which suppliers have long expected lead times?
- Which purchase orders were delivered late?
- Which suppliers or supplier-category combinations create delivery risk?
- How much value was saved through negotiation?
- Which areas should procurement review more closely?

## Key queries completed

### Purchase order overview

I created a query showing purchase orders together with supplier name, category, order value, and delivery status.

This helps procurement teams understand basic order-level information in one view.

### High-value purchase orders

I filtered purchase orders above a selected value threshold.

This is useful because high-value orders usually require closer monitoring and stronger supplier management.

### Late deliveries

I identified purchase orders where actual lead time was higher than expected lead time.

This helps detect delivery performance problems and potential supply chain risk.

### Negotiated savings

I calculated the difference between original unit price and negotiated unit price.

This allowed me to calculate both monetary savings and savings percentage for each purchase order.

### Supplier-category risk view

I created a supplier-category level risk view using:

- supplier name
- country
- category
- expected lead time
- average actual lead time
- total order value
- number of orders
- number of late orders
- delivery performance risk level

This query was more advanced than the basic tasks and helped me practice aggregation and business logic.

## Assumptions

- All order values are shown in PLN.
- The dataset is synthetic and created only for learning purposes.
- `unit_price * quantity` represents net order value.
- A purchase order is considered late when `actual_lead_time_days` is greater than `expected_lead_time_days`.
- Supplier risk is based on delivery performance and order value.

## Business summary

The analysis identifies purchase orders with high value, delayed deliveries, and supplier-category combinations with elevated procurement risk.

High-value orders should be monitored closely because delays in these orders may have a stronger impact on production continuity and working capital.

Suppliers with frequent late deliveries and high total spend should be prioritized for supplier performance review.

The procurement team should investigate root causes of delays, review supplier commitments, and assess whether alternative suppliers or revised delivery terms are required.

This type of analysis can support supplier review meetings, category strategy, operational risk monitoring, and procurement decision-making.

## What I learned

Today I learned that SQL is not only about retrieving data from tables.

SQL can also be used to:

- connect business entities using joins,
- calculate key procurement metrics,
- detect delivery issues,
- classify risk using business rules,
- summarize data for decision-making.

The most important concept today was understanding that SQL queries should answer clear business questions, not just return rows from a database.

## What I need to improve next

- Writing cleaner and more consistent aliases
- Understanding aggregation more deeply
- Practicing `GROUP BY` and `HAVING`
- Calculating percentage-based KPIs
- Building supplier performance summaries
- Making sure every business conclusion is supported by a query

```
