CREATE TABLE  #ProcSearch  (databaseName VARCHAR(100),ProcName VARCHAR(128),RoutineType varchar(100), Text varchar(50))  
  
DECLARE @command varchar(1000)   
SELECT @command = ' 
DECLARE @Search varchar(255) 
SET @Search=''%ROWCOUNT %'' 
 
IF ''?'' NOT IN(''master'', ''model'', ''msdb'', ''tempdb'') BEGIN USE ?   
INSERT INTO #ProcSearch 
SELECT DISTINCT ''?'', 
    o.name AS Object_Name,o.type_desc, 
	SUBSTRING(m.definition, CHARINDEX(REPLACE(@Search, ''%'', ''''), m.definition) - 20, 50) 
    FROM sys.sql_modules        m  
        INNER JOIN sys.objects  o ON m.object_id=o.object_id 
    WHERE m.definition Like ''%''+@Search+''%'' 
    ORDER BY 2,1  
END' 
EXEC sp_MSforeachdb @command  
  
SELECT * FROM #ProcSearch  
  
DROP TABLE #ProcSearch  