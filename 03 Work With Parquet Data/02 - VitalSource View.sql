/* Script below walks through some queries to clean up and narrow 
down the data from the external table.  This will allow us 
to filter and clean up what's sent to Power BI report. 
**** Make sure to change the context of the database before you run 
the script below.  USE statement doesn't seem to work in studio like SSMS/etc****

The code below is meant to be stepped through for understanding.  
Final 2 queries pertain to building and querying the final view. 

*/ 


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
	[id],
	[dataVersion],
	[sendTime],
	[sensor],
	[VitalSrcFileProcessed]
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
	[id],
	[dataVersion],
	[sendTime],
	[sensor],
	[VitalSrcFileProcessed]
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
	[id],
	[dataVersion],
	[sendTime],
	[sensor],
	[VitalSrcFileProcessed]
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
	[id],
	[dataVersion],
	[sendTime],
	[sensor],
	[VitalSrcFileProcessed]
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
	[id],
	[dataVersion],
	[sendTime],
	[sensor],
	[VitalSrcFileProcessed]
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
	[id],
	[dataVersion],
	[sendTime],
	[sensor],
	[VitalSrcFileProcessed]
FROM 
    cte_pull_raw
/*
    WHERE
    year = 2018;
*/ 


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
	[id],
	[dataVersion],
	[sendTime],
	[sensor],
	[VitalSrcFileProcessed]
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
	[id],
	[dataVersion],
	[sendTime],
	[sensor],
	[VitalSrcFileProcessed]
FROM 
    cte_pull_raw

    WHERE
    year = 2018;


  /* 
