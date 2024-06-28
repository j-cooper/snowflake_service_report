select usage_date, 
       sum(credits_billed) as credits_billed
from snowflake.account_usage.metering_daily_history
group by 1;
