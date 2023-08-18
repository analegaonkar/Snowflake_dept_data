{{
config (materialized = 'table')
}}

with 

cte_dept_tbl as
(
select row_number() over (order by dept_id) as deptid_key
, DEPT_ID
, EFFECTIVE_DATE
, EFFECTIVE_STAUS
, DEPT_DESCR
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
    select d.deptid_key
        , d.DEPT_ID
        , d.EFFECTIVE_DATE
        , d.EFFECTIVE_STAUS
        , d.DEPT_DESCR 
        , d.created_datetime
        , l1.latest_active_row
from cte_dept_tbl d 
  left outer join cte_latest_active_row l1
    on l1.dept_id = d.dept_id
    and l1.effective_date = d.effective_date
)

select * from final