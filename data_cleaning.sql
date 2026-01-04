--data cleaning

--1. remove duplicates if any
--2. standardize the data
--3. null values or blank values
--4. remove any uneccesary rows or columns

select *
from layoffs ;

--creating staging to work on


CREATE TABLE layoffs_staging (LIKE layoffs INCLUDING ALL);
 
--inserting data into staging table

insert into layoffs_staging
select company,
location,
industry,
total_laid_off,
percentage_laid_off,
date,
stage,
country,
funds_raised_millions
from layoffs ;

--check data insertion

select * from layoffs_staging;


--1. removing duplicates

--identifying duplicate

select *,
row_number() over(
partition by company,
industry,
total_laid_off,
percentage_laid_off,
'date'
) as row_num
from layoffs_staging;

with duplicate_cte as
(
select *,
row_number() over(
partition by company,location,
industry, total_laid_off,
percentage_laid_off, 'date',stage,
country, funds_raised_millions
) as row_num
from layoffs_staging
)
select *
from duplicate_cte
where row_num > 1;

--checking whether the duplicates are legit or not using a duplicate data

select *
from layoffs_staging
where company = 'ExtraHop';

--deleting duplicates

WITH duplicate_cte AS (
    SELECT ctid,
           ROW_NUMBER() OVER (
               PARTITION BY company,
                            location,
                            industry,
                            total_laid_off,
                            percentage_laid_off,
                            "date",
                            stage,
                            country,
                            funds_raised_millions
           ) AS row_num
    FROM layoffs_staging
)
DELETE FROM layoffs_staging
WHERE ctid IN (
    SELECT ctid
    FROM duplicate_cte
    WHERE row_num > 1
);

WITH duplicate_cte AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY company,
                            location,
                            industry,
                            total_laid_off,
                            percentage_laid_off,
                            "date",
                            stage,
                            country,
                            funds_raised_millions
           ) AS row_num
    FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

--confirming deletion

WITH duplicate_cte AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY company,
                            location,
                            industry,
                            total_laid_off,
                            percentage_laid_off,
                            "date",
                            stage,
                            country,
                            funds_raised_millions
           ) AS row_num
    FROM layoffs_staging
)
SELECT *
FROM duplicate_cte;
