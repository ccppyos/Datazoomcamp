#In this section

I have learned how to make an orchestration using kestra.

Relevant points for me are:

1. The use of external tables:

Medium: https://medium.com/@santosh_beora/external-tables-in-bigquery-a-beginners-guide-b76d9d080dbe
An external table in BigQuery allows you to query data stored outside of BigQuery, such as in Google Cloud Storage (GCS), without needing to load it into BigQuery’s storage. This can be beneficial for accessing large datasets without the need for additional storage costs or data duplication.

That is, we are use the CSV we have extracted from HTTPS and use it later to transform the external table to a one that has transformed columns.

2. After we have manipulated the external table:

We create a table with clean data and some additional columns

3. Use of MERGE

This DML (data manipulation language) operation allows us to insert, update or delate information beased on conditions.

For this marticular case we are only going to insert data that is new:


 MERGE INTO `{{kv('GCP_PROJECT_ID')}}.{{kv('GCP_DATASET')}}.green_tripdata` T
USING `{{kv('GCP_PROJECT_ID')}}.{{render(vars.table)}}` S
ON T.unique_row_id = S.unique_row_id
WHEN NOT MATCHED THEN
    INSERT (unique_row_id, filename, VendorID, lpep_pickup_datetime, lpep_dropoff_datetime, store_and_fwd_flag, RatecodeID, PULocationID, DOLocationID, passenger_count, trip_distance, fare_amount, extra, mta_tax, tip_amount, tolls_amount, ehail_fee, improvement_surcharge, total_amount, payment_type, trip_type, congestion_surcharge)
    VALUES (S.unique_row_id, S.filename, S.VendorID, S.lpep_pickup_datetime, S.lpep_dropoff_datetime, S.store_and_fwd_flag, S.RatecodeID, S.PULocationID, S.DOLocationID, S.passenger_count, S.trip_distance, S.fare_amount, S.extra, S.mta_tax, S.tip_amount, S.tolls_amount, S.ehail_fee, S.improvement_surcharge, S.total_amount, S.payment_type, S.trip_type, S.congestion_surcharge);

If the data exists, we do nothing.



New defintions

DML => Data manipulation language
DDL  => Data definition language
DCL = > Data control language

Datawarehouse: cleaned processed data
Datalake: raw data