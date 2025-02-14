# Population-Data-Analysis

## Table of Contents

- [Overview](#overview)
- [Data Sources](#data-sources)
- [Tools](#tools)
- [Data Cleaning](#data-cleaning)
- [Data Analysis](#data-analysis)
- [Key Findings](#key-findings)
- [Conclusion](#conclusion)

### Overview

The dataset is from The World Bank and looks at Population for the world over time, spanning from 1960 to 2023. It looks at world population by Region, Year, Country Name, Country Code and shows trends by five year bands.

![World Population](https://github.com/user-attachments/assets/caca2faa-0d6b-43ee-9258-31c2fd1942ea)

### Data Sources

Population Analysis data: The primary dataset used for this analysis is the "API_SP.POP.TOTL_DS2_en_excel_v2_287.xlsx" file from The World Bank, containing detailed information on world population from 1960 to 2023 by Country, Country Code, Indicator Code, Year

### Tools

- SQL Server
- Microsoft Power BI
- Python

### Data Cleaning

- Loading and inspecting the data
- Handling missing values
- Data Cleaning and formatting

```python
# 'dataset' holds the input data for this script
import pandas as pd

# Convert dataset into DataFrame
df = dataset

# Define a list of non-country regions to remove
non_countries = [
    "World","Lower middle income","Least developed countries: UN classification", "High income", "Low income", "Middle income", "Euro area", "European Union",
    "East Asia & Pacific", "Europe & Central Asia", "Latin America & Caribbean", 
    "North America", "South Asia", "Sub-Saharan Africa","Small states","Europe & Central Asia (IDA & IBRD countries)",
"Other small states","Central Europe and the Baltics","Middle East & North Africa (excluding high income)"
]

# Filter out rows where "Country Name" matches the non-country list
df = df[~df["Country Name"].isin(non_countries)]

# Return the cleaned dataset
df
```

### Data Analysis

```sql
BEGIN TRY 
    DROP TABLE #WorldPopulation; 
END TRY 
BEGIN CATCH 
    -- Handle errors if the table doesn't exist
END CATCH;

-- Create the temporary table and populate it with data
SELECT * 
INTO #WorldPopulation
FROM [dbo].[WorldPopulation];

-- Unpivot the data
SELECT 
    [Country Name], 
    [Country Code], 
    Year, 
	--Creating 5 Year Categories
	CASE 
	WHEN Year BETWEEN 1960 AND 1964 THEN '1960-1964'
	WHEN Year BETWEEN 1960 AND 1969 THEN '1965-1969'
	WHEN Year BETWEEN 1960 AND 1974 THEN '1970-1974'
	WHEN Year BETWEEN 1960 AND 1979 THEN '1975-1979'
	WHEN Year BETWEEN 1960 AND 1984 THEN '1980-1984'
	WHEN Year BETWEEN 1960 AND 1989 THEN '1985-1989'
	WHEN Year BETWEEN 1960 AND 1994 THEN '1990-1994'
	WHEN Year BETWEEN 1960 AND 1999 THEN '1995-1999'
	WHEN Year BETWEEN 1960 AND 2004 THEN '2000-2004'
	WHEN Year BETWEEN 1960 AND 2009 THEN '2005-2009'
	WHEN Year BETWEEN 1960 AND 2014 THEN '2010-2014'
	WHEN Year BETWEEN 1960 AND 2019 THEN '2015-2019'
	WHEN Year BETWEEN 1960 AND 2024 THEN '2020-2024'
	END AS [YearCategory],
    [Indicator Name], 
    [Indicator Code], 
    Population

INTO WorldPopulation_Cleaned 
FROM #WorldPopulation
UNPIVOT (
    Population FOR Year IN (
        [1960], [1961], [1962], [1963], [1964], [1965], [1966], [1967], [1968], [1969], 
        [1970], [1971], [1972], [1973], [1974], [1975], [1976], [1977], [1978], [1979], 
        [1980], [1981], [1982], [1983], [1984], [1985], [1986], [1987], [1988], [1989], 
        [1990], [1991], [1992], [1993], [1994], [1995], [1996], [1997], [1998], [1999], 
        [2000], [2001], [2002], [2003], [2004], [2005], [2006], [2007], [2008], [2009], 
        [2010], [2011], [2012], [2013], [2014], [2015], [2016], [2017], [2018], [2019], 
        [2020], [2021], [2022], [2023]
    )
) AS Unpvt;
```
Map Showing Population

![map](https://github.com/user-attachments/assets/f987692c-3eda-4261-9efd-6aa271126c4f)

Top 10 Countries by Population

![top_10](https://github.com/user-attachments/assets/a10bcab1-7fd1-4c0c-bb94-a4d1f9aad793)

World Population (Billions) by 5 year bands

![5_year_bands](https://github.com/user-attachments/assets/1c739c3e-60b3-4820-997a-0abb1585f84d)

World population by Countries 

![countries](https://github.com/user-attachments/assets/f0162020-59cc-48f3-bb51-b7dbb6f41f54)

World Population Trends

![Trends](https://github.com/user-attachments/assets/07055711-0d8b-4993-a19d-94b3b19d1d67)

### Key Findings

- **Top 10 Countries**
- In ascending order India, China, United States, Indonesia, Pakistan, Nigeria, Brazil, Bangladesh, Russian Federation, Mexico are the most populated in the world

- **Bottom 10 Countries**
- In ascending order Tuvalu, Nauri, Palau, St. Martin, San Marino, etc are among the least populated in the world

- **Asia**
- Asian countries have a larger population compared to the rest of the world

- **Population Proportions**
- India and China have 35% of the World's population
- India has the highest population (17.89%)

- **Population Difference**
- The World's population has increased by 1.4 billion from 1960 to 2023

![pie](https://github.com/user-attachments/assets/61b0768c-3865-4290-bc80-752562c040f0)


### Conclusion

Although this analysis gave insights, there is a need to access micro data to further understand contrubuting factors towards population growth. This can further enhance the analysis through the use of machine learning models in order to predict the world population.


