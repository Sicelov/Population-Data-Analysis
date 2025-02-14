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