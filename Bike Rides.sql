--understanding the data
select * from dbo.bike_share_yr_0;
select * from dbo.bike_share_yr_1;
select * from dbo.cost_table;

--Data Cleaning
--Checking for Nulls
select *
from dbo.bike_share_yr_0
where [dteday] is null 
	or [season] is null 
	or [yr] is null 
	or [mnth] is null 
	or [hr] is null 
	or [holiday] is null 
	or [weekday] is null 
	or [workingday] is null 
	or [weathersit] is null 
	or [temp] is null 
	or [atemp] is null 
	or [hum] is null 
	or [windspeed] is null 
	or [rider_type] is null 
	or [riders] is null; --Found no nulls in table bike_share_yr_0

select *
from dbo.bike_share_yr_1
where [dteday] is null 
	or [season] is null 
	or [yr] is null 
	or [mnth] is null 
	or [hr] is null 
	or [holiday] is null 
	or [weekday] is null 
	or [workingday] is null 
	or [weathersit] is null 
	or [temp] is null 
	or [atemp] is null 
	or [hum] is null 
	or [windspeed] is null 
	or [rider_type] is null 
	or [riders] is null; --Found no nulls in bike_share_yr_1


--Checking for duplicates
select *
from dbo.bike_share_yr_0
group by [dteday], [season], [yr], [mnth], [hr], [holiday], [weekday], 
         [workingday], [weathersit], [temp], [atemp], [hum], [windspeed], 
         [rider_type], [riders]
having COUNT(*) > 1; --No duplicates found

select *
from dbo.bike_share_yr_1
group by [dteday], [season], [yr], [mnth], [hr], [holiday], [weekday], 
         [workingday], [weathersit], [temp], [atemp], [hum], [windspeed], 
         [rider_type], [riders]
having COUNT(*) > 1; --No duplicates found


--Joining two tables
with cte as(
select * from dbo.bike_share_yr_0
union
select * from dbo.bike_share_yr_1)

--Querying for columns that I needed for further analysis
select dteday,
	season,
	a.yr,
	weekday,
	hr,
	riders,
	rider_type,
	price,
	COGS,
	(riders * price) as revenue,
	(riders * COGS) as expenses	
from cte a
left join
dbo.cost_table b
on a.yr = b.yr;

