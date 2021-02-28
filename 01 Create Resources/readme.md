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
1. Prereq check - Open your PowerShell editor/IDE of choice and open the file 00 - PreReqCheck.ps1.  This file contains commands to check for and/or install some of the pre-reqs needed to run the rest of the scripts.  
2. Update the paramfile.json with the values you want to use for the rest of the scripts.  Storage is finicky in the rules it has for naming.  Keep storage params lowercase and your prefix 3-5 characters.  
3. Run the 01 - CreateResources.ps1 file and supply the param file location.  You'll be prompted for your login credentials to Azure.  You'll also be prompted for a username and password.  This will be your Synapse admin login.  Below is some sample syntax to run the file and pass the paramfile.  Keep all your script and json files in the same folder location.    
-  & "C:\PSScripts\01 - CreateResources.ps1" -filepath "C:\PSScripts\paramfile.json"
5. Run the 02 - GrantStorageRights.ps1.  You'll again be prompted for login to Azure.  This script will assign the rights needed to the ADLS storage account.  It will grant your account (or the admin user provided in the paramfile) to the role Storage Blob Data Contributor role on the ADLS account.  Below is a sample syntax. 
|    & "C:\PSScripts\02 - GrantStorageRights.ps1" -filepath "C:\PSScripts\paramfile.json"
5. Run the 03 - Create Pipeline Parts.ps1.  You'll again be prompted for login to Azure.  This script will create the pipeline related components.  This will also update the json files based on the values again in the paramfile.  Below is a sample syntax. 
	*& "C:\PSScripts\03 - Create Pipeline Parts.ps1" -filepath "C:\PSScripts\paramfile.json"
