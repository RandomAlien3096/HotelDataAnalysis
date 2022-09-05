with hotels as (				--grabs all the tables and joins them as one
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union
select * from dbo.['2020$'])

select				--select two columns (arrival_date_year and revenue)
arrival_date_year,
hotel,
round(sum((stays_in_week_nights + stays_in_weekend_nights) * adr),2) as revenue
/*	stays_in_week_nights + stays_in_weekend_nights --> joins theses columns
	* adr --> multiplies the joined columns to adr (average daily rate) to find the revenue
	as revenue --> gives the final column a name
	sum(everything) sums everything whithin a group, i
	n this case, by year 
	*/
from hotels
group by arrival_date_year, hotel

-- joins the main table with market segment column

select * from hotels
left join dbo.market_segment$
on hotels.market_segment = market_segment$.market_segment
left join dbo.meal_cost$
on meal_cost$.meal  =hotels.meal