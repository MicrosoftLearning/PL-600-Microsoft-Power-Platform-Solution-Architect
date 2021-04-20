# **Module 15: Robotic Process Automation**

## **Lab Scenario**

In this hands-on lab, you are a solution architect for Contoso, helping them automate their legacy applications.

You need to integrate the legacy Windows Contoso Invoicing application in an an end-to-end workflow.

In this lab, you will be using Power Automate Desktop to create and run a desktop flow.

## **High Level Steps**

In this lab you will configure Power Automate Desktop to run on your computer, create a desktop flow for a legacy Windows application, and create a cloud flow to retrieve data from Dataverse and enter that data into the legacy application.

## **Lab Test Environment**

You will be assigned one or more users to use to complete the tasks. As this is a shared environment, some tasks that require a tenant Global Administrator or a Service Administrator role will have already been performed.

## **Exercise 1: Initialize Software**

In this exercise you will install the legacy invoicing application and Power Automate software.

### **Task 1: Contoso Invoicing**

1. Open a browser and navigate to <https://aka.ms/RPAinaDayPackage>
   **Note:** A Zip file will be downloaded
2. Extract the files from the Zip file
3. Open the **lab data file packages** folder
![Contoso Invoice application installer.](../media/install-invoicing-app.png)
4. Run **ContosoInvoicingSetup.exe**
5. Complete the installation with the defaults

### **Task 2: Power Automate Desktop**

1. Navigate to <https://flow.microsoft.com>
2. Click **Sign in**
3. Provide your tenant credentials and click **Next**.
4. Provide your password and click **Sign in**
5. Click **Yes**
   **Note:** If prompted, click Get Started
6. Select the production environment
![Select environment.](../media/select-environment.png)
7. Go to **My flows** and click **Install**
![Download installers.](../media/download-installers.png)
8. Click **Power Automate Desktop**
9. Click **Install** again
10. Click **On-premises data gateway**
11. Once the download completes, click on the file to open and run the installer:
![Setup.Microsoft.PowerAutomateDesktop.exe](../media/pad-setup.png)
12. On the following screen, click **Next**
![Power Automate Desktop step 1](../media/pad-setup-step-1.png)
13. On the following screen, check the final box and click **Install**
![Power Automate Desktop step 2](../media/pad-setup-step-2.png)
**Note:** If prompted, click Yes
14. Once the installation completes, on the following screen, click on the link for **Google Chrome**
![Power Automate Desktop step 3](../media/pad-setup-step-3.png)
15. The Chrome web store will open as shown on the following screen
![Power Automate Desktop step 4 - Chrome web store](../media/pad-setup-step-4.png)
16. Click **Add to chrome** and **Add extension**
17. On the Power Automate Desktop setup screen, click on the link for **Microsoft Edge**
18. The Edge Add-ons page will open as shown on the following screen
![Power Automate Desktop step 5 - Edge Add-ons](../media/pad-setup-step-5.png)
19. Click **Get** and **Add extension**
20. On the Power Automate Desktop setup screen, click **Close**

### **Task 3: On-premises data gateway**

1. In the Power Automate portal, go to **My flows** and click **Install**
2. Click **Install**
3. Click **On-premises data gateway**
4. Once the download completes, click on the file to open and run the installer:
![GatewayInstall.exe](../media/gateway-setup.png)
5. On the following screen, accept the terms and click **Install**
![Gateway setup step 1](../media/gateway-setup-step-1.png)
**Note:** If prompted, click Yes
6. Once the installation completes, enter your tenant email address and click **Sign in**
![Gateway setup step 2](../media/gateway-setup-step-2.png)
7. On the following screen, register a new gateway and click **Next**
![Gateway setup step 3](../media/gateway-setup-step-3.png)
8. On the following screen, enter your name as the gateway name, enter **password** for the key, and click **Configure**
![Gateway setup step 4](../media/gateway-setup-step-4.png)
10. On the following screen, click **Close**
![Gateway setup step 5](../media/gateway-setup-step-5.png)
11. In the Power Automate portal, go to **Gateways** to verify the gateway is configured
![Gateways in Power Automate portal](../media/gateways.png)

