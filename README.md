# BookStore-Analysis-MySQL

Overview:
This project demonstrates SQL-based analysis on a normalized online bookstore database. It focuses on revenue calculation, customer behavior, and product performance using realistic relational data.

Database Design:
The database consists of four tables:
customers: customer details and signup information
books: book catalog with genre and pricing
orders: order-level transactions
order_items: line-level purchase details
The schema follows normalization principles and uses foreign keys to maintain data integrity.

Key Analyses:
Total and genre-wise revenue analysis
Bestselling books based on quantity sold
Customer spending and repeat customer identification
Monthly revenue trend analysis
Ranking books by revenue within each genre using window functions

SQL Concepts Used:
table creation and relationships
joins and aggregations
subqueries and derived tables
window functions (rank() over)
date-based analysis

Tools:
MySQL 

How to Run:
Execute the SQL script from top to bottom. It creates the database, inserts sample data, and runs all analytical queries.

Outcome:
The project demonstrates the ability to design relational databases, write analytical SQL queries, and extract business insights from transactional data.
