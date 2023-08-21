{% set new_schema = target.schema + '_snapshot' %}

{{
    config(
      materialized='incremental',
      full_refresh=false,
      target_database = 'staging',
      target_schema = new_schema,
      on_schema_change='sync_all_columns'
    )
}}


select
    *
from {{ ref('fct_depthead') }}
{% if is_incremental() %}
    where true
{% endif %}