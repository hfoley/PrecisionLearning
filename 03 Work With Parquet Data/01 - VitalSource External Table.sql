IF NOT EXISTS (SELECT * FROM sys.databases where name = 'VitalSource') 
	CREATE DATABASE [VitalSource]
GO
USE [VitalSource]
GO

IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseParquetFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseParquetFormat] 
	WITH ( FORMAT_TYPE = PARQUET)
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'vitalsource_hlulake_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [vitalsource_hlulake_dfs_core_windows_net] 
	WITH (
		LOCATION   = 'https://<***replace***>.dfs.core.windows.net/vitalsource', 
	)
Go

--DROP EXTERNAL TABLE VitalSourceEvents
CREATE EXTERNAL TABLE VitalSourceEvents (
	[@context] varchar(8000),
	[action] varchar(8000),
	[actor] varchar(8000),
	[edApp] varchar(8000),
	[eventTime] datetime2(7),
	[object] varchar(8000),
	[session] varchar(8000),
	[type] varchar(8000),
	[uuid] varchar(8000),
	[dataVersion] varchar(8000),
	[sendTime] varchar(8000),
	[sensor] varchar(8000),
	[FileProcessed] varchar(8000)
	)
	WITH (
	LOCATION = 'PartitionYear=2017/PartitionMonth=4/*/*.snappy.parquet',
	DATA_SOURCE = [vitalsource_hlulake_dfs_core_windows_net],
	FILE_FORMAT = [SynapseParquetFormat]
	)
GO

SELECT TOP 100 * FROM VitalSourceEvents
GO