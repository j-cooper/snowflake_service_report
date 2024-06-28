select to_date(start_time) as date,
           warehouse_name,
           avg(avg_running) as avg_running_time,
           avg(avg_queued_load) as avg_load,
           avg(avg_queued_provisioning) as avg_queue_prov,
           avg(avg_blocked) as avg_blocked
    from snowflake.account_usage.warehouse_load_history
    where warehouse_name is not null 
          and to_date(start_time) = :daterange
    group by 1, 2;      
