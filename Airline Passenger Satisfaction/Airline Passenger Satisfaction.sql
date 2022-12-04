--Inspecting Data--
select * from [Airline passenger satisfaction].dbo.airline_passenger_satisfaction

--ANALYSIS---
-- Finding Distinct Categories--
select distinct [Customer Type] from [Airline passenger satisfaction].dbo.airline_passenger_satisfaction
select distinct [Type of Travel] from [Airline passenger satisfaction].dbo.airline_passenger_satisfaction
select distinct Class from [Airline passenger satisfaction].dbo.airline_passenger_satisfaction
select distinct Satisfaction from [Airline passenger satisfaction].dbo.airline_passenger_satisfaction

-- Total Passengers -- 
select count(*) as "Total Passengers"
from [Airline passenger satisfaction].dbo.airline_passenger_satisfaction

-- Passengers based on gender--
select Gender, count(Gender) as "Gender Count", count(Gender)*100.0 / sum(count(Gender)) over () as "Gender Percentage"
from [Airline passenger satisfaction].dbo.airline_passenger_satisfaction
group by Gender

-- passengers based on Class--
select Class, count(Class) as "Class Count"
from [Airline passenger satisfaction].dbo.airline_passenger_satisfaction
group by Class
order by 2 asc

-- passengers based on Tavel Type Count--
select [Type of Travel], count([Type of Travel]) as "Travel Type Count"
from [Airline passenger satisfaction].dbo.airline_passenger_satisfaction
group by [Type of Travel]
order by 2 asc

-- Gender on Type of Travel--
select Gender, [Type of Travel], count([Gender])
from [Airline passenger satisfaction].dbo.airline_passenger_satisfaction
group by Gender, [Type of Travel]
order by Gender desc

-- passengers based on Customer Type--
select [Customer Type], count([Customer Type]) as "Customer Type Count", 
       count([Customer Type])*100.0 / sum(count([Customer Type])) over () as "CT Percentage"
from [Airline passenger satisfaction].dbo.airline_passenger_satisfaction
group by [Customer Type]
order by 2 asc

-- Satisfaction--
select  Satisfaction, count(Satisfaction) as "Satisfaction Count",
        count(Satisfaction) *100 / sum(count(Satisfaction)) over () as "Satisfaction Percentage" 
from [Airline passenger satisfaction].dbo.airline_passenger_satisfaction
group by Satisfaction
order by 2 asc

-- Satisfaction by Gender--
select  Gender, Satisfaction
from [Airline passenger satisfaction].dbo.airline_passenger_satisfaction
group by Gender
order by 2 asc  

-- percentage of passenger satisfied --
select  Satisfaction, 
        count(Satisfaction) as "Satisfaction Count" ,
        count(Satisfaction) * 100.0 / Sum(count(Satisfaction)) over() as "Satisfaction Percentage"
from [Airline passenger satisfaction].dbo.airline_passenger_satisfaction
group by Satisfaction

-- percentage of passenger satisfied by customer type --
select  [Customer Type],
        count([Customer Type]) as "CT Count", Satisfaction,
        count([Satisfaction]) * 100.0  / Sum(count([Satisfaction])) over() as "Satisfaction Percentage"
from [Airline passenger satisfaction].dbo.airline_passenger_satisfaction
group by [Customer Type], [Satisfaction] 

-- percentage of passenger satisfied by Type of Travel --
select  [Type of Travel],[Class],
        count([Type of Travel]) as "CT Count", Satisfaction,
        count([Type of Travel]) * 100.0  / Sum(count([Type of Travel])) over() as "Satisfaction Percentage"
from [Airline passenger satisfaction].dbo.airline_passenger_satisfaction
group by [Type of Travel], [Satisfaction] ,[Class]

-- percentage of passenger satisfied by Class --
select  [Class],
        count([Class]) as "Class Count", Satisfaction,
        count([Class]) * 100.0  / Sum(count([Class])) over() as "Satisfaction Percentage"
from [Airline passenger satisfaction].dbo.airline_passenger_satisfaction
group by [Class],[Satisfaction]
order by [Class]

---Average Ratings---
select [Satisfaction],
       AVG(Cast([Departure and Arrival Time Convenience] AS int)) as "Departure and Arrival Time Convenience" , 
       AVG(Cast([Ease of Online Booking] As int)) as "Ease of Online Booking",
	   Avg(Cast([Check-in Service] As int)) as "Check-in Service",
	   Avg(Cast([Online Boarding] As int)) as "Online Boarding",
	   Avg(Cast([Gate Location] As int)) as "Gate Location",
	   Avg(Cast([On-board Service] As int)) as "On-board Service",
	   Avg(Cast([Seat Comfort] As int)) as "Seat Comfort",
	   Avg(Cast([Leg Room Service] As int)) as "Leg Room Service",
	   Avg(Cast([Cleanliness] As int)) as "Cleanliness",
	   Avg(Cast([Food and Drink] As int)) as "Food and Drink",
	   Avg(Cast([In-flight Service] As int)) as "In-flight Service",
	   Avg(Cast([In-flight Service] As int)) as "In-flight Service",
	   Avg(Cast([In-flight Service] As int)) as "In-flight Service",
	   Avg(Cast([Baggage Handling] As int)) as "Baggage Handling"	   
from [Airline passenger satisfaction].dbo.airline_passenger_satisfaction
group by [Satisfaction]


-- max & min Flight distance--
select max(Cast([Flight Distance] AS int)) as " Fl.Dist Max", 
       min(Cast([Flight Distance] AS int)) as " Fl.Dist Min",
	   avg(cast([Flight Distance] As int)) as "Fl.Dist Avg"
from [Airline passenger satisfaction].dbo.airline_passenger_satisfaction

-- Departure & arrival delay --
select max(Cast([Departure Delay] AS int)) as " Dep.Delay Max", 
       min(Cast([Departure Delay] AS int)) as " Dep.Delay Min",
	   max(Cast([Arrival Delay] AS int)) as " Arr.Delay Max", 
       min(Cast([Arrival Delay] AS int)) as " Arr.Delay Min"
from [Airline passenger satisfaction].dbo.airline_passenger_satisfaction
where [Departure Delay]>0 AND [Arrival Delay]>0
group by Satisfaction

