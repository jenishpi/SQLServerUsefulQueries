-- # OF CONNECTIONS FOR ALL THE SERVERS PER USER 
SELECT  
    DB_NAME(dbid) as DBName,  
    COUNT(dbid) as NumberOfConnections, 
    loginame as LoginName 
FROM 
    sys.sysprocesses 
WHERE  
    dbid > 0 
GROUP BY  
    dbid, loginame 
 
 
-- other ways 
EXEC sp_who 
 
EXEC sp_who2 
 
 
-- HOW LONG RUNNING QUERIES HAVE BEEN RUNNING FOR 
SELECT  * 
FROM    sys.dm_exec_requests   
        CROSS APPLY sys.dm_exec_sql_text(sql_handle)   
 
 
-- KILL XX -- WILL KILL session_id/spid 