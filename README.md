# Precision Learning - Synapse Analytics Solution Sample 

This solution is to help build the components of a big data architecture in Synapse Analytics.  This use case is one that tackles one data source in a precision learning.  There is an accompanying blog post for my interpretation of precision learning at www.hopefoley.com/precisionlearning.  This solution mimics data from an e-textbook and learning system called VitalSource (https://get.vitalsource.com/).  The sample data file is based on the example at https://developer.vitalsource.com/hc/en-us/articles/115015721128.  We'll mimic landing the gzipped json files from this system into a container raw in data lake.  We'll create a pipeline to run a mapping data flow to process all the gzip files in raw that begin with the filenames "Vital*".  They will be processed into the vitalsource container into parquet files.  Parquet files are suited for big data queries and give a way to query across the files.  We'll then create an ondemand sql database containing an external table pointing to the parquet files.  We'll create on top of that external table a view.  This view will be the portion that is exposed to a Power BI report.  
	
The architecture of the solution diagrammed below.  

![alt text](https://github.com/hfoley/EDU/blob/master/images/Hope%20Precision%20Learning2.jpg?raw=true)

## Asset List - These items will be created in your Azure subscription 
	1. Azure Resource Group
	2. Azure Synapse Analytics workspace - all components will exist in the workspace
	3. Azure Data Lake Gen 2 - will create one that's required for Synapse workspace but will leave alone 
	4. Azure Data Lake Gen 2 - will create one that we will use as our data lake and will use for our raw and processed data zones 
	5. Synapse linked service - this establishes connection for the pipeline to use to #4 above 
	6. Synapse dataset to raw landing zong - will create dataset for the source location 
	7. Synapse dataset to processed container - will create a dataset to land processed parquet files in to vitalsource container in #4
	8. Synapse mapping data flow - will create a mapping dataflow we'll use to process and land data in parquet files in #4
	9. Synapse pipeline - will do a pipeline to run after an issue is addressed in creating pipelines via PowerShell that contain a mapping dataflow
	
* [01 Create Resources](https://github.com/hfoley/PrecisionLearning/tree/main/01%20Create%20Resources)   - contains PowerShell scripts to build all the Azure components in the solution and grant necessary permissions. Skip this if you want to use existing resources.  
* [02 Sample Data](https://github.com/hfoley/PrecisionLearning/tree/main/02%20Sample%20Data)   - contains the raw VitalSource extract data I mimicked from documentation (link above)
 * [03 Work With Parquet Data](https://github.com/hfoley/PrecisionLearning/tree/main/03%20Work%20With%20Parquet%20Data)  - contains the SQL Server script files we'll use to create an external table and view that we'll use to pass data to Power BI.  I'll also include a Power BI template file to connect to Synapse on demand view.  

## Pre-reqs
There is a script you can use to check and install items in 01 Create Resources folder called 00 - PreReqCheck.ps1.  
1. Need to have at least PowerShell 5.1 installed.  You can check this by running the following script. 
	$PSVersionTable.PSVersion
2. Install Powershell AZ package.  This solution has been tested with 4.3.0.  You can find info on installing this at https://www.powershellgallery.com/packages/Az/
3. You may also need addtional modules if you have installed Az package some time ago.  Az.Synapse (https://www.powershellgallery.com/packages/Az.DataFactory) and Az.Synapse (https://www.powershellgallery.com/packages/Az.Synapse).  
	







		

	
	

