#Need at least 5.1 of PowerShell running
#Also will need to run in administrator mode if we need to install modules.


$PSVersionTable.PSVersion

#check for version of Az Powershell module 
Get-InstalledModule -Name Az -AllVersions | Select-Object -Property Name, Version


#if not installed can install via this command 
Install-Module -Name Az

#can use command below to see the modules that are installed with Az 
#tested with 
Get-Module -Name Az* -ListAvailable

#we'll use Az.Synapse heavily 
#you can check for that specific one by running code below 
# I'm using latest available now (0.7.0)
Get-Module -Name Az.Sy* -ListAvailable

#If you need to install Az.Synapse or want to update 
Install-Module -Name Az.Synapse -RequiredVersion 0.12.0


# Connect to Azure and list subscriptions available 
# Can note the ID for paramfile 
Connect-AzAccount
Get-AzSubscription | Format-Table
$sub = Get-AzSubscription Where-Object {$_.Name -like "<your sub name>*"}

$SubscriptionId = $sub.SubscriptionId
Write-Host "Sub id for param file is " $SubscriptionId

#You'll need SQL and Synapse providers enabled in your subscription 
#or can do via portal https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/error-register-resource-provider

Get-AzResourceProvider -ListAvailable
Get-AzResourceProvider -ProviderNamespace Microsoft.SQL
Get-AzResourceProvider -ProviderNamespace Microsoft.Synapse
