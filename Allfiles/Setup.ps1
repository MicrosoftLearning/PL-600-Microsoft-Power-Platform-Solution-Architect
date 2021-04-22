#
#
#  Run  Start-PL600-Setup 
#
#  V1.0 - 4/20/2020 - inital version
#
####

   $LabAdminPrefix = "labadmin";
   $LabAdminPassword = "test@word1"

   #For E3 use ENTERPRISEPACK
   #For E5 use ENTERPRISEPREMIUM
   $LabADminOfficeLicense=""
   #$LabAdminPowerLicense="POWERAPPS_PER_USER"
   $LabAdminPowerLicense="DYN365_ENTERPRISE_PLAN1"
   $ALH=$true

####
#   End of the configuration section
####

[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12;

Install-Module -Name Microsoft.PowerApps.Administration.PowerShell -Scope CurrentUser -Force 
Install-Module -Name Microsoft.PowerApps.PowerShell -Scope CurrentUser -AllowClobber -Force 
Install-Module Microsoft.Xrm.OnlineManagementAPI -Scope CurrentUser
Install-Module -Name Microsoft.Xrm.Data.Powershell -Scope CurrentUser
Install-Module -Name MSOnline -Scope CurrentUser -RequiredVersion 1.1.166.0 
Install-module azuread -Scope CurrentUser
Import-Module Microsoft.PowerShell.Utility 

Write-Host "### Prepare to run Start-PL600-Setup ###" 
Write-Host ""
Write-Host "  Start-PL600-Setup -TenantName 'WWLLABXXX' -CDSLocation 'unitedstates' -UserCount 24" -ForegroundColor Green     
Write-Host "  Parameters details for Start-PL600-Setup:"
Write-Host "     TenantName : This is the name portion of name.onmicrosoft.com" -ForegroundColor Green  
Write-Host "     CDSLocation: This must match be appropriate for Region e.g. US = unitedstates"  -ForegroundColor Green
Write-Host "     UserCount: This is a number between 1 and 75 that is attending your event"  -ForegroundColor Green
Write-Host "     APIUrl : You can find the url for your tenant region here if not in US - https://docs.microsoft.com/en-us/dynamics365/customer-engagement/developer/online-management-api/get-started-online-management-api"  -ForegroundColor Green
Write-Host "     You can find out your tenant region by running running Get-MsolCompanyInformation and looking at CountryLetterCode" -ForegroundColor Green
Write-Host ""
Write-Host "### Ready for you to run Start-PL600-Setup ###" 

function Start-PL600-Setup
{
    <#
    .SYNOPSIS 
      Configure a tenant for running an ALM lab
    .EXAMPLE
     Start-PL600-Setup -TenantName 'MX60265ABC'  -CDSLocation 'unitedstates' -UserCount 10 
     
     TenantName : This is the name portion of name.onmicrosoft.com     
     CDSLocation: This must match be appropriate for Region e.g. US = unitedstates
     UserCount: This is a number between 1 and the max you have licenses for
     Solution : This allows you to specify a Dataverse Solution that will be pre-loaded into each student environment
     EnvSKU: This can be either Trial or Production, default is Trial
     APIUrl : You can find the url for your region here if not in US - https://docs.microsoft.com/en-us/dynamics365/customer-engagement/developer/online-management-api/get-started-online-management-api
     APIUrl : The APIUrl is not required as derived from CDSLocation
     DeleteUsers: This will delete/disable all other uses besides the one that runs this script - use $true to enable - default is $false
    #>
    param(
    [Parameter(Mandatory = $true)]
    [string]$TenantName,
    [Parameter(Mandatory = $false)]
    [string]$CDSlocation="unitedstates",
    [Parameter(Mandatory = $true)]
    [int]$UserCount=24,
    [Parameter(Mandatory = $false)]
    [string]$APIUrl = "https://admin.services.crm.dynamics.com",
    [Parameter(Mandatory = $false)]
    [string]$Solution,
    [Parameter(Mandatory = $false)]
    [string]$EnvSKU="Trial",
    [Parameter(Mandatory = $false)]
    [switch]$DeleteUsers=$false
    )

    Write-Host "Setup Starting"

    Write-Host "Tenant:" $TenantName
    $Tenant = $TenantName;
    Write-Host "Region:" $Region
    $TenantRegion = $Region;
    Write-Host "API Url:" $APIUrl
    $AdminAPIUrl = Get-AdminServiceUrl -CDSlocation $CDSlocation  -APIUrl $APIUrl
    Write-Host "Dataverse Location:" $CDSlocation
    Write-Host "User Count:" $UserCount
    Write-Host "Solution:" $Solution
    $LabAdminCount = $UserCount  
    $DomainName =$Tenant + ".onmicrosoft.com"

    $UserCredential = Get-Credential
    Write-Host "Connecting to Office 365..."
    Connect-MsolService -Credential $UserCredential
    Write-Host "Connecting to Azure AD..."
    Connect-AzureAD -Credential $UserCredential
    Write-Host "Connecting to PowerApps..."
    try{
       Add-PowerAppsAccount -Username $UserCredential.UserName -Password $UserCredential.Password
    }
    catch { 
       Write-Host "Error connecting to PowerApps, if error includes Cannot find overload for UserCredential please run CleanupOldModules.ps1 and retry this script"
       Read-Host -Prompt 'Press <Enter> to exit, then restart script with proper information'
       exit
    }
    
    if ($DeleteUsers -eq $true) {
        $confirmDelete = Read-Host -Prompt 'Confirm disabling all accounts other than this admin account(Y/N)'
        if ($confirmDelete -and $confirmDelete -eq 'Y') {
	        Write-Host "Proceeding to disable all users"
            Delete-DemoUsers;
        }
    }
        
    $companyInfo = Get-MsolCompanyInformation   
    Write-Host "Verifying licenses..."
    $verifyLicense = Verify-Licenses -Tenant $Tenant -UserCount $LabAdminCount
    if ($verifyLicense -eq $true)
    {     
        Write-Host "Setting up development environment..."
        Setup-ContosoEnvs
        
        $verifySolution=Verify-SolutionFile-ToEnv -namePrefix "Device Ordering Development" -uniquename ContosoDeviceOrderManagement
        if ($verifySolution -eq $false)
        {
            Write-Host "Importing solution..."
            Setup-DeviceOrderingSolution
        }

        if ($ALH -eq $true)
        {
            Write-Host "Set for ALH..."
            $EnvSKU="Production"
            Write-Host "Finding users..."
            List-Users
            Write-Host "Adding roles to users..."
            Setup-AddLabAdminRoles
        }
        else
        {
            Write-Host "Set for Trial..."
            Write-Host "Creating users..."
            Create-LabAdminUsers -Tenant $Tenant -Count $LabAdminCount -TenantRegion $companyInfo.CountryLetterCode -password $LabAdminPassword -userprefix $LabAdminPrefix
        }
                
        Setup-AddLabAdminToGroup
        Setup-AddLabAdminToSysAdmin-FixedEnvs
        Add-PowerAppsAccount -Username $UserCredential.UserName -Password $UserCredential.Password
        
        Create-CDSenvironment -namePrefix "Prod - " -CDSlocation $CDSlocation -password $LabAdminPassword -EnvSKU $EnvSKU
        Wait-ForEnvProvisioning -namePrefix "Prod - " -envCount $UserCount
        Create-CDSDatabases -namePrefix "Prod - "
        
        if ($EnvSKU -ne "Trial")
        {
            Write-Host "Setting users as System Administrators on environments..."
            Setup-AddLabAdminToSysAdmin-StudentEnvs -namePrefix "Prod - "     
        }
        if ($solution -ne "" -and $solution -ne $null)
        {
            Write-Host "Installing solution file"
            Install-SolutionFile-ToEnv -nameprefix "Prod - " -solution $Solution -APIUrl $AdminAPIUrl
        }
     }
     else
     {
        Write-Host "Your current licensed skus are:"
        Get-MsolAccountSku | Format-Table -Property AccountSkuID
        Write-Host "Fix your licenses and then restart"
     }
 
    Write-Host "Setup Ending"
}


class NewEnvInfo {
    [string]$displayname
    [string]$location
    [string]$sku; `
`
    NewEnvInfo(
    [string]$displayname,
    [string]$location,
    [string]$sku
    ){
        $this.displayname = $displayname
        $this.location = $location
        $this.sku = $sku
    }
}

function Setup-ContosoEnvs{

    $newEnvList =@([NewEnvInfo]::new("Device Ordering Development",$CDSlocation,"Trial"))
    
    Add-PowerAppsAccount -Username $UserCredential.UserName -Password $UserCredential.Password -Verbose

    ForEach ($newEnv in $newEnvList) { 

        $envQuery = $newEnv.displayname + "*"
        $envDevList = @(Get-AdminPowerAppEnvironment | where { $_.DisplayName -like $envQuery })         
        
        if ($envDevList.count -eq 0 ) { 
            Write-Host "Creating environment " $newEnv.displayname
            $devEnv = New-AdminPowerAppEnvironment -DisplayName  $newEnv.displayname -LocationName $newEnv.location -EnvironmentSku $newEnv.sku 
            Write-Host "Creating Dataverse:" $newEnv.displayname
            New-AdminPowerAppCdsDatabase -EnvironmentName  $devEnv.EnvironmentName -CurrencyName USD -LanguageName 1033 -ErrorAction Continue -WaitUntilFinished $true
            Wait-ForCDSProvisioning -namePrefix $newEnv.displayname
        }
        else {
            Write-Host "Environment " $newEnv.displayname " already exists - skipping"
        }
    }
}

function Setup-DeviceOrderingSolution{

    Write-Host "Starting import of device admin solution"
    $adminGroup = Get-azureADGroup | where {$_.DisplayName -eq "Lab Admin Team"} | Select-Object -first 1
    $role = 'System Administrator'
    $cdsInstances = Get-CrmInstances -ApiUrl $AdminAPIUrl -Credential $UserCredential 
    $envlist=$cdsInstances.Where({$_.EnvironmentType  -ne 'Default'}).Where({$_.FriendlyName -like  '*Device Ordering Development*' })
    Write-Host "Found " $envlist.length " environments to process"
    ForEach ($environment in $envlist) { 
        Write-Host "Processing environment :" $environment.FriendlyName
        $conn = Connect-CrmOnline -Credential $UserCredential -ServerUrl $environment.ApplicationUrl -ForceOAuth
        $conn.IsReady,$conn.ConnectedOrgFriendlyName
        $currentLocation=Get-Location
        $solutionPath = $currentLocation.Path + "\ContosoDeviceOrderManagement_1_0_0_1.zip"
        if ($PSScriptRoot -ne "" -and $PSScriptRoot -ne $null)
        {
           $solutionPath = $PSScriptRoot + "\ContosoDeviceOrderManagement_1_0_0_1.zip"
        }
        Write-Host "Importing " $solutionPath
        Import-CrmSolution -conn $conn -SolutionFilePath $solutionPath -Verbose   
     }   

     Write-Host "Giving Can Edit permission to labadmins"

     $devEnv = Get-AdminPowerAppEnvironment | where {$_.DisplayName -like 'Device Ordering Development*'}       
     $devApp = get-adminpowerapp -EnvironmentName  $devEnv.EnvironmentName -Filter 'Device Ordering App'
     Set-AdminPowerAppRoleAssignment -PrincipalType Group -PrincipalObjectId $adminGroup.ObjectId -RoleName CanViewWithShare -AppName $devApp.AppName -EnvironmentName $devEnv.EnvironmentName
     Write-Host "Ending import of device admin solution"
}

function Setup-AddLabAdminToSysAdmin-FixedEnvs{

    $userprefix ='labadmin*'
    $userQuery = '*.onmicrosoft.com'
    Write-Host "Starting to add lab admin to dev environment as sysadmin"
    $role = 'System Administrator'
    $cdsInstances = Get-CrmInstances -ApiUrl $AdminAPIUrl -Credential $UserCredential 
    $envlist=$cdsInstances.Where({ $_.FriendlyName -like '*Device Ordering Development*'  })
    Write-Host "Found " $envlist.length " environments to process"
    ForEach ($environment in $envlist) { 
        Write-Host "Processing environment :" $environment.FriendlyName
        $conn = Connect-CrmOnline -Credential $UserCredential -ServerUrl $environment.ApplicationUrl -ForceOAuth
        $conn.IsReady,$conn.ConnectedOrgFriendlyName
        $users = Get-CrmRecords `
               -EntityLogicalName systemuser `
               -Fields domainname,systemuserid, fullname `
               -conn $conn
#       $users = $users.CrmRecords | where {$_.domainname -like $userprefix} | Sort-Object domainname
        $users = $users.CrmRecords | where {$_.UserPrincipalName -like $userQuery} | Sort-Object domainname
        ForEach ($user in $users) { 
            write-host "adding user "  $user.fullname  " to group sysadmin"
            try
            {
                Add-CrmSecurityRoleToUser `
                   -UserId $user.systemuserid `
                   -SecurityRoleName $role `
                   -conn $conn
            }
            Catch
            {
                $ErrorMessage = $_.Exception.Message        
                write-output $ErrorMessage
            }
        }
    }   
    Write-Host "Ending add lab admin to dev environment as sysadmin"
}

