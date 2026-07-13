CREATE DATABASE HOTEL_DB;

CREATE OR REPLACE FILE FORMAT FF_CSV
    TYPE = 'CSV'
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    SKIP_HEADER = 1
    NULl_IF = ('NULL', 'null', '')

CREATE OR REPLACE STAGE STG_HOTEL_BOOKINGS
    FILE_FORMAT = FF_CSV;

--BRONZE LAYER TABLE IS FOR STORING RAW_DATA

CREATE TABLE BRONZE_HOTEL_BOOKING(
    booking_id STRING,
    hotel_id STRING,
    hotel_city STRING,
    customer_id STRING,
    customer_name STRING,
    customer_email STRING,
    check_in_date STRING,
    check_out_date STRING,
    room_type STRING,
    num_guests STRING,
    total_amount STRING,
    currency STRING,
    booking_status STRING
); 

    COPY INTO BRONZE_HOTEL_BOOKING
    FROM @STG_HOTEL_BOOKINGS
    FILE_FORMAT = (FORMAT_NAME = FF_CSV)
    ON_ERROR = 'CONTINUE';

SELECT * FROM BRONZE_HOTEL_BOOKING
LIMIT 100;

--FIRST MOST STEP IS TO ASSIGN PROPER DATA TYPES FOR COLUMNS

CREATE OR REPLACE TABLE SILVER_HOTEL_BOOKING(
    booking_id VARCHAR,
    hotel_id VARCHAR,
    hotel_city VARCHAR,
    customer_id VARCHAR,
    customer_name VARCHAR,
    customer_email VARCHAR,
    check_in_date DATE,
    check_out_date DATE,
    room_type VARCHAR,
    num_guests INTEGER,
    total_amount FLOAT,
    currency VARCHAR,
    booking_status VARCHAR
);

--CHECKING FOR WRONG FORMATS, MISSING VALUES, TYPOS,etc

SELECT customer_email 
FROM BRONZE_HOTEL_BOOKING
WHERE NOT(customer_email LIKE '%@%.%')
    OR customer_email IS NULL;      --returned 401 rows

SELECT total_amount
FROM BRONZE_HOTEL_BOOKING
WHERE TRY_TO_NUMBER(total_amount) < 0;         --176 ROWS ARE NEGATIVE 

SELECT check_in_date, check_out_date 
FROM BRONZE_HOTEL_BOOKING
WHERE TRY_TO_DATE(check_out_date) < TRY_TO_DATE(check_in_date);         --42 ROWS , where check out date is less than check in date

SELECT DISTINCT booking_status
FROM BRONZE_HOTEL_BOOKING;      --SOME NULL, AND ONE TYPO (Confirmeeed)



--now inserting all data in new silve_hotel_booking table, checking data insertion is having no missing values, typos and wrong formats simultaneously

--AKA Filtering all data when inserting into SILVER_HOTEL_BOOKING



INSERT INTO SILVER_HOTEL_BOOKING
SELECT 
    booking_id,
    hotel_id,
    INITCAP(TRIM(hotel_city)) AS hotel_city,
    customer_id,
    INITCAP(TRIM(customer_name)) AS customer_name,
    CASE
        WHEN customer_email LIKE '%@%.%' THEN LOWER(TRIM(customer_email))
        ELSE NULL
    END AS customer_email,
    TRY_TO_DATE(NULLIF(check_in_date, '')) AS check_in_date,
    TRY_TO_DATE(NULLIF(check_out_date, '')) AS check_out_date,
    room_type,
    num_guests,
    ABS(TRY_TO_NUMBER(total_amount)) AS total_amount,
    currency,
    CASE
        WHEN LOWER(booking_status) IN ('confirmeed','confirmd') THEN 'Confirmed'
        ELSE booking_status
    END AS booking_status
FROM BRONZE_HOTEL_BOOKING
    WHERE
        TRY_TO_DATE(check_in_date) IS NOT NULL
        AND TRY_TO_DATE(check_out_date) IS NOT NULL
        AND TRY_TO_DATE(check_out_date) >= TRY_TO_DATE(check_in_date);


SELECT * FROM SILVER_HOTEL_BOOKING;

TRUNCATE TABLE SILVER_HOTEL_BOOKING;

INSERT INTO SILVER_HOTEL_BOOKING
SELECT
    booking_id,
    hotel_id,
    INITCAP(TRIM(hotel_city)) AS hotel_city,
    customer_id,
    INITCAP(TRIM(customer_name)) AS customer_name,

    CASE
        WHEN customer_email LIKE '%@%.%' THEN LOWER(TRIM(customer_email))
        ELSE NULL
    END AS customer_email,

    TRY_TO_DATE(NULLIF(check_in_date, '')) AS check_in_date,
    TRY_TO_DATE(NULLIF(check_out_date, '')) AS check_out_date,

    INITCAP(TRIM(room_type)) AS room_type,

    TRY_TO_NUMBER(num_guests) AS num_guests,

    ABS(TRY_TO_NUMBER(total_amount)) AS total_amount,

    UPPER(TRIM(currency)) AS currency,

    CASE
        WHEN LOWER(TRIM(booking_status)) IN ('confirmeed', 'confirmd') THEN 'Confirmed'
        ELSE INITCAP(TRIM(booking_status))
    END AS booking_status

FROM BRONZE_HOTEL_BOOKING

WHERE
    TRY_TO_DATE(NULLIF(check_in_date, '')) IS NOT NULL
    AND TRY_TO_DATE(NULLIF(check_out_date, '')) IS NOT NULL
    AND TRY_TO_DATE(NULLIF(check_out_date, '')) >= TRY_TO_DATE(NULLIF(check_in_date, ''));  --750 rows inserted (Cleaned data)

SELECT * FROM SILVER_HOTEL_BOOKING;  



--Gold layer table used for dashboard and KPIs

CREATE TABLE GOLD_AGG_DAILY_BOOKING AS
SELECT
    check_in_date AS date,
    COUNT(*) AS total_booking,
    SUM(total_amount) AS total_revenue,
FROM SILVER_HOTEL_BOOKING
GROUP BY check_in_date
ORDER BY date;

CREATE TABLE GOLD_AGG_HOTEL_CITY_SALES AS
SELECT
    hotel_city,
    SUM(total_amount) AS total_revenue,
FROM SILVER_HOTEL_BOOKING
GROUP BY hotel_city
ORDER BY total_revenue DESC;

CREATE TABLE GOLD_BOOKING_CLEAN AS
SELECT
    booking_id,
    hotel_id,
    hotel_city,
    customer_id,
    customer_name,
    customer_email,
    check_in_date,
    check_out_date,
    room_type,
    num_guests,
    total_amount,
    currency,
    booking_status
FROM SILVER_HOTEL_BOOKING;

--important table creation for dashboard purpose

SELECT * FROM GOLD_AGG_DAILY_BOOKING;

SELECT * FROM GOLD_AGG_HOTEL_CITY_SALES;

SELECT * FROM GOLD_BOOKING_CLEAN;


