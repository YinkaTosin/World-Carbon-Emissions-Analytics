CREATE  DATABASE Climate_data;
USE Climate_data;

CREATE TABLE World_Emissions(
  country VARCHAR(100),
  year INT,
  iso_code VARCHAR(100),
  population BIGINT,
  gdp BIGINT,
  co2 FLOAT,
  co2_including_luc FLOAT,
  co2_per_capita FLOAT,
  co2_per_gdp FLOAT,
  coal_co2 FLOAT,
  coal_co2_per_capita FLOAT,
  consumption_co2 FLOAT,
  cumulative_co2 FLOAT,
  gas_co2 FLOAT,
  gas_co2_per_capita FLOAT,
  land_use_change_co2 FLOAT,
  methane FLOAT,
  methane_per_capita FLOAT,
  nitrous_oxide FLOAT,
  nitrous_oxide_per_capita FLOAT,
  oil_co2 FLOAT,
  oil_co2_per_capita FLOAT,
  primary_energy_consumption FLOAT,
  total_ghg FLOAT,
  trade_co2 FLOAT,
  PRIMARY KEY (country, year)
);

SELECT COUNT(*) AS Total_rows
FROM world_emissions;

SELECT COUNT(*) AS Total_columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_schema = 'climate_data'
	AND table_name = 'world_emissions';

-- Global CO2 Emissions Over Time
SELECT year, SUM(co2) AS Total_CO2
FROM world_emissions
WHERE YEAR BETWEEN 2000 AND 2020
	AND country NOT IN (
    'Africa', 'Africa (GCP)', 'Antarctica', 'Asia', 'Asia (GCP)', 'Asia (excl. China and India)', 'Bonaire Sint Eustatius and Saba', 'Central America (GCP)', 'Christmas Island', 'Cook Islands','Europe', 'Europe (GCP)', 'Europe (excl. EU-27)',
    'Europe (excl. EU-28)', 'European Union (27)', 'European Union (28)', 'High-income countries', 'International aviation', 'International shipping', 'International transport', 'Kuwaiti Oil Fires', 'Kuwaiti Oil Fires (GCP)',
    'Least developed countries (Jones et al.)', 'Low-income countries', 'Lower-middle-income countries', 'Middle East (GCP)', 'Montserrat', 'Niue', 'Non-OECD (GCP)', 'North America', 'North America (GCP)','North America (excl. USA)', 
    'OECD (GCP)', 'OECD (Jones et al.)', 'Oceania', 'Oceania (GCP)', 'Ryukyu Islands', 'Ryukyu Islands (GCP)', 'Saint Pierre and Miquelon', 'South America', 'South America (GCP)', 'Upper-middle-income countries', 'World'
    )
GROUP BY year
ORDER BY YEAR;

-- Top Emitters in 2020
SELECT country, co2
FROM world_emissions
WHERE year = 2020 
	AND co2 IS NOT NULL
   AND country NOT IN (
    'Africa', 'Africa (GCP)', 'Antarctica', 'Asia', 'Asia (GCP)', 'Asia (excl. China and India)', 'Bonaire Sint Eustatius and Saba', 'Central America (GCP)', 'Christmas Island', 'Cook Islands','Europe', 'Europe (GCP)', 'Europe (excl. EU-27)',
    'Europe (excl. EU-28)', 'European Union (27)', 'European Union (28)', 'High-income countries', 'International aviation', 'International shipping', 'International transport', 'Kuwaiti Oil Fires', 'Kuwaiti Oil Fires (GCP)',
    'Least developed countries (Jones et al.)', 'Low-income countries', 'Lower-middle-income countries', 'Middle East (GCP)', 'Montserrat', 'Niue', 'Non-OECD (GCP)', 'North America', 'North America (GCP)','North America (excl. USA)', 
    'OECD (GCP)', 'OECD (Jones et al.)', 'Oceania', 'Oceania (GCP)', 'Ryukyu Islands', 'Ryukyu Islands (GCP)', 'Saint Pierre and Miquelon', 'South America', 'South America (GCP)', 'Upper-middle-income countries', 'World'
    )
ORDER BY co2 DESC
LIMIT 10;