function Reset-PL600
{
   <#
    .SYNOPSIS 
      This will delete all existing student environments and then create new ones
    .EXAMPLE
     Reset-PL600 -TenantName 'MX60265ABC'  -CDSLocation 'unitedstates'  'https://admin.services.crm.dynamics.com'
     
     TenantName : This is the name portion of name.onmicrosoft.com     
     CDSLocation: This must match be appropriate for Region e.g. US = unitedstates     
     APIUrl : You can find the url for your region here if not in US - https://docs.microsoft.com/en-us/dynamics365/customer-engagement/developer/online-management-api/get-started-online-management-api
     Solution : This allows you to specify a Dataverse Solution that will be pre-loaded into each student environment
     EnvSKU: This can be either Trial or Production, default is Trial     
    #>
param(
    [Parameter(Mandatory = $true)]
    [string]$TenantName,
    [Parameter(Mandatory = $false)]
    [string]$CDSlocation="unitedstates",   
    [Parameter(Mandatory = $false)]
    [string]$APIUrl = "https://admin.services.crm.dynamics.com",
    [Parameter(Mandatory = $false)]
    [string]$Solution,
    [Parameter(Mandatory = $false)]
    [string]$EnvSKU="Trial"
    )

    Write-Host "Reset Starting"
    Write-Host "Tenant:" $TenantName
    $Tenant = $TenantName;
    Write-Host "Region:" $Region
    $TenantRegion = $Region;
    Write-Host "API Url:" $APIUrl
    $AdminAPIUrl = Get-AdminServiceUrl -CDSlocation $CDSlocation  -APIUrl $APIUrl
    Write-Host "Dataverse Location:" $CDSlocation
   
    $DomainName =$Tenant + ".onmicrosoft.com"
    $UserCredential = Get-Credential

    Write-Host "Connecting to Office 365..."
    Connect-MsolService -Credential $UserCredential
    Write-Host "Connecting to Azure AD..."
    Connect-AzureAD -Credential $UserCredential
    Write-Host "Connecting to PowerApps..."
    try{
        Add-PowerAppsAccount -Username $UserCredential.UserName -Password $UserCredential.Password
    }
    catch { 
       Write-Host "Error connecting to PowerApps, if error includes Cannot find overload for UserCredential please run CleanupOldModules.ps1 and retry this script"
       Read-Host -Prompt 'Press <Enter> to exit, then restart script with proper information'
       exit
    }
    
    $companyInfo = Get-MsolCompanyInformation        
    
    Add-PowerAppsAccount -Username $UserCredential.UserName -Password $UserCredential.Password
    Delete-CDSenvironment -namePrefix "Prod - "
    Wait-ForCDSDeleting -namePrefix "Prod - "
    Create-CDSenvironment -namePrefix "Prod - " -CDSlocation $CDSlocation -password $LabAdminPassword -EnvSKU $EnvSKU
    Add-PowerAppsAccount -Username $UserCredential.UserName -Password $UserCredential.Password
    Create-CDSDatabases -namePrefix "Prod - "

    if ($EnvSKU -ne "Trial")
    {
        Setup-AddLabAdminToSysAdmin-StudentEnvs -namePrefix "Prod - "     
    }

    Install-SolutionFile-ToEnv -nameprefix "Prod - " -solution $Solution -APIUrl $AdminAPIUrl     

    Write-Host "Setup Ending"
}

