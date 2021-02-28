# Precision Learning - 01 Create Resources

The files in this location are to help build the resources we'll use in your Azure subscription.  The resources below will be create.  


## Asset List - These items will be created in your Azure subscription 
	1. Azure Resource Group
	2. Azure Synapse Analytics workspace - all components will exist in the workspace
	3. Azure Data Lake Gen 2 - will create one that's required for Synapse workspace but will leave alone 
	4. Azure Data Lake Gen 2 - will create one that we will use as our data lake and will use for our raw and processed data zones 
	5. Synapse linked service - this establishes connection for the pipeline to use to #4 above 
	6. Synapse dataset to raw landing zong - will create dataset for the source location 
	7. Synapse dataset to processed container - will create a dataset to land processed parquet files in to vitalsource container in #4
	8. Synapse mapping data flow - will create a mapping dataflow we'll use to process and land data in parquet files in #4
	9. *TBD Synapse pipeline - will do a pipeline to run after an issue is addressed in creating pipelines via PowerShell that contain a mapping dataflow
	

## Steps 
There is a script you can use to check and install items in 01 Create Resources folder called 00 - PreReqCheck.ps1.  
1. Need to have at least PowerShell 5.1 installed.  You can check this by running the following script. 
	$PSVersionTable.PSVersion
2. Install Powershell AZ package.  This solution has been tested with 4.3.0.  You can find info on installing this at https://www.powershellgallery.com/packages/Az/
3. You may also need addtional modules if you have installed Az package some time ago.  Az.Synapse (https://www.powershellgallery.com/packages/Az.DataFactory) and Az.Synapse (https://www.powershellgallery.com/packages/Az.Synapse).  
	







		

	
	

