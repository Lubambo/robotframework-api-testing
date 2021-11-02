SELECT * FROM 
( SELECT {columns} FROM {table} {filters}
ORDER BY dbms_random.value ) 
WHERE rownum <= {amount}