with 

cte_dept_tbl as
(
select row_number() over (order by dept_id) as deptid_key
, DEPT_ID
, EFFECTIVE_DATE
, EFFECTIVE_STAUS
, DEPT_DESCR
, to_timestamp_ntz(CURRENT_TIMESTAMP()) as created_datetime
from STG_DEPT_TBL
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
        , d.created_datetime, l.latest_active_row
from cte_dept_tbl d 
  left outer join cte_latest_active_row l
    on l.dept_id = d.dept_id
    and l.effective_date = d.effective_date
)

select * from final