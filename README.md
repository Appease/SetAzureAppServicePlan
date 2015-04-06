![](https://ci.appveyor.com/api/projects/status/2s5v9ydi7fbo5k0r?svg=true)

####What is it?

An [Appease](http://appease.io) task template that sets an [Azure App Service plan](http://azure.microsoft.com/en-us/documentation/articles/azure-web-sites-web-hosting-plans-in-depth-overview/).

####How do I install it?

```PowerShell
Add-AppeaseTask `
    -DevOpName YOUR-DEVOP-NAME `
    -TemplateId SetAzureAppServicePlan
```

####What parameters are required?

#####Name
description: a `string` representing the name of the App Service plan.

#####ResourceGroupName
description: a `string` representing the name of the resource group this App Service plan will be added to.

#####Location
description: a `string` representing the geographical location of the resource group.  
allowed values: 
```PowerShell
PS C:\> AzureResourceManager\Get-AzureLocation |
    ?{$_.Name -eq 'Microsoft.Web/serverFarms'} |
    select LocationsString |
    ft -Wrap

LocationsString                                                                                 
---------------                                                                                 
Brazil South, East Asia, East US, Japan East, Japan West, North Central US, North Europe, South 
Central US, West Europe, West US, Southeast Asia, Central US, East US 2
```

#####Sku
description: a `string` representing the sku of the App Service plan  
allowed values: `Free`, `Shared`, `Basic`, `Standard`, `Premium`

#####WorkerSize
description: a `string` representing the size of each worker VM allocated to the App Service plan  
allowed values: `0`, `1`, `2`

#####NumberOfWorkers
description: an `int` representing the number of worker VMs allocated to the App Service plan

####What parameters are optional?

#####Tags
description: a `PSCustomObject[]` representing tags (labels) to associate with the App Service plan  
schema:
```PowerShell
@(
    [PSCustomObject]@{
        'YOUR-TAG-KEY'='YOUR-TAG-VALUE'
    }
)
```
