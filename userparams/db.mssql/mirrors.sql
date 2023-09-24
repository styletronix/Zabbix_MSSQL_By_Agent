SELECT db_name(database_id) as dbname
FROM sys.database_mirroring
WHERE mirroring_state_desc IS NOT NULL