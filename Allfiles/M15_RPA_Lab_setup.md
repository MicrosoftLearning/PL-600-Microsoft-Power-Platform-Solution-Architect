# **Robotic Process Automation lab setup**

## **Lab Test Environment**

As this is a shared environment, some tasks that require a tenant Global Administrator or a Service Administrator role will need to be completed by the instructor prior to the course

## **Power Automate Desktop**

1. Power Automate trial  
    a. From Microsoft 365 admin center: <https://admin.microsoft.com/AdminPortal/Home#>  
        i. Go to **Billing** and then **Purchase Services**  
            1. Search for **"Power Automate"**  
            2. Select **Power Automate per user plan with attended RPA**  
            3. Click **Start free trial**  
            4. Click **Try now**  
            5. Click **Continue**  
        ii. Go to **Billing** and then **Purchase Services**  
            1. Search for **Unattended**  
            2. Select **Power Automate unattended RPA add-on trial**  
            3. Click **Start free trial**  
            4. Click **Try now**  
            5. Click **Continue**  
        iii. Go to **Users** and then **Active Users**  
            1. Select all users  
            2. Select **Manage product licenses**  
            3. Select **Assign more**  
            4. Select **Power Automate per user plan with attended RPA**  
            5. Click **Save changes**

2. Power Automate capacity  
    a. From Power Platform admin center: <https://admin.powerplatform.microsoft.com>  
        i. Go to **Resources** and then **Capacity**  
            1. Click the **Add-ons** tab  
            2. Click **+ Assign to an environment**  
            3. Select the production environment  
            4. Assign **25** to **Power Automate Unattended RPA**  
            5. Click **Save**

## **Security roles**

1. Assign security roles to users  
    a. From Power Platform admin center: <https://admin.powerplatform.microsoft.com>  
        i. Select the production environment and go to **Settings**  
            1. Expand **Users + permissions**  
            2. Click **Security roles**  
            3. Select **Sales Enterprise app access** role  
                There should be 25 users listed. If not click **+ Add people**, search and add the users (see the list below)  
            4. Click **Security roles**  
            5. Select **Salesperson** role  
                There should be 25 users listed. If not click **+ Add people**, search and add the following users:  
                    a. Alan Steiner  
                    b. Alicia Thomber  
                    c. Allie Bellew  
                    d. Amy Alberts  
                    e. Annie Weiler  
                    f. Carlos Grilo  
                    g. Christa Geller  
                    h. Dan Jump  
                    i. David So  
                    j. Diane Prescott  
                    k. Eric Gruber  
                    l. Greg Winston  
                    m. Jamie Reding  
                    n. Jeff Hay  
                    o. Julian Isla  
                    p. Karen Berg  
                    q. Kelly Krout  
                    r. Molly Clark  
                    s. Renee Lo  
                    t. Sanjay Shah  
                    u. Spencer Low  
                    v. Sven Mortensen  
                    w. Veronica Quek  
                    x. William Contoso

## **Sample data**

1. Sample Data  
    a. From Power Platform admin center: <https://admin.powerplatform.microsoft.com>  
        i. Select the production environment and go to **Settings**  
            1. Expand **Data Management**  
            2. Click **Sample data**  
            3. Click **Install Sample Data**  
            4. Click **Close**

2. Products  
    a. From Power Platform admin center: <https://admin.powerplatform.microsoft.com>  
        i. Select the production environment and click **Open environment**  
            1. Select **Sales Hub**  
            2. Navigate to **Products**  
            3. Select the **Draft Products, Families, and Bundles** view  
            4. Select the **Office 365 Service (sample)** product  
            5. Click **Publish** and **Publish hierarchy**  
            6. Click **Confirm**

3. Price List  
    a. From Power Platform admin center: <https://admin.powerplatform.microsoft.com>  
        i. Select the production environment and click **Open environment**  
            1. Select **Sales Hub**  
            2. Select **App Settings** area  
            3. Navigate to **Price Lists**  
            4. Select the **CRM Service USA (sample)** price list  
            5. Select the **Price List Items** tab  
            6. Click **+ Add New Price List Item**  
            7. Select the **Exchange Online (sample)** product  
            8. Select the **Pricing information** tab  
            9. Enter **9** in the **Amount** field  
            10. Click **Save and Close**  
            11. Click **+ Add New Price List Item**  
            12. Select the **SharePoint Online (sample)** product  
            13. Select the **Pricing information** tab  
            14. Enter **12** in the **Amount** field  
            15. Click **Save and Close**  
            16. Click **Save and Close**

4. Invoices  
    a. From Power Platform admin center: <https://admin.powerplatform.microsoft.com>  
        i. Select the production environment and click **Open environment**  
            1. Select **Sales Hub**  
            2. Navigate to **Invoices**  
            3. Click **+ New** and enter the following details  
                a. Name: **Exchange Licenses**  
                b. Customer: **Alpine Ski House (sample)**  
                c. Currency: **US Dollar**  
                d. Price List: **CRM Service USA (sample)**  
                e. Click **Save**  
                f. Click **+ Add Product**  
                g. Select the **Exchange Online (sample)** product  
                h. Enter **100** in the **Quantity** field  
                i. Click **Save and Close**  
                j. Click **Save and Close**  
            4. Click **+ New** and enter the following details  
                a. Name: **SharePoint Licenses**  
                b. Customer: **Coho Winery (sample)**  
                c. Currency: **US Dollar**  
                d. Price List: **CRM Service USA (sample)**  
                e. Click **Save**  
                f. Click **+ Add Product**  
                g. Select the **SharePoint Online (sample)** product  
                h. Enter **250** in the **Quantity** field  
                i. Click **Save and Close**  
                j. Click **Save and Close**  
            5. Click **+ New** and enter the following details  
                a. Name: **Office 365 Licenses**  
                b. Customer: **Fourth Coffee (sample)**  
                c. Currency: **US Dollar**  
                d. Price List: **CRM Service USA (sample)**  
                e. Click **Save**  
                f. Click **+ Add Product**  
                g. Select the **Exchange Online (sample)** product  
                h. Enter **50** in the **Quantity** field  
                i. Click **Save and Close**  
                j. Click **+ Add Product**  
                k. Select the **SharePoint Online (sample)** product  
                l. Enter **50** in the **Quantity** field  
                m. Click **Save and Close**  
                n. Click **Save and Close**