-- GDP vs CO2 (All Countries, 2000 - 2020)
SELECT year, SUM(gdp) AS Total_gdp, SUM(co2) AS Total_co2
FROM world_emissions
WHERE year BETWEEN 2000 AND 2020
	AND country NOT IN (
    'Africa', 'Africa (GCP)', 'Antarctica', 'Asia', 'Asia (GCP)', 'Asia (excl. China and India)', 'Bonaire Sint Eustatius and Saba', 'Central America (GCP)', 'Christmas Island', 'Cook Islands','Europe', 'Europe (GCP)', 'Europe (excl. EU-27)',
    'Europe (excl. EU-28)', 'European Union (27)', 'European Union (28)', 'High-income countries', 'International aviation', 'International shipping', 'International transport', 'Kuwaiti Oil Fires', 'Kuwaiti Oil Fires (GCP)',
    'Least developed countries (Jones et al.)', 'Low-income countries', 'Lower-middle-income countries', 'Middle East (GCP)', 'Montserrat', 'Niue', 'Non-OECD (GCP)', 'North America', 'North America (GCP)','North America (excl. USA)', 
    'OECD (GCP)', 'OECD (Jones et al.)', 'Oceania', 'Oceania (GCP)', 'Ryukyu Islands', 'Ryukyu Islands (GCP)', 'Saint Pierre and Miquelon', 'South America', 'South America (GCP)', 'Upper-middle-income countries', 'World'
    )
	AND gdp IS NOT NULL
    AND co2 IS NOT NULL
GROUP BY year
ORDER BY year;

-- Greenhouse Gas Comparison
SELECT country, year, co2, methane, nitrous_oxide
FROM world_emissions
	WHERE co2 IS NOT NULL
    AND country NOT IN (
    'Africa', 'Africa (GCP)', 'Antarctica', 'Asia', 'Asia (GCP)', 'Asia (excl. China and India)', 'Bonaire Sint Eustatius and Saba', 'Central America (GCP)', 'Christmas Island', 'Cook Islands','Europe', 'Europe (GCP)', 'Europe (excl. EU-27)',
    'Europe (excl. EU-28)', 'European Union (27)', 'European Union (28)', 'High-income countries', 'International aviation', 'International shipping', 'International transport', 'Kuwaiti Oil Fires', 'Kuwaiti Oil Fires (GCP)',
    'Least developed countries (Jones et al.)', 'Low-income countries', 'Lower-middle-income countries', 'Middle East (GCP)', 'Montserrat', 'Niue', 'Non-OECD (GCP)', 'North America', 'North America (GCP)','North America (excl. USA)', 
    'OECD (GCP)', 'OECD (Jones et al.)', 'Oceania', 'Oceania (GCP)', 'Ryukyu Islands', 'Ryukyu Islands (GCP)', 'Saint Pierre and Miquelon', 'South America', 'South America (GCP)', 'Upper-middle-income countries', 'World'
    )   
ORDER BY co2 DESC;


-- Energy Use vs GHG Emissions Over Time
SELECT 
	year,
    SUM(primary_energy_consumption) AS Total_Energy_Consumption,
    SUM(total_ghg) AS Total_GHG_Emissions
FROM world_emissions
WHERE year BETWEEN 2000 AND 2020
	AND country NOT IN (
    'Africa', 'Africa (GCP)', 'Antarctica', 'Asia', 'Asia (GCP)', 'Asia (excl. China and India)', 'Bonaire Sint Eustatius and Saba', 'Central America (GCP)', 'Christmas Island', 'Cook Islands','Europe', 'Europe (GCP)', 'Europe (excl. EU-27)',
    'Europe (excl. EU-28)', 'European Union (27)', 'European Union (28)', 'High-income countries', 'International aviation', 'International shipping', 'International transport', 'Kuwaiti Oil Fires', 'Kuwaiti Oil Fires (GCP)',
    'Least developed countries (Jones et al.)', 'Low-income countries', 'Lower-middle-income countries', 'Middle East (GCP)', 'Montserrat', 'Niue', 'Non-OECD (GCP)', 'North America', 'North America (GCP)','North America (excl. USA)', 
    'OECD (GCP)', 'OECD (Jones et al.)', 'Oceania', 'Oceania (GCP)', 'Ryukyu Islands', 'Ryukyu Islands (GCP)', 'Saint Pierre and Miquelon', 'South America', 'South America (GCP)', 'Upper-middle-income countries', 'World'
    )
	AND primary_energy_consumption IS NOT NULL
    AND total_ghg IS NOT NULL
