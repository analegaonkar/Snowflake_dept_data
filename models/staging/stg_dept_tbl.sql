select   DEPARTMENT_ID  dept_id
    , EFFECTIVE_DATE         effective_date
    , EFF_STATUS            effective_staus
    , DESCR50               dept_descr
    , EXTRACT_DATETIME      extracted_datetime
  from {{ source('dept','RAW_DEPT_TBL')}}