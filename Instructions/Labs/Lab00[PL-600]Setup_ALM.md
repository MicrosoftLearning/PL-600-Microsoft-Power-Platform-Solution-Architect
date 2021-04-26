---
lab:
    title: 'Lab 00: Validate lab environment'
---

# Lab 0 - Setup for ALM lab
1.  Get a new Azure Pass (valid for 30-days) from the instructor or other source. 
2.  Use a private browser session, go to Microsoftazurepass.com to redeem your Azure Pass using the tenant credentials provided to you). (Redeem a Microsoft Azure Pass) Follow the instructions for redemption. 
3.  Using the same browser session, go to portal.azure.com, then search for “Azure DevOps”. In the resulting page, click Azure DevOps Organizations. 
4.  Next, click on the link called “My Azure DevOps Organizations” (or navigate to https://aex.dev.azure.com/).
5.  Create a new organization (find blue box in upper right-hand corner of the screen) using the Default directory.
6.  Choose the newly created organization, then choose Organization settings on the left-hand side of the screen
7.  Navigate to Organization settings -> Billing -> Setup billing -> Select an Azure subscription, then select the Azure Pass subscription, then choose “MS Hosted CI/CD” and set the field “Paid parallel jobs” to 1. Then click SAVE in the blue box at the bottom. 
8.  Wait at least 3 hours before using the CI/CD capabilities so that new settings are reflected in the back end. Otherwise you will still see the message “This agent is not running because you have reached the maximum number of requests…”.
9. As an optional step, you can validate this by creating a new pre-defined project using the newly created org with billing enabled, using https://azuredevopsdemogenerator.azurewebsites.net/. Wait for some time before trying, then run a test build. [Not necessary for PL-600]