GROUP BY year
ORDER BY year;

-- Decoupling Analysis
SELECT
	country,
    SUM(CASE WHEN year = 2000 THEN gdp END) AS GDP_2000,
	SUM(CASE WHEN year = 2020 THEN gdp END) AS GDP_2020,
	SUM(CASE WHEN year = 2000 THEN co2 END) AS CO2_2000,
	SUM(CASE WHEN year = 2020 THEN co2 END) AS CO2_2020
FROM world_emissions
WHERE year IN (2000, 2020)
	AND country NOT IN (
    'Africa', 'Africa (GCP)', 'Antarctica', 'Asia', 'Asia (GCP)', 'Asia (excl. China and India)', 'Bonaire Sint Eustatius and Saba', 'Central America (GCP)', 'Christmas Island', 'Cook Islands','Europe', 'Europe (GCP)', 'Europe (excl. EU-27)',
    'Europe (excl. EU-28)', 'European Union (27)', 'European Union (28)', 'High-income countries', 'International aviation', 'International shipping', 'International transport', 'Kuwaiti Oil Fires', 'Kuwaiti Oil Fires (GCP)',
    'Least developed countries (Jones et al.)', 'Low-income countries', 'Lower-middle-income countries', 'Middle East (GCP)', 'Montserrat', 'Niue', 'Non-OECD (GCP)', 'North America', 'North America (GCP)','North America (excl. USA)', 
    'OECD (GCP)', 'OECD (Jones et al.)', 'Oceania', 'Oceania (GCP)', 'Ryukyu Islands', 'Ryukyu Islands (GCP)', 'Saint Pierre and Miquelon', 'South America', 'South America (GCP)', 'Upper-middle-income countries', 'World'
    )
GROUP BY country
HAVING GDP_2020 > GDP_2000 AND CO2_2020 < co2_2000;

SELECT 
country,
year,
SUM(co2) AS Total_CO2
FROM world_emissions
WHERE year BETWEEN 2000 AND 2020
	AND country NOT IN (
    'Africa', 'Africa (GCP)', 'Antarctica', 'Asia', 'Asia (GCP)', 'Asia (excl. China and India)', 'Bonaire Sint Eustatius and Saba', 'Central America (GCP)', 'Christmas Island', 'Cook Islands','Europe', 'Europe (GCP)', 'Europe (excl. EU-27)',
    'Europe (excl. EU-28)', 'European Union (27)', 'European Union (28)', 'High-income countries', 'International aviation', 'International shipping', 'International transport', 'Kuwaiti Oil Fires', 'Kuwaiti Oil Fires (GCP)',
    'Least developed countries (Jones et al.)', 'Low-income countries', 'Lower-middle-income countries', 'Middle East (GCP)', 'Montserrat', 'Niue', 'Non-OECD (GCP)', 'North America', 'North America (GCP)','North America (excl. USA)', 
    'OECD (GCP)', 'OECD (Jones et al.)', 'Oceania', 'Oceania (GCP)', 'Ryukyu Islands', 'Ryukyu Islands (GCP)', 'Saint Pierre and Miquelon', 'South America', 'South America (GCP)', 'Upper-middle-income countries', 'World'
    )
GROUP BY country, year;

-- Land Use Change vs Region
SELECT
	country AS region,
    year,
	SUM(land_use_change_co2) AS Total_Land_Use_CO2,
	SUM(co2) AS Total_CO2,
	ROUND(
			(SUM(land_use_change_co2) / NULLIF (SUM(co2), 0)), 
            2) AS Land_Use_Share_Percent
FROM world_emissions
WHERE year BETWEEN 2000 AND 2020
	AND country IN (
    'Africa', 'Asia', 'Europe', 'North America', 'South America', 'Oceania'
    )
GROUP BY country, year
ORDER BY year, country; 

