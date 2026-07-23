# Retail Sales Data Analysis Using PostgreSQL

## Project Overview

This project analyzes a retail sales dataset using PostgreSQL and SQL.

The project is designed to simulate a real-world retail business analysis workflow, starting from data quality validation and progressing toward business performance analysis, sales analysis, customer analysis, product analysis, time-series analysis, profitability analysis, shipping analysis, and advanced SQL techniques.

The project uses a relational database structure with three tables:

* `sales`
* `customers`
* `products`

The `sales` table contains transactional information, while the `customers` and `products` tables contain master data related to customers and products.

The main objective of this project is to transform raw retail transaction data into meaningful business insights using SQL.

---

# Project Objectives

The project aims to answer important business questions such as:

* Is the dataset complete and reliable?
* How much revenue and profit did the business generate?
* Which regions, states, and cities perform best?
* Which products generate the highest revenue?
* Which products generate the highest profit?
* Which customers are the most valuable?
* Which customer segments contribute the most revenue and profit?
* How do discounts affect profitability?
* Which products generate losses?
* How does business performance change over time?
* Which months and quarters perform best?
* How efficient is the shipping process?
* Which products perform best within each category?

---

# Database Structure

The project uses the following PostgreSQL schema:

```text
retail
│
├── sales
│   ├── order_id
│   ├── order_date
│   ├── ship_date
│   ├── customer_id
│   ├── product_id
│   ├── quantity
│   ├── unit_price
│   ├── discount_percentage
│   ├── sales
│   ├── cost
│   ├── profit
│   ├── city
│   ├── state
│   ├── region
│   ├── salesperson
│   └── payment_mode
│
├── customers
│   ├── customer_id
│   ├── customer_name
│   └── segment
│
└── products
    ├── product_id
    ├── product_name
    ├── category
    ├── sub_category
    └── unit_price
```

---

# Data Model

The project follows a relational data model where the `sales` table acts as the central transaction table.

```text
customers
    │
    │ customer_id
    │
    ▼
sales
    │
    │ product_id
    │
    ▼
products
```

The relationships are:

```text
customers.customer_id
        │
        └────────── sales.customer_id

products.product_id
        │
        └────────── sales.product_id
```

This structure allows transactional data to be analyzed together with customer and product information using SQL `JOIN` operations.

---

# Dataset Summary

The dataset contains:

* 10,000 sales transactions
* 1,200 unique customers
* 15 products
* Sales data covering the year 2025
* Multiple regions, states, and cities across India
* Multiple payment methods
* Multiple customer segments
* Multiple product categories and sub-categories

The dataset includes both profitable and loss-making transactions, making it suitable for profitability and discount analysis.

---

# Project Structure

```text
Retail-Sales-Data-Analysis-PostgreSQL/
│
├── data/
│   ├── sales.csv
│   ├── customers.csv
│   └── products.csv
│
├── sql/
│   ├── 01_data_quality_checks.sql
│   ├── 02_overall_business_performance.sql
│   ├── 03_sales_analysis.sql
│   ├── 04_customer_analysis.sql
│   ├── 05_product_analysis.sql
│   ├── 06_time_analysis.sql
│   ├── 07_profitability_analysis.sql
│   ├── 08_shipping_analysis.sql
│   └── 09_advanced_sql.sql
│
└── README.md
```

---

# SQL Analysis Workflow

The analysis is divided into nine SQL scripts.

---

# 01. Data Quality Checks

File:

```text
01_data_quality_checks.sql
```

## Purpose

The first step of the project is to validate the quality and reliability of the data before performing business analysis.

This script checks:

* Available tables
* Row counts
* Duplicate customer IDs
* Duplicate product IDs
* Duplicate order IDs
* Date range
* Missing values
* Referential integrity
* Profit calculation accuracy
* Invalid shipping dates
* Negative or invalid quantities
* Invalid financial values

## Key SQL Concepts Used

* `COUNT()`
* `COUNT(DISTINCT)`
* `GROUP BY`
* `HAVING`
* `CASE`
* `LEFT JOIN`
* Data validation conditions

## Key Findings

The dataset contains:

