{{
config (materialized = 'table')
}}

with 

cte_dept_tbl as
(
select row_number() over (order by dept_id) as deptid_key
, dept_id
, effective_date
, effective_status
, dept_descr
, to_timestamp_ntz(CURRENT_TIMESTAMP()) as created_datetime
from {{ ref("stg_dept_tbl") }}
),

cte_latest_active_row as
(
    select DEPT_ID, max(effective_date) effective_date , 1 as latest_active_row
				  from cte_dept_tbl 
				  group by DEPT_ID 
),

final as
(
    select {{ dbt_utils.generate_surrogate_key(['d.dept_id','d.effective_date']) }} as dept_key
        , d.dept_id
        , d.effective_date
        , d.effective_status
        , d.dept_descr 
        , d.created_datetime
        , l.latest_active_row
from cte_dept_tbl d 
  left outer join cte_latest_active_row l
    on l.dept_id = d.dept_id
    and l.effective_date = d.effective_date
)

select * from final