function Cleanup-PL600
{
  <#
    .SYNOPSIS 
      This will delete all existing student environments 
    .EXAMPLE
     Cleanup-PL600 -TenantName 'MX60265ABC'   'https://admin.services.crm.dynamics.com'
     
     TenantName : This is the name portion of name.onmicrosoft.com     
     APIUrl : You can find the url for your region here if not in US - https://docs.microsoft.com/en-us/dynamics365/customer-engagement/developer/online-management-api/get-started-online-management-api
    #>
param(
    [Parameter(Mandatory = $true)]
    [string]$TenantName,  
    [Parameter(Mandatory = $false)]
    [string]$APIUrl = "https://admin.services.crm.dynamics.com"
    )

    Write-Host "cleanup Starting"

    Write-Host "Tenant:" $TenantName
    $Tenant = $TenantName;
    Write-Host "Region:" $Region
    $TenantRegion = $Region;
    Write-Host "API Url:" $APIUrl
    $AdminAPIUrl = Get-AdminServiceUrl -CDSlocation $CDSlocation  -APIUrl $APIUrl
    Write-Host "Dataverse Location:" $CDSlocation

    $DomainName =$Tenant + ".onmicrosoft.com"
    $UserCredential = Get-Credential

    Write-Host "Connecting to Office 365..."
    Connect-MsolService -Credential $UserCredential
    Write-Host "Connecting to Azure AD..."
    Connect-AzureAD -Credential $UserCredential
    Write-Host "Connecting to PowerApps..."
    try{
        Add-PowerAppsAccount -Username $UserCredential.UserName -Password $UserCredential.Password
    }
    catch { 
       Write-Host "Error connecting to PowerApps, if error includes Cannot find overload for UserCredential please run CleanupOldModules.ps1 and retry this script"
       Read-Host -Prompt 'Press <Enter> to exit, then restart script with proper information'
       exit
    }

    $companyInfo = Get-MsolCompanyInformation                                    

    Add-PowerAppsAccount -Username $UserCredential.UserName -Password $UserCredential.Password
    Delete-CDSenvironment -namePrefix "Prod - "
    Wait-ForCDSDeleting -namePrefix "Prod - "

    Write-Host "Cleanup Ending"
}


