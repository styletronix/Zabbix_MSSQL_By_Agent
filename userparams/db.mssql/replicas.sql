SELECT ag.name as group_name,
  arcs.replica_server_name as replica_name
FROM sys.dm_hadr_availability_replica_cluster_states as arcs
JOIN sys.availability_groups ag 
  ON ag.group_id = arcs.group_id
JOIN sys.dm_hadr_availability_replica_states ars 
  ON ars.replica_id = arcs.replica_id