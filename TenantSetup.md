Setup MB600 student tenant
==========================

This document is intended to help setup a tenant provisioned from https://cdx.transform.microsoft.com/ to run the workshop.  The script provides a set of commands to automate creating users, assigning licenses and creating a trial environment with Common Data Service for each user.

Do not use this on your production live tenants as it does delete users and
environments. You will create a tenant at demos.microsoft.com and make sure to
use those credentials.

This setup process is documented to use the Windows PowerShell ISE application.
If you aren’t familiar with it you can find more information here
<https://docs.microsoft.com/en-us/powershell/scripting/components/ise/introducing-the-windows-powershell-ise?view=powershell-6>

Step 1 – Create a new Demo tenant
---------------------

1. Sign up for a new demo at https://cdx.transform.microsoft.com/

2. Select **My Environments -\> Create Tenant**

3. Select **Type of Quick Tenant**

4. Choose **Microsoft 365 Enterprise with Users and No Content.** Create the tenant.

5. Make note of the admin user and password. You might have to wait a minute or two for the tenant to be provisioned first before they are available.

6.  **Open a new private browser session** and go to admin.microsoft.com. Login
    with your tenant credentials.

7.  Go to **Billing -\>Purchase Services** and Search on **Power Apps per User
    Plan** and click on it.

8.  Click **Get free trial**.

9.  Click **Try now**.

10.  Click **Continue**.

11.  Now assign one of these licenses to your admin user, this will leave 24 that
    you can use with the remaining script setup.

12.  In the same browser sessions, navigate to aka.ms/ppac

13.  Select **Environments** and make sure you can see the default environment.

14.  Click on the default environment it will take you to admin.powerapps.com

15. Change the environment name to **Personal Productivity** and click **Save**.

Step 2 - Run Setup Script
-------------------------

Note: If you receive errors or messages not documented in these steps, review
the known issues below for possible resolution.

Wait and give some time for the tenant to sync user licensing.

1.  From Windows Start search on and run the Windows PowerShell ISE application.

2.  File -\> Open **Setup.ps1.**

3.  Run the script by pressing F5 or by clicking the play icon. This just loads
    the setup commands it does not start the actual setup process. You will know
    this is completed when the command prompt becomes available again.

4.  If you see errors or warnings resolve them prior to continuing

5.  **Note**: If you have incompatible PowerShell modules already installed you
    might get an error prompting you to run CleanupOldModules.ps1. Close all
    PowerShell sessions and run this script which will remove all PowerShell
    modules used by the setup script so the setup script can then install the
    versions it requires.

6.  Run the **Start-MB600-Setup** command; use the parameters to provide tenant
    and configuration information like shown in the following example commands:

    -   North America tenant example:  
        **Start-MB600-Setup -TenantName MX12345ABC -CDSLocation unitedstates
        -UserCount 24**

    -   Europe tenant example:  
        **Start-MB600 -Setup -TenantName MX12345ABC -CDSLocation europe**  
        **-UserCount 24**  
        

    -   When choosing your User Count keep in mind the number of licenses you
        have available

    -   When you are prompted for your tenant admin account **make sure to
        provide the account only for your demo tenant admin.**

    -   You can get parameter help using **get-help Start**-**MB600-Setup**
        -Detailed

This should now cycle through creating your users and their environments. This
may take several minutes. You will see a command prompt when this is complete.
Review the log for any errors you may need to address. You may re-run the setup
script to attempt to resolve errors that occurred during the prior run.

It’s always good to manually review a few of the users and environments prior to
your event.

The users that are created follow a naming convention of
<labadminXX@yourtenant.onmicrosoft.com>; with a password of test\@word1. The XX
is replaced by the numbered user up to the number of users you provisioned with
the script.

Other commands available
------------------------

-   In the event CDS provisioning does not complete you can run just that using
    the **Resume-MB600-CDSProvisioning** command to finish that part of setup.

Known Issues
------------

-   You might receive warning messages about PSGallery – if you wish to suppress
    those messages you can use the following command to change your trust level
    on the gallery
    
    ```
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
    ```
    
-   Some computers have restrictive policies for running unsigned scripts – you
    can adjust your execution policy using the information provided here if
    needed https:/go.microsoft.com/fwlink/?LinkID=135170

-   Sometimes on copy and paste line spacing loses formatting. If the behavior
    is not as expected, review the spacing.