function Resume-PL600-CDSProvisioning
{
  <#
    .SYNOPSIS 
      This will resume provisioning student environments in case the inital script has to be restarted
    .EXAMPLE
     Resume-PL600-CDSProvisioning -TenantName 'MX60265ABC'  -CDSLocation 'unitedstates'  'https://admin.services.crm.dynamics.com'
     
     TenantName : This is the name portion of name.onmicrosoft.com     
     CDSLocation: This must match be appropriate for Region e.g. US = unitedstates     
     APIUrl : You can find the url for your region here if not in US - https://docs.microsoft.com/en-us/dynamics365/customer-engagement/developer/online-management-api/get-started-online-management-api
     Solution : This allows you to specify a Dataverse Solution that will be pre-loaded into each student environment
     EnvSKU: This can be either Trial or Production, default is Trial     
    #>
param(
    [Parameter(Mandatory = $true)]
    [string]$TenantName,
    [Parameter(Mandatory = $false)]
    [string]$CDSlocation="unitedstates",   
    [Parameter(Mandatory = $false)]
    [string]$APIUrl = "https://admin.services.crm.dynamics.com",
    [Parameter(Mandatory = $false)]
    [string]$Solution,
    [Parameter(Mandatory = $false)]
    [string]$EnvSKU="Trial"
    )
    Write-Host "Resume Starting"

    Write-Host "Tenant:" $TenantName
    $Tenant = $TenantName;
    Write-Host "Region:" $Region
    $TenantRegion = $Region;
    Write-Host "API Url:" $APIUrl
    $AdminAPIUrl = Get-AdminServiceUrl -CDSlocation $CDSlocation  -APIUrl $APIUrl
    Write-Host "Admin Url:" $AdminAPIUrl
    Write-Host "Dataverse Location:" $CDSlocation

    $DomainName =$Tenant + ".onmicrosoft.com"
    $UserCredential = Get-Credential

    Write-Host "Connecting to Office 365..."
    Connect-MsolService -Credential $UserCredential
    Write-Host "Connecting to Azure AD..."
    Connect-AzureAD -Credential $UserCredential
    Write-Host "Connecting to PowerApps..."
    try{
        Add-PowerAppsAccount -Username $UserCredential.UserName -Password $UserCredential.Password
    }
    catch { 
       Write-Host "Error connecting to PowerApps, if error includes Cannot find overload for UserCredential please run CleanupOldModules.ps1 and retry this script"
       Read-Host -Prompt 'Press <Enter> to exit, then restart script with proper information'
       exit
    }
            
    $companyInfo = Get-MsolCompanyInformation                                    

    Add-PowerAppsAccount -Username $UserCredential.UserName -Password $UserCredential.Password
    Create-CDSenvironment -namePrefix "Prod - " -CDSlocation $CDSlocation -password $LabAdminPassword -EnvSKU $EnvSKU
    Add-PowerAppsAccount -Username $UserCredential.UserName -Password $UserCredential.Password
    Create-CDSDatabases -namePrefix "Prod - "

   if ($EnvSKU -ne "Trial")
   {
       Setup-AddLabAdminToSysAdmin-StudentEnvs -namePrefix "Prod - "     
    }

    Install-SolutionFile-ToEnv -nameprefix "Prod - " -solution $Solution -APIUrl $AdminAPIUrl

    Write-Host "Setup Ending"
}

