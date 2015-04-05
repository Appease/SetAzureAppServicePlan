# halt immediately on any errors which occur in this module
$ErrorActionPreference = 'Stop'

function Invoke(

    [string]
    [ValidateNotNullOrEmpty()]
    [Parameter(
        Mandatory=$true,
        ValueFromPipelineByPropertyName=$true)]
    $Name,

    [string]
    [ValidateNotNullOrEmpty()]
    [Parameter(
        Mandatory=$true,
        ValueFromPipelineByPropertyName=$true)]
    $ResourceGroupName,

    [string]
    [ValidateNotNullOrEmpty()]
    [Parameter(
        Mandatory=$true,
        ValueFromPipelineByPropertyName=$true)]
    $Location,

    [string]
    [ValidateNotNullOrEmpty()]
    [Parameter(
        Mandatory=$true,
        ValueFromPipelineByPropertyName=$true)]
    $Sku,

    [string]
    [ValidateNotNullOrEmpty()]
    [Parameter(
        Mandatory=$true,
        ValueFromPipelineByPropertyName=$true)]
    $WorkerSize,

    [string]
    [ValidateNotNullOrEmpty()]
    [Parameter(
        Mandatory=$true,
        ValueFromPipelineByPropertyName=$true)]
    $NumberOfWorkers,

    [PSCustomObject[]]
    [Parameter(
        ValueFromPipelineByPropertyName=$true)]
    $Tag
){

    $ApiVersion = '2014-04-01'
    $ResourceType = 'Microsoft.Web/serverFarms'

    # build up property Hashtable from parameters
    $Properties = @{'sku'=$Sku;'workerSize'=$WorkerSize;'numberOfWorkers'=$NumberOfWorkers}

    # build up tag Hashtable from tag PSCustomObject
    $TagHashtable = @{}
    if($Tag){
        $Tag.PSObject.Properties | %{$TagHashtable[$_.Name]=$_.Value}
    }

    If(!(Get-AzureResource | ?{($_.Name -eq $Name) -and ($_.ResourceGroupName -eq $ResourceGroupName) -and ($_.Location -eq $Location)})){
        New-AzureResource `
        -Location $Location `
        -Name $Name `
        -ResourceGroupName $ResourceGroupName `
        -ResourceType $ResourceType `
        -Tag $TagHashtable `
        -ApiVersion $ApiVersion `
        -PropertyObject $Properties `
        -Force
    }
    Else{
        Set-AzureResource `
        -Name $Name `
        -ResourceGroupName $ResourceGroupName `
        -ResourceType $ResourceType `
        -Tag $TagHashtable `
        -ApiVersion $ApiVersion `
        -PropertyObject $Properties
    }
}

Export-ModuleMember -Function Invoke