## **Exercise 2: Desktop flow**

In this exercise you will create a desktop flow to enter an Invoice into the legacy Contoso Invoicing application.

### **Task 1: Capture tasks**

1. Launch Power Automate Desktop from the computer
2. Click **Sign in**
3. Provide your tenant credentials and click **Sign in**.
4. Provide your password and click **Sign in**
![Power Automate Desktop console](../media/pad-console.png)
5. Select the production environment
![Select environment in Power Automate Desktop console](../media/pad-select-environment.png)
6. Click **+ New flow**
7. Enter **Enter Contoso Invoice** prefixed with your initials for the name and click **Create**
8. When the application starts, expand the System actions and select Run application as shown in the following screenshot:
![Select Run action](../media/pad-record-step-1.png)
9. Drag the **Run** action to the canvas in the middle pane
![Add Run action](../media/pad-record-step-2.png)
10. Enter the location path of Contoso Invoicing app under Application path and click **Save**
![Path to Contoso Invoicing application](../media/pad-record-step-3.png)
11. Click the **Run** icon to start the Contoso Invoicing app
![Start Contoso Invoicing application](../media/pad-record-step-4.png)
12. Click the **Desktop recorder** icon to start the task recorder
![Start Desktop recorder](../media/pad-record-step-5.png)
13. Click the **Record** button to start recording steps
![Start recording](../media/pad-record-step-6.png)
14. Click **Invoices** in the Contoso Invoicing app
![Select Invoices](../media/pad-record-step-7.png)
15. Click the **New Record** button in the Contoso Invoicing app
![New Record button](../media/pad-record-step-8.png)
16. In the Invoice Detail pane leave the date and enter the following:
    a. Account: **This Account**
    b. Contact: **This Contact**
    c. Amount: **999**
    d. Status: **Invoiced**
![Invoice detail](../media/pad-record-step-9.png)
17. Click the **Save** button in the Contoso Invoicing app
18. Click the **Finish** button to stop recording steps
![Stop recording](../media/pad-record-step-10.png)
19. **Save** the desktop flow
![Save the flow](../media/pad-record-step-11.png)

### **Task 2: Edit tasks**

1. Click the **+** icon in the Input/Output variables pane and select **Input**
![Add a new variable](../media/pad-edit-step-1.png)
2. In the input variable dialog, enter the following and click **Create**:
    a. Variable name: **AccountName**
    b. Data Type: **Text**
    c. DefaultValue: **TestAccount**
    d. External name: **AccountName**
    e. Description: **Name of account**
![Account input variable](../media/pad-edit-step-2.png)
3. Click the **+** icon in the Input/Output variables pane and select **Input**
4. In the input variable dialog, enter the following and click **Create**:
    a. Variable name: **ContactName**
    b. Data Type: **Text**
    c. DefaultValue: **Your name**
    d. External name: **ContactName**
    e. Description: **Name of contact**
![Contact input variable](../media/pad-edit-step-3.png)
5. Click the **+** icon in the Input/Output variables pane and select **Input**
6. In the input variable dialog, enter the following and click **Create**:
    a. Variable name: **Amount**
    b. Data Type: **Text**
    c. DefaultValue: **999**
    d. External name: **Amount**
    e. Description: **Invoice amount**
![Amount input variable](../media/pad-edit-step-4.png)
7. Click the **+** icon in the Input/Output variables pane and select **Output**
8. In the input variable dialog, enter the following and click **Create**:
    a. Variable name: **InvoiceReference**
    b. Data Type: **Text**
    d. External name: **InvoiceReference**
    e. Description: **Invoice reference**
![Output variable](../media/pad-edit-step-5.png)
9. Edit the Account entry step
![Edit step](../media/pad-edit-step-6.png)
10. In the populate text field dialog, remove "This Account" and click on the **{x}** icon and select the **AccountName** variable
![Select variable](../media/pad-edit-step-7.png)
11. Click **Save**
![Variable added to step](../media/pad-edit-step-8.png)
12. Edit the Contact entry step and replace the text with the **ContactName** variable
13. Edit the Amount entry step and replace the text with the **Amount** variable
14. Select the **UI elements** tab
![UI elements tab](../media/pad-edit-step-9.png)
15. Click **Add UI element**
16. Hover the mouse over the Invoice ID field in the Contoso Invoicing app
![Highlight the Invoice ID field](../media/pad-edit-step-10.png)
17. Hold the **Ctrl** key down and **Left-Click** on the ID field with the mouse
18. Click **Done**
19. Drag the **Get details of a UI element in Window** action to the end of the steps in the canvas, and select the Invoice ID UI element
![Get details of UI element](../media/pad-edit-step-11.png)
20. Set the variable produced to be the output variable and click **Save**
![Set output variable](../media/pad-edit-step-12.png)
21. Drag the **Close window** action to the end of the steps in the canvas, and select the Contoso Invoicing UI element
![Close window](../media/pad-edit-step-13.png)
22. **Save** the desktop flow. The desktop flow steps should be similar to the following screenshot
![Steps](../media/pad-edit-step-14.png)
23. **Close** the Power Automate Desktop editor window

### **Task 3: Test**

1. From the Power Automate Desktop console, run the desktop flow
![Power Automate Desktop console](../media/pad-test-step-1.png)
2. Enter the inputs for the flow
![Flow inputs](../media/pad-test-step-2.png)
3. Monitor the running of the flow in attended mode
4. Verify a new Invoice reference is output
![Flow outputs](../media/pad-test-step-3.png)

## **Exercise 3: Cloud flow**

In this exercise you will create and run a cloud flow to retrieve data from Dataverse and use the desktop flow to enter the data into the legacy Contoso Invoicing application.

### **Task 1: Create Button flow**

1. Navigate to <https://flow.microsoft.com>
2. Click **Sign in**
3. Provide your tenant credentials and click **Next**.
4. Provide your password and click **Sign in**
5. Select the production environment
6. Go to **My flows** and select the **Desktop flows** tab
7. Verify the desktop flow you created is listed
8. Click **+ New flow** and select **Instant cloud flow**
![Add an instant flow](../media/button-create-step-1.png)
9. Name the flow **Add Dataverse invoices to Contoso Invoicing app** prefixed with your initials
10. Select **Manually trigger a flow** and click **Create**
![Select button flow](../media/button-create-step-2.png)
11. Click **+ New step**
12. Search for and select the **Dataverse** connector
![Dataverse connector](../media/button-create-step-3.png)
13. Select the **List rows** action
14. Select the **Invoices** table
15. Click **+ New step**
16. Select the **Control** connector and the **Apply to each** action
17. Select **value** from the List rows step in the Apply to each
![Flow with list and loop actions.](../media/button-create-step-4.png)
18. **Save** the flow

### **Task 2: Call desktop flow**

1. Navigate to <https://flow.microsoft.com>
2. Select the production environment
3. Go to **My flows** and select the **Cloud flows** tab
4. Edit the **Add Dataverse invoices to Contoso Invoicing app** flow
5. Expand the **Apply to each** step
6. Click **Add an action**
7. Search for **Desktop** and select the **Desktop flows** connector
![Desktop flows connector.](../media/button-desktop-step-1.png)
8. Select **Run a flow built with Power Automate Desktop** and click **Create**
9. Select the gateway configured earlier
10. Use the username and password for your computer, and click **Create**
![Connect to gateway.](../media/button-desktop-step-2.png)
11. Select your desktop flow and choose **Attended** mode
12. Use Dynamics Content to select the Account and Contact as **Customer (value)** and Amount as **Amount Due**
![Run desktop flow.](../media/button-desktop-step-3.png)
13. **Save** the flow

### **Task 3: Run the flow**

1. Navigate to <https://flow.microsoft.com>
2. Select the production environment
3. Go to **My flows** and select the **Cloud flows** tab
4. Run the **Add Dataverse invoices to Contoso Invoicing app** flow
5. Click **Continue**
6. Click **Run flow**
7. Click **Done**
8. View the run history for the flow and verify the flow ran successfully
9. Start the Contoso Invoicing app and check that the invoices were added successfully
