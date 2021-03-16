<# This file is driven by parameter file passed.  
There is a sample starting one in the github repo called paramfile.json 
You'll need to update that file and pass when running this script. 
Put all the files in the same folder as the paramfile.  

Tips: Storage requires lowercase only in naming 
Tips: Synapse SQL Pools have to be 15 or less characters 
Tips: prefix should be small 3-5 characters to not cause issues with rules for storage for example

You can run this script by sample syntax below: 
& "C:\PSScripts\01 - CreateResources.ps1" -filepath "C:\PSScripts\paramfile.json"

 #>
param(
        [Parameter(Mandatory)]
        [string]$filepath
    )

$startTime = Get-Date
$filestuff = (get-content $filepath -raw | ConvertFrom-Json)

$SubscriptionId = $filestuff.SubscriptionId
$resourceGroupName = $filestuff.resourceGroupName
$resourceGroupLocation = $filestuff.resourceGroupLocation 

#Many resources will begin with prefix
$prefix = $filestuff.prefix 


#Synapse variables 
$azsynapsename = $prefix+"synaps"
$azstoragename = $prefix+"sysads"
$containername = $prefix+"lakecont" 
$SKUName = $filestuff.SKUName 
$storagekind = $filestuff.storagekind 
$ManagedVirtualNetwork = $filestuff.ManagedVirtualNetwork 

#Firewall to connect to Synapse workspace 
$firewallrulename = $filestuff.firewallrulename  


#ADLS 2 - this will be the ADLS landing area for parquet files
$azstoragename2 = $prefix+"lake"
$containername1 = $filestuff.containername1
$containername2 = $filestuff.containername2


#####################variables below do not need updated

Connect-AzAccount
#Select-AzSubscription -SubscriptionId $SubscriptionId
Set-AzContext -Subscription $SubscriptionId

<# Create Resource Group if doesn't exist.  #>
Write-Host "The resource group creation script was started " $startTime
$RGCheck = Get-AzResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue
if(-not $RGCheck)
    {
    Write-Host "Resource group '$resourceGroupName' doesn't exist and will be created"
    New-AzResourceGroup -Name $resourceGroupName -Location $resourceGroupLocation
    }
else 
    {Write-Host "Resource group '$resourceGroupName' already created"}
$endTime = Get-Date
write-host "Ended resource group creation at " $endTime


$startTime = Get-Date

Write-Host "The Azure ADLS Gen 2 sys storage creation script was started " $startTime

$ADLSCheck1 = Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $azstoragename -ErrorAction SilentlyContinue
if(-not $ADLSCheck1)
    {
    Write-Host "The ADLS storage '$azstoragename' doesn't exist and will be created"
    New-AzStorageAccount -ResourceGroupName $resourceGroupName -AccountName $azstoragename -Location $resourceGroupLocation -SkuName $SKUName -Kind $storagekind  -EnableHierarchicalNamespace $true 
     $ctx = New-AzStorageContext -StorageAccountName $azstoragename -UseConnectedAccount
        $ContCheck1 = Get-AzStorageContainer -Name $containername -Context $ctx -ErrorAction SilentlyContinue
        if(-not $ContCheck1)
            {
            Write-Host "The ADLS storage container '$containername' doesn't exist and will be created"
            New-AzStorageContainer -Name $containername -Context $ctx
           
            }
            else
            {
            Write-Host "The ADLS storage container '$containername' already there"
            }
    }
else 
    {
    Write-Host "The ADLS storage '$azstoragename' already created"
    }

<# Main secondary ADLS to use for data and containers used. #>
$ADLSCheck2 = Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $azstoragename2 -ErrorAction SilentlyContinue
if(-not $ADLSCheck2)
    {
    Write-Host "The ADLS storage '$azstoragename2' doesn't exist and will be created"
    New-AzStorageAccount -ResourceGroupName $resourceGroupName -AccountName $azstoragename2 -Location $resourceGroupLocation -SkuName $SKUName -Kind $storagekind  -EnableHierarchicalNamespace $true 
     $ctx = New-AzStorageContext -StorageAccountName $azstoragename2 -UseConnectedAccount
        $ContCheck = Get-AzStorageContainer -Name $containername1 -Context $ctx -ErrorAction SilentlyContinue
        if(-not $ContCheck)
            {
            Write-Host "The ADLS storage container '$containername1' doesn't exist and will be created"
            New-AzStorageContainer -Name $containername1 -Context $ctx
            New-AzStorageContainer -Name $containername2 -Context $ctx
            }
            else
            {
            Write-Host "The ADLS storage container '$containername1' already there"
            }
    }
else 
    {
    Write-Host "The ADLS storage '$azstoragename2' already created"
        $ctx = New-AzStorageContext -StorageAccountName $azstoragename2 -UseConnectedAccount
       
    }



Write-Host "The Azure Synapse Workspace script was started " $startTime

$SynapseCheck =  Get-AzSynapseWorkspace -ResourceGroupName $ResourceGroupName -Name $azsynapsename -ErrorAction SilentlyContinue
if(-not $SynapseCheck)
    {
    Write-Host "Synapse workspace '$azsynapsename' doesn't exist and will be created"
    New-AzSynapseWorkspace -ResourceGroupName $resourceGroupName -Name $azsynapsename -Location $resourceGroupLocation -DefaultDataLakeStorageAccountName $azstoragename -DefaultDataLakeStorageFilesystem $containername -ManagedVirtualNetwork $ManagedVirtualNetwork -SqlAdministratorLoginCredential (Get-Credential)-Verbose
    }
else 
    {Write-Host "Synapse workspace '$azsynapsename'  already created"}

$endTime = Get-Date
write-host "Ended Synapse workspace creation script at " $endTime

$startTime = Get-Date


$clientip = Invoke-RestMethod http://ipinfo.io/json | Select-Object -exp ip


$firewallrule = Get-AzSynapseFirewallRule -ResourceGroupName $resourceGroupName -WorkspaceName $azsynapsename
#$startip = $firewallrule.StartIpAddress



if(-not $firewallrule)
    {
    Write-Host "Synapse workspace firewall '$firewallrulename' doesn't exist and will be created"
    New-AzSynapseFirewallRule -WorkspaceName $azsynapsename -Name $firewallrulename -StartIpAddress $clientip -EndIpAddress $clientip 
    }
else 
    {Write-Host "Synapse workspace firewall '$firewallrulename'  already created"}

$endTime = Get-Date
write-host "Ended Synapse firewall rule creation script at " $endTime

#New-AzSynapseFirewallRule -WorkspaceName $azsynapsename -AllowAllAzureIP

$startTime = Get-Date

write-host "Total resources creation script finish at " $endTime

