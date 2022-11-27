-- Inspecting Data --
select * from [dbo].[sales_data_sample]

-- checking unique values --
select distinct Status from [dbo].[sales_data_sample]
select distinct Year_ID from [dbo].[sales_data_sample]
select distinct PRODUCTLINE from [dbo].[sales_data_sample]
select distinct COUNTRY from [dbo].[sales_data_sample]
select distinct TERRITORY from [dbo].[sales_data_sample]
select distinct DEALSIZE from [dbo].[sales_data_sample]

--- ANALYSIS ---
-- Sales by product line -- 
select PRODUCTLINE, round(sum(SALES),2) as 'TOTAL SALES'
from [dbo].[sales_data_sample]
group by PRODUCTLINE    -- best product is Classic cars
order by 2 desc

--Sales by year--
select YEAR_ID, round(sum(SALES),2) as 'TOTAL SALES'
from [dbo].[sales_data_sample]
group by YEAR_ID
order by 2 desc

--Sales by Dealsize--
select DEALSIZE, round(sum(SALES),2) as 'TOTAL SALES'
from [dbo].[sales_data_sample]
group by DEALSIZE      -- larger no of deals are medium sized
order by 2 desc

--what was the best month for sales in a specific year? How much was earned that month? --
select Month_ID, round(sum(SALES),2) as 'TOTAL SALES', count(ORDERNUMBER) as 'FREQUENCY'
from [dbo].[sales_data_sample]
where YEAR_ID = 2003   -- change year to see  and best month is nov 
group by MONTH_ID
order by 2 desc

-- November seems to be best but what product they sell in november
select MONTH_ID,PRODUCTLINE, count(PRODUCTLINE) as 'FREQUENCY',round(sum(SALES),2) as 'TOTAL SALES'
from [dbo].[sales_data_sample]
where YEAR_ID = 2003 and MONTH_ID = 11   
group by MONTH_ID,PRODUCTLINE
order by 3 desc

-- what city has the highest number of sales in specific country -- 
select CITY,round(sum(SALES),2) as 'TOTAL SALES'
from [dbo].[sales_data_sample]
where COUNTRY = 'UK'
group by CITY
order by 2 desc


-- what is the best product in the UK -- 
select COUNTRY,YEAR_ID,PRODUCTLINE, round(sum(SALES),2) as 'TOTAL SALES'
from [dbo].[sales_data_sample]
where COUNTRY= 'UK'
group by PRODUCTLINE,COUNTRY,YEAR_ID
order by 4 desc


-- Who is the best customer based on RFM Analysis--
DROP TABLE IF EXISTS #rfm
;with rfm as 
(
	select CUSTOMERNAME,
		   round(sum(SALES),2) AS 'MONETARY_VALUE',
		   round(avg(SALES),2) as 'AVG_MONETARY_VALUE',
		   count(ORDERNUMBER) as 'FREQUENCY',
		   max(ORDERDATE) as 'LAST_ORDER_DATE',
		   (select maX(ORDERDATE) from [dbo].[sales_data_sample]) as ' LAST_ORDER_DATE_DB',
		   DATEDIFF(day, max(ORDERDATE),(select maX(ORDERDATE) from [dbo].[sales_data_sample])) as 'RECENCY'
	from [dbo].[sales_data_sample]
	group by CUSTOMERNAME
),
rfm_calc as 
(
	select r.*,
		NTILE(4) over(order by RECENCY) as  rfm_recency,
		NTILE(4) over(order by FREQUENCY) as  rfm_frequency,
		NTILE(4) over(order by MONETARY_VALUE) as  rfm_monetary
	from rfm as r
)

select c.*,
       rfm_recency + rfm_frequency + rfm_monetary as rfm_cell,
	   cast(rfm_recency as varchar) + cast(rfm_frequency as varchar) + cast(rfm_monetary as varchar) as rfm_cell_string
into #rfm 
from rfm_calc c

select CUSTOMERNAME , rfm_recency, rfm_frequency, rfm_monetary, rfm_cell_string,
	case 
		when rfm_cell_string in (111, 112 , 121, 122, 123, 132, 211, 212, 114, 141) then 'lost_customers'  --lost customers
		when rfm_cell_string in (133, 134, 143, 244, 334, 343, 344, 144) then 'slipping away, cannot lose' -- (Big spenders who haven’t purchased lately) slipping away
		when rfm_cell_string in (311, 411, 331) then 'new customers'
		when rfm_cell_string in (222, 223, 233, 322) then 'potential churners'
		when rfm_cell_string in (323, 333,321, 422, 332, 432) then 'active' --(Customers who buy often & recently, but at low price points)
		when rfm_cell_string in (433, 423, 434, 443, 444) then 'loyal'
	end rfm_segment 
from #rfm




