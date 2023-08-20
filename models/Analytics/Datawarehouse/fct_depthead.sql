with stg_dept as (

    select dept_id,effective_date from {{ref("stg_dept_tbl")}}
),
stg_dept_head as (
    select dept_id, dept_head_id,effective_date from {{ ref("stg_dept_head_tbl")}}
),
headcount as (select dept_id, count(dept_head_id) head_count from stg_dept_head group by dept_id )

select {{ dbt_utils.generate_surrogate_key(['d.dept_id','dh.dept_head_id']) }} as depthead_key,
{{ dbt_utils.generate_surrogate_key(['d.dept_id','d.effective_date']) }} as dept_key,
{{ dbt_utils.generate_surrogate_key(['dh.dept_id','dh.effective_date','dh.dept_head_id']) }} as dept_head_key
, d.dept_id
, dh.dept_head_id, h.head_count
from stg_dept d inner join stg_dept_head dh on dh.dept_id = d.dept_id
inner join headcount h on h.dept_id = dh.dept_id