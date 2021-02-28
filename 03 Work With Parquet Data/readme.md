# Precision Learning - 03 Work with Parquet Data

The files in this location are SQL Scripts we'll use within the Synapse Studio develope area.  These scripts help build an external table and view pointing to the parquet files we processed in previous steps.  

## File list 
	1. 01 - VitalSource External Table.sql - SQL script to help build external table.  This was auto generated from navigating to the parquet files and right clicking. 
	2. 02 - VitalSource View.sql - SQL script to narrow down the data and clean it up from json format.  This is the view the Power BI report will use as a data source.  
	
	![alt text](https://github.com/hfoley/EDU/blob/master/images/SQLScript.jpg?raw=true)
	
## Steps
These steps will all be done within the Synapse Studio environment.  
1. Need to have at least PowerShell 5.1 installed.  You can check this by running the following script. 
	$PSVersionTable.PSVersion
2. Install Powershell AZ package.  This solution has been tested with 4.3.0.  You can find info on installing this at https://www.powershellgallery.com/packages/Az/
3. You may also need addtional modules if you have installed Az package some time ago.  Az.Synapse (https://www.powershellgallery.com/packages/Az.DataFactory) and Az.Synapse (https://www.powershellgallery.com/packages/Az.Synapse).  
	


		

	
	