* 10,000 sales records
* 1,200 customer records
* 15 product records
* No duplicate customer IDs
* No duplicate product IDs
* No duplicate order IDs
* No missing critical values
* Valid customer and product relationships
* Correct profit calculations

The dataset was therefore suitable for further business analysis.

---

# 02. Overall Business Performance

File:

```text
02_overall_business_performance.sql
```

## Purpose

This script provides a high-level overview of the overall business performance.

The analysis calculates:

* Total orders
* Total quantity sold
* Total sales
* Total cost
* Total profit
* Overall profit margin
* Average order value
* Average units per order

## Key Findings

The business generated approximately:

* **₹217.87 million in sales**
* **₹189.26 million in total cost**
* **₹28.61 million in profit**
* **13.13% overall profit margin**

The business processed:

* **10,000 orders**
* **31,820 units sold**

The average order value was approximately:

* **₹21,786.82**

The average order contained approximately:

* **3.18 units**

## Business Insight

The business is profitable overall, but profitability varies significantly across products, categories, discount levels, and regions.

---

# 03. Sales Analysis

File:

```text
03_sales_analysis.sql
```

## Purpose

This script analyzes sales performance across different geographic, product, and payment dimensions.

The analysis covers:

* Sales by region
* Sales by state
* Sales by city
* Sales by category
* Sales by sub-category
* Sales by payment mode

## Regional Analysis

The four regions generated relatively similar sales volumes.

The **South region** generated the highest total sales.

However, the **West region** achieved the highest profit margin among the major regions.

## State Analysis

The highest sales-performing states included:

* Gujarat
* Tamil Nadu
* Uttar Pradesh
* Maharashtra

Maharashtra achieved one of the strongest profit margins despite not having the highest sales.

## City Analysis

Hyderabad generated the highest total sales among the cities.

Other strong-performing cities included:

* Surat
* Patna
* Guwahati
* Bhubaneswar
* Chandigarh

Mumbai and Chandigarh showed strong profitability relative to their sales volumes.

## Category Analysis

The major categories were:

* Electronics
* Furniture
* Office Supplies

Electronics generated the majority of total sales.

However, Office Supplies generated a significantly higher profit margin.

This indicates that the category with the highest revenue is not necessarily the category with the highest profitability.

## Payment Mode Analysis

Net Banking generated the highest sales volume.

However, UPI and Debit Card transactions showed slightly stronger profit margins.

Overall, profitability was relatively balanced across payment methods.

---

# 04. Customer Analysis

File:

```text
04_customer_analysis.sql
```

## Purpose

This script analyzes customer behavior and identifies the most valuable customers.

The analysis includes:

* Top customers by sales
* Top customers by profit
* Customer segment performance

## Top Customers

The analysis identifies customers who contribute the highest:

* Total sales
* Total profit
* Number of orders
* Quantity purchased

The customer with the highest sales was not necessarily the customer with the highest profit.

This demonstrates the importance of analyzing both revenue and profitability.

## Customer Segment Analysis

The dataset contains three customer segments:

* Consumer
* Corporate
* Home Office

### Home Office

Home Office customers generated the highest total sales and profit.

### Consumer

Consumer customers achieved the highest profit margin among the three segments.

### Corporate

Corporate customers generated significant revenue but had a slightly lower profit margin compared with the other segments.

## Business Insight

Customer segments should not be evaluated only by revenue.

A segment may generate high sales but lower profitability due to discounts, product mix, or purchasing behavior.

---

# 05. Product Analysis

File:

```text
05_product_analysis.sql
```

## Purpose

This script analyzes product-level performance.

The analysis identifies:

* Top products by sales
* Top products by profit
* Best-selling products by quantity
* Product profit margins

## Top Product by Sales

The **Laptop** was the highest-selling product by a significant margin.

It generated approximately:

* **₹95.9 million in sales**

The Laptop was the primary revenue driver of the business.

## Top Product by Profit

The Laptop also generated the highest total profit.

However, its profit margin was relatively low compared with several other products.

## Best-Selling Products by Quantity

Office Supplies products such as:

* Marker Set
* Pen Pack
* File Folder
* Notebook Pack

sold significant quantities despite generating much lower total revenue than high-value electronics.

## Business Insight

High sales volume does not always mean high revenue.

Similarly:

