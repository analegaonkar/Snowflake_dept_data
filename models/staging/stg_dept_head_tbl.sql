select DEPARTMENT_ID            dept_id
, EFFECTIVE_DATE                effective_date
, DEPARTMENT_FUNCTION_HEAD_ID   dept_head_id
, DEPARTMENT_FUNCTION_HEAD      dept_head_name
, EXTRACT_DATETIME              extracted_datetime
from {{ source('hris_peoplesoft','dept_head_tbl')}}