function Verify-Licenses
{
  param(  
  [Parameter(Mandatory = $true)]
    [string]$Tenant,  
    [Parameter(Mandatory = $true)]
    [int]$UserCount=1    
    )
    
    $licensesGood = $true

    $skus = Get-MsolAccountSku
    $skuquery = $Tenant+":"+$LabAdminPowerLicense
    $sku = $skus.where({$_.AccountSkuId -eq $skuquery}) 
    if ($sku -eq $null -or $sku.Count -eq 0)
    {
        Write-Host "No License in tenant for LabAdminPowerLicense " $LabAdminPowerLicense " Add license or change sku before you continue" -ForegroundColor red
        $licensesGood = $false
    }
    if ($LabADminOfficeLicense -ne $null -and $LabADminOfficeLicense -ne "")
    {
        $skuquery = $Tenant+":"+$LabAdminOfficeLicense
        $sku = $skus.where({$_.AccountSkuId -eq $skuquery}) 
        if ($sku -eq $null -or $sku.Count -eq 0)
        {
            Write-Host "No License in tenant for LabAdminOfficeLicense " $LabAdminOfficeLicense " Add license or change sku before you continue" -ForegroundColor red
            $licensesGood = $false
        }
    }

    return $licensesGood
}

function Delete-DemoUsers {

    Write-Host "***Removing Demo Users ****" -ForegroundColor Green

#    Get-MsolUser | where {$_.UserPrincipalName -notlike $userCredential.UserName}|Remove-MsolUser -Force

    $userQuery = $LabAdminPrefix+'*'
    Get-MsolUser | where {$_.UserPrincipalName -like $userQuery} | Remove-MsolUser -Force


    Write-Host "****Old Users Deleted ****" -ForegroundColor Green
    Get-MsolUser |fl displayname,licenses

}

function List-Users
{
    $userQuery = '*.onmicrosoft.com'
    $studentUsers = Get-MsolUser | where {$_.UserPrincipalName -like $userQuery} | where {$_.UserPrincipalName -ne $UserCredential.UserName} | Sort-Object UserPrincipalName
}

function Setup-AddLabAdminRoles
{
    $roleName="Power Platform Administrator"
    $role = Get-AzureADDirectoryRole | Where {$_.displayName -eq $roleName}
    if ($role -eq $null) {
        $roleTemplate = Get-AzureADDirectoryRoleTemplate | Where {$_.displayName -eq $roleName}
        Enable-AzureADDirectoryRole -RoleTemplateId $roleTemplate.ObjectId
        $role = Get-AzureADDirectoryRole | Where {$_.displayName -eq $roleName}
    }
    $role.Description

    $userQuery = '*.onmicrosoft.com'
    $studentUsers = Get-MsolUser | where {$_.UserPrincipalName -like $userQuery} | where {$_.UserPrincipalName -ne $UserCredential.UserName} | Sort-Object UserPrincipalName
    ForEach ($user in $studentUsers)
    { 
        try
        {
            write-host "adding user " $user.UserPrincipalName " to role" $role.DisplayName
            Add-AzureADDirectoryRoleMember -ObjectId $role.ObjectId -RefObjectId (Get-AzureADUser | Where {$_.UserPrincipalName -eq $user.UserPrincipalName}).ObjectID
        }
        catch {}
    }
}

function Create-LabAdminUsers
{
   param
    (
    [Parameter(Mandatory = $true)]
    [string]$Tenant,
    [Parameter(Mandatory = $true)]
    [int]$Count,
    [Parameter(Mandatory = $false)]
    [string]$TenantRegion="GB",
    [Parameter(Mandatory = $false)]
    [string]$password=$UserPassword,
    [Parameter(Mandatory = $false)]
    [string]$userprefix="labadmin",
    [Parameter(Mandatory = $false)]
    [int]$startCount=1,
    [Parameter(Mandatory = $false)]
    [string]$powerLicense=$LabAdminPowerLicense
    
    )

    $DomainName = $Tenant+".onmicrosoft.com"
    
    Write-Host "Tenant: " $Tenant
    Write-Host "Domain Name: " $DomainName
    Write-Host "Count: " $Count
    Write-Host "Licence Plans: " (Get-MsolAccountSku).AccountSkuId
    Write-Host "TenantRegion: " $TenantRegion
    Write-Host "CDSlocation: " $CDSlocation
    Write-Host "password: " $password

    $securepassword = ConvertTo-SecureString -String $password -AsPlainText -Force
    
    Write-Host "creating users " -ForegroundColor Green
   
    for ($i=$startCount;$i -lt $Count+1; $i++) {
        $firstname = "Lab"
        $lastname = "Admin" + $i
        $displayname = "Lab Admin " + $i
        $email = ($userprefix + $i + "@" + $DomainName).ToLower()
        $existingUser = Get-MsolUser -UserPrincipalName $email -ErrorAction SilentlyContinue

        if($existingUser -eq $Null)
        {
             New-MsolUser -DisplayName $displayname -FirstName $firstname -LastName $lastname -UserPrincipalName $email -UsageLocation $TenantRegion -Password $password -LicenseAssignment $Tenant":"$powerLicense -PasswordNeverExpires $true -ForceChangePassword $false  
         
             if ($LabADminOfficeLicense -ne $null -and $LabADminOfficeLicense -ne "")
             {
                Set-MsolUserLicense -UserPrincipalName $email -AddLicenses $Tenant":"$LabADminOfficeLicense
                #For E3 Set-MsolUserLicense -UserPrincipalName $email -AddLicenses $Tenant":ENTERPRISEPACK" -Verbose
                #For E5 Set-MsolUserLicense -UserPrincipalName $email -AddLicenses $Tenant":ENTERPRISEPREMIUM" -Verbose
            } 
        }
         
    }
    Write-Host "*****************Lab Users Created ***************" -ForegroundColor Green
    $userQuery = $LabAdminPrefix+'*'
    $studentUsers = Get-MsolUser | where {$_.UserPrincipalName -like $userQuery}
}


