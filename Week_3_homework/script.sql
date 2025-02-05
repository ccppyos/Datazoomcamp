#SETUP
CREATE OR REPLACE EXTERNAL TABLE `yellow_trip.yellow_tripdata`
OPTIONS (
  format = 'parquet',
  uris = ['gs://dezoomcamp_hw3_2025_crp/yellow_tripdata_2024-*.parquet']
);

CREATE OR REPLACE TABLE `yellow_trip.yellow_tripdata_materialized`as(
  SELECT * FROM `mesmerizing-app-448304-t5.yellow_trip.yellow_tripdata`
);

#Question 2
#0 MB
#SELECT COUNT(DISTINCT PULocationID) from `yellow_trip.yellow_tripdata`;
#155.12 MB 
SELECT COUNT(DISTINCT PULocationID) from `yellow_trip.yellow_tripdata_materialized`;

#Question 3
#SELECT PULocationID from `yellow_trip.yellow_tripdata_materialized`; #310.24
SELECT PULocationID, DOLocationID  from `yellow_trip.yellow_tripdata_materialized`;#465.36

#Question 4
SELECT COUNTIF(fare_amount = 0) from `yellow_trip.yellow_tripdata_materialized`;#465.36


#Question 6

CREATE OR REPLACE TABLE `yellow_trip.yellow_tripdata_partitionized`
PARTITION BY DATE(tpep_dropoff_datetime)
CLUSTER BY VendorID AS (
  SELECT * FROM `yellow_trip.yellow_tripdata_materialized`
);

SELECT DISTINCT VendorID FROM `yellow_trip.yellow_tripdata_materialized` 
WHERE tpep_dropoff_datetime BETWEEN '2024-03-01' AND '2024-03-15';


SELECT DISTINCT VendorID FROM `yellow_trip.yellow_tripdata_partitionized` 
WHERE tpep_dropoff_datetime BETWEEN '2024-03-01' AND '2024-03-15';

#it might be due to metadata
#Question 9
SELECT COUNT(*) FROM `yellow_trip.yellow_tripdata_materialized`