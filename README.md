# PrecisionLearning

This solution is to help build the components of a big data architecture in Synapse Analytics.  This use case is one that tackles one data source in a precision learning.  There is an accompanying blog post for my interpretation of precision learning at www.hopefoley.com/precisionlearning.  This solution mimics data from an e-textbook and learning system called VitalSource (https://get.vitalsource.com/).  The sample data file is based on the example at https://developer.vitalsource.com/hc/en-us/articles/115015721128.  We'll mimic landing the gzipped json files from this system
	
The architecture of the solution diagrammed below.  

![alt text](https://github.com/hfoley/EDU/blob/master/images/Hope%20Precision%20Learning.jpg?raw=true)

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
	
* [01 Create Resources](https://github.com/hfoley/SynapseLoadV2/tree/master/01%20Create%20Resources)   - contains PowerShell scripts to build all the Azure components in the solution. 
* [02 ADF Create](https://github.com/hfoley/SynapseLoadV2/tree/master/02%20ADF%20Create)   - contains powershell script and json files needed to build Azure Data Factory pipelines and other components.    
* [03 SQL Scripts](https://github.com/hfoley/SynapseLoadV2/tree/master/03%20SQL%20Scripts)  - contains the SQL Server script to create the metadata tables and insert data on your Azure SQL DB.  There's also a subdirectory [Sample](https://github.com/hfoley/SynapseLoadV2/tree/master/03%20SQL%20Scripts/Sample) if you'd like to use sample files instead of using your own tables.  
	

## Pre-reqs
1. Need to have at least PowerShell 5.1 installed.  You can check this by running the following script. 
	$PSVersionTable.PSVersion
2. Install Powershell AZ package.  This solution has been tested with 4.3.0.  You can find info on installing this at https://www.powershellgallery.com/packages/Az/
3. You may also need addtional modules as well like Az.DataFactory (https://www.powershellgallery.com/packages/Az.DataFactory) and Az.Synapse (https://www.powershellgallery.com/packages/Az.Synapse).  These commands below can help you determine if you have these components. I have tested this with Az.DataFactory 1.8.2 and Az.Synapse 0.1.2.  

	```powershell
	$PSVersionTable.PSVersion

	Get-InstalledModule -Name Az -AllVersions | Select-Object -Property Name, Version

	Get-Module -Name Az.Sy* -ListAvailable
	Get-Module -Name Az.DataF* -ListAvailable
	```

## Steps 
Each folder contains PowerShell and/or SQL scripts you'll need to update for your environment.  Further details on the files are in the readme of each section.  

1. Start here to create Azure resources above >> [01 Create Resources](https://github.com/hfoley/SynapseLoadV2/tree/master/01%20Create%20Resources) 

2. Start here to only want to create the Azure Data Factory components >> [02 ADF Create](https://github.com/hfoley/SynapseLoadV2/tree/master/02%20ADF%20Create).  

3. Start here if you only need to create the metadata tables >> [03 SQL Scripts](https://github.com/hfoley/SynapseLoadV2/tree/master/03%20SQL%20Scripts)






		

	
	

