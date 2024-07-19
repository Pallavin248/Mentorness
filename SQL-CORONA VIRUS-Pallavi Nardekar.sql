SELECT *
  FROM [model].[dbo].[Corona Virus Dataset]

    -- Q1 Write a code to check NULL values
SELECT 
  COUNT(*) AS total_null_values
  FROM
  [model].[dbo].[Corona Virus Dataset]
  WHERE
  Province is NULL
  OR 'Country/Region' IS NULL
  OR Latitude IS NULL
  OR Longitude IS NULL
  OR Date IS NULL
 OR Confirmed IS NULL
 OR Deaths IS NULL
 OR Recovered IS NULL;

 --OR
  SELECT
Sum(case when Province is null then 1 else 0 end) as Province_1,
Sum(case when [Country Region] is null then 1 else 0 end) as Country_Region_1,
Sum(case when Latitude is null then 1 else 0 end) as Latitude_1,
Sum(case when Longitude is null then 1 else 0 end) as Longitude_1,
Sum(case when Date is null then 1 else 0 end) as Date_1,
Sum(case when Confirmed is null then 1 else 0 end) as Confirmed_1,
Sum(case when Deaths is null then 1 else 0 end) as Deaths_1,
Sum(case when Recovered is null then 1 else 0 end) as Recovered_1
FROM [model].[dbo].[Corona Virus Dataset];


 -- Q2 If NULL values are present, update then with zeros for all columns.
 --There are no null values present in data

 UPDATE  
 [model].[dbo].[Corona Virus Dataset]
  SET 
  Province = COALESCE(Province, '0'),
  'Country/Region' = COALESCE('Country/Region', '0'),
  Latitude = COALESCE[Latitude, 0],
  Longitude = COALESCE[Longitude, 0],
  Date = COALESCE[Date, '0000-01-01'],
  Confirmed = COALESCE[Confirmed, 0],
  Deaths = COALESCE[Deaths, 0],
  Recovered = COALESCE[Recovered, 0];
  WHERE
  ID>0 ;

  --Q3 Check total number of rows
  SELECT 
  COUNT(*) AS total_rows
  FROM
   [model].[dbo].[Corona Virus Dataset];

   --Q4 Check what is start_date and end_date
   SELECT 
   MIN(Date) as start_date,
   MAX(Date) as end_date
   FROM
    [model].[dbo].[Corona Virus Dataset];

	--Q5 Number of month present in dataset 
	 SELECT COUNT(DISTINCT MONTH(Date)) AS num_months
FROM [model].[dbo].[Corona Virus Dataset];

--Q6 Find monthly average for confirmed, deaths, recovered

SELECT 
    MONTH(Date) AS Month,
    AVG(Confirmed) AS AvgConfirmed,
    AVG(Deaths) AS AvgDeaths,
	AVG(Recovered) AS AvgRecovered
FROM [model].[dbo].[Corona Virus Dataset]
GROUP BY MONTH(Date)
ORDER BY Month;

--Q7 Find most frequent value for confirmed, deaths, recovered each month

SELECT YEAR(date) AS year, MONTH(date) AS month,
       MAX(Confirmed) AS most_frequent_confirmed,
       MAX(Deaths) AS most_frequent_deaths,
       MAX(Recovered) AS most_frequent_recovered
FROM [model].[dbo].[Corona Virus Dataset]
GROUP BY YEAR(date), MONTH(date);

--Q8 Find minimum values for confirmed, deaths, recovered per year 
SELECT
YEAR(Date) AS year,
MIN(Confirmed) AS min_confirmed,
MIN(Deaths) AS min_deaths,
MIN(Recovered) AS min_recovered
FROM [model].[dbo].[Corona Virus Dataset]
GROUP BY
year(Date);


--Q9 Find maximum values for confirmed, deaths, recovered per year 
SELECT
YEAR(Date) AS year,
MAX(Confirmed) AS max_confirmed,
MAX(Deaths) AS max_deaths,
MAX(Recovered) AS max_recovered
FROM [model].[dbo].[Corona Virus Dataset]
GROUP BY
year(Date);

--Q10 The total number of case of confirmed, deaths, recovered each month

SELECT 
    MONTH(Date) AS Month,
    SUM(Confirmed) AS TotalConfirmed,
    SUM(Deaths) AS TotalDeaths,
    SUM(Recovered) AS TotalRecovered
FROM [model].[dbo].[Corona Virus Dataset]
GROUP BY  MONTH(Date)
ORDER BY Month;


--Q11 Check how corona virus spread out with respect to confirmed case
---(EG.: total confirmed cases, their average, variance & std dev)

SELECT
COUNT(Confirmed) as total_confirmed_cases,
AVG(Confirmed) as average_confirmed_cases,
VAR(Confirmed) as variance_confirmed_cases,
STDEV(Confirmed) as stddev_confirmed_cases
FROM [model].[dbo].[Corona Virus Dataset]


--Q12 Check how corona virus spread out with respect to death case per month
-- (Eg.: total confirmed cases, their average, variance &stddev)
SELECT 
    YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    COUNT(Deaths) AS TotalDeaths,
    AVG(Deaths) AS AverageDeaths,
    VAR(Deaths) AS VarianceDeaths,
    STDEV(Deaths) AS StdevDeaths
FROM [model].[dbo].[Corona Virus Dataset]
GROUP BY YEAR(Date), MONTH(Date)
ORDER BY Year,Month;


--Q13 Check how corona virus spread out with respect to recovered case
-- (Eg.: total confirmed cases, their average, variance &stddev)
SELECT 
COUNT(Recovered) AS total_recovered_cases,
AVG(Recovered) AS average_recovered_cases,
VAR(Recovered) as variance_recovered_cases,
STDEV(Recovered) as stddev_recovered_cases
FROM [model].[dbo].[Corona Virus Dataset]


--Q14 Find Country having highest number of the Confirmed case 

SELECT TOP 1
    [Country Region],
    SUM(Confirmed) AS TotalConfirmed
FROM [model].[dbo].[Corona Virus Dataset]
GROUP BY [Country Region]
ORDER BY TotalConfirmed DESC;


--Q15 Find Country having lowest number of the death case 

SELECT TOP 1
    [Country Region],
    SUM(Deaths) AS TotalDeaths
FROM [model].[dbo].[Corona Virus Dataset]
GROUP BY [Country Region]
ORDER BY TotalDeaths ASC;


-- Q16. Find top 5 countries having highest recovered case

SELECT TOP 5
    [Country Region],
    SUM(Recovered) AS TotalRecovered
FROM [model].[dbo].[Corona Virus Dataset]
GROUP BY [Country Region]
ORDER BY TotalRecovered DESC;