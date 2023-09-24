SELECT 
  drs.database_state as database_state, 
  drs.is_suspended as is_suspended, 
  drs.synchronization_health as synchronization_health, 
  ag.name as group_name, 
  arcs.replica_server_name as replica_name, 
  db_name(drs.database_id) as dbname 
FROM 
  sys.dm_hadr_database_replica_states drs 
JOIN sys.dm_hadr_availability_replica_cluster_states arcs ON arcs.replica_id = drs.replica_id 
  AND arcs.replica_server_name = '{$MSSQL.PARAM2}' 
JOIN sys.availability_groups ag ON ag.group_id = arcs.group_id 
  AND ag.name = '{$MSSQL.PARAM3}' 
JOIN sys.dm_hadr_availability_replica_states ars ON ars.replica_id = arcs.replica_id 
  AND db_name(drs.database_id) = '{$MSSQL.PARAM4}'