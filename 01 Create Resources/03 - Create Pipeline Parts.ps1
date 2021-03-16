<# This file is driven by parameter file passed.  
There is a sample starting one in the github repo called paramfile.json 
You'll need to update that file and pass when running this script. 
Put all the files in the same folder as the paramfile.  

Tips: Storage requires lowercase only in naming 
Tips: Synapse SQL Pools have to be 15 or less characters 
Tips: prefix should be small 3-5 characters to not cause issues with rules for storage for example

You can run this script by sample syntax below: 
& "C:\PSScripts\03 - Create Pipeline Parts.ps1" -filepath "C:\PSScripts\paramfile.json"

 #>

 param(
    [Parameter(Mandatory)]
    [string]$filepath
)

$startTime = Get-Date
$folderpath = Split-Path -Path $filepath
$filestuff = (get-content $filepath -raw | ConvertFrom-Json)

$SubscriptionId = $filestuff.SubscriptionId

#variables for Synapse workspace. Based on prefix from param file
$prefix = $filestuff.prefix 
$azsynapsename = $prefix+"synaps"

$LinkedServiceName1 = $filestuff.LinkedServiceName1 
$linkedsvcfile1 = $filestuff.linkedsvcfile1
$linkedSvcfullpath = $folderpath + $linkedsvcfile1
$linkedsvcurl = "https://"+$prefix+"lake"+".dfs.core.windows.net"
Write-Host $linkedSvcfullpath 

#The parquet files to load into Synapse for the load processes 
$DatasetName1 = $filestuff.DatasetName1
$DatasetFile1 = $filestuff.DatasetFile1
$DataSet1fullpath = $folderpath + $DatasetFile1
Write-Host $DataSet1fullpath

#Azure SQL metadata table driving the load process ADF.MetadataLoad
$DatasetName2 = $filestuff.DatasetName2
$DatasetFile2 = $filestuff.DatasetFile2
$DataSet2fullpath = $folderpath + $DatasetFile2
Write-Host $DataSet2fullpath

$DataflowName1 = $filestuff.DataflowName1
$DataflowFile1 = $filestuff.DataflowFile1 
$DF1fullpath = $folderpath + $DataflowFile1 
Write-Host $DF1fullpath

$PipelineName1 = $filestuff.PipelineName1
$PipelineFile1 = $filestuff.PipelineFile1
$PL1fullpath = $folderpath + $PipelineFile1 
Write-Host $PL1fullpath
<#####################variables below do not need updated #> 

Connect-AzAccount
Select-AzSubscription -SubscriptionId $SubscriptionId
Write-Host "The Synapse pipeline parts creation script was started " $startTime
Set-Location $folderpath

<#Updating json files to build pipelines from parameters file #>
$linkedsvcedit = (get-content $linkedSvcfullpath -raw | ConvertFrom-Json)
$linkedsvcedit.name = $prefix+"lake"
$linkedsvcedit.properties.typeProperties.url = $linkedsvcurl
$linkedsvcedit | ConvertTo-Json -depth 32| set-content $linkedSvcfullpath

$editrawds = (get-content $DataSet1fullpath -raw | ConvertFrom-Json)
$editrawds.name = $filestuff.DatasetName1
$editrawds.properties.linkedServiceName.referenceName = $LinkedServiceName1
$editrawds | ConvertTo-Json -depth 32| set-content $DataSet1fullpath

$editsinkds = (get-content $DataSet2fullpath -raw | ConvertFrom-Json)
$editsinkds.name = $filestuff.DatasetName2
$editsinkds.properties.linkedServiceName.referenceName = $filestuff.LinkedServiceName1
$editsinkds | ConvertTo-Json -depth 32| set-content $DataSet2fullpath

$editdf = (get-content $DF1fullpath -raw | ConvertFrom-Json)
$editdf.name = $filestuff.DataflowName1
$editdf.properties.typeProperties.sources.dataset.referenceName = $filestuff.DatasetName1
$editdf.properties.typeProperties.sinks.dataset.referenceName = $filestuff.DatasetName2
$editdf | ConvertTo-Json -depth 100| set-content $DF1fullpath

