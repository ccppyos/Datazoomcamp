
select 
locationid, borough, zone, 
replace(service_zone,'Boro','Green') as service
from {{ ref('taxi_zone_lookup') }}