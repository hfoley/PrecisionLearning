
<# 

This will grant storage blob contributor role for mananged service account 
created with Synapse.  It will also grant admin AAD account in the 
paramfile that right as well.  (Could be redundant...I know...but it's needed)
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

