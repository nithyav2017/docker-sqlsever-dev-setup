--To Retore Database
RESTORE DATABASE AdventureWorks2022 
FROM DISK = '/var/opt/mssql/data/Adevntureworks2022.bak'
WITH 
	MOVE 'AdventureWorks2022' TO '/var/opt/mssql/data/AdventureWorks2022.mdf', 
	MOVE 'AdventureWorks2022_log' TO '/var/opt/mssql/data/AdventureWorks2022_log.ldf' , 
REPLACE;

--To Verify the Restoration
sqlcmd -S localhost,1433 -U sa -P 'Password' 
 "SELECT name, database_id, create_date FROM sys.databases WHERE name = 'AdventureWorks2022';"

GO
--To Use the Restored Database
USE AdventureWorks2022;
GO
--To Verify Tables in the Restored Database
 sqlcmd -S localhost,1433 -U sa -P 'Password@123' -d AdventureWorks2022 -W -s","
 SELECT TOP 5 BusinessEntityID, FirstName, LastName, EmailPromotion from Person.Person;
GO
--Expected Output
BusinessEntityID,FirstName,LastName,EmailPromotion
----------------,---------,--------,--------------
1,Ken,Sánchez,0
2,Terri,Duffy,1
3,Roberto,Tamburello,0
4,Rob,Walters,0
5,Gail,Erickson,0

-- TO generate table script for a specific table
 sqlcmd -S localhost,1433 -U sa -P 'Password' -d AdventureWorks2022 -W -s","
1> SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE
2> FROM INFORMATION_SCHEMA.COLUMNS
3> WHERE TABLE_SCHEMA = 'Person' AND TABLE_NAME = 'Person'
4> ORDER BY ORDINAL_POSITION;
5> GO
-- Expected Output
-----------,---------,------------------------,-----------
BusinessEntityID,int,NULL,NO
PersonType,nchar,2,NO
NameStyle,bit,NULL,NO
Title,nvarchar,8,YES
FirstName,nvarchar,50,NO
MiddleName,nvarchar,50,YES
LastName,nvarchar,50,NO
Suffix,nvarchar,10,YES
EmailPromotion,int,NULL,NO
AdditionalContactInfo,xml,-1,YES
Demographics,xml,-1,YES
rowguid,uniqueidentifier,NULL,NO
ModifiedDate,datetime,NULL,NO
GO