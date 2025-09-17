-- This SQL script below was written in MotherDuck to query the weather data that was ingested from MongoDB Atlas Cloud using Airbyte.
-- The data was fetched from weatherbit.io API using a Python script (ingest_weather_api.py) and stored in a MongoDB database.
-- Airbyte was then used to connect to the MongoDB Atlas Cloud and transfer the data to MotherDuck for analysis and visualisation.
-- The script below includes various queries to retrieve and analyze weather data, such as temperature, wind speed, and weather conditions for different cities and dates.

-- show all data in the weather table
SELECT * FROM weather;

-- This query retrieves the date/time, city, country, and temperature (rounded to one decimal place) for all weather records in Accra, sorted from most recent to oldest. 
-- Also provides the weather forecast for that city 
SELECT dt as data_time, city, country, ROUND(temp_c,1) as temperature from weather
WHERE city = 'Johannesburg' -- entering the specific city (e.g Accra, Lagos, Johannesburg)
ORDER BY data_time DESC;

-- Getting the average temperature for all cities on each day, along with the highest and lowest temperatures recorded per day.
SELECT city, DATE(dt) AS date, ROUND(AVG(temp_c), 1) AS average_temperature, ROUND(MAX(temp_c), 1) AS maximum_temperature, ROUND(MIN(temp_c), 1) AS maximum_temperature
FROM weather
GROUP BY city, date
ORDER BY date DESC, average_temperature DESC;

-- This query provides the average weather for that city for each day
SELECT city, DATE(dt) AS date, ROUND(AVG(temp_c), 1) AS average_temperature
FROM weather
WHERE city = 'Accra'
GROUP BY city, date
ORDER BY date DESC;

-- This query retrieve a clean, readable summary of weather data per each day, hour and for each city, including temperature, feels-like temperature, 
-- wind speed, and weather conditions, with the temperature and wind speed values rounded by 1 decimal place.
-- Also provides the weather forecast for each day, per hour, and for each city
SELECT dt as date, city, ROUND(temp_c,1) AS temperature, ROUND(feels_like_c,1) as feels_like, ROUND(wind_ms,2) as wind_speed, conditions
FROM weather
ORDER BY date DESC;

-- This query is to get data about wind gust, wind speed and which direcction the wind is coming from
SELECT dt as date, city, country, wind_cdir as wind_direction, wind_cdir_full as wind_direction_full, ROUND(wind_ms,2) as wind_speed, ROUND(wind_gust_ms,2) as wind_gust_speed
FROM weather
ORDER BY date DESC;

-- This query is to get data for average wind gust and wind speed for that city for that day
SELECT DATE(dt) as date, city, country, ROUND(AVG(wind_ms),2) as avg_wind_speed, ROUND(AVG(wind_gust_ms),2) as avg_wind_gust_speed
FROM weather
GROUP BY city, country, date
ORDER BY date DESC, avg_wind_speed DESC, avg_wind_gust_speed DESC;