# RETENTION-PLOT [SQL]
## Problem
The problem is to write a SQL query to generate a retention plot based on an "Order" table with the schema (id, user_id, total, created). The retention analysis tracks weekly user engagement starting from the week a user first places an order, referred to as "Week 0." In "Week 0," we count the number of unique users who placed their first order that week. For subsequent weeks (Week 1 to Week 10), we determine the number of these users who returned to place orders in the corresponding weeks following their initial purchase, thereby measuring retention over a 10-week period.
## Purpose
The main purpose of the script is to calculate user retention on a weekly basis by:

- Determining when each user made their first order.
- Calculating the number of weeks elapsed since the first purchase.
- Grouping the results to count distinct users for each week difference.
## Importance
Understanding user retention is crucial for businesses to:

- Assess the effectiveness of marketing strategies.
- Identify periods of high or low user engagement.
- Formulate customer retention strategies.
- Make data-driven decisions to improve user satisfaction and boost sales.
## Steps Involved
### Creating the orders Table:

- The orders table is created to store order data including order ID, user ID, total amount, and the order date.
- The data is loaded from a CSV file.

![Screenshot 2024-10-29 125023](https://github.com/user-attachments/assets/6561fa68-4f46-4fcb-8cd1-8ad1752f0cdd)

### Grouping Orders:

- A temporary table (grouped) is created to store user IDs and the corresponding dates when orders were made, ensuring each combination is unique.
![Screenshot 2024-10-29 125112](https://github.com/user-attachments/assets/687a422a-8f8a-4b88-90f8-3b3fc3472626)

### Calculating the First Order Week:

- Another temporary table (week) is created to store the user orders along with the week start date.
- The minimum week start date for each user is calculated and stored in the minweek table to determine when each user made their first purchase.
![Screenshot 2024-10-29 125155](https://github.com/user-attachments/assets/11663140-a7c0-456b-a8f6-5963c9e48d3b)

### Calculating Week Differences:

- The script joins the grouped and minweek tables to calculate the difference in weeks from each order to the user's first order, stored in a new table (final).
![Screenshot 2024-10-29 125224](https://github.com/user-attachments/assets/b0c885d5-1012-4829-8490-2d54f74e0a1c)

### Weekly User Retention Analysis:

- Finally, the script performs a grouped count to calculate the number of distinct users for each week difference and outputs the results, showing retention over a 10-week period.

![Screenshot 2024-10-29 125329](https://github.com/user-attachments/assets/5514898a-1983-48a0-86a7-fb702ffe2a4f)
## Technical Skills
- SQL Basics: Knowledge of SQL for creating tables, importing data, and performing CRUD operations.
- Data Aggregation: Using GROUP BY, ORDER BY, and JOIN to summarize and analyze data.
- Date and Time Functions: Manipulating timestamps to calculate differences.
- Data Transformation: Converting raw data into a structured format suitable for analysis.
## Soft Skills
- Analytical Thinking: Understanding the business requirement for user retention analysis and converting it into a structured data analysis workflow.
- Problem-Solving: Addressing potential data quality or structure issues that could arise when importing and processing data.
- Attention to Detail: Ensuring accurate calculations by carefully structuring the SQL queries to produce meaningful insights.
## Conclusion
- The script provides a way to analyze user retention by identifying the week a user first placed an order and counting how many distinct users returned in subsequent weeks. This can be leveraged to inform strategies for improving customer loyalty and optimizing marketing efforts.
