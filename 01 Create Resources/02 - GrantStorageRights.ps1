
<# 

Update all the variables in the section below for your environment.  
Update the values below within the < > 

** After you run this you'll need to update the linked services created. 
** You'll need to update the storage key for ADLSGen2LnkSvr 
** You'll need to update the user/password for Azure SQL and Synapse SQL pool
** Make sure to create the logging table prior to running pipelines
** Make sure to run the 01-UpdateADFJsonTemplate script first as files created used in this process
#>
param(
        [Parameter(Mandatory)]
        [string]$filepath
    )


$startTime = Get-Date
$filestuff = (get-content $filepath -raw | ConvertFrom-Json)

$SubscriptionId = $filestuff.SubscriptionId
$resourceGroupName = $filestuff.resourceGroupName
$prefix = $filestuff.prefix 
$azstoragename2 = $prefix+"lake"
$azsynapsename = $prefix+"synaps"
$adminuser = $filestuff.adminuser



$startTime = Get-Date
Write-Host "The granting of access to $azstoragename2 began at " $startTime

Connect-AzureAD 


$servicePrincipal = Get-AzureADServicePrincipal -Filter "DisplayName eq '$azsynapsename'"
$servicePrincipal
$ServicePrincipalId = $servicePrincipal.AppId
$ServicePrincipalId 
#Get-AzureADServicePrincipal $ServicePrincipalId

New-AzRoleAssignment -RoleDefinitionName "storage blob data contributor" -ApplicationId $ServicePrincipalId `
-Scope  "/subscriptions/$SubscriptionId/resourceGroups/$resourceGroupName/providers/Microsoft.Storage/storageAccounts/$azstoragename2"

New-AzRoleAssignment -SignInName $adminuser `
    -RoleDefinitionName "storage blob data contributor" `
    -Scope  "/subscriptions/$SubscriptionId/resourceGroups/$resourceGroupName/providers/Microsoft.Storage/storageAccounts/$azstoragename2"

