# Zabbix_MSSQL_By_Agent
Template to integrate MSSQL Server into Zabbix. Based on the official template "MSSQL by ODBC"  

Requires Powershell including the sqlserver Module on the Database Server.  

Currently in beta Version and not fully tested.


## ToDo:
- See "Issues" on Github.

## Pros and Cons comparing to the original "MSSQL by ODBC" Template from Zabbix.

### Pro:
- Does not require ODBC
- Easy deployment
- Does not require SQL Credentials on Zabbix Server

### Cons:
- Requires Agent on SQL Server
- Requires Powershell on SQL Server


## Installation:
- Import the Template  

- Put the Folder userparams into the Zabbix Agent folder on your SQL Server.  

- Integrate the db.mssql.conf into your Zabbix Agent config by adding a Include parameter.  
For example: Include=C:\Program Files\Zabbix\conf\userparams\*.conf  

- You may need to increase the timeouts in zabbix if using the template for the passive Agent.  

- Execute the install.ps1 in the folder userparams\db.mssql as admin to install the required sqlserver powershell module.  

- Assign a User to the Zabbix Agent Service and assign this user the following permissions on the SQL Server:


GRANT VIEW ANY DEFINITION TO Zabbix  
GRANT VIEW SERVER STATE TO Zabbix  
GRANT SELECT ON OBJECT::msdb.dbo.sysjobs TO Zabbix  
GRANT SELECT ON OBJECT::msdb.dbo.sysjobservers TO Zabbix  
GRANT SELECT ON OBJECT::msdb.dbo.sysjobactivity TO Zabbix  
GRANT EXECUTE ON OBJECT::msdb.dbo.agent_datetime TO Zabbix  
