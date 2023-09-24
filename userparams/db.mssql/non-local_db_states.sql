SELECT 
  ISNULL(drs.log_send_queue_size, 0) as log_send_queue_size, 
  ISNULL(drs.redo_queue_size, 0) as redo_queue_size, 
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