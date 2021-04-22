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

The location of the files for the setup for this course are in GitHub <https://github.com/MicrosoftLearning/PL-600-Power-Platform-Solution-Architect/tree/master/Allfiles>

Step 1 – Create a new Trial tenant (if required)
------------------------------------------------

If you are not using an Authorized Lab Hoster lab, you will need to create a Power Apps trial. The steps are contained in the **Power Platform Trial Setup** instructions which can be found in *Allfiles**

Step 2 - ALM Lab Setup
----------------------

Follow the steps in the ALM lab setup document. This uses a PowerShell script to creates user, security groups, environments, and import a solution.

If you see errors or warnings when running the script, resolve them prior to continuing

> [!NOTE]
> If you have incompatible PowerShell modules already installed you might get an error prompting you to run CleanupOldModules.ps1. Close all PowerShell sessions and run th CleanupOldModules.ps1 script which will remove all PowerShell modules used by the setup script so the setup script can then install the versions it requires.

This should now cycle through creating your users and their environments. This may take several minutes. You will see a command prompt when this is complete. Review the log for any errors you may need to address. You may re-run the setup script to attempt to resolve errors that occurred during the prior run.

If you are using an Authorized Lab Hoster lab, there are 24 users pre-created on the tenant. If you are using a trial tenant, the script creates users that follow a naming convention of **<labadminXX@yourtenant.onmicrosoft.com>**; with a password of **test\@word1**. The XX is replaced by the numbered user up to the number of users you provisioned with the script.

Step 3 - RPA Lab Setup
----------------------

Follow the steps in the RPA lab setup document. In these instructions you will add a trial of Power Automate RPA and configures users.

Step 4 - App Exercise Setup
---------------------------

Follow the steps in the App lab setup document. In these instructions you will import a solution add a trial of Power Automate RPA and configures users.
