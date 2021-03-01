IF NOT EXISTS (SELECT * FROM sys.databases where name = 'VitalSource') 
	CREATE DATABASE [VitalSource]
GO
USE [VitalSource]
GO
/* Change the context of the notebook to newly created VitalSource Db.  
It seems as of now USE statement doesn't work like in other DB tools
****update the external data source location for your environment. ****
*/ 

IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseParquetFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseParquetFormat] 
	WITH ( FORMAT_TYPE = PARQUET)
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'vitalsource_hplt1lake_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [vitalsource_hplt1lake_dfs_core_windows_net] 
	WITH (
		LOCATION   = 'https://<***change this***>.dfs.core.windows.net/vitalsource', 
	)
Go

--DROP EXTERNAL TABLE VitalSourceEvents
CREATE EXTERNAL TABLE VitalSourceEvents (
	[@context] varchar(8000),
	[action] varchar(8000),
	[actor] varchar(8000),
	[edApp] varchar(8000),
	[eventTime] varchar(8000),
	[extensions] varchar(8000),
	[federatedSession] varchar(8000),
	[generated] varchar(8000),
	[group] varchar(8000),
	[id] varchar(8000),
	[object] varchar(8000),
	[searchTerm] varchar(8000),
	[session] varchar(8000),
	[target] varchar(8000),
	[type] varchar(8000),
	[dataVersion] varchar(8000),
	[sendTime] varchar(8000),
	[sensor] varchar(8000),
	[VitalSrcFileProcessed] varchar(8000)
	)
	WITH (
	LOCATION = 'PartitionYear=2017/PartitionMonth=4/*/*.snappy.parquet',
	DATA_SOURCE = [vitalsource_hplt1lake_dfs_core_windows_net],
	FILE_FORMAT = [SynapseParquetFormat]
	)
GO

SELECT TOP 100 * FROM VitalSourceEvents
GO

