# Precision Learning - 03 Work with Parquet Data

The files in this location are SQL Scripts we'll use within the Synapse Studio develope area.  These scripts help build an external table and view pointing to the parquet files we processed in previous steps.  

## File list 
	1. 01 - VitalSource External Table.sql - SQL script to help build external table.  This was auto generated from navigating to the parquet files and right clicking. 
	2. 02 - VitalSource View.sql - SQL script to narrow down the data and clean it up from json format.  This is the view the Power BI report will use as a data source.  
	
![alt text](https://github.com/hfoley/EDU/blob/master/images/SQLScript.jpg?raw=true)
	
## Steps
These steps will all be done within the Synapse Studio environment.  
1. Open the Synapse workspace within Azure.  You can then click the Open Synapse Studio or workspace url link.  Open the Develop pane (paper icon on left side).  
2. Click the + sign in middle pane (hover says add new resource). 
3. Click on import.  
4. Navigate to the SQL Scripts file you've extracted them to locally.  Select the files and click open. 
5. Select the script 01 - VitalSource External Table.  You'll need to update the external data source location (see highlight in image above).  Update it to your *lake data lake storage account. 
6. Hit publish all to save changes to SQL Scripts. 
7. Run the 01 - VitalSource External Table script.  You will need to make sure you have created the managed private endpoint at this time.  If not this script will error.  


		

	
	