$editpl = (get-content $PL1fullpath -raw | ConvertFrom-Json)
$editpl.name = $filestuff.PipelineName1
$arraylevel = $editpl.properties.activities
$arraylevel[0].name = $filestuff.DataflowName1
$arraylevel2 = $editpl.properties.activities
#$vPSObject2 = $arraylevel2[0].typeProperties.dataflow.referenceName
$arraylevel2[0].typeProperties.dataflow.referenceName = $filestuff.DataflowName1
#$updated = $arraylevel2[0].typeProperties.dataflow.referenceName
#write-host "is before: "$vPSObject
$editpl | ConvertTo-Json -depth 100| set-content $PL1fullpath


#################

$LinkedServiceCheck = Get-AzSynapseLinkedService -WorkspaceName $azsynapsename -Name $LinkedServiceName1 -ErrorAction SilentlyContinue
if(-not $LinkedServiceCheck)
    {
    Write-Host "Linked Service '$LinkedServiceName1' doesn't exist and will be created"
    Set-AzSynapseLinkedService -WorkspaceName $azsynapsename -Name $LinkedServiceName1  -DefinitionFile $linkedSvcfullpath
    }
else 
    {Write-Host "Linked Service '$LinkedServiceName1' already created"}
$endTime = Get-Date
write-host "Ended Linked Service creation at " $endTime


$Dataset1Check = Get-AzSynapseDataset -WorkspaceName $azsynapsename -Name $DatasetName1 -ErrorAction SilentlyContinue
if(-not $Dataset1Check)
    {
    Write-Host "Dataset '$DatasetName1' doesn't exist and will be created"
    Set-AzSynapseDataset -WorkspaceName $azsynapsename -Name $DatasetName1 -DefinitionFile $DataSet1fullpath

    }
else 
    {Write-Host "Dataset '$DatasetName1' already created"}
$endTime = Get-Date
write-host "Ended '$DatasetName1' creation at " $endTime


$Dataset2Check = Get-AzSynapseDataset -WorkspaceName $azsynapsename  -Name $DatasetName2 -ErrorAction SilentlyContinue
if(-not $Dataset2Check)
    {
    Write-Host "Dataset '$DatasetName2' doesn't exist and will be created"
    Set-AzSynapseDataset -WorkspaceName $azsynapsename -Name $DatasetName2 -DefinitionFile $DataSet2fullpath

    }
else 
    {Write-Host "Dataset '$DatasetName2' already created"}
$endTime = Get-Date
write-host "Ended '$DatasetName2' creation at " $endTime

$Dataflow1Check = Get-AzSynapseDataflow -WorkspaceName $azsynapsename -Name $DataflowName1 -ErrorAction SilentlyContinue
if(-not $Dataflow1Check)
    {
    Write-Host "Dataflow '$DataflowName1' doesn't exist and will be created"
    Set-AzSynapseDataflow -WorkspaceName $azsynapsename -Name $DataflowName1 -DefinitionFile $DF1fullpath 

    }
else 
    {Write-Host "Dataflow '$DataflowName1' already created"}

$endTime = Get-Date
write-host "Ended '$DataflowName1' creation at " $endTime


$Pipeline1Check = Get-AzSynapsePipeline -Name $PipelineName1 -WorkspaceName $azsynapsename -ErrorAction SilentlyContinue
if(-not $Pipeline1Check)
    {
    Write-Host "Pipeline '$PipelineName1' doesn't exist and will be created"
    Set-AzSynapsePipeline -WorkspaceName $azsynapsename -Name $PipelineName1 -DefinitionFile $PL1fullpath
    }
else 
    {Write-Host "Pipeline '$PipelineName1' already created"}

write-host "Pipeline comonents completed at " $endTime