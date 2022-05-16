Setup PL-600 student tenant
===========================

All delegates, and instructor, share the same tenant. As this is a shared environment, some tasks require a tenant Global Administrator role need to be completed by the instructor prior to the course.

It is recommended to use an online lab provided with an Authorized Lab Hoster (ALH) for this course. Alternatively, you can create trial tenant with a Power Apps trial license.

There are a series of instructions that required to performed to prepare for delivery of the course for both online lab and trial options:

- ALM lab setup: Creates users, groups, and environments
- RPA lab setup: Adds a trial of Power Automate RPA and configures users
- App exercise setup: Import a solution and create test data

> [!IMPORTANT]
> Do not use this on your production live tenants as it creates and delete users and environments.

Location of files
-----------------

The location of the files for the setup for this course are in GitHub <https://github.com/MicrosoftLearning/PL-600-Microsoft-Power-Platform-Solution-Architect/tree/master/Allfiles>

Step 1 – Download files from GitHub
------------------------------------------------

1. In Windows, open Windows PowerShell

    Make sure you open PowerShell as an **administrator**. See <https://docs.microsoft.com/powershell/scripting/learn/ps101/01-getting-started#how-do-i-launch-powershell> for how to start PowerShell

> [!NOTE]
> You can use the PowerShell command line or the PowerShell ISE. The setup process is documented to use, and was tested with, the Windows PowerShell ISE application. If you are not familiar with Windows PowerShell ISE, you can find more information at <https://docs.microsoft.com/en-us/powershell/scripting/windows-powershell/ise/introducing-the-windows-powershell-ise>.

1. New-Item -Path "C:\\" -Name "LabFiles" -ItemType "directory"
1. Set-Location C:\LabFiles
1. Import-Module -Name BitsTransfer
1. Start-BitsTransfer -Source 'https://github.com/MicrosoftLearning/PL-600-Power-Platform-Solution-Architect/archive/master.zip' -Destination C:\LabFiles
1. Expand-Archive -Path 'C:\LabFiles\master.zip' -DestinationPath 'C:\LabFiles'
1. Move-item -Path "C:\LabFiles\PL-600-Microsoft-Power-Platform-Solution-Architect-master\\*" -Destination "C:\LabFiles" -confirm:$false
1. Remove-Item master.zip
1. Remove-Item PL-600-Microsoft-Power-Platform-Solution-Architect-master
1. Set-Location C:\LabFiles\Allfiles

Step 2 – Create a new Trial tenant (if required)
------------------------------------------------

If you are using an Authorized Lab Hoster lab, there are 24 users pre-created on the tenant all of whom have the System Administrator role on the production environment. The production environment will be named WWLLABNNN where NNN is a number.

If you are not using an Authorized Lab Hoster lab, you will need to create a Power Apps trial. The steps are contained in the **Power Platform Trial Setup** instructions which can be found in *Allfiles**.

If you are using a trial tenant, you will need to create a new trial environment and name it Production, create users, and add the users to the environment with the System Administrator role.

Step 3 - RPA Lab Setup
----------------------

Follow the steps in the RPA lab setup document. In these instructions you will add a trial of Power Automate RPA and configure users.

Step 4 - App Exercise Setup
---------------------------

Follow the steps in the App lab setup document. In these instructions you will import the solution used in the exercise.
