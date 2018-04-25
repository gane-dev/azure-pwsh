# Define properties for the app service plan
$resourceGroupName ="ganesh-azure-group"
$appServicePlanName="ganesh-azure-app-service-plan"
$location = "East US"
$tier = "Free"
$workerSize="small"

#create a new resource group
New-AzureRmResourceGroup -Name $resourceGroupName -Location $location

#create a new app service plan
New-AzureRmAppServicePlan -ResourceGroupName $resourceGroupName `
    -Name $appServicePlanName -Location $location `
    -Tier $tier -WorkerSize $workerSize



