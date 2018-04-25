$rgName     = "gd-azure-grp"  
$location   = "East US"
New-AzureRmResourceGroup -Name $rgName -Location $location

$subnets = @()
$subnet1Name = "Subnet-1"
$subnet2Name = "Subnet-2"
$subnet1AddressPrefix = "10.0.0.0/24"
$subnet2AddressPrefix = "10.0.1.0/24"
$vnetAddresssSpace = "10.0.0.0/16"
$VNETName = "gd-azure-vnet"
$subnets += New-AzureRmVirtualNetworkSubnetConfig -Name $subnet1Name `
    -AddressPrefix $subnet1AddressPrefix
$subnets += New-AzureRmVirtualNetworkSubnetConfig -Name $subnet2Name `
    -AddressPrefix $subnet2AddressPrefix

$vnet = New-AzureRmVirtualNetwork -Name $VNETName `
        -ResourceGroupName $rgName `
        -Location $location `
        -AddressPrefix $vnetAddresssSpace `
        -Subnet $subnets

$saName     = "gd-azure-sa"
$storageAcc = New-AzureRmStorageAccount -ResourceGroupName $rgName `
                                                -Name $saName `
                                                -Location $location `
                                                -SkuName Standard_LRS
$blobEndpoint = $storageAcc.PrimaryEndpoints.Blob.ToString()

$avSet = New-AzureRmAvailabilitySet -ResourceGroupName $rgName `
                                    -Name $avSet `
                                    -Location $location

$dnsName = "gd-azure-dns"                                   

pip = New-AzureRmPublicIpAddress -Name $ipName `
                                -ResourceGroupName $rgName `
                                -Location $location `
                                -AllocationMethod Dynamic `
                                -DomainNameLabel $dnsName  
# Add a rule to the network security group to allow RDP in
$nsgRules = @()
$nsgRules += New-AzureRmNetworkSecurityRuleConfig -Name "RDP" `
                                     -Description "RemoteDesktop" `
                                     -Protocol Tcp `
                                     -SourcePortRange "*" `
                                     -DestinationPortRange "3389" `
                                     -SourceAddressPrefix "*" `
                                     -DestinationAddressPrefix "*" `
                                     -Access Allow `
                                     -Priority 110 `
                                     -Direction Inbound
$nsgName    = "gd-azure-nsg"
$nsg = New-AzureRmNetworkSecurityGroup -ResourceGroupName $rgName `
        -Name $nsgName `
        -SecurityRules $nsgRules `
        -Location $location


