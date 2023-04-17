SELECT t.[text], s.last_execution_time 
FROM sys.dm_exec_cached_plans AS p 
INNER JOIN sys.dm_exec_query_stats AS s 
   ON p.plan_handle = s.plan_handle 
CROSS APPLY sys.dm_exec_sql_text(p.plan_handle) AS t 
WHERE t.[text] LIKE N'%MY OPTIONAL SEARCH TERM%' 
AND last_execution_time >= '2017-12-01' and last_execution_time <= '2017-12-02' 
ORDER BY s.last_execution_time DESC 