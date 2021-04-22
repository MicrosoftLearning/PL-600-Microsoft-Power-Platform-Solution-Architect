**Module 8: Application Lifecycle Management**
==============================================

**Lab Scenario**
----------------

In this hands-on lab, you are an administrator for Contoso, helping them adopt
the Power Platform.

The team building the “Device Order Management” app is now ready to transport
the solution from their development environment to the test environment for
testing.

In this lab, you will be using Azure DevOps and the Power Apps build tools to
automate checking the solution into a source control repository and then use
that to deploy to test and production environment.

**Lab Test Environment**
------------------------

You will be assigned one or more users to use to complete the tasks. As this is
a shared environment, some tasks that require a tenant Global Administrator or a
Service Administrator role will have already been performed.

**Exercise 1: Initialize Azure DevOps**
---------------------------------------

In this exercise, you will be signing up for an Azure DevOps account and
configuring the Power Apps build tools for the account.

**Note:** If you already have Azure DevOps outside of this course and this
environment, you **CANNOT** use that here. You will need to follow the below
instructions to sign up.

### **Task 1: Signup for Azure DevOps**

1.  Log on to <https://dev.azure.com> and click **Sign into Azure DevOps;** use
    the credentials from your instructor.

2.  Provide your credentials and click **Next**.

3.  Provide a **Password** and click **Sign in**.

4.  Click **Continue**.

5.  Provide a unique **Azure DevOps Organization** name such as lastnameMMYY,
    select a location closest to your tenant, enter captcha and click
    **Continue**. *Replace lastname with your last name, MM current month and YY
    current year.*

    **Note:** For some users, the DevOps Organization is automatically created using your username.
	This is OK and you do not need to rename the Organization.

    **Note:** For some users, this page has a heading “We need a few more
    details”. Ensure that you enter the organization name and not miss this
    step.

6.  Enter **Device Management lastnameMMYY** for **Project Name** and click
    **Continue**. *Replace lastname with your Last name, MM with current month,
    and YY with current year.* Select **Private**for **Project Visibility**. This will take 3-7 seconds to configure and
    navigate to the Project’s Home page.

7.  Projects are containers in Azure DevOps that track work items and source
    assets. When you set up the automation for the deployment tasks, those will
    be pipelines built in the context of a project.

8.  Select **Repos \| Files**.

9.  An Azure Repo is a source/version control container inside the Azure DevOps
    project and is used to track changes you make. You will be using it to store
    the solution files for the team building the Device Ordering app.

10. Scroll down and check the **Add a Readme** checkbox and then click
    **Initialize**.

### **Task 2: Configure Power Apps Build Tasks**

1.  Log on to <https://marketplace.visualstudio.com/azuredevops>

2.  Search for **PowerApps**.

3.  Select **PowerApps BuildTools**.

4.  Click **Get it Free**.

5.  Select the **Azure DevOps** organization you created and click **Install**.

6.  Click **Proceed to Organization**. This will open a new tab for the project.

7.  Click to open the **Device Management lastnameMMYY** project you created.

8.  Click **Project Settings** in the bottom left corner of the Azure DevOps.

9.  Select **Repositories** in the settings pane.

10. Navigate to the **Permissions** tab then select **Project Collection Build Service Accounts**

11. Locate **Contribute** and set it to **Allow**.

12. Search for **Project Collection Build Service** and select the Project Collection without Accounts at the end of the name.

13. Locate **Contribute** and set it to **Allow**.

**Exercise 2: Build Export Pipeline**
-------------------------------------

In this exercise, you will build an Azure DevOps pipeline that will export the
solution from the development environment, unpack the solution file to
individual files and then check those files into the repository. These solution
files can then be used to re-create development environments or promote the
solution to test/production.

### **Task 1: Export Solution**

1.  Create a Build Pipeline.

    1.  Click to expand **Pipelines**.

    2.  Click **Create Pipeline**.

    3.  Click **Use the Classic Editor to create a pipeline without YAML.**

    4.  Click **Continue**. Do not change the default values.

    5.  Select **Empty Job**.

    6.  Click **Save and Queue** and select **Save**.

    7.  Click **Save**.