SELECT 
country,
year,
sum(co2) AS Total_CO2
FROM world_emissions
WHERE year BETWEEN 2000 AND 2020
	AND country NOT IN (
    'Africa', 'Africa (GCP)', 'Antarctica', 'Asia', 'Asia (GCP)', 'Asia (excl. China and India)', 'Bonaire Sint Eustatius and Saba', 'Central America (GCP)', 'Christmas Island', 'Cook Islands','Europe', 'Europe (GCP)', 'Europe (excl. EU-27)',
    'Europe (excl. EU-28)', 'European Union (27)', 'European Union (28)', 'High-income countries', 'International aviation', 'International shipping', 'International transport', 'Kuwaiti Oil Fires', 'Kuwaiti Oil Fires (GCP)',
    'Least developed countries (Jones et al.)', 'Low-income countries', 'Lower-middle-income countries', 'Middle East (GCP)', 'Montserrat', 'Niue', 'Non-OECD (GCP)', 'North America', 'North America (GCP)','North America (excl. USA)', 
    'OECD (GCP)', 'OECD (Jones et al.)', 'Oceania', 'Oceania (GCP)', 'Ryukyu Islands', 'Ryukyu Islands (GCP)', 'Saint Pierre and Miquelon', 'South America', 'South America (GCP)', 'Upper-middle-income countries', 'World'
    )
GROUP BY country, year
ORDER BY year, Total_CO2 DESC;    

CREATE TABLE Country_Table AS
SELECT DISTINCT country
FROM world_emissions
WHERE country NOT IN (
    'Africa', 'Africa (GCP)', 'Antarctica', 'Asia', 'Asia (GCP)', 'Asia (excl. China and India)', 'Bonaire Sint Eustatius and Saba', 'Central America (GCP)', 'Christmas Island', 'Cook Islands','Europe', 'Europe (GCP)', 'Europe (excl. EU-27)',
    'Europe (excl. EU-28)', 'European Union (27)', 'European Union (28)', 'High-income countries', 'International aviation', 'International shipping', 'International transport', 'Kuwaiti Oil Fires', 'Kuwaiti Oil Fires (GCP)',
    'Least developed countries (Jones et al.)', 'Low-income countries', 'Lower-middle-income countries', 'Middle East (GCP)', 'Montserrat', 'Niue', 'Non-OECD (GCP)', 'North America', 'North America (GCP)','North America (excl. USA)', 
    'OECD (GCP)', 'OECD (Jones et al.)', 'Oceania', 'Oceania (GCP)', 'Ryukyu Islands', 'Ryukyu Islands (GCP)', 'Saint Pierre and Miquelon', 'South America', 'South America (GCP)', 'Upper-middle-income countries', 'World'
    )
ORDER BY country;    

-- Ranking Countries by CO2 Emissions
SELECT
	country,
    year,
    co2
FROM world_emissions
WHERE country NOT IN (
    'Africa', 'Africa (GCP)', 'Antarctica', 'Asia', 'Asia (GCP)', 'Asia (excl. China and India)', 'Bonaire Sint Eustatius and Saba', 'Central America (GCP)', 'Christmas Island', 'Cook Islands','Europe', 'Europe (GCP)', 'Europe (excl. EU-27)',
    'Europe (excl. EU-28)', 'European Union (27)', 'European Union (28)', 'High-income countries', 'International aviation', 'International shipping', 'International transport', 'Kuwaiti Oil Fires', 'Kuwaiti Oil Fires (GCP)',
    'Least developed countries (Jones et al.)', 'Low-income countries', 'Lower-middle-income countries', 'Middle East (GCP)', 'Montserrat', 'Niue', 'Non-OECD (GCP)', 'North America', 'North America (GCP)','North America (excl. USA)', 
    'OECD (GCP)', 'OECD (Jones et al.)', 'Oceania', 'Oceania (GCP)', 'Ryukyu Islands', 'Ryukyu Islands (GCP)', 'Saint Pierre and Miquelon', 'South America', 'South America (GCP)', 'Upper-middle-income countries', 'World'
    )
    AND co2 IS NOT NULL
    AND co2 > 0;

SELECT COUNT(*) AS Total_rows
FROM world_emissions;
