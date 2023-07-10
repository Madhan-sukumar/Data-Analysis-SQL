-- View the Data -- 
select *
from [dbo].[coca cola data]

-- See Unique Values -- 
select distinct Retailer from [dbo].[coca cola data]
select distinct Region from [dbo].[coca cola data]
select distinct State from [dbo].[coca cola data]
select distinct City from [dbo].[coca cola data]
select distinct [Beverage Brand] from [dbo].[coca cola data]

-- ADDING NEW COLUMN  - YEAR & Month --
-- Add a new column to the table
alter table [dbo].[coca cola data] add year INT;
update [dbo].[coca cola data]
set year = year([Invoice Date]);

alter table [dbo].[coca cola data] add months INT;
update [dbo].[coca cola data]
set months = month([Invoice Date]);


-- Analysis -- 
-- 1. How many different retailers are included in the data? --
select distinct Retailer from [dbo].[coca cola data]

-- 2. What is the distribution of sales across regions? --
select Region, sum([Total Sales]) as Total_Sales 
from [dbo].[coca cola data]
group by Region

-- 3. Which state has the highest total sales? Which state has the lowest total sales? --
select State, sum([Total Sales]) as Total_Sales
from [dbo].[coca cola data]
group by State
order by sum([Total Sales]) desc

-- 4. Which city has the highest total sales? Which city has the lowest total sales? -- 
select City, sum([Total Sales]) as Total_Sales
from [dbo].[coca cola data]
group by City
order by sum([Total Sales]) desc

-- 5. What is the total sales and profit for each beverage brand? -- 
select [Beverage Brand], sum([Total Sales]) as Total_sales , sum([Operating Profit]) as Operating_Profit
from [dbo].[coca cola data]
group by [Beverage Brand]

-- 6. How does the price per unit vary across different beverage brands? --
select [Beverage Brand], avg([Price per Unit]) as Average_Price
from [dbo].[coca cola data]
group by [Beverage Brand]
order by avg([Price per Unit]) desc

--7. Are there any noticeable trends or patterns in sales and profit over time (based on invoice date)? 
select [Invoice Date], sum([Total Sales]) as Total_sales , sum([Operating Profit]) as Operating_Profit
from [dbo].[coca cola data]
group by [Invoice Date]
order by [Invoice Date] desc

-- 8. What is the overall operating margin for the company, considering all the sales and profits? -- 
select (sum([Operating Profit]) / sum([Total Sales])) * 100 as Overall_Operating_Margin
from [dbo].[coca cola data]

-- 9.  How does the retailer's sales performance vary across different beverage brands? -- 
select Retailer, [Beverage Brand], sum([Total Sales]) as Total_Sales
from [dbo].[coca cola data]
group by Retailer, [Beverage Brand]
order by Retailer asc

-- 10. What is the contribution of each beverage brand to the retailer's total sales and operating profit? -- 
select [Beverage Brand], sum([Total Sales]) as Total_Sales, sum([Operating Profit]) as Operating_Profit
from [dbo].[coca cola data]
group by [Beverage Brand]
order by Operating_Profit desc

-- 11. Total Units sold by Retailer based on Brand -- 
select Retailer, [Beverage Brand], sum([Units Sold]) as Total_Units_Sold
from [dbo].[coca cola data]
group by [Retailer], [Beverage Brand]
order by [Beverage Brand] desc

-- 12. Which month holds the highest no of units sold --
select months, sum([Units Sold]) as Total_Units_Sold
from [dbo].[coca cola data]
group by months
order by sum([Units Sold]) desc

-- 13.  How does the price per unit affect the retailer's sales and profit?  -- 

select [Price per Unit], 
       sum([Units Sold]) as Total_Units_Sold, 
       sum([Total Sales]) as Total_Sales, 
       sum([Operating Profit]) as Operating_Profit
from [dbo].[coca cola data]
group by [Price per Unit]
order by [Price per Unit] asc

