declare @dbs table (dbname sysname) 
create table #all_roles (db sysname, [user] varchar(200), role varchar(200)) 
declare @Next sysname 
insert into @dbs 
select name from sys.databases 
select top 1 @Next = dbname from @dbs order by dbname 
while (@@rowcount<>0) 
begin 
	exec('use [' + @Next + '] 
	INSERT INTO #all_roles 
	SELECT''' + @Next + ''' as db,  us.name as [user], dp.name as [role] 
	FROM sys.sysusers us right  
	JOIN  sys.database_role_members rm ON us.uid = rm.member_principal_id 
	JOIN sys.database_principals dp ON rm.role_principal_id =  dp.principal_id 
	ORDER BY us.name') 
	delete @dbs where dbname = @Next 
	select top 1 @Next = dbname from @dbs order by dbname 
end 
 
select * from #all_roles 
order by db, [user], [role] 
 
drop table #all_roles 