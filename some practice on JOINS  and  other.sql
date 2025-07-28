
SELECT  * FROM country;

CREATE VIEW null_independent_year AS
SELECT * FROM country WHERE IndepYear IS NULL;

SELECT * FROM null_independent_year;


DROP PROCEDURE IF EXISTS  Top_Populated_European_Countries;

CREATE PROCEDURE Top_Populated_European_Countries()
SELECT *  FROM country WHERE Continent = "Europe" AND Population > 50000000;

CALL Top_Populated_European_Countries;

SELECT * FROM city;

SELECT  * FROM country;

SELECT * FROM countrylanguage;

SELECT c.Name, c.Continent, C.region,  cl.Language, cl.Percentage, ct.Name, ct.District
FROM country c INNER JOIN countrylanguage  cl
ON c.Code = cl.CountryCode
INNER JOIN city ct
ON  ct.CountryCode=c.Code
WHERE C.Region =  "Middle East";



SELECT * FROM city;

SELECT  * FROM country;

SELECT * FROM countrylanguage;


SELECT DISTINCT C.Name, C.SurfaceArea, C.population, C.LifeExpectancy, cl.Language, cl.Percentage, ct.District, ct.Population
FROM country C INNER JOIN countrylanguage cl
ON C.Code  = cl.CountryCode
INNER  JOIN city ct 
ON  cl.CountryCode = ct.CountryCode
WHERE C.Continent = "Asia";




SELECT DISTINCT C.Name, C.SurfaceArea, C.population, C.HeadOfState, cl.Language, cl.Percentage, ct.District, ct.Population
FROM country C LEFT JOIN countrylanguage cl
ON C.Code  = cl.CountryCode
LEFT  JOIN city ct 
ON  cl.CountryCode = ct.CountryCode
WHERE C.Continent = "Europe";



SELECT AVG(CGPA) AS avg_gpa, MAX(CGPA) AS high_gpa, AVG(Work_Study_Hours), MAX(Age), City
FROM students_dep_analysis
WHERE suicidal_thoughts = "No" AND Family_Mental_Illness = "No"
GROUP BY  City
ORDER BY avg_gpa DESC;



SELECT MIN(CGPA), City
FROM students_dep_analysis
GROUP BY City;