function Setup-AddLabAdminToGroup
{
   Write-Host "Starting add labadmin users to Lab Admin Team group"

   $userprefix =$LabAdminPrefix+'*'
   $adminGroup = Get-azureADGroup | where {$_.DisplayName -eq "Lab Admin Team"} | Select-Object -first 1

   if (!$adminGroup)
   {
        $adminGroup = New-AzureADGroup -Description "Lab Admin Team" -DisplayName "Lab Admin Team" -MailEnabled $false -SecurityEnabled $true -MailNickName "LabAdmins"
        Write-Host "Created new group " $adminGroup.ObjectId
        write-host "Short delay to allow group creation to finish..."
        Start-Sleep -s 15
   }
   else
   {
        Write-Host "Found existing group " $adminGroup.ObjectId
   }

   $userQuery = '*.onmicrosoft.com'
   $studentUsers = Get-MsolUser | where {$_.UserPrincipalName -like $userQuery} | where {$_.UserPrincipalName -ne $UserCredential.UserName} | Sort-Object UserPrincipalName
   $users = $studentUsers | Sort-Object UserPrincipalName
   $existingMembers = Get-AzureADGroupMember -ObjectId $adminGroup.ObjectId | Select -ExpandProperty UserPrincipalName

   ForEach ($user in $users) { 

       if (!$existingMembers -contains $user.UserPrincipalName)
       {
           write-host "adding user "  $user.UserPrincipalName  " to group "  $adminGroup.DisplayName
           Add-AzureADGroupMember -ObjectId $adminGroup.ObjectId -RefObjectId $user.ObjectId
       }
       else
       {
           write-host "user "  $user.UserPrincipalName  " is already a member of "  $adminGroup.DisplayName
       }
    }
    Write-Host "Ending add labadmin users to Lab Admin Team group"
}


function Install-SolutionFile-ToEnv
{
 param(
    [Parameter(Mandatory = $true)]
    [string]$namePrefix="Central Apps Test - ",
    [Parameter(Mandatory = $false)]
    [string]$solution,
    [Parameter(Mandatory = $false)]
    [string]$APIUrl = "https://admin.services.crm.dynamics.com"   
    )

    Write-Host "Starting import of starting solution"
    
    if ($solution -ne "" -and $solution -ne $null)
    {
        $cdsInstances = Get-CrmInstances -ApiUrl $APIUrl -Credential $UserCredential 

        $envQuery = '*'+$namePrefix+'*'
        $envlist=$cdsInstances.Where({$_.EnvironmentType  -ne 'Default'}).Where({$_.FriendlyName -like  $envQuery })

        Write-Host "Found " $envlist.Count " environments to process"

        ForEach ($environment in $envlist) { 
           Write-Host "Processing environment :" $environment.FriendlyName

           $conn = Connect-CrmOnline -Credential $UserCredential -ServerUrl $environment.ApplicationUrl -ForceOAuth
           $solutionPath = $PSScriptRoot + "\" + $solution

           Write-Host "Importing " $solutionPath

           try{
                Import-CrmSolution -conn $conn -SolutionFilePath $solutionPath -PublishChanges $true
           }
           Catch
           {
               $ErrorMessage = $_.Exception.Message        
               if ($ErrorMessage -like '*timeout*' -or $ErrorMessage -like '*Underlying connection was closed*' )
               { 
                    write-host "  retrying import due to timeout after short delay"
                    Start-Sleep -s 30
                    Import-CrmSolution -conn $conn -SolutionFilePath $solutionPath -Verbose -PublishChanges $true
               }
               else
               {
                   write-host $ErrorMessage -ForegroundColor Red
               }
            }
        }   
    }
     
    Write-Host "Ending import of starting solution"
}

