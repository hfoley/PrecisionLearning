use vitalsource;
GO 
select
  [@context] as "Version",
	[action],
	[actor],
	[edApp],
	[eventTime],
	[object],
	[session],
	[type],
	[uuid],
	[dataVersion],
	[sendTime],
	[sensor],
	[FileProcessed]
  from VitalSourceEvents
GO 

/* Here's an example to clean up the data that's still 
in JSON format */ 

select 
actor,
JSON_VALUE(actor,'$.id') AS 'ActorID'
from VitalSourceEvents

/* Full SQL cleanup for a view */ 

select top 10 
[@context] as "Version",
	[action],
	[actor],
  JSON_VALUE(actor,'$.id') AS 'ActorID',
	[edApp],
  JSON_VALUE(edApp,'$.type') AS 'EdAppType',
	[eventTime],
	[object],
  JSON_VALUE(object,'$.id') AS 'BookID',
  JSON_VALUE(object,'$.isPartOf.type') AS 'ObjectType',
  JSON_VALUE(object,'$.name') AS 'PageNum',
  JSON_VALUE(object,'$.type') AS 'PageType',
	[session],
  JSON_VALUE(session,'$.id') AS 'SessionID',
	[type],
	[uuid],
	[dataVersion],
	[sendTime],
	[sensor],
	[FileProcessed]
  from VitalSourceEvents
  --where 





WITH cte_pull_raw AS (
 select top 10 
[@context] as "Version",
	[action],
	[actor],
  JSON_VALUE(actor,'$.id') AS 'ActorID',
	[edApp],
  JSON_VALUE(edApp,'$.type') AS 'EdAppType',
	[eventTime],
	[object],
  JSON_VALUE(object,'$.id') AS 'BookID',
  JSON_VALUE(object,'$.isPartOf.type') AS 'ObjectType',
  JSON_VALUE(object,'$.name') AS 'PageNum',
  JSON_VALUE(object,'$.type') AS 'PageType',
	[session],
  JSON_VALUE(session,'$.id') AS 'SessionID',
	[type],
	[uuid],
	[dataVersion],
	[sendTime],
	[sensor],
	[FileProcessed]
  from VitalSourceEvents

)

SELECT
 [Version],
	[action],
	--[actor],
  JSON_VALUE(actor,'$.id') AS 'ActorID',
	--[edApp],
  JSON_VALUE(edApp,'$.type') AS 'EdAppType',
	[eventTime],
	--[object],
  JSON_VALUE(object,'$.id') AS 'BookID',
  JSON_VALUE(object,'$.isPartOf.type') AS 'ObjectType',
  JSON_VALUE(object,'$.name') AS 'PageNum',
  JSON_VALUE(object,'$.type') AS 'PageType',
	--[session],
  JSON_VALUE(session,'$.id') AS 'SessionID',
	[type],
	[uuid],
	[dataVersion],
	[sendTime],
	[sensor],
	[FileProcessed]
FROM 
    cte_pull_raw
/*
    WHERE
    year = 2018;
*/ 


DROP VIEW IF EXISTS EventsView;
GO

CREATE VIEW EventsView
AS 
  WITH cte_pull_raw AS (
   select top 10 
[@context] as "Version",
	[action],
	[actor],
  JSON_VALUE(actor,'$.id') AS 'ActorID',
	[edApp],
  JSON_VALUE(edApp,'$.type') AS 'EdAppType',
	[eventTime],
	[object],
  JSON_VALUE(object,'$.id') AS 'BookID',
  JSON_VALUE(object,'$.isPartOf.type') AS 'ObjectType',
  JSON_VALUE(object,'$.name') AS 'PageNum',
  JSON_VALUE(object,'$.type') AS 'PageType',
	[session],
  JSON_VALUE(session,'$.id') AS 'SessionID',
	[type],
	[uuid],
	[dataVersion],
	[sendTime],
	[sensor],
	[FileProcessed]
  from VitalSourceEvents
  )

SELECT
 [Version],
	[action],
  JSON_VALUE(actor,'$.id') AS 'ActorID',
  JSON_VALUE(edApp,'$.type') AS 'EdAppType',
	[eventTime],
  JSON_VALUE(object,'$.id') AS 'BookID',
  JSON_VALUE(object,'$.isPartOf.type') AS 'ObjectType',
  JSON_VALUE(object,'$.name') AS 'PageNum',
  JSON_VALUE(object,'$.type') AS 'PageType',
  JSON_VALUE(session,'$.id') AS 'SessionID',
	[type],
	[uuid],
	[dataVersion],
	[sendTime],
	[sensor],
	[FileProcessed]
FROM 
    cte_pull_raw


select * from EventsView


/* 
ALTER VIEW EventsView
as 
WITH cte_pull_raw AS (
   select top 10 
[@context] as "Version",
	[action],
	[actor],
  JSON_VALUE(actor,'$.id') AS 'ActorID',
	[edApp],
  JSON_VALUE(edApp,'$.type') AS 'EdAppType',
	[eventTime],
	[object],
  JSON_VALUE(object,'$.id') AS 'BookID',
  JSON_VALUE(object,'$.isPartOf.type') AS 'ObjectType',
  JSON_VALUE(object,'$.name') AS 'PageNum',
  JSON_VALUE(object,'$.type') AS 'PageType',
	[session],
  JSON_VALUE(session,'$.id') AS 'SessionID',
	[type],
	[uuid],
	[dataVersion],
	[sendTime],
	[sensor],
	[FileProcessed]
  from VitalSourceEvents
  )

SELECT
 [Version],
	[action],
  JSON_VALUE(actor,'$.id') AS 'ActorID',
  JSON_VALUE(edApp,'$.type') AS 'EdAppType',
	[eventTime],
  JSON_VALUE(object,'$.id') AS 'BookID',
  JSON_VALUE(object,'$.isPartOf.type') AS 'ObjectType',
  JSON_VALUE(object,'$.name') AS 'PageNum',
  JSON_VALUE(object,'$.type') AS 'PageType',
  JSON_VALUE(session,'$.id') AS 'SessionID',
	[type],
	[uuid],
	[dataVersion],
	[sendTime],
	[sensor],
	[FileProcessed]
FROM 
    cte_pull_raw

  */ 
