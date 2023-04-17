--List dropped or deleted objects and rows
SELECT  
[Current LSN], 
Operation, 
[Transaction Id], 
[Transaction SID], 
[Transaction Name], 
 [Begin Time], 
   [SPID], 
   Description 
 
FROM fn_dblog (NULL, NULL) 
WHERE [Transaction Name] = 'DROPOBJ' 
GO 
 
SELECT  
 [Current LSN],     
 [Transaction ID], 
 [Begin Time], 
     Operation, 
     Context, 
     AllocUnitName 
FROM  
    fn_dblog(NULL, NULL) 
WHERE  
    Operation = 'LOP_DELETE_ROWS' 