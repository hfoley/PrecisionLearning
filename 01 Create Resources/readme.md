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

    & "C:\PSScripts\01 - CreateResources.ps1" -filepath "C:\PSScripts\paramfile.json"
4. Run the 02 - GrantStorageRights.ps1.  You'll again be prompted for login to Azure.  This script will assign the rights needed to the ADLS storage account.  It will grant your account (or the admin user provided in the paramfile) to the role Storage Blob Data Contributor role on the ADLS account.  Below is a sample syntax.  

    & "C:\PSScripts\02 - GrantStorageRights.ps1" -filepath "C:\PSScripts\paramfile.json"

5. Run the 03 - Create Pipeline Parts.ps1.  You'll again be prompted for login to Azure.  This script will create the pipeline related components.  This will also update the json files based on the values again in the paramfile.  Below is a sample syntax.  
    & "C:\PSScripts\03 - Create Pipeline Parts.ps1" -filepath "C:\PSScripts\paramfile.json"
    
## Create managed private endpoint
1. Open the Synapse workspace within Azure.  You can then click the Open Synapse Studio or workspace url link.  Open the manage pane (tool box on left side).  
2. We need to create a private endpoint to allow connectivity before we can interact with the ADLS storage.  As of now (2/25) it seems unable to be done in Powershell so we'll do manually.  Select Managed private endpoints.  Select new.  
3. Select Azure Data Lake Storage Gen 2 option.  Specify name appropriate for the endpoint.  This essentially just allows Synapse to communicate with your storage.  It will be name your prefix+"lake".  Select the appropriate subscription and storage account.  Hit create.  In Synapse you'll see a "pending state".  
4. In the Azure portal - navigate to your storage account.  Select Networking withing Settings of your storage account (left side).  Select on right side "Private endpoint connections".  
5. You should see your pending endpoint.  Select it and click Approve.  You can add a description.  
6. Back in Synapse Studio - you will see your endpoint approved but will take a few minutes (around 3-5 minutes in my experience). 
7. Once you see approved in Synapse you can test the linked service connection.  Select Linked Services (still in manage pane).  In order to do so you'll need to enable a session with Azure IR.  This does start some compute resources (more info at XX).  After the IR is running you can hit Test connection on the 

## Create pipeline & run 
As of now (3/1/21) there's an issue creating a pipeline via PowerShell that contains a mapping data flow.  We'll create this manually for now and run the pipeline to process our raw files into parquet.  I will automate thise when that's resolved in updates to Az.Synapse PowerShell modules.  
1. Open the Synapse workspace within Azure.  You can then click the Open Synapse Studio or workspace url link.  Open the manage pane (tool box on left side).  
2. Navigate to Integrate pane.  Select the + and select pipeline.  Give it appropriate name. Tip: can click on properties in top right to move it out of the way.  
3. Expand Activities and select and drag to canvas to run a Data flow (Move & Transform section). 
4. Select settings for data flow - expand Data flow and choose VitalSourceDF. 
5. After you've created and updated setting for the pipeline - hit publish to save your changes to Synapse. 
6. You can now run the pipeline to process the raw VitalSource gzipped json file.  The pipeline will process any files beginning with the filename "Vital*" and process them into the vitalsource container. 
7. Navigate to container and verify a parquet file was created. 

Up next is to upload sample data files into our newly created ADLS Gen 2 data lake.  You can view and validate what's contained in the resource group.  Navigate to sample data folder below.  
* [02 Sample Data](https://github.com/hfoley/PrecisionLearning/tree/main/02%20Sample%20Data)   - contains the raw VitalSource extract data I mimicked from documentation (link above)
