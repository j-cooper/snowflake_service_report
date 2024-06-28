select date,
       warehouse_name,
       sum(compute_cost_usd) as compute_cost_usd,
       sum(effective_credits) as credits_used
from       
(select warehouse_name,
        date,
        sum(effective_credits_used) as effective_credits,
        effective_credits * 3 as compute_cost_usd
 from (select warehouse_name,
              to_date(start_time) as date,
              sum(credits_used_compute)/10 as free_credits_cloud,
              sum(credits_used_cloud_services) as used_cloud_credits,
              abs(free_credits_cloud - used_cloud_credits) as extra_cloud_credits,
              case when used_cloud_credits > free_credits_cloud then extra_cloud_credits
                   else 0 end as effective_cloud_service_credits,
              sum(CREDITS_USED_COMPUTE) + effective_cloud_service_credits as effective_credits_used      
       from snowflake.account_usage.warehouse_metering_history
       where to_date(start_time) = :daterange
       group by 1, 2)
 group by 1, 2)      
group by 1, 2;
