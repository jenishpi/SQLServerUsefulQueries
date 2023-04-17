CREATE TABLE  #ProcSearch  (databaseName VARCHAR(100),ROUTINE_CATALOG varchar(50),ProcName VARCHAR(128),RoutineType varchar(100),CreateDate date)  
  
  
DECLARE @command1 varchar(1000)   
SELECT @command1 = 'IF ''?'' NOT IN(''master'', ''model'', ''msdb'', ''tempdb'') BEGIN USE ?   
INSERT INTO #ProcSearch  
SELECT ''?'',ROUTINE_CATALOG, ROUTINE_NAME, ROUTINE_TYPE, CREATED FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_DEFINITION LIKE ''%MY SEARCH TERM HERE%'' AND (ROUTINE_TYPE=''PROCEDURE'' or ROUTINE_TYPE=''FUNCTION'');   
END'   
EXEC sp_MSforeachdb @command1  
  
SELECT * FROM #ProcSearch  
  
DROP TABLE #ProcSearch  