select to_date(start_time) as date,
       warehouse_name,
       count(query_id) as query_count
from snowflake.account_usage.query_history
where warehouse_size is not null 
      and to_date(start_time) = :daterange
group by 1, 2;
