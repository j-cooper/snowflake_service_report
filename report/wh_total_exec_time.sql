select date,
       warehouse_name,
       sum(time_in_sec) as exec_time_in_sec
from (select to_date(start_time) as date,
             database_name,
             user_name,
             role_name,
             warehouse_name,
             total_elapsed_time/1000 as time_in_sec,
             rows_produced,
             credits_used_cloud_services,
             query_acceleration_bytes_scanned,
             query_acceleration_partitions_scanned,
             query_acceleration_upper_limit_scale_factor
      from snowflake.account_usage.query_history
      where to_date(start_time) = :daterange
            and warehouse_name is not null)
group by 1, 2;     