* High revenue does not always mean high profit margin.
* Low-priced products can generate strong margins.
* High-value products can generate high revenue but lower margins.

---

# 06. Time Analysis

File:

```text
06_time_analysis.sql
```

## Purpose

This script analyzes business performance over time.

The analysis includes:

* Monthly sales
* Quarterly sales
* Monthly profit
* Month-over-month sales growth

## Monthly Performance

December was the strongest month in terms of:

* Sales
* Profit
* Quantity sold

May was the weakest month in terms of total sales.

## Monthly Profitability

The highest monthly profit was generated in December.

October also showed strong profitability with one of the highest monthly profit margins.

August had one of the lowest profit margins.

## Quarterly Performance

The fourth quarter was the strongest quarter of the year.

It generated:

* The highest sales
* The highest profit
* The highest quantity sold

This indicates strong business performance toward the end of the year.

## Month-over-Month Growth

The strongest positive monthly growth occurred in:

* June
* October

The largest decline occurred in:

* May

The business experienced fluctuations throughout the year, but performance improved significantly during the final quarter.

---

# 07. Profitability Analysis

File:

```text
07_profitability_analysis.sql
```

## Purpose

This script focuses on understanding profitability and identifying loss-making areas.

The analysis includes:

* Profitable orders
* Loss-making orders
* Break-even orders
* Discount analysis
* Loss-making products
* High-sales but low-profit products

## Order Profitability

The majority of orders were profitable.

The dataset contained:

* Profitable orders
* Loss-making orders
* Break-even orders

Although profitable orders were the majority, loss-making transactions created a significant negative impact on total profitability.

## Discount Analysis

A clear relationship was observed between discount percentage and profit margin.

As discounts increased:

```text
Discount ↑
     │
     ▼
Profit Margin ↓
```

The highest profit margins were achieved with low or zero discounts.

At a 30% discount, the overall profit margin became negative.

This means that aggressive discounting can turn sales into losses.

## Loss-Making Products

The Laptop generated the largest total loss from loss-making orders due to its high transaction value and volume.

Cabinets and Monitors also generated significant losses from discounted transactions.

## High-Sales but Low-Profit Products

Several products generated high revenue but relatively low profit margins.

The most important example was the Laptop.

This indicates that revenue alone should not be used to evaluate product performance.

---

# 08. Shipping Analysis

File:

```text
08_shipping_analysis.sql
```

## Purpose

This script analyzes shipping performance and delivery efficiency.

The analysis includes:

* Average shipping duration
* Fastest shipping time
* Longest shipping time
* Fast, standard, and delayed orders
* Shipping performance by region

## Overall Shipping Performance

The average shipping duration was approximately:

* **4 days**

The fastest shipment was completed in:

* **1 day**

The longest shipment took:

* **7 days**

## Shipping Categories

Orders were classified as:

* Fast
* Standard
* Delayed

Approximately:

* 42.9% of orders were shipped quickly
* 28.5% were standard
* 28.6% were delayed

## Regional Shipping Performance

Shipping performance was relatively consistent across all regions.

The North region had the lowest average shipping duration.

The South region had the highest average shipping duration and the highest delayed-order percentage.

However, the differences between regions were relatively small.

## Business Insight

Shipping performance is generally consistent across regions, but reducing delayed shipments could improve customer experience and operational efficiency.

---

# 09. Advanced SQL

File:

```text
09_advanced_sql.sql
```

## Purpose

This script demonstrates advanced SQL techniques used to answer more complex business questions.

The analysis includes:

* Common Table Expressions
* Window functions
* Ranking
* Category-level ranking
* Top products within each category
* Advanced aggregations

## Common Table Expressions

CTEs are used to break complex queries into logical steps.

Example use case:

```text
Step 1 → Aggregate product sales
Step 2 → Calculate profitability
Step 3 → Rank products
Step 4 → Return the required result
```

This improves query readability and maintainability.

## Window Functions

Window functions were used to rank products without collapsing the result set.

For example:

```sql
RANK() OVER (
    ORDER BY total_sales DESC
)
```

This ranks products based on total sales.

## Overall Product Ranking

The Laptop ranked first in total sales.

Other high-performing products included:

* Printer
* Monitor
* Cabinet
* Study Table

## Top Products Within Each Category

