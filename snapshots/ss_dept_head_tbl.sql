{% snapshot ss_dept_head_tbl %}

{% set new_schema = target.schema + '_snapshot' %}
    {{
        config(
            target_database = 'staging',
            target_schema = new_schema,
            unique_key ='DEPARTMENT_ID',

            strategy = 'check',
            check_cols=['DEPARTMENT_FUNCTION_HEAD_ID','DEPARTMENT_FUNCTION_HEAD','EFFECTIVE_DATE']

        )
    }}
    select * from {{ source('hris_peoplesoft','dept_head_tbl')}}
{% endsnapshot %}