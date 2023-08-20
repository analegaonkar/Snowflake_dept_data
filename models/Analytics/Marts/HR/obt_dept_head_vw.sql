with f_depthead as ( select * from {{ ref("fct_depthead")}}),

d_dept_tbl as (select * from {{ ref("dim_dept_tbl")}}),

d_dept_head_tbl as (select * from {{ ref("dim_dept_head_tbl")}})

select 
f.dept_id,
d.dept_descr,
f.dept_head_id,
dh.dept_head_name,
f.head_count
from 
f_depthead f inner join d_dept_tbl d on d.dept_key = f.dept_key
inner join d_dept_head_tbl dh on dh.dept_head_key = f.dept_head_key