Window functions were used to identify the top products within each category.

For example:

```text
Electronics
├── Laptop
├── Printer
└── Monitor

Furniture
├── Cabinet
└── Study Table

Office Supplies
├── Notebook Pack
└── Marker Set
```

This is more useful for business analysis than simply ranking all products globally.

A product may not be among the top products overall but may still be the best-performing product in its own category.

---

# Key Business Insights

The analysis produced several important business insights.

## 1. Revenue and Profitability Are Different

The Laptop was the largest revenue-generating product.

However, its profit margin was relatively low.

Therefore:

> The product generating the highest revenue is not always the most profitable product.

---

## 2. Office Supplies Had the Highest Profit Margin

Office Supplies generated significantly lower revenue than Electronics.

However, its profit margin was much higher.

This indicates that smaller products can generate stronger returns.

---

## 3. Discounts Strongly Impact Profitability

Higher discounts resulted in lower profit margins.

At a 30% discount, the business generated an overall negative profit margin.

This suggests that discount policies should be carefully controlled.

---

## 4. Electronics Dominated Revenue

Electronics generated the majority of total revenue.

However, several Electronics products had relatively low profit margins.

The category should therefore be evaluated carefully based on both:

* Sales
* Profitability

---

## 5. The Fourth Quarter Was the Strongest

The fourth quarter generated the highest:

* Sales
* Profit
* Quantity sold

December was the strongest individual month.

This indicates a strong end-of-year sales trend.

---

## 6. Home Office Customers Generated the Highest Revenue

Home Office customers contributed the highest total sales and profit.

However, Consumer customers achieved a slightly higher profit margin.

This shows why customer segmentation should consider both revenue and profitability.

---

## 7. Loss-Making Transactions Require Attention

Most orders were profitable, but a significant number of transactions generated losses.

Losses were particularly associated with certain products and high-discount transactions.

---

## 8. Shipping Performance Was Relatively Consistent

Shipping duration remained relatively similar across regions.

However, approximately 28.6% of orders were classified as delayed.

Reducing delayed shipments could improve operational performance.

---

# SQL Concepts Demonstrated

This project demonstrates the following PostgreSQL and SQL concepts:

* `SELECT`
* `WHERE`
* `GROUP BY`
* `HAVING`
* `ORDER BY`
* `DISTINCT`
* Aggregate functions
* `COUNT()`
* `SUM()`
* `AVG()`
* `MIN()`
* `MAX()`
* `CASE`
* `JOIN`
* `LEFT JOIN`
* `INNER JOIN`
* Common Table Expressions
* Window Functions
* `RANK()`
* Date Functions
* Date Arithmetic
* Conditional Aggregation
* Data Quality Validation
* Referential Integrity Checks
* Financial Calculations
* Percentage Calculations
* Month-over-Month Growth Analysis

---

# Technologies Used

* PostgreSQL
* SQL
* pgAdmin
* Git
* GitHub

---

# Project Workflow

The complete project follows the following workflow:

```text
Raw CSV Files
      │
      ▼
PostgreSQL Database
      │
      ▼
Data Quality Checks
      │
      ▼
Overall Business Performance
      │
      ▼
Sales Analysis
      │
      ▼
Customer Analysis
      │
      ▼
Product Analysis
      │
      ▼
Time Analysis
      │
      ▼
Profitability Analysis
      │
      ▼
Shipping Analysis
      │
      ▼
Advanced SQL Analysis
      │
      ▼
Business Insights
```

---

# Conclusion

This project demonstrates how PostgreSQL and SQL can be used to analyze a retail business from multiple perspectives.

The analysis begins with data validation and progresses through:

* Business performance
* Sales performance
* Customer behavior
* Product performance
* Time-series trends
* Profitability
* Shipping operations
* Advanced SQL analysis

The project demonstrates that effective business analysis requires more than calculating total sales.

A complete analysis should consider:

```text
Revenue
   +
Profitability
   +
Customers
   +
Products
   +
Time
   +
Discounts
   +
Operations
```

The project shows how raw transactional data can be transformed into actionable business insights using SQL.

---

# Author

**Pooja Dixit**

This project was created as a portfolio project to demonstrate practical SQL and PostgreSQL data analysis skills.