function Verify-SolutionFile-ToEnv
{
 param(
    [Parameter(Mandatory = $true)]
    [string]$namePrefix="Development",
    [Parameter(Mandatory = $true)]    
    [string]$uniquename="ContosoDeviceOrderManagement",
    [Parameter(Mandatory = $false)]
    [string]$APIUrl = "https://admin.services.crm.dynamics.com"   
    )

    Write-Host "Starting verify solution"
   
    $cdsInstances = Get-CrmInstances -ApiUrl $APIUrl -Credential $UserCredential 

    $envQuery = '*'+$namePrefix+'*'
    $envlist=$cdsInstances.Where({$_.EnvironmentType  -ne 'Default'}).Where({$_.FriendlyName -like  $envQuery })

    Write-Host "Found " $envlist.Count " environments to process"

    ForEach ($environment in $envlist) { 
     
        Write-Host "Processing environment :" $environment.FriendlyName
        $conn = Connect-CrmOnline -Credential $UserCredential -ServerUrl $environment.ApplicationUrl -ForceOAuth
        $solutionList = Get-CrmRecords `
            -EntityLogicalName solution `
            -Fields uniquename `
            -conn $conn

        $sol = $solutionList.CrmRecords.Where({$_.uniquename -eq $uniquename})
        if ($sol.Count -eq 1)
        {
            Write-Host "   Solution verified" -ForegroundColor Green
        }
        else
        {
            Write-Host "   Solution Not Found:" $environment.FriendlyName -ForegroundColor Red
        }
    
    }   
    Write-Host "Ending verify of starting solution"

    if ($sol.Count -eq 1)
    {
        return $true
    }
    else
    {
        return $false
    }
}

function Create-CDSenvironment {

    param(
    [Parameter(Mandatory = $true)]
    [string]$namePrefix="Prod - ",
    [Parameter(Mandatory = $false)]
    [string]$password=$UserPassword,
    [Parameter(Mandatory = $false)]
    [string]$CDSlocation="canada",
    [Parameter(Mandatory = $false)]
    [string]$EnvSKU="Trial"
    )

    $userprefix = $LabAdminPrefix + '*'

    $starttime= Get-Date -DisplayHint Time
    Write-Host " Starting CreateCDSEnvironment :" $starttime   -ForegroundColor Green

    $userQuery = '*.onmicrosoft.com'
    $studentUsers = Get-MsolUser | where {$_.UserPrincipalName -like $userQuery} | where {$_.UserPrincipalName -ne $UserCredential.UserName} | Sort-Object UserPrincipalName

    $securepassword = ConvertTo-SecureString -String $password -AsPlainText -Force
    $users = Get-MsolUser | where {$_.UserPrincipalName -like $userprefix } | Sort-Object UserPrincipalName
    $users=$studentUsers
    $allEnvList = @(Get-AdminPowerAppEnvironment)
    
    ForEach ($user in $users) { 
        $envDev=$null
        $envProd=$null

        if ($user.isLicensed -eq $false)
        {
            write-host " skiping user " $user.UserPrincipalName " he is not licensed" -ForegroundColor Red
            continue
        }

        if ($EnvSKU -eq "Trial")
        {
            write-host " switching to user " $user.UserPrincipalName 
            Add-PowerAppsAccount -Username $user.UserPrincipalName -Password $securepassword -Verbose
        }

        write-host " creating environment for user " $user.UserPrincipalName 
         
        $envDisplayname = $namePrefix + $user.UserPrincipalName.Split('@')[0] 
        $envDisplayname
        $envQuery = $envDisplayname + "*"
        $envDevList = @($allEnvList.where( { $_.DisplayName -like $envQuery }))         
        
        if ($envDevList.count -eq 0 ) { 
       
            $envDev = New-AdminPowerAppEnvironment -DisplayName  $envDisplayname -LocationName $CDSlocation -EnvironmentSku $EnvSKU 
            Write-Host " Created Power Platform Environment with id :" $envDev.DisplayName   -ForegroundColor Green 
        }
        else{
            Write-Host " Skipping Power Platform Environment with id :" $envDev.DisplayName " it already exists"  -ForegroundColor Green 
        }
    }

    if ($EnvSKU -eq "Trial")
    {
        write-host " switching back to user " $UserCredential.UserName 

        Add-PowerAppsAccount -Username $UserCredential.UserName -Password $UserCredential.Password
    }
    $endtime = Get-Date -DisplayHint Time
    $duration = $("{0:hh\:mm\:ss}" -f ($endtime-$starttime))
    Write-Host "End of CreateCDSEnvironment at : " $endtime "  Duration: " $duration   -ForegroundColor Green
}


function Create-CDSDatabases {
 param(
    [Parameter(Mandatory = $true)]
    [string]$namePrefix="Prod - "
    )

        $searchPrefix = '*' + $namePrefix + '*'
        $starttime= Get-Date -DisplayHint Time
        Write-Host "Starting CreateCDSDatabases :" $starttime   -ForegroundColor Green

        $CDSenvs = Get-AdminPowerAppEnvironment | where { $_.DisplayName -like $searchPrefix -and $_.commonDataServiceDatabaseType -eq "none"} | Sort-Object displayname
        
        Write-Host "creating Dataverse databases for following environments :
          " $CDSenvs.DisplayName "
        ****************************************************************
        ****************************************************************" -ForegroundColor Green

        ForEach ($CDSenv in $CDSenvs) { 
            $CDSenv.EnvironmentName
            Write-Host "creating Dataverse databases for:" $CDSenv.DisplayName " id:" $CDSenv.EnvironmentName -ForegroundColor Yellow
            New-AdminPowerAppCdsDatabase -EnvironmentName  $CDSenv.EnvironmentName -CurrencyName USD -LanguageName 1033  -ErrorAction Continue -WaitUntilFinished $false   -Templates @(“D365_CDSSampleApp“)
        }

        Wait-ForCDSProvisioning -namePrefix $namePrefix

        $endtime = Get-Date -DisplayHint Time
        $duration = $("{0:hh\:mm\:ss}" -f ($endtime-$starttime))
        Write-Host "End of CreateCDSDatabases at : " $endtime "  Duration: " $duration   -ForegroundColor Green       
}

function Wait-ForEnvProvisioning{

param(
    [Parameter(Mandatory = $true)]
    [string]$namePrefix="Prod - ",
    [Parameter(Mandatory = $true)]
    [int]$envCount
    )

        $searchPrefix = '*' + $namePrefix + '*'
        $count=0

        Write-host "Checking on provisioning status of environments"
        Do  
        {
            $CDSenvs = @(Get-AdminPowerAppEnvironment | where { $_.DisplayName -like $searchPrefix  })         
            if ($CDSenvs.count -ne $envCount)
            {
                $count++
                Write-Host "There are" $CDSenvs.count "environments of $envCount - Waiting 10 seconds "
                Start-Sleep -s 10
            }
        } While ($CDSenvs.count -ne $envCount -and $count -lt 5)
}

function Wait-ForCDSProvisioning{

param(
    [Parameter(Mandatory = $true)]
    [string]$namePrefix="Prod - "
    )

        $searchPrefix = '*' + $namePrefix + '*'

        Write-host "Checking on provisioning status of CDS"
        Do  
        {
            $CDSenvs = @(Get-AdminPowerAppEnvironment | where { $_.DisplayName -like $searchPrefix -and $_.CommonDataServiceDatabaseProvisioningState -ne "Succeeded" })         
            
            if ($CDSenvs.count -gt 0)
            {
                $count++
                Write-Host "There are" $CDSenvs.count "Dataverse provisionings left - Waiting 10 seconds "
                Start-Sleep -s 10
            }
        } While ($CDSenvs.count -gt 0 -and $count -lt 10)
}

function Wait-ForCDSDeleting{

param(
    [Parameter(Mandatory = $true)]
    [string]$namePrefix="Prod - "
    )

        $searchPrefix = '*' + $namePrefix + '*'

        Write-host "Checking on delete status of CDS"
        Do  
        {
            
            $CDSenvs = @(Get-AdminPowerAppEnvironment | where { $_.DisplayName -like $searchPrefix  })         

            if ($CDSenvs.count -gt 0)
            {
                Write-Host "There are" $CDSenvs.count "Dataverse removals left - Waiting 30 seconds "
                Start-Sleep -s 30
            }
        } While ($CDSenvs.count -gt 0)
}

function Setup-AddLabAdminToSysAdmin-StudentEnvs{

    param(
    [Parameter(Mandatory = $true)]
    [string]$namePrefix="Prod - ",
    [Parameter(Mandatory = $false)]
    [string]$APIUrl = "https://admin.services.crm.dynamics.com"
    )

    Write-Host "Starting add lab admin to test environment as sysadmin"

    $AdminAPIUrl = Get-AdminServiceUrl -CDSlocation $CDSlocation  -APIUrl $APIUrl
    $role = 'System Administrator'
    $cdsInstances = Get-CrmInstances -ApiUrl $AdminAPIUrl -Credential $UserCredential 
    $searchPrefix = '*' + $namePrefix + '*'
    $envlist=$cdsInstances.Where({$_.EnvironmentType  -ne 'Default'}).Where({$_.FriendlyName -like $searchPrefix })

    Write-Host "Found " $envlist.count " environments to process"

        ForEach ($environment in $envlist) { 
    
            Write-Host "Processing environment :" $environment.FriendlyName
            $conn = Connect-CrmOnline -Credential $UserCredential -ServerUrl $environment.ApplicationUrl -ForceOAuth
#            $conn.IsReady
#            $conn.ConnectedOrgFriendlyName
            $users = Get-CrmRecords `
               -EntityLogicalName systemuser `
               -Fields domainname,systemuserid, fullname `
               -conn $conn
              
            $compareString =$conn.ConnectedOrgFriendlyName -replace $namePrefix,"*" 
            $compareString = $compareString +  "@*"
#            Write-Host "comparing("$compareString")"

            $selectedUsers = $users.CrmRecords | where { $_.domainname -like $compareString} | Sort-Object domainname

#            Write-Host "Found "$selectedUsers.count " users to process"

            ForEach ($user in $selectedUsers) { 

#            write-host "  adding user "$user.fullname" to group sysadmin"

            try
            {
                Add-CrmSecurityRoleToUser `
                   -UserId $user.systemuserid `
                   -SecurityRoleName $role `
                   -conn $conn

                write-host "  added user "  $user.fullname  " to group sysadmin"
            }
            Catch
            {
                $ErrorMessage = $_.Exception.Message        
                if ($ErrorMessage -like '*Cannot insert duplicate key*')
                { 
                    write-host "  Skipping user "  $user.fullname  " already a member"
                }
                else
                {
                    write-host $ErrorMessage -ForegroundColor Red
                }
            }
        } #foreach user
    }   #foreach env
    Write-Host "Ending add lab admin to test environment as sysadmin"
}

function Get-AdminServiceUrl
{
param(   
    [Parameter(Mandatory = $false)]
    [string]$CDSlocation="unitedstates",
    [Parameter(Mandatory = $false)]
    [string]$APIUrl="https://admin.services.crm.dynamics.com"
    )
   $result = switch ( $CDSlocation )
    {
        "unitedstates" { 'https://admin.services.crm.dynamics.com'    }
        "southamerica" { 'https://admin.services.crm2.dynamics.com'    }
        "canada" { 'https://admin.services.crm3.dynamics.com'    }
        "europe" { 'https://admin.services.crm4.dynamics.com'    }
        "asia" { 'https://admin.services.crm5.dynamics.com'    }
        "australia" { 'https://admin.services.crm6.dynamics.com'    }
        "japan" { 'https://admin.services.crm7.dynamics.com'    }
        "india" { 'https://admin.services.crm8.dynamics.com'    }
        "unitedkingdom" { 'https://admin.services.crm11.dynamics.com'    }
        "france" { 'https://admin.services.crm12.dynamics.com'    }
        default { $APIUrl    }
       
    }

    return $result
}

function Delete-CDSenvironment
{
param(
    [Parameter(Mandatory = $true)]
    [string]$namePrefix="Prod - "    
    )
  
    $searchPrefix =  $namePrefix + '*'
    
    #delete all environment
    $envlist=Get-AdminPowerAppEnvironment | where {$_.DisplayName -like $searchPrefix}
    ForEach ($environment in $envlist) { 
        Remove-AdminPowerAppEnvironment -EnvironmentName $environment.EnvironmentName
    }
}
