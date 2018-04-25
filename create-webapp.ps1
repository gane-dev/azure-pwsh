# Define properties for the web app
$resourceGroupName = "ganesh-azure-group"
$appServicePlanName = "ganesh-azure-app-service-plan"
$location = "East US"
$webAppName = "ganesh-hr-app"

# Create a new web app using an existing app service plan
New-AzureRmWebApp -ResourceGroupName $resourceGroupName -Location $location `
 -AppServicePlan $appServicePlanName -Name $webAppName