2.  Add PowerApps Tool Installer task.  This is found under **Deprecated Tasks**
    **Note:** The PowerApps Tool Installer needs to be run before any other
    PowerApps build tasks.

    1.  Click **+ Add Task** to **Agent Job 1**.

    2.  Search for **PowerApps Tool** hover over select **PowerApps Tool Installer** and click **Add**.

3.  Add PowerApps Export Solution task.  This is found under **Deprecated Tasks**

    1.  Search for **Export**

    2.  Hover over **PowerApps Export Solution** and click **Add**.

4.  Open PowerApps Export Solution.

    1.  Select the **PowerApps Export Solution** task.

5.  Get your development environment URL

    1.  Start a new browser window or tab and log on to
        <https://admin.powerplatform.microsoft.com>. Use the same credentials
        that you are using in Azure DevOps to log in.
        

    2.  Select **Environments** and click to open the **Device Ordering
        Development** environment.

    3.  Copy the **Environment URL** and keep it in your clipboard. Keep this
        URL on a notepad.

       **Note**: If the **Device Ordering Development** environment is not listed in the
       Power Platform Admin Centre, log on to <https://make.powerapps.com/> and click on **Apps**.
       Click on **Device Procurement** app to play the app.
       Copy the **URL** from the browser app up to and including dynamics.com.

       **Note**: To make sure that the required solution exists, log on to
        <https://make.powerapps.com/> and make sure you are in the **Device
        Ordering Development** environment. Select **Solutions** from the left
        menu and you should see the **Contoso Device Order Management** unmanaged solution.

    4.  Close the **Power Platform Admin** browser window or tab.

    5.  Close the **Maker Portal** browser window or tab.

