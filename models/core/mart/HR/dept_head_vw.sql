with 
final as
(select 
       D.DEPT_ID				department_id
	 , D.DEPT_DESCR				department_descr
	 , D.EFFECTIVE_DATE			effective_date
	 , D.EFFECTIVE_STAUS		effective_status
	 , H.DEPT_HEAD_ID           department_function_head_id
	 , H.DEPT_HEAD_NAME         department_function_head
       FROM {{ ref('dim_dept_tbl') }} D				
	         LEFT OUTER JOIN {{ ref('dim_dept_head_tbl') }} H	    
	           ON H.DEPT_ID = D.DEPT_ID 
	           AND H.LATEST_ACTIVE_ROW = 1
        WHERE D.LATEST_ACTIVE_ROW = 1 
        order by 1 
)

select * from final