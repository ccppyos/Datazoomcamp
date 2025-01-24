#QUESTION 3
SELECT 
	 count(*) FILTER (WHERE trip_distance <= 1) AS cat_1
	 , count(*) FILTER (WHERE trip_distance > 1 and trip_distance <= 3) AS cat_2
	 , count(*) FILTER (WHERE trip_distance > 3 and trip_distance <= 7) AS cat_3
	 , count(*) FILTER (WHERE trip_distance > 7 and trip_distance <= 10) AS cat_4
	 , count(*) FILTER (WHERE trip_distance > 10) AS over_10
FROM public.green_taxi_data
WHERE lpep_dropoff_datetime >= '2019-10-01' AND lpep_dropoff_datetime < '2019-11-01'

#QUESTION 4
SELECT lpep_pickup_datetime
FROM public.green_taxi_data
ORDER BY trip_distance DESC
limit 1


#QUESTION 5
SELECT Z."Zone", SUM(total_amount) as t_am
FROM public.green_taxi_data T
INNER JOIN public.zones Z ON T."PULocationID" = Z."LocationID"
WHERE DATE(lpep_pickup_datetime) = '2019-10-18'
GROUP BY 1
HAVING SUM(total_amount) > 13000

#QUESTION 6
SELECT F."Zone"
FROM public.green_taxi_data T
INNER JOIN public.zones Z ON T."PULocationID" = Z."LocationID"
INNER JOIN public.zones F ON T."DOLocationID" = F."LocationID"
WHERE date_trunc('month', DATE(T.lpep_pickup_datetime)) = '2019-10-01' and Z."Zone" = 'East Harlem North'
ORDER BY tip_amount DESC
limit 1;