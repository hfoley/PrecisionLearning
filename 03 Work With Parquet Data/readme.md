# Precision Learning - 03 Work with Parquet Data

The files in this location are SQL Scripts we'll use within the Synapse Studio develope area.  These scripts help build an external table and view pointing to the parquet files we processed in previous steps. Make sure to update the script prior to running. 

## File list 
	1. 01 - VitalSource External Table.sql - SQL script to help build external table.  This was auto generated from navigating to the parquet files and right clicking. 
	2. 02 - VitalSource View.sql - SQL script to narrow down the data and clean it up from json format.  This is the view the Power BI report will use as a data source.  
	3. VitalSource Events PBI Report.pbit - Power BI template file that can be used to connect to your view in the vitalsource database within serverless SQL pool.  
	
![alt text](https://github.com/hfoley/EDU/blob/master/images/SQLScript.jpg?raw=true)
	
## Create External Table & View
These steps will all be done within the Synapse Studio environment.  
1. Open the Synapse workspace within Azure.  You can then click the Open Synapse Studio or workspace url link.  Open the Develop pane (paper icon on left side).  
2. Click the + sign in middle pane (hover says add new resource). 
3. Click on import.  
4. Navigate to the SQL Scripts file you've extracted them to locally.  Select the files and click open. 
5. Select the script 01 - VitalSource External Table.  You'll need to update the external data source location (see highlight in image above).  Update it to your *lake data lake storage account. 
6. Hit publish all to save changes to SQL Scripts. 
7. Run the 01 - VitalSource External Table script.  You will need to make sure you have created the managed private endpoint at this time.  If not this script will error.  

## Connect Power BI to View in Desktop
You can easily connect Power BI Desktop to your view within the database in a serverless SQL pool.  There's also a Power BI template you can use as well.  
1. Open Azure portal and navigate to the resource page for your Synapse workspace.  In the overview pane you'll see "Serverless SQL endpoint".  This is the server you'll supply to Power BI.  Click to copy the contents of it by hovering just to the right.  
2. Open Power BI and choose to Get Data.  Select "Azure Synapse Analytics" and click to connect. 
3. Paste the contents of the serverless endpoint into server. Specify "vitalsource" as the database.  Expand Advanced options and paste in our same query from before of "select * from EventsView" and click ok. 
4. Select either Load or Transform Data if you'd like to begin further clean up of the data in Power BI report. 

![alt text](https://github.com/hfoley/EDU/blob/master/images/PBIConnect2.jpg?raw=true)

## Connect Power BI to View via Power BI template
I created a Power BI template file you can use as well.  It contains a parameter to pass to specify your serverless SQL endpoint.  
1. Open the local copy of VitalSource Events PBI Report.pbit file.  
2. You will get a prompt for Serverless Server - paste in your serverless SQL endpoint server into the prompt. Click load. 
3. You'll get prompted to run a native database query.  Click to Run. 
4. You'll get a prompt for credentials.  You'll want to use Microsoft account option. Sign in then click to connect. 
5. You can then do a file - save as - and save the Power BI Desktop file to location of choice.  

You now have a Power BI connected to Synapse Analytics data lake powered serverless SQL pool.  If you use this, really appreciate feedback or tips to make it better.  Hit me up via Twitter - @hope_foley (https://twitter.com/hope_foley).  




		

	
	

