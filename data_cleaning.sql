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


--standardizing data

SELECT DISTINCT company
FROM layoffs_staging
ORDER BY company;


UPDATE layoffs_staging
SET company  = TRIM(company),
    location = TRIM(location),
    industry = TRIM(industry),
    total_laid_off = TRIM(total_laid_off),
    percentage_laid_off = TRIM(percentage_laid_off),
    date = TRIM(date),
    stage = TRIM(stage),
    country  = TRIM(country),
    funds_raised_millions = TRIM(funds_raised_millions);


SELECT DISTINCT company, location, industry
FROM layoffs_staging
ORDER BY company, location;

SELECT DISTINCT  industry
FROM layoffs_staging
ORDER BY 1;


select *
from layoffs_staging 
where industry like 'Crypto%';

update layoffs_staging 
set industry = 'Crypto'
where industry like 'Crypto%';

SELECT DISTINCT  industry
FROM layoffs_staging;

select distinct country
from layoffs_staging
order by 1;

select *
from layoffs_staging
where country  like 'United States%';

select distinct country,
TRIM(trailing '.' from country)
from layoffs_staging
order by 1;

update layoffs_staging 
set country = TRIM(trailing '.' from country)
where country like 'United States%';


--time series

select date 
from layoffs_staging;


--changing the datatype of 'date' from VARCHAR to date

select date, pg_typeof(date)
from layoffs_staging;

update layoffs_staging 
set date = to_date(date, 'MM/DD/YYYY');

SELECT date, pg_typeof(date)
FROM layoffs_staging
where date is not null;

ALTER TABLE layoffs_staging
ALTER COLUMN date TYPE DATE;
 

--removing null values and blank values

select distinct industry 
from layoffs_staging 
;

update layoffs_staging 
set industry = null
where industry = '';

select *
from layoffs_staging 
where industry is null;

select *
from layoffs_staging 
where company = 'Airbnb';

SELECT t1.*, t2.*
FROM layoffs_staging t1
JOIN layoffs_staging t2
  ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
  AND t2.industry IS NOT NULL;

SELECT t1.industry AS t1_industry, t2.industry AS t2_industry
FROM layoffs_staging t1
JOIN layoffs_staging t2
  ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
  AND t2.industry IS NOT NULL;

UPDATE layoffs_staging t1
SET industry = t2.industry
FROM layoffs_staging t2
WHERE t1.company = t2.company
  AND t1.industry IS NULL
  AND t2.industry IS NOT NULL;

select *
from layoffs_staging 
where company like 'Bally%';
	
select * 
from layoffs_staging;


--removing unnecessary rows and columns 

select * 
from layoffs_staging
where total_laid_off is null 
	or percentage_laid_off is null;

delete 
from layoffs_staging
where total_laid_off is null 
	or percentage_laid_off is null;

select * 
from layoffs_staging;

alter table layoffs_staging
drop column row_num;

