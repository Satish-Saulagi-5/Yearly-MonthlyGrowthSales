# Yearly-MonthlyGrowthSales
Business Growth Dashboard using MySQL and Power BI. Tracks total sales over time, product category performance, and customer distribution across countries from the Northwind database.
# 📈 Business Growth Dashboard  

This project tracks **sales growth trends, product performance, and customer distribution** using **MySQL** for data aggregation and **Power BI** for visualization.  

---

## 📌 Project Objectives
- Analyze **monthly sales trends** to identify growth or decline patterns.  
- Measure **total sales quantities by product category**.  
- Compare **number of customers across different countries**.  
- Build an interactive dashboard to support business growth decisions.  

---

## 🖼️ Dashboard Overview
![Business Growth Dashboard](Dashboard_Screenshots/business_growth.png)

### Dashboard Features:
1. **Total Sales by Year & Month (Line Chart)**  
   - Shows monthly sales trend across different years.  
   - Highlights seasonal growth/decline patterns.  

2. **Total Quantity by Category (Area Chart)**  
   - Visualizes sales quantities across product categories (Beverages, Dairy Products, Seafood, etc.).  
   - Identifies top-selling and underperforming product categories.  

3. **Customers by Country (Pie Chart)**  
   - Displays distribution of customers across USA, Venezuela, Brazil, Canada, and Ireland.  
   - Helps understand geographic spread of customers.  

---

## 🗄️ Data Source
- **Database**: Northwind (Sample Database)  
- **Tables Used**:  
  - `salesorder`  
  - `orderdetail`  
  - `products`  
  - `customer`  

---

## 🛠️ SQL Queries

### 1️⃣ Monthly Sales Growth View
The following view (`monthly_growth`) calculates monthly sales totals and growth percentages compared to the previous month.  

```sql
CREATE ALGORITHM=UNDEFINED DEFINER=`GFGDA3`@`%` SQL SECURITY DEFINER 
VIEW `northwind`.`monthly_growth` AS 
WITH monthlys AS (
    SELECT 
        MONTH(s.orderDate) AS months,
        SUM(o.quantity * o.unitPrice) AS total
    FROM northwind.salesorder s
    JOIN northwind.orderdetail o ON s.orderId = o.orderId
    GROUP BY months
)
SELECT 
    monthlys.months AS months,
    monthlys.total AS total,
    LAG(monthlys.total, 1) OVER (ORDER BY monthlys.months) AS previous_months,
    ROUND(
        (
            (monthlys.total - LAG(monthlys.total, 1) OVER (ORDER BY monthlys.months)) 
            / NULLIF(LAG(monthlys.total, 1) OVER (ORDER BY monthlys.months), 0)
        ) * 100, 2
    ) AS growth
FROM monthlys
ORDER BY monthlys.months;

## Project Files  

- `BusinessGrowth.sql` → MySQL query used to prepare sales, product, and customer distribution data  
- `BusinessGrowthDashboard.png` → Power BI dashboard screenshot (see preview below)  

## Dashboard Preview  
See `BusinessGrowthDashboard.png` in this repository for the Power BI dashboard screenshot.
