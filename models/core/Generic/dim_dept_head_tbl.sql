{{
config (materialized = 'table')
}}

with 

cte_dept_head_tbl as
(
select row_number() over (order by dept_id) as dept_head_key
, DEPT_ID
, EFFECTIVE_DATE
, DEPT_HEAD_ID
, DEPT_HEAD_NAME
, to_timestamp_ntz(CURRENT_TIMESTAMP()) as created_datetime
from {{ ref("stg_dept_head_tbl") }}
),

cte_latest_active_row as
(
    select DEPT_ID, max(effective_date) effective_date , 1 as latest_active_row
				  from cte_dept_head_tbl
				  group by DEPT_ID 
),

final as
(
    select d.dept_head_key
, d.DEPT_ID
, d.EFFECTIVE_DATE
, d.DEPT_HEAD_ID
, d.DEPT_HEAD_NAME
, d.created_datetime
, l.latest_active_row
from cte_dept_head_tbl d 
  left outer join cte_latest_active_row l
    on l.dept_id = d.dept_id
    and l.effective_date = d.effective_date
)

select * from final 