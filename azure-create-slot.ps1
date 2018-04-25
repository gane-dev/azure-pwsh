$resourceGroupName ="ganesh-azure-group"
$webAppName ="ganesh-hr-app"
$stagingSlotName = "Staging"

# Create a new web app deployment slot
New-AzureRmWebAppSlot -ResourceGroupName $resourceGroupName `
    -Name $webAppName -Slot $stagingSlotName

