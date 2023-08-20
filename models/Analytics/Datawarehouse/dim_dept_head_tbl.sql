{{
config (materialized = 'table')
}}

with 

cte_dept_head_tbl as
(select dept_id
, effective_date
, dept_head_id
, dept_head_name
, to_timestamp_ntz(CURRENT_TIMESTAMP()) as created_datetime
from {{ ref("stg_dept_head_tbl") }}
),

cte_latest_active_row as
(
    select dept_id, max(effective_date) effective_date , 1 as latest_active_row
				  from cte_dept_head_tbl
				  group by dept_id 
),

final as
(select {{ dbt_utils.generate_surrogate_key(['d.dept_id','d.effective_date','d.dept_head_id']) }} as dept_head_key
, d.dept_id
, d.effective_date
, d.dept_head_id
, d.dept_head_name
, d.created_datetime
, l.latest_active_row
from cte_dept_head_tbl d 
  left outer join cte_latest_active_row l
    on l.dept_id = d.dept_id
    and l.effective_date = d.effective_date
)

select * from final 