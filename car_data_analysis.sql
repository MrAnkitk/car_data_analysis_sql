create database cars;
use cars;

-- 1. Total Cars in Dataset
select count(distinct Car_ID) AS Total_Cars
from Car_Data;

-- 2. Total Brands Available
select brand, count(Brand) AS Total_Brands
from car_data
group by brand;

-- 3. Total Fuel Types
select count(distinct Fuel_Type) As Total_Fuel_Types
from car_data;

-- 4. Total Models
select count(distinct model) AS Total_Models
from car_data;

-- 5. Cars by fuel type
select Fuel_Type, Count(*) AS Total_Cars
From car_data 
group by Fuel_Type
order by Total_Cars desc;

-- 6. Which car brands have the highest average selling price in the dataset?
select Brand, round(avg(sales_data.Sale_Price_Lakh),2) AS AVG_saling_price_Lakh
from car_data
join sales_data
on car_data.Car_ID = sales_data.Car_ID
group by brand
order by AVG_saling_price_Lakh desc
limit 5;

-- 7. What is the trend of car sales by year? (e.g., total cars sold each year).
select year(Sale_Date) AS Sales_By_Year, count(*) AS Total_Cars
from sales_data
group by Sales_By_Year
order by Sales_By_Year;

-- 8. Which transmission type (Manual vs Automatic) has higher sales and higher average prices?
select c.Transmission AS Transmission, count(s.Car_ID) AS Total_Sales, avg(s.Sale_Price_Lakh) AS Avg_Sale_Price
from car_data c
join sales_data s
on c.Car_ID = s.Car_ID
group by Transmission
order by Total_Sales desc, Avg_Sale_Price desc;


-- 9. What is the average depreciation rate of cars by brand? (Difference between purchase price and sale price per year).
select c.Brand, round(avg(
(c.Price_Lakh - s.Sale_Price_Lakh) / nullif (extract(year from s.Sale_Date) - o.Purchase_Year,0)
),2) AS Avg_Depreciation_Per_Year
from car_data c
join sales_data s
on c.Car_ID = s.Car_ID
join owner_data o
on c.Car_ID = o.Car_ID
group by c.Brand
order by Avg_Depreciation_Per_Year desc;

-- 10. Top 5 Most Expensive Cars Sold and Their Buyers
SELECT 
    c.Brand,
    c.Model,
    s.Sale_Price_Lakh,
    s.Buyer_Name,
    s.Sale_Date
FROM car_data c
JOIN sales_data s ON c.Car_ID = s.Car_ID
ORDER BY s.Sale_Price_Lakh DESC
LIMIT 5;

-- 11. Monthly Trends
SELECT 
    m.Month_Number,
    ELT(m.Month_Number,
        'January','February','March','April','May','June',
        'July','August','September','October','November','December'
    ) AS Month_Name,
    m.Total_Sales
FROM (
    SELECT 
        MONTH(Sale_Date) AS Month_Number,
        COUNT(*) AS Total_Sales
    FROM sales_data
    GROUP BY MONTH(Sale_Date)
) AS m
ORDER BY m.Month_Number;



