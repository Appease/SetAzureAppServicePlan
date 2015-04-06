# halt immediately on any errors which occur in this module
$ErrorActionPreference = 'Stop'
Import-Module 'C:\Program Files (x86)\Microsoft SDKs\Azure\PowerShell\ResourceManager\AzureResourceManager' -Force -RequiredVersion '0.8.8'

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
    $NumberOfWorkers
){

    $ApiVersion = '2014-04-01'
    $ResourceType = 'Microsoft.Web/serverFarms'
    # azure returns location strings with whitespace stripped
    $WhitespaceStrippedLocation = $Location -replace '\s', ''

    # build up property Hashtable from parameters
    $Properties = @{'sku'=$Sku;'workerSize'=$WorkerSize;'numberOfWorkers'=$NumberOfWorkers}

    If(!(AzureResourceManager\Get-AzureResource | ?{($_.Name -eq $Name) -and ($_.ResourceGroupName -eq $ResourceGroupName) -and ($_.Location -eq $WhitespaceStrippedLocation) -and ($_.ResourceType -eq $ResourceType)})){
        AzureResourceManager\New-AzureResource `
        -Location $Location `
        -Name $Name `
        -ResourceGroupName $ResourceGroupName `
        -ResourceType $ResourceType `
        -ApiVersion $ApiVersion `
        -PropertyObject $Properties `
        -Force
    }
    Else{
        AzureResourceManager\Set-AzureResource `
        -Name $Name `
        -ResourceGroupName $ResourceGroupName `
        -ResourceType $ResourceType `
        -ApiVersion $ApiVersion `
        -PropertyObject $Properties
    }
}

Export-ModuleMember -Function Invoke
