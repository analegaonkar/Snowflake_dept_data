select DEPARTMENT_ID            dept_id
, EFFECTIVE_DATE                effective_date
, DEPARTMENT_FUNCTION_HEAD_ID   dept_head_id
, DEPARTMENT_FUNCTION_HEAD      dept_head_name
, EXTRACT_DATETIME              extracted_datetime
from MANAGE_DB.EXTERNAL_STAGE.RAW_DEPT_HEAD_TBL