6.  Create a **Generic Service Connection.** Service Connections are how the
    build tasks know what environment URL and user credentials to use to access
    the Common Data Service environments.

    1.  Go back to the **Pipeline**.

    2.  Make sure you still have the **PowerApps Export Solution** task
        selected.

    3.  Click **Manage** next to Service Connection. This will open a new window.

    4.  Click **Create Service Connection**.

    5.  Search and Select **Generic** and click **Next**.

    6.  Paste the **Environment URL** you copied (the URL should begin with https://), provide your credentials,
        provide the **Connection Name** as **Dev Connection**, and click **Save**.

    7.  Make sure that the connection is created and then close the **Service
        Connections** browser window or tab.

7.  Select the Generic Service Connection you created as the Power Apps
    Environment URL.

    1.  Go back to the **Build Pipeline** tasks and make sure you still have
        PowerApps Export Solution task selected.

    2.  Locate the **PowerApps Environment URL** field and click **Refresh**.

    3.  Select the **Generic Service Connection** you just created named **Dev
        Connection**.

    4.  Enter **\$(SolutionName)** for **Solution Name**,
        **\$(Build.ArtifactStagingDirectory)\\\$(SolutionName).zip** for
        **Solution Output File**. Ensure that there are no white spaces while
        entering the above values.

    5.  Click **+ Add Task** again.

    6.  Add another **Export Solution** task.

    7.  Select the second **Export Solution** task.

    8.  Select the connection you created, enter **\$(SolutionName)** for
        **Solution Name**,
        **\$(Build.ArtifactStagingDirectory)\\\$(SolutionName)_managed.zip** for
        **Solution Output File**. Ensure that there are no white spaces while
        entering the above values.

    9.  Check the **Export as Managed Solution**.

8.  Add an Unpack task. This task will take the solution zip file and expand it
    into a file for each solution component. This is found under **Deprecated Tasks**.

    1.  Click **+ Add Task**.

    2.  Search for **Unpack**.

    3.  Hover over **PowerApps Unpack Solution** and click **Add**.

9.  Provide Unpack settings information.

    1.  Select the **Unpack** task.

    2.  Enter **\$(Build.ArtifactStagingDirectory)\\\$(SolutionName).zip** for
        **Solution Input File**,
        **\$(Build.SourcesDirectory)\\\$(SolutionName)** for **Target Folder**.
        Ensure that there are no white spaces while entering the above values.

    3.  Choose **Both** for Type of Solution.

10. Allow scripts to access the OAuth Token. This will allow the commands you
    will add to check in files to the Azure DevOps repo to work. **This is a very important step which if skipped will cause the pipeline to fail**.

    1.  Select **Agent Job 1**.

    2.  Scroll down and check the **Allow Scripts to Access the OAuth Token**
        checkbox.

    3.  Click **Save and Queue** and select **Save**.

    4.  Click **Save** again.

11. Add Command Line task.

    1.  Click **+ Add a Task**.

    2.  Search for **Command Line**.

    3.  Hover over **Command Line** and click **Add**.

12. Add Scripts to the Command Line task. This task will be used to check in the
    solution file changes to the repo.

    1.  Select the Command Line task.

    2.  Paste the script below in the **Script** text area. Replace
        **user\@myorg.onmicrosoft.com** with your user credentials.

    ```
    echo commit all changes
    git config user.email "user@myorg.onmicrosoft.com"
    git config user.name "Automatic Build"
    git checkout main
    git add --all
    git commit -m "solution updates"
    echo push code to new repo
    git -c http.extraheader="AUTHORIZATION: bearer \$(System.AccessToken)" push origin main
    ```

13.  Add Solution Name variable.

   1.  Select the Variables tab.

   2.  Click **+ Add.**

   3.  Enter **SolutionName** for **Name** and **ContosoDeviceOrderManagement**
        for **Value**. Ensure that there are no white spaces while entering the
        above values.
        
   4.  Click **Save and Queue** and select **Save**.

   5.  Click **Save** again.

14.  Allow Contribute for Build Service.

   1.  Click **Project Settings** in the bottom left corner of the Azure DevOps.

   2.  Select **Repositories** in the settings pane.

   3. Navigate to the **Permissions** tab
 
   4.  Select **Device Management lastnameMMYY Build Service** user. 
   
       **Note**: If the Azure DevOps Organization was generated automatically, the name maybe slightly different.

   5.  Locate **Contribute** and set it to **Allow**.

**Exercise 3: Test the Pipeline**
---------------------------------

In this exercise, you will test the build pipeline you created.

### **Task 1: Run the Pipeline**

1.  Open the build pipeline.

    1.  Log on to <https://dev.azure.com/> and click to open the **Device
        Management lastnameMMYY** project.

    2.  Select **Pipelines**.

    3.  Click to open the pipeline.

    4.  Click **Run Pipeline**.

    5.  Click **Run** again and wait.

    6.  Wait for the job to complete. The job should run and succeed. Click to
        open it.

2.  Review the Repository.

    1.  Select Repos.

    2.  You should see **ContosoDeviceOrderManagement** folder. Click to open
        the folder.

    3.  You may examine the content of each folder.

**Exercise 4: Build Manage Solution and Publish Artifacts**
-----------------------------------------------------------

In this exercise, you will take the solution files checked into the repo in the
previous steps and re-package them into a managed solution file. This solution
file will be published as a build artifact so it can be used in the release
pipeline that we are going to use to publish to test and production.

In a real project this is where you could add steps to import the solution into
a build Common Data Service environment to check for missing dependencies. You
could also add build tasks to run tests against your solution as well as run
PowerApps Solution Checker to detect problems. In this lab exercise we will skip
those extra steps to ensure you have enough time to complete the lab.

### <br>**Task 1: Build the Managed Solution**

1.  Select **Pipelines**.

2.  Click **New Pipeline**.

3.  Click **Use Classic Editor**.

4.  Click **Continue**.

5.  Click **Empty Job.**

6.  Enter **Build Managed Solution** for **Name**, click **Save and Queue** and
    select **Save**.

7.  Click **Save** again.

8.  Click **Add a Task to Agent Job 1**.

9.  Search for **PowerApps Tool**, hover over **PowerApps Tool Installer** and
    click **Add**. This is found under **Deprecated Tasks**.

10. Search for **PowerApps Pack**, hover over **PowerApps Pack Solution** and
    click **Add**. This is found under **Deprecated Tasks**.

11. Select the **PowerApps Pack Solution** task.

12. Enter **\$(Build.SourcesDirectory)\\\$(SolutionName)** for **Source Folder
    of Solution to Pack**, enter
    **\$(Build.ArtifactStagingDirectory)\\\$(SolutionName)_managed.zip** for
    **Solution Output Folder**, and select **Managed** for **Type of Solution**.
    Ensure that there are no white spaces while entering the above values.

13. Select the **Variables** tab and click **+ Add**.

14. Enter **SolutionName** for **Name** and **ContosoDeviceOrderManagement** for
    **Value**. Ensure that there are no white spaces while entering the above
    values.

15. Select the **Tasks** tab and click **Add a Task**.

16. Search **Publish Pipeline**, hover over **Publish Pipeline Artifacts** and
    click **Add**. Publishing the solution as an artifact will make it available
    for the release pipeline you will build.

17. Select the **Publish Pipeline Artifact** task.

18. Enter **\$(Build.ArtifactStagingDirectory)\\\$(SolutionName)_managed.zip**
    for **File or directory Path** and enter **drop** for **Artifact Name**. Ensure
    that there are no white spaces while entering the above values.

19. Click **Save and Queue** and select **Save and Queue**.

20. Click **Save and Run**.

21. Wait for the run to complete.

22. Job tasks should run and succeed. Click to open the job.

23. Click on the **Artifact** link.  
    **Note:** The artifcat link can be found by selecting **Agent job 1**. If you do not see the artifacts, refresh the browser and it will
    appear.

24. Expand the **drop** folder and you should see the managed solution.

**Exercise 5: Build a Release Pipeline**
----------------------------------------

In this exercise, you will build a release pipeline. The release pipeline is
intended to take the output from the build pipeline and coordinate deployments
to one or more release environments. A common release pipeline might deploy to
dev -\> test -\> user acceptance -\> production. Release pipelines can have
approval requirements between each environment.

For the purposes of this lab we are only going to deploy to one test
environment.

### **Task 1: Create Connection and Release to Prod**

1.  Log on to <https://dev.azure.com/>

2.  Click to open the **Device Management** project.

3.  Click **Project Settings.**

4.  Go to the **Pipelines** area and select **Service Connections**.

5.  Click **New Service Connection**.

6.  Select **Generic** and click **Next**.

7.  In a new tab, log on to <https://admin.powerplatform.microsoft.com>

8.  Select **Environments** and click to open the **Prod - labadminx** environment
    where x is a number.

9.  Right click on the **URL** and select **Copy Link**.

10. Close the **Admin Center** browser tab.

11. Paste the **URL** you copied to the **Server URL**, provide your
    credentials, **Test Connection** for **Server Connection Name**, and click
    **Save**.

12. Select **Pipelines** -\> **Releases**.

13. Click **New Pipeline**.

14. Select **Empty Job**.

15. Enter **Test** for **Stage Name** and click **+ Add** under **Artifacts**.

16. Select **Build Managed Solution** for **Source** and click **Add**.

17. Select the **Tasks** tab and click **+ Add Task**.

18. Search for **PowerApps Tool**, hover over **PowerApps Tool Installer** and
    click **Add**. This is found under **Deprecated Tasks**.

19. Search for **PowerApps Import**, hover over **PowerApps Import Solution**
    and click **Add**. This is found under **Deprecated Tasks**.

20. Select the **PowerApps Import Solution** task.

21. Select the **Test Connection** for Environment and enter
    **\$(System.DefaultWorkingDirectory)/_Build Managed Solution/drop/\$(SolutionName)_managed.zip** for **Solution Input File**.
    **Note**: There are spaces around the word Managed.

22. Select the **Variables** tab and click **+ Add**.

23. Enter **SolutionName** for **Name**, **ContosoDeviceOrderManagement** for
    **Value**, and click **Save**. Ensure that there are no white spaces while
    entering the above values.

24. Click **OK**.

25. Click **Create Release**.

26. Click **Create**.

27. Select **Releases** and click to open the release.

28. Wait for the release tasks to complete. The release pipeline should succeed.

29. Log on to <https://make.powerapps.com> and select the **Prod - labadminx**
    environment where x is a number.

30. Select **Solutions**. You should see the managed solution you published from
    the release pipeline.

31. Click to open the **Contoso Device Order Management** solution.

32. You should be able to see the **You cannot edit managed** solution message.

33. Select Apps. You should see **Device Ordering App** Canvas application and
    **Device Procurement** Model-Driven-Application.
