SELECT * FROM (SELECT object_name,
  counter_name,
  instance_name,
  cntr_value
FROM sys.dm_os_performance_counters
UNION SELECT '{$MSSQL.INSTANCE}' AS object_name,
  'Version' AS counter_name,
  @@version AS instance_name,
  0 AS cntr_value
UNION SELECT '{$MSSQL.INSTANCE}' AS object_name,
  'Uptime' AS counter_name,
  '' AS instance_name,
  DATEDIFF(second, sqlserver_start_time, GETDATE()) AS cntr_value
FROM sys.dm_os_sys_info
UNION SELECT '{$MSSQL.INSTANCE}:Databases' AS object_name,
  'State' AS counter_name,
  name AS instance_name,
  state AS cntr_value
FROM sys.databases
UNION SELECT a.object_name,
  'BufferCacheHitRatio' AS counter_name,
  '' AS instance_name,
  cast(a.cntr_value * ISNULL((100.0 / NULLIF(b.cntr_value,0)),0) AS dec(3, 0)) AS cntr_value
FROM sys.dm_os_performance_counters a
JOIN (
  SELECT cntr_value,
    OBJECT_NAME
  FROM sys.dm_os_performance_counters
  WHERE counter_name = 'Buffer cache hit ratio base'
    AND OBJECT_NAME = '{$MSSQL.INSTANCE}:Buffer Manager'
) b
  ON a.OBJECT_NAME = b.OBJECT_NAME
WHERE a.counter_name = 'Buffer cache hit ratio'
  AND a.OBJECT_NAME = '{$MSSQL.INSTANCE}:Buffer Manager'
UNION SELECT a.object_name,
  'WorktablesFromCacheRatio' AS counter_name,
  '' AS instance_name,
  cast(a.cntr_value * ISNULL((100.0 / NULLIF(b.cntr_value,0)),0) AS dec(3, 0)) AS cntr_value
FROM sys.dm_os_performance_counters a
JOIN (
  SELECT cntr_value,
    OBJECT_NAME
  FROM sys.dm_os_performance_counters
  WHERE counter_name = 'Worktables From Cache Base'
    AND OBJECT_NAME = '{$MSSQL.INSTANCE}:Access Methods'
) b
  ON a.OBJECT_NAME = b.OBJECT_NAME
WHERE a.counter_name = 'Worktables From Cache Ratio'
  AND a.OBJECT_NAME = '{$MSSQL.INSTANCE}:Access Methods'
UNION SELECT a.object_name,
  'CacheHitRatio' AS counter_name,
  '_Total' AS instance_name,
  cast(a.cntr_value * ISNULL((100.0 / NULLIF(b.cntr_value,0)),0) AS dec(3, 0)) AS cntr_value
FROM sys.dm_os_performance_counters a
JOIN (
  SELECT cntr_value,
    OBJECT_NAME
  FROM sys.dm_os_performance_counters
  WHERE counter_name = 'Cache Hit Ratio base'
    AND OBJECT_NAME = '{$MSSQL.INSTANCE}:Plan Cache'
    AND instance_name = '_Total'
) b
  ON a.OBJECT_NAME = b.OBJECT_NAME
WHERE a.counter_name = 'Cache Hit Ratio'
  AND a.OBJECT_NAME = '{$MSSQL.INSTANCE}:Plan Cache'
  AND instance_name = '_Total') as tbl
  WHERE tbl.object_name = '{$MSSQL.PARAM